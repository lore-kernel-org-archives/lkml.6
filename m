Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E85C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE412214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE412214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388999AbeHPJ3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 05:29:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48442 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbeHPJ3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 05:29:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5F896207F3; Thu, 16 Aug 2018 08:33:07 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 11D2F20731;
        Thu, 16 Aug 2018 08:33:07 +0200 (CEST)
Date:   Thu, 16 Aug 2018 08:33:07 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, cyrille.pitchen@wedev4u.fr,
        broonie@kernel.org, pp@emlix.com, Zhiqiang.Hou@nxp.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: m25p80: consider max message size in m25p80_read
 when use the spi_mem_xx() API
Message-ID: <20180816083307.684bdb72@bbrezillon>
In-Reply-To: <1534314823-14048-1-git-send-email-chuanhua.han@nxp.com>
References: <1534314823-14048-1-git-send-email-chuanhua.han@nxp.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuanhua,

On Wed, 15 Aug 2018 14:33:43 +0800
Chuanhua Han <chuanhua.han@nxp.com> wrote:

> Consider a message size limit when calculating the maximum amount
> of data that can be read.
> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
>  drivers/mtd/devices/m25p80.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index e84563d..87efa56 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -128,7 +128,12 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
>  	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
>  
>  	while (remaining) {
> -		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
> +		op.data.nbytes = min3(remaining,
> +				spi_max_transfer_size(flash->spimem->spi),
> +				spi_max_message_size(flash->spimem->spi) -
> +				sizeof(op.cmd.opcode) -
> +				op.addr.nbytes -
> +				op.dummy.nbytes);

Nope, this sort of things should go in the SPI controller driver
->adjust_op_size() hook or directly in spi_mem_adjust_op_size() if it's
generic enough (which doesn't seem to be the case since your not
counting the opcode, addr and dummy bytes in the message length).

Regards,

Boris
