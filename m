Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3201C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858A32087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548870207;
	bh=3XBGqaxbIgirgGdiwL2FpJd4AZ+2J/mt9qBsXw7eYSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ulKf9T4rLgtm3LgB2F6l7owgE/6MYwmaIVks3n2cv/6xiOqcQR1HMaavYJfGZolaM
	 YD4eK6V6p/2qQGEvEKwqrMyIePxh0GEGnJq3t1YOChkKl22zNUSQpPoZ3uNh94Lo6k
	 qYwwb06p/CJRCnoJ8TKk8x6GWRSGIMjmrcurwQe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbfA3RnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:43:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732527AbfA3RnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:43:24 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38D6E2087F;
        Wed, 30 Jan 2019 17:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548870203;
        bh=3XBGqaxbIgirgGdiwL2FpJd4AZ+2J/mt9qBsXw7eYSs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MZNG4yQGUa+lUxsCA/fw9zcPYVkyoxVdiFJfMqbl7klNSZ8SzkkgavUmTo7bC+quu
         2BXZZAiNHyHGfji9HE/JWb6YRlXhhxe/1hGuEacutxk//vsBkiM1oRPvsAE7hXewUv
         pp1+i8nlTK8nNJBlSfOvAIv2JFZu6D41PmtvBMME=
Date:   Wed, 30 Jan 2019 18:43:13 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Message-ID: <20190130184313.281f5374@bbrezillon>
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

> +static int atmel_sam9x60_qspi_clk_prepare_enable(struct atmel_qspi *aq)
> +{
> +	struct device *dev = &aq->pdev->dev;
> +	int ret;
> +
> +	if (!aq->clk) {
> +		/* Get the peripheral clock */
> +		aq->clk = devm_clk_get(dev, "pclk");
> +		if (IS_ERR(aq->clk)) {
> +			dev_err(dev, "missing peripheral clock\n");
> +			return PTR_ERR(aq->clk);
> +		}
> +	}
> +
> +	if (!aq->qspick) {
> +		/* Get the QSPI system clock */
> +		aq->qspick = devm_clk_get(dev, "qspick");
> +		if (IS_ERR(aq->qspick)) {
> +			dev_err(dev, "missing system clock\n");
> +			return PTR_ERR(aq->qspick);
> +		}
> +	}

Move the devm_clk_get() calls to the probe path instead of doing it at
prepare time, and you can make it generic for both compats with
something like:

	aq->clk = devm_clk_get(dev, "pclk");
	if (IS_ERR(aq->clk))
		aq->clk = devm_clk_get(dev, NULL);

	if (IS_ERR(aq->clk))
		return PTR_ERR(aq->clk);

	if (aq->caps->qspick_required) {
		aq->qspick = devm_clk_get(dev, "qspick");
		if (IS_ERR(aq->qspick)) {
			return PTR_ERR(aq->qspick);
	}

> +
> +	/* Enable the peripheral clock */
> +	ret = clk_prepare_enable(aq->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable the peripheral clock\n");
> +		return ret;
> +	}
> +
> +	/* Enable the QSPI system clock */
> +	ret = clk_prepare_enable(aq->qspick);
> +	if (ret) {
> +		dev_err(dev, "failed to enable the QSPI system clock\n");
> +		clk_disable_unprepare(aq->clk);
> +	}

Again, you can make the enable function generic since
clk_prepare_enable(NULL) is a NO-OP that returns 0 and aq->qspick will
be NULL when it's not required.

> +
> +	return ret;
> +}
> +
> +static void atmel_sam9x60_qspi_clk_disable_unprepare(struct atmel_qspi *aq)
> +{
> +	clk_disable_unprepare(aq->qspick);
> +	clk_disable_unprepare(aq->clk);

Ditto.

> +}
