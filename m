Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D12AC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC5F2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549288816;
	bh=rWhYzT7UjHT4ejUyjxjI9R2JCrNUWzH8DfYNDXDEMWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rUsqJZxgaKpTk3nrfa688JCEoo2WcvN3FU5FyllEhWD+5kco92xXnD2/RW3hsOWpV
	 zoCDDKPmAneqb1zhcDWuVc2nWIZQq+PR42zJ+Li6xJFdq91zEL++yQ0VL3N9Ax2rac
	 TotwLgSNCtpjhmWueaDByxb8vASuU8E2TSAPt6s0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbfBDOAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:00:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbfBDOAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:00:13 -0500
Received: from bbrezillon (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAB872082F;
        Mon,  4 Feb 2019 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549288813;
        bh=rWhYzT7UjHT4ejUyjxjI9R2JCrNUWzH8DfYNDXDEMWQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UOMvXWSVLM1sjqhzgedjrPZL37SAyM1KYnh7VZyQg2PSGoYC3sDIuu5cIEP1vQ9DR
         +fY4kuf+1qOBbEBxOmhTEaM/tCGhPUCcTc3iENUI8ThCz9bxr/07wH+/+oV5gD+5EF
         w/E25sENpGxO2KcI583sv9xwcFWozi2YpC8Gll5A=
Date:   Mon, 4 Feb 2019 15:00:05 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v4 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Message-ID: <20190204150005.3567bf29@bbrezillon>
In-Reply-To: <20190204100910.26701-2-tudor.ambarus@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
        <20190204100910.26701-2-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 10:09:22 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Set the controller by default in Serial Memory Mode (SMM) at probe.
> Cache Mode Register (MR) value to avoid write access when setting
> the controller in serial memory mode at exec_op().
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> v4: s/smm/mr, init controller in serial memory mode by default
> v3: update smm value when different. rename mr/smm
> v2: cache MR value instead of moving the write access at probe
> 
>  drivers/spi/atmel-quadspi.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index ddc712410812..d6864d29f294 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -155,6 +155,7 @@ struct atmel_qspi {
>  	struct clk		*clk;
>  	struct platform_device	*pdev;
>  	u32			pending;
> +	u32			mr;
>  	struct completion	cmd_completion;
>  };
>  
> @@ -238,7 +239,14 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	icr = QSPI_ICR_INST(op->cmd.opcode);
>  	ifr = QSPI_IFR_INSTEN;
>  
> -	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +	/*
> +	 * If the QSPI controller is set in regular SPI mode, set it in
> +	 * Serial Memory Mode (SMM).
> +	 */
> +	if (aq->mr != QSPI_MR_SMM) {
> +		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +		aq->mr = QSPI_MR_SMM;
> +	}
>  
>  	mode = find_mode(op);
>  	if (mode < 0)
> @@ -381,6 +389,10 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
>  	/* Reset the QSPI controller */
>  	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
>  
> +	/* Set the QSPI controller by default in Serial Memory Mode */
> +	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +	aq->mr = QSPI_MR_SMM;
> +
>  	/* Enable the QSPI controller */
>  	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
>  

