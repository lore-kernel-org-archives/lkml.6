Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D71C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6AF20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6AF20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388863AbeGXVyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:54:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45297 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388604AbeGXVyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:54:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AFB5520798; Tue, 24 Jul 2018 22:46:29 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id EDDE9206A6;
        Tue, 24 Jul 2018 22:46:28 +0200 (CEST)
Date:   Tue, 24 Jul 2018 22:46:26 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Graham Moore <grmoore@opensource.altera.com>,
        Vignesh R <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: spi-nor: cadence-quadspi: make return type fit
 wait_for_completion_timeout
Message-ID: <20180724224626.777149ce@bbrezillon>
In-Reply-To: <1532189293-5975-1-git-send-email-hofrat@osadl.org>
References: <1532189293-5975-1-git-send-email-hofrat@osadl.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jul 2018 18:08:13 +0200
Nicholas Mc Guire <hofrat@osadl.org> wrote:

> wait_for_completion_timeout returns an unsigned long not int. declare a
> suitably type timeout and fix up assignment and check.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Reported-by: Vignesh R <vigneshr@ti.com>
> Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")

If you don't mind, I'd like to squash all wait_for_completion_timeout()
fixes into a single commit.

Thanks,

Boris

> ---
> 
> Given that CQSPI_TIMEOUT_MS is < INT_MAX the type conversion is actually safe
> here but it is cleaner to use proper types.
> 
> Patch was compile tested with: socfpga_defconfig (implies
> CONFIG_SPI_CADENCE_QUADSPI=y)
> 
> Patch is against 4.18-rc5 (localversion-next is next-20180720)
> 
>  drivers/mtd/spi-nor/cadence-quadspi.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index d7e10b3..ce5f840 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -622,6 +622,7 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t to_addr,
>  	unsigned int remaining = n_tx;
>  	unsigned int write_bytes;
>  	int ret;
> +	unsigned long timeout;
>  
>  	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
>  	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
> @@ -649,10 +650,10 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t to_addr,
>  		iowrite32_rep(cqspi->ahb_base, txbuf,
>  			      DIV_ROUND_UP(write_bytes, 4));
>  
> -		ret = wait_for_completion_timeout(&cqspi->transfer_complete,
> -						  msecs_to_jiffies
> -						  (CQSPI_TIMEOUT_MS));
> -		if (!ret) {
> +		timeout = wait_for_completion_timeout(&cqspi->transfer_complete,
> +						      msecs_to_jiffies
> +						      (CQSPI_TIMEOUT_MS));
> +		if (!timeout) {
>  			dev_err(nor->dev, "Indirect write timeout\n");
>  			ret = -ETIMEDOUT;
>  			goto failwr;

