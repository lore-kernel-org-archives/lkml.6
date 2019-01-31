Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC28C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50755218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548953749;
	bh=5InK5VVpqOh9e3SQsYJHpCS38H6ABMfXKqzoKGLxjl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CywE/ZfW0Q6zBlSj8xc2TdPwljg1UAWNCAcGII6xP0j1vTrxtKI1PnLD7ogAXDY42
	 Qb2+1bPKgO0TO/Npm3qDWlqF3UK6nCLBkDWOu1jZzMZRdRyephUiLQaHImvLkY9V94
	 pH9MJsUxKmoGxUoWLUAVJBzX0mS/lYA6+938NKCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387676AbfAaQzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:55:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbfAaQzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:55:47 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EDE2218AF;
        Thu, 31 Jan 2019 16:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548953746;
        bh=5InK5VVpqOh9e3SQsYJHpCS38H6ABMfXKqzoKGLxjl8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WYPSA056mZica1VwG8DG43PAnno1y7GGhDARRwdmhsXCFiuDIwkUHXb/rKr4t1Y5S
         rMuz1uK6DC1gWjjKzeJYMvgjOQCv7yC4tNWXhUPt0HzXncCzWZ/Kjaq5Ng6xz79y/9
         LfE9MVeeEWfA7rQ5SELv1Xt9OeLpXBZ+uvdxG/Sk=
Date:   Thu, 31 Jan 2019 17:55:35 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 01/10] spi: atmel-quadspi: cache MR value to avoid a
 write access
Message-ID: <20190131175535.3f60ccff@bbrezillon>
In-Reply-To: <20190131161515.21605-2-tudor.ambarus@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
        <20190131161515.21605-2-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 16:15:28 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Cache MR value to avoid write access when setting the controller
> in Serial Memory Mode (SMM). SMM is set in exec_op() and not at
> probe time, to let room for future regular SPI support.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v2: cache MR value instead of moving the write access at probe
> 
>  drivers/spi/atmel-quadspi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index ddc712410812..fe05aee5d845 100644
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
> @@ -238,7 +239,9 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	icr = QSPI_ICR_INST(op->cmd.opcode);
>  	ifr = QSPI_IFR_INSTEN;
>  
> -	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +	/* Set the QSPI controller in Serial Memory Mode */
> +	if (!(aq->mr & QSPI_MR_SMM))

	if (aq->mr != QSPI_MR_SMM)

> +		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);

You need to update ->mr here.

>  
>  	mode = find_mode(op);
>  	if (mode < 0)

