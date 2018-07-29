Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D86FF05E2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF7520893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+XfeUp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF7520893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeG2NSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 09:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbeG2NSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 09:18:43 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6517720873;
        Sun, 29 Jul 2018 11:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532864911;
        bh=EC7gBJTPnn/wFeLFZevhpjMVvLZlYe7kyX41pNfiKr0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c+XfeUp0/FPgNLSgRGFFaW//rixt3jUMbFJQuCgjbRbBDMl9yOpYhN8CER+SGp6vp
         EkjtoOF3zFneVmquWuYeRjp9/CDlTZ/x0dT/TDm4bG5Y4NHLEBU/9AEWG5LM4wyhbV
         hK6Wh+g41bezyYyBeyY3522q0lIVxsp3PqpImyRE=
Date:   Sun, 29 Jul 2018 12:48:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] iio: adc: xilinx: Check for return values in clk
 related functions
Message-ID: <20180729124826.74784bf2@archlinux>
In-Reply-To: <1532358123-23485-2-git-send-email-manish.narani@xilinx.com>
References: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
        <1532358123-23485-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018 20:32:00 +0530
Manish Narani <manish.narani@xilinx.com> wrote:

> This patch adds check for return values from clock related functions.
> This was reported by static code analysis tool.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 0127e85..23395fc 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -340,6 +340,8 @@ static int xadc_zynq_setup(struct platform_device *pdev,
>  	xadc->zynq_intmask = ~0;
>  
>  	pcap_rate = clk_get_rate(xadc->clk);
> +	if (!pcap_rate)
> +		return -EINVAL;
>  
>  	if (tck_rate > pcap_rate / 2) {
>  		div = 2;
> @@ -887,6 +889,9 @@ static int xadc_write_raw(struct iio_dev *indio_dev,
>  	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
>  	unsigned int div;
>  
> +	if (!clk_rate)
> +		return -EINVAL;
> +
>  	if (info != IIO_CHAN_INFO_SAMP_FREQ)
>  		return -EINVAL;
>  
> @@ -1237,8 +1242,10 @@ static int xadc_probe(struct platform_device *pdev)
>  		goto err_free_irq;
>  
>  	/* Disable all alarms */
> -	xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
> -		XADC_CONF1_ALARM_MASK);
> +	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
> +				  XADC_CONF1_ALARM_MASK);
> +	if (ret)
> +		goto err_free_irq;
>  
>  	/* Set thresholds to min/max */
>  	for (i = 0; i < 16; i++) {

