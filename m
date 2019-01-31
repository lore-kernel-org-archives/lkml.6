Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D94CC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001C7218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548935732;
	bh=ljvHK5+CxgCaWGa66nNZEVCCE59QxWDz8dsWIFaljuM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ybTcjzveBUKOho+ZxQccRB77AEoLCLIFuSHMHCoTED6vn0cfP0gsHcxXOdSyeN7KT
	 H3PVS9V7oA7N/KADzRsiXIECxQzFLrnmiCpqXQTs6DmtY8xCzsFXdCT0w2UnbzTCx7
	 bew1+Ggxw0xczfv1uM5CA/TQtr1DQ7L6jYtpw5mQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732489AbfAaLza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:55:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbfAaLz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:55:29 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9549B2087F;
        Thu, 31 Jan 2019 11:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548935729;
        bh=ljvHK5+CxgCaWGa66nNZEVCCE59QxWDz8dsWIFaljuM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c6AEIqJ3TZw6xN3zH5OQzsXGnZXJBbnJlBoMsHzcIydnfNwRLu6a4SfdZ60MeiBtS
         4jKAaqUtyjZ9EDCGSW0OIaUUoXsOi+qiVciXQKQNEawdpwrGkF8HxK+ZNIL4gdtsDL
         SLFggB2qZEg2X1oXRQxTneON4QGU490KviGVV7Tk=
Date:   Thu, 31 Jan 2019 12:55:19 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Message-ID: <20190131125504.3eff449d@bbrezillon>
In-Reply-To: <20190130150818.24902-10-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-10-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 15:08:47 +0000
<Tudor.Ambarus@microchip.com> wrote:

> +
> +static int atmel_sam9x60_qspi_set_cfg(struct atmel_qspi *aq,
> +				      const struct spi_mem_op *op,
> +				      struct atmel_qspi_cfg *cfg)
> +{
> +	int ret = atmel_qspi_set_mode(cfg, op);
> +
> +	if (ret)
> +		return ret;
> +
> +	cfg->icr = QSPI_ICR_INST(op->cmd.opcode);
> +
> +	if (!op->addr.nbytes) {
> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_REG;
> +		if (op->data.dir == SPI_MEM_DATA_OUT)
> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_WRITE;
> +		else
> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_READ;
> +	} else {
> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_MEM;

Why do you use a MEM transfer here? What's the difference with a
regular transfer?

> +	}
> +
> +	/* Set data enable */
> +	if (op->data.nbytes)
> +		cfg->ifr |= QSPI_IFR_DATAEN;
> +
> +	ret = atmel_qspi_set_address_mode(cfg, op);
> +	if (ret)
> +		return ret;
>  
>  	/* Clear pending interrupts */
>  	(void)atmel_qspi_readl(aq, QSPI_SR);
>  
>  	/* Set QSPI Instruction Frame registers */
> -	atmel_qspi_writel(aq, QSPI_IAR, iar);
> -	atmel_qspi_writel(aq, QSPI_ICR, icr);
> -	atmel_qspi_writel(aq, QSPI_IFR, ifr);
> +	atmel_qspi_writel(aq, QSPI_IAR, cfg->iar);
> +	if (op->data.dir == SPI_MEM_DATA_OUT)
> +		atmel_qspi_writel(aq, QSPI_ICR, cfg->icr);
> +	else
> +		atmel_qspi_writel(aq, QSPI_RICR, cfg->icr);
> +	atmel_qspi_writel(aq, QSPI_IFR, cfg->ifr);
> +
> +	return 0;
> +}

