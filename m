Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A694C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA142186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549470098;
	bh=YwsAmUrMskHHmHEljjzPKq7MmZ/6Lm8hMKyX4fwbP14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qXMP7E6gXu9GHxwHA24NVeTeRQ97W6KRKEU/Zz0yTdLOshgvnvKBqQJXyqYBc8FPI
	 /HIYqQ9vcb+U3EbF9IG1X7q5H0+utZnTkUTtZhcHfIm7UxK7L3Yw7XmY9jwSnjI4k6
	 G0sH6xZtqq6fKB4KNXuA35951d1VFHxOmK6jUAEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfBFQVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:21:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbfBFQVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:21:30 -0500
Received: from localhost (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0438E2175B;
        Wed,  6 Feb 2019 16:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549470089;
        bh=YwsAmUrMskHHmHEljjzPKq7MmZ/6Lm8hMKyX4fwbP14=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ani1vL/ltsdGnVVaSlzU7mhtITlkRWq4pO6SZteF0WMAPXGbPajQ21Ns/5qzbmoD+
         QPnmVFPXg5mvhmvm+cA7c44i4onGdwvfPLvnqwn1ptZyFnH4ViiBjKafcEVOpRhgG0
         Dzrq0LP8wfwSssHItryQMyg04Utaxhby8uCyrtaI=
Date:   Wed, 6 Feb 2019 17:21:21 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v6 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Message-ID: <20190206172121.78fff6c5@kernel.org>
In-Reply-To: <20190205173254.16388-2-tudor.ambarus@microchip.com>
References: <20190205173254.16388-1-tudor.ambarus@microchip.com>
        <20190205173254.16388-2-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2019 17:33:06 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Set the controller by default in Serial Memory Mode (SMM) at probe.
> Cache Mode Register (MR) value to avoid write access when setting
> the controller in serial memory mode at exec_op().
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Add my R-b back

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
> v6: no change
> v5: collect R-b
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

