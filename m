Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967323AbeCAKFQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:05:16 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36802 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967069AbeCAKFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:05:14 -0500
Date: Thu, 1 Mar 2018 11:05:02 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Mohit Aggarwal <maggarwa@codeaurora.org>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc-pm8xxx: Fix issue in RTC write path
Message-ID: <20180301100502.GU1479@piout.net>
References: <1519807878-14842-1-git-send-email-maggarwa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519807878-14842-1-git-send-email-maggarwa@codeaurora.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this was not sent to the correct mailingr- list, please use a more recent
kernel ;)

On 28/02/2018 at 14:21:18 +0530, Mohit Aggarwal wrote:
> In order to set time in rtc, need to disable
> rtc hw before writing into rtc registers.
> 
> Also fixes disabling of alarm while setting
> rtc time.
> 
> Change-Id: Ia2c9c922dd78e2ecb92554d5722c894706d83ac0

checkpatch rightfully complains loudly about that line.

> Signed-off-by: Mohit Aggarwal <maggarwa@codeaurora.org>
> ---
>  drivers/rtc/rtc-pm8xxx.c | 49 +++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index fac8355..5309edc 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -74,16 +74,18 @@ struct pm8xxx_rtc {
>  /*
>   * Steps to write the RTC registers.
>   * 1. Disable alarm if enabled.
> - * 2. Write 0x00 to LSB.
> - * 3. Write Byte[1], Byte[2], Byte[3] then Byte[0].
> - * 4. Enable alarm if disabled in step 1.
> + * 2. Disable rtc if enabled.
> + * 3. Write 0x00 to LSB.
> + * 4. Write Byte[1], Byte[2], Byte[3] then Byte[0].
> + * 5. Enable rtc if disabled in step 2.
> + * 6. Enable alarm if disabled in step 1.
>   */
>  static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	int rc, i;
>  	unsigned long secs, irq_flags;
> -	u8 value[NUM_8_BIT_RTC_REGS], alarm_enabled = 0;
> -	unsigned int ctrl_reg;
> +	u8 value[NUM_8_BIT_RTC_REGS], alarm_enabled = 0, rtc_disabled = 0;
> +	unsigned int ctrl_reg, rtc_ctrl_reg;
>  	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
>  	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
>  
> @@ -92,23 +94,38 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  
>  	rtc_tm_to_time(tm, &secs);
>  
> +	dev_dbg(dev, "Seconds value to be written to RTC = %lu\n", secs);
> +
>  	for (i = 0; i < NUM_8_BIT_RTC_REGS; i++) {
>  		value[i] = secs & 0xFF;
>  		secs >>= 8;
>  	}
>  
> -	dev_dbg(dev, "Seconds value to be written to RTC = %lu\n", secs);
> -
>  	spin_lock_irqsave(&rtc_dd->ctrl_reg_lock, irq_flags);
>  
> -	rc = regmap_read(rtc_dd->regmap, regs->ctrl, &ctrl_reg);
> +	rc = regmap_read(rtc_dd->regmap, regs->alarm_ctrl, &ctrl_reg);
>  	if (rc)
>  		goto rtc_rw_fail;
>  
>  	if (ctrl_reg & regs->alarm_en) {
>  		alarm_enabled = 1;
>  		ctrl_reg &= ~regs->alarm_en;
> -		rc = regmap_write(rtc_dd->regmap, regs->ctrl, ctrl_reg);
> +		rc = regmap_write(rtc_dd->regmap, regs->alarm_ctrl, ctrl_reg);
> +		if (rc) {
> +			dev_err(dev, "Write to RTC Alarm control register failed\n");
> +			goto rtc_rw_fail;
> +		}
> +	}
> +
> +	/* Disable RTC H/w before writing on RTC register */
> +	rc = regmap_read(rtc_dd->regmap, regs->ctrl, &rtc_ctrl_reg);
> +	if (rc)
> +		goto rtc_rw_fail;
> +
> +	if (rtc_ctrl_reg & PM8xxx_RTC_ENABLE) {
> +		rtc_disabled = 1;
> +		rtc_ctrl_reg &= ~PM8xxx_RTC_ENABLE;
> +		rc = regmap_write(rtc_dd->regmap, regs->ctrl, rtc_ctrl_reg);
>  		if (rc) {
>  			dev_err(dev, "Write to RTC control register failed\n");
>  			goto rtc_rw_fail;
> @@ -137,11 +154,21 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  		goto rtc_rw_fail;
>  	}
>  
> +	/* Enable RTC H/w after writing on RTC register */
> +	if (rtc_disabled) {
> +		rtc_ctrl_reg |= PM8xxx_RTC_ENABLE;
> +		rc = regmap_write(rtc_dd->regmap, regs->ctrl, rtc_ctrl_reg);
> +		if (rc) {
> +			dev_err(dev, "Write to RTC control register failed\n");
> +			goto rtc_rw_fail;
> +		}
> +	}
> +
>  	if (alarm_enabled) {
>  		ctrl_reg |= regs->alarm_en;
> -		rc = regmap_write(rtc_dd->regmap, regs->ctrl, ctrl_reg);
> +		rc = regmap_write(rtc_dd->regmap, regs->alarm_ctrl, ctrl_reg);
>  		if (rc) {
> -			dev_err(dev, "Write to RTC control register failed\n");
> +			dev_err(dev, "Write to RTC Alarm control register failed\n");
>  			goto rtc_rw_fail;
>  		}
>  	}
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
