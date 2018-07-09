Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2979FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC2320881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC2320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeGIVeb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:34:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43624 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933060AbeGIVea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:34:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C979A20733; Mon,  9 Jul 2018 23:34:28 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 74E4320012;
        Mon,  9 Jul 2018 23:34:28 +0200 (CEST)
Date:   Mon, 9 Jul 2018 23:34:27 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     linux-mtd@lists.infradead.org, frieder.schrempf@exceet.de,
        computersforpeace@gmail.com, david.wolfe@nxp.com, han.xu@nxp.com,
        festevam@gmail.com, marek.vasut@gmail.com,
        prabhakar.kushwaha@nxp.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] mtd: spi-nor: Support controllers with limited TX FIFO
 size
Message-ID: <20180709233427.1a714de7@bbrezillon>
In-Reply-To: <1528870092-14526-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1528870092-14526-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Fabio

Hi Yogesh,

On Wed, 13 Jun 2018 11:38:12 +0530
Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Some SPI controllers can't write nor->page_size bytes in a single
> step because their TX FIFO is too small.
> 
> Allow nor->write() to return a size that is smaller than the requested
> write size to gracefully handle this case.

There's been a discussion between Marek and I regarding this patch and
patch "mtd: devices: m25p80: Make sure WRITE_EN is issued before each
write". Marek would like to avoid letting drivers do non-aligned page
writes when the MTD user requested full page writes.

So, the question is, is the FSL QSPI engine capable of handling that
when the NOR page is being than the TX FIFO? According to the current
implementation it's not [1], but it looks like we have a way to
know when the TX FIFO is not full so we could potentially refill the
FIFO either from the CPU or using DMA if that's possible (not sure the
eDMA engine can fill the QSPI TX FIFO directly).

What I find worrisome with this solution is this particular statement
in the datasheet:

"
When the QuadSPI module tries to pull data out of an empty TX Buffer
the TX Buffer underrun is signaled by the QSPI_FR[TBUF] flag. The
current IP Command leading to the underrun condition is continued until
the specified number of bytes has been sent to the serial flash device,
in the underrun condition when QuadSPI module tries to pull out data of
empty TX buffer, the data transferred is undefined i.e. once the
underrun flag is set, it will return the garbage value until the
required number of bytes are not sent.
"

If we fail to fill the TX FIFO fast enough for any reasons (contention
on the APB/AHB/AXI bus in case of DMA, task being scheduled out in
case of PIO access), that means we transfer garbage to the NOR...
Clearly something we should avoid at any cost.

Yogesh, Fabio, Han, any comment on this?

Thanks,

Boris

[1]https://elixir.bootlin.com/linux/v4.18-rc4/source/drivers/mtd/spi-nor/fsl-quadspi.c#L1117

> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 5bfa36e..3e63543 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1431,13 +1431,6 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>  			goto write_err;
>  		*retlen += written;
>  		i += written;
> -		if (written != page_remain) {
> -			dev_err(nor->dev,
> -				"While writing %zu bytes written %zd bytes\n",
> -				page_remain, written);
> -			ret = -EIO;
> -			goto write_err;
> -		}
>  	}
>  
>  write_err:

