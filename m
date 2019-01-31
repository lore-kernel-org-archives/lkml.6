Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA46EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8253A218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oALGTAWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfAaRko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:40:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38909 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfAaRko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:40:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so1796329pfi.5;
        Thu, 31 Jan 2019 09:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CH7NqMeH7U9k+dTRiNnxtrCogZdiuJTC0dcyxd2NyuA=;
        b=oALGTAWWj8qCFFDuBUvf8a0UFpOE4/zhU2jIXjJHoFE8gRZxnjcAaRpzmmZu4Mz2Xt
         J+Ok5XtHvJL3HL8XZWAp9xJqT3yYpp1jHxGbguGQ6QMJjbbTR4/zWxCmF+UCh6+uFE/J
         AUCOYzW+3LWziMcVITkvMM4V6xg/0iLldsJiRADXza60oq0uvir1uUzDb6wcB0MR2FZd
         Jllbbt0jqrhW/P4x030MCGQKeweqe7Uy4F22Ax2AmvOD1wYM17UMmXGpLSWCt5CntvYk
         W6L6lfSf59JqVhNwdQ3PC62fd2g+CTsKWM01cqJe7vv84RbXY3DvBmfio7TohB3YUoeY
         v7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CH7NqMeH7U9k+dTRiNnxtrCogZdiuJTC0dcyxd2NyuA=;
        b=YN6Kk962Nu1XD733h5I08rzaIF7Ite6RLPPIBIgqTq7AseKlgYKocu+fa5/jwFIIPz
         Wu/ZODwcBw6+aT8GGFwHjnWez7zyov7BIhPlanemoOTijgFkdMOv1t/ZkrfYGUkPEqDh
         lvcpiHwjEsr6J7wPuZkpaszbsx7t8yzYw19xlA4gls6D1UQQzVrcbnTUGJSLefJfw3Gu
         XOzjZDd7XX5Xd0Fkbtm9GO099cHsPBbiMnKiinmIXqvPw52RJHdEz+5sG8YskA4QL1AP
         aYENJVXWg0+n0tQ1KxdajB0ToFMaPJ18meZaERwPXOF+HSsItzdBhs1b+znV3Ys9zrXF
         eLRQ==
X-Gm-Message-State: AJcUukevRSEULMc8424vpnYE4NEZeAfyL1fBeuwIhOuehYGp0yeu7Qho
        brEnc3LgN0/UKb1bAcqd9Ms=
X-Google-Smtp-Source: ALg8bN6g1HaUXxAvMRdVmPtO3dt2rYR8R6gUudjZdo/aS4VmJsh778ni+uL7Uf4OVfc6BqDbPN2wDA==
X-Received: by 2002:a62:4886:: with SMTP id q6mr36671869pfi.182.1548956442935;
        Thu, 31 Jan 2019 09:40:42 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b10sm7740106pfj.183.2019.01.31.09.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 09:40:41 -0800 (PST)
Date:   Thu, 31 Jan 2019 09:40:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] hwmon: pwm-fan: Add RPM support via external
 interrupt
Message-ID: <20190131174040.GA15498@roeck-us.net>
References: <1548860827-29796-1-git-send-email-stefan.wahren@i2se.com>
 <1548860827-29796-4-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548860827-29796-4-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 04:07:07PM +0100, Stefan Wahren wrote:
> This adds RPM support to the pwm-fan driver in order to use with
> fancontrol/pwmconfig. This feature is intended for 2 pulse-per-revolution
> fans which provides a tachometer output signal.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/hwmon/pwm-fan.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 9e0591e..731fdc6 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -18,6 +18,7 @@
>  
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> @@ -26,13 +27,22 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/sysfs.h>
>  #include <linux/thermal.h>
> +#include <linux/timer.h>
>  
>  #define MAX_PWM 255
> +#define SAMPLE_TIME		1 /* seconds */
> +#define PULSE_PER_REVOLUTION	2
>  
>  struct pwm_fan_ctx {
>  	struct mutex lock;
>  	struct pwm_device *pwm;
>  	struct regulator *reg_en;
> +
> +	int irq;
> +	unsigned int pulses;
> +	unsigned int rpm;
> +	struct timer_list sample_timer;
> +
>  	unsigned int pwm_value;
>  	unsigned int pwm_fan_state;
>  	unsigned int pwm_fan_max_state;
> @@ -40,6 +50,27 @@ struct pwm_fan_ctx {
>  	struct thermal_cooling_device *cdev;
>  };
>  
> +static irqreturn_t pulse_handler(int irq, void *dev_id)
> +{
> +	struct pwm_fan_ctx *ctx = dev_id;
> +
> +	if (ctx->pulses < INT_MAX / 2)
> +		ctx->pulses++;

Please explain the limit. With this code, the maximum number
for pulses is INT_MAX / 2. The calculation below multiplies
that with 60, which is well above UINT_MAX. Either use a 
realistic limit or drop the if statement (it is kind of
unlikely to get that many interrupts per second).

> +
> +	return IRQ_HANDLED;

This assumes a self resetting edge triggered interrupt ?
You might want to mention that somewhere.

> +}
> +
> +static void sample_timer(struct timer_list *t)
> +{
> +	struct pwm_fan_ctx *ctx = from_timer(ctx, t, sample_timer);
> +	unsigned int pulses;
> +
> +	pulses = ctx->pulses;
> +	ctx->pulses -= pulses;

This is racy; the substract operation is not atomic, and neither
is the addition in the interrupt handler.

> +	ctx->rpm = pulses * 60 / SAMPLE_TIME / PULSE_PER_REVOLUTION;

The calculation assumes that sample_timer is called exactly after one
second. Have to tested how much variation this causes on a loaded system ?

> +	mod_timer(&ctx->sample_timer, jiffies + (HZ * SAMPLE_TIME));
> +}
> +
>  static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
>  {
>  	unsigned long period;
> @@ -100,11 +131,20 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
>  	return sprintf(buf, "%u\n", ctx->pwm_value);
>  }
>  
> +static ssize_t rpm_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%u\n", ctx->rpm);
> +}
>  
>  static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
> +static SENSOR_DEVICE_ATTR_RO(fan1_input, rpm, 0);
>  
>  static struct attribute *pwm_fan_attrs[] = {
>  	&sensor_dev_attr_pwm1.dev_attr.attr,
> +	&sensor_dev_attr_fan1_input.dev_attr.attr,

This attribute is visible even if not supported, meaning it will
report a fan speed of 0 rpm in that case. Please make the attribute
conditional.

>  	NULL,
>  };
>  
> @@ -263,6 +303,19 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	timer_setup(&ctx->sample_timer, sample_timer, 0);
> +
> +	ctx->irq = platform_get_irq(pdev, 0);
> +	if (ctx->irq >= 0) {
> +		ret = devm_request_irq(&pdev->dev, ctx->irq, pulse_handler, 0,
> +				       pdev->name, ctx);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Can't get interrupt working.\n");
> +			return ret;
> +		}
> +		mod_timer(&ctx->sample_timer, jiffies + (HZ * SAMPLE_TIME));
> +	}
> +
>  	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
>  						       ctx, pwm_fan_groups);
>  	if (IS_ERR(hwmon)) {
> @@ -304,6 +357,8 @@ static int pwm_fan_remove(struct platform_device *pdev)
>  	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
>  
>  	thermal_cooling_device_unregister(ctx->cdev);
> +	del_timer_sync(&ctx->sample_timer);
> +
>  	if (ctx->pwm_value)
>  		pwm_disable(ctx->pwm);
>  
