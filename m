Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78D8C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7015321721
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549091225;
	bh=E3FJCRyIlElVvR6dxcgGbiQIi5lKYbeOzntDFZu4bJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RIVRb/pu1NdRMDoaLr9ajme/EoFJpcNzgrFCWQQo/kk445DlBN8ZZBVvQH4xdA9dZ
	 RVgcIBAPtNAYWjJM7c4kt63u30eDZq1V2Z5E+OCmeRN2rwRbRnjLra8kQD5ors9uuj
	 LrECnX+IXl0cIzR+0MYo7v8jGqAR4EGwixinKRps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfBBHHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 02:07:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfBBHHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 02:07:04 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B55B20870;
        Sat,  2 Feb 2019 07:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549091223;
        bh=E3FJCRyIlElVvR6dxcgGbiQIi5lKYbeOzntDFZu4bJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nlOcOcvrBqYWCQ3vNMPwvYhANUhKW+CJo5jIRvgL7zmJJckqXp3GQR/81RvP/wYKP
         jFhKV7VXZlzR9XuaGcicB3w3eSX1bJIs13A7jz51cV6SEnyyedDH2OjmYniKONjUO0
         OnDqvFf6hrT07g+UuvanbCCOM6IydxM8cFLxkhQ4=
Date:   Sat, 2 Feb 2019 08:06:50 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Message-ID: <20190202080650.44becc2d@bbrezillon>
In-Reply-To: <20190202040653.1217-2-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
        <20190202040653.1217-2-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2019 04:07:13 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Cache Serial Memory Mode (SMM) value to avoid write access when
> setting the controller in serial memory mode. SMM is set in
> exec_op() and not at probe time, to let room for future regular
> SPI support.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v3: update smm value when different. rename mr/smm
> v2: cache MR value instead of moving the write access at probe
> 
>  drivers/spi/atmel-quadspi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index ddc712410812..645284c6ec9a 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -155,6 +155,7 @@ struct atmel_qspi {
>  	struct clk		*clk;
>  	struct platform_device	*pdev;
>  	u32			pending;
> +	u32			smm;
>  	struct completion	cmd_completion;
>  };
>  
> @@ -238,7 +239,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	icr = QSPI_ICR_INST(op->cmd.opcode);
>  	ifr = QSPI_IFR_INSTEN;
>  
> -	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +	/* Set the QSPI controller in Serial Memory Mode */
> +	if (aq->smm != QSPI_MR_SMM) {

Sorry, I think I misunderstood your previous suggestion, I thought the
reg was called SMM. If the reg is called MR and the value you expect in
there is SMM, then the field should be named ->mr as it caches the
whole reg, not only the SMM bit. So it's actually:

	if (aq->mr != QSPI_MR_SMM) {

> +		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +		aq->smm = QSPI_MR_SMM;
> +	}
>  
>  	mode = find_mode(op);
>  	if (mode < 0)

