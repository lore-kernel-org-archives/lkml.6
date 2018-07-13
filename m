Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F09ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8138520870
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Hvd9oPeJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i8Ixl8Jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8138520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbeGMWhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 18:37:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54026 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeGMWhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 18:37:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6B27A60B6B; Fri, 13 Jul 2018 22:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531520464;
        bh=Yq7w7LqqEp48sCvUi3sNglH93WCY2BHI3m1OpTh0kPE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Hvd9oPeJETvhjIAFI7HT6F7hAxD+IPmps8lSTH7cyPrn7utGOlL9itvKH4Yo11/K1
         lS0LDPWP1HUHVZ5EnDP1aBQuhgsp0O/GQurobPAzfvHc+z4Rs7aB4RhXIUDg+PKqOB
         Y+W8GHfAb7tnviUsLIJdypJo/Xr+tt3F46XnwYxw=
Received: from [10.226.60.116] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kramasub@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2EF9A6063F;
        Fri, 13 Jul 2018 22:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531520463;
        bh=Yq7w7LqqEp48sCvUi3sNglH93WCY2BHI3m1OpTh0kPE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=i8Ixl8JvzXDXYkPY/CbfQONRG1K55OsIBVU8KeUm4YpXyqeX7RyGA4YCITXwhgO3y
         FqoSrXCNo6orLHk3JYu5xvuW08sMcBLZtz1BAl6qafweH3/d502+M7ttNhfUzvPOkL
         WjPibNFKuxqzTjjyTcpzKA3xpdmBfOkjIyK1Ayj8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2EF9A6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kramasub@codeaurora.org
Subject: Re: [PATCH] i2c: i2c-qcom-geni: Fix suspend clock handling
To:     Evan Green <evgreen@chromium.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        dianders@chromium.org, Girish Mahadevan <girishm@codeaurora.org>,
        linux-i2c@vger.kernel.org
References: <20180709234937.176154-1-evgreen@chromium.org>
From:   Karthik Ramasubramanian <kramasub@codeaurora.org>
Message-ID: <7bd24be2-e019-42f8-555f-719cd602dc40@codeaurora.org>
Date:   Fri, 13 Jul 2018 16:21:02 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709234937.176154-1-evgreen@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/2018 5:49 PM, Evan Green wrote:
> pm_runtime_suspended can return 0 even if the last runtime power
> management function called in the device was a suspend call. This
> trips up the i2c-qcom-geni's suspend_noirq accounting, which was
> trying to use the function to determine if it should disable clocks
> or if that had already been done.
> 
> The fix is to track whether or not clocks have been enabled explicitly
> in the driver with a new member. While in there, also honor the return
> value of geni_se_resources_off, which can technically fail.
> 
> An example of the warning generated during suspend:
> [   68.314733] WARNING: CPU: 0 PID: 1990 at drivers/clk/clk.c:595 clk_core_disable+0x28/0x200
> [   68.464576] Call trace:
> [   68.554410] [<ffffff80083f0ed0>] clk_core_disable+0x28/0x200
> [   68.560244] [<ffffff80083f349c>] clk_disable+0x38/0x4c
> [   68.565541] [<ffffff8008408910>] geni_se_resources_off+0x40/0x74
> [   68.571731] [<ffffff800862aadc>] geni_i2c_runtime_suspend+0x2c/0x3c
> [   68.578185] [<ffffff800862ae6c>] geni_i2c_suspend_noirq+0x38/0x68
> [   68.584475] [<ffffff800852bd40>] dpm_run_callback+0x104/0x210
> [   68.590404] [<ffffff800852c3d4>] __device_suspend_noirq+0x158/0x1a8
> [   68.596859] [<ffffff800852dff0>] dpm_noirq_suspend_devices+0x180/0x38c
> [   68.603594] [<ffffff80080fdebc>] suspend_devices_and_enter+0x49c/0x964
> [   68.610321] [<ffffff80080fea14>] pm_suspend+0x690/0x6e0
> [   68.615712] [<ffffff80080fc930>] state_store+0xd4/0xf8
> [   68.621014] [<ffffff80088a57f0>] kobj_attr_store+0x18/0x28
> [   68.626672] [<ffffff8008297a54>] sysfs_kf_write+0x5c/0x68
> [   68.632240] [<ffffff8008296a00>] kernfs_fop_write+0x174/0x1b8
> [   68.638177] [<ffffff800821a2c4>] __vfs_write+0x58/0x160
> [   68.643567] [<ffffff800821a5d8>] vfs_write+0xcc/0x184
> [   68.648780] [<ffffff800821a850>] SyS_write+0x64/0xb4
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> This change applies atop Karthik's patch [1], which as far as I can tell
> technically hasn't landed yet, but also hasn't had feedback in awhile
> either. I opted to submit this as a separate patch, but if the maintainers
> prefer it's fine with me if this get folded in to another spin of the
> base series.
> 
> [1] https://patchwork.kernel.org/patch/10460819/
> 
>  drivers/i2c/busses/i2c-qcom-geni.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 54bcd1a79cc5..90c4cbfa22d8 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -85,6 +85,7 @@ struct geni_i2c_dev {
>  	spinlock_t lock;
>  	u32 clk_freq_out;
>  	const struct geni_i2c_clk_fld *clk_fld;
> +	int suspended;
>  };
>  
>  struct geni_i2c_err_log {
> @@ -567,9 +568,15 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  	geni_se_init(&gi2c->se, gi2c->tx_wm, tx_depth);
>  	geni_se_config_packing(&gi2c->se, BITS_PER_BYTE, PACKING_BYTES_PW,
>  							true, true, true);
> -	geni_se_resources_off(&gi2c->se);
> +	ret = geni_se_resources_off(&gi2c->se);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Error turning off resources %d\n", ret);
> +		return ret;
> +	}
> +
>  	dev_dbg(&pdev->dev, "i2c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
>  
> +	gi2c->suspended = 1;
>  	pm_runtime_set_suspended(gi2c->se.dev);
>  	pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
>  	pm_runtime_use_autosuspend(gi2c->se.dev);
> @@ -590,10 +597,19 @@ static int geni_i2c_remove(struct platform_device *pdev)
>  
>  static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
>  {
> +	int ret;
>  	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
>  
>  	disable_irq(gi2c->irq);
> -	geni_se_resources_off(&gi2c->se);
> +	ret = geni_se_resources_off(&gi2c->se);
> +	if (ret) {
> +		enable_irq(gi2c->irq);
> +		return ret;
> +
> +	} else {
> +		gi2c->suspended = 1;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -607,12 +623,15 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
>  		return ret;
>  
>  	enable_irq(gi2c->irq);
> +	gi2c->suspended = 0;
>  	return 0;
>  }
>  
>  static int __maybe_unused geni_i2c_suspend_noirq(struct device *dev)
>  {
> -	if (!pm_runtime_suspended(dev)) {
> +	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
> +
> +	if (!gi2c->suspended) {
>  		geni_i2c_runtime_suspend(dev);
>  		pm_runtime_disable(dev);
>  		pm_runtime_set_suspended(dev);
> 
Reviewed-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
