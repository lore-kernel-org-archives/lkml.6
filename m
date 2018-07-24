Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F64ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE87D20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g28mt7Xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE87D20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbeGXCLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:11:46 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45978 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388188AbeGXCLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:11:46 -0400
Received: by mail-pl0-f66.google.com with SMTP id j8-v6so897312pll.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 18:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zyZf6/KqGIMDgpREyYCY0R+wT7ZUloWtCIe+utSRNvA=;
        b=g28mt7XjpQhdpjpsv/mXKwK35op4V0qTPGg7atWlYvMXGA1HP+vvdLXVdABi6noU+Q
         WJTLlCHae3CXav1JaoHQYUqTbewytUaXCo0tO/O7T9FjWji31ButcvmMDazdLA7g4WlZ
         Jd7bfMKqGAUMPJ/1/3PAgmhPKZIJ3dHCBJs+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zyZf6/KqGIMDgpREyYCY0R+wT7ZUloWtCIe+utSRNvA=;
        b=unP8W96j+L9ckGAbKHR9BAvt62nMKubSAx7NdCm9pfKPbzUfJGmJw7KJ5Dp5odv+WN
         54kWcVFPLf8FdtXNXlQDNDOkTn7R1cs7jblmcWZ4dAYXnscN55oagZFoJgwZ7fe9eL49
         JxC0+r8fMc2+Rd+MNKExXIN/BHGQcU2+RfngTUf7RZEsM/FHcVu8TnF6tThGa1LHV/iM
         xGBbemXVC4zzjecBwVNqgbuSXQzIMqDcGRE7mMIjYBAjW0DHeegZyFjkQaDVwccNdEiQ
         QVCAyMtomN/AnppoIxMcBXzsn4yyuxhSMb7pg4L69awMNEwdVpn2icsjTw5TfAoEw3x+
         haDQ==
X-Gm-Message-State: AOUpUlF0LGPvZT18+hP1U0g86JR+DHomR3C5OJZZ+a97vRLQPEOWvJ2O
        M/LWHvL56QuZI5r0yoI9Ib2oyQ==
X-Google-Smtp-Source: AAOMgpf1U3PUA5VkiFkKu079QFbqBQylhk31lTeJaaVjouHsFsYsC+VTrtZivzcOHpxtaKrPibVVcA==
X-Received: by 2002:a17:902:8d98:: with SMTP id v24-v6mr14912428plo.250.1532394474378;
        Mon, 23 Jul 2018 18:07:54 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 87-v6sm21496387pfn.103.2018.07.23.18.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 18:07:53 -0700 (PDT)
Date:   Mon, 23 Jul 2018 18:06:49 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, david@lechnology.com,
        broonie@kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] leds: core: Introduce generic pattern interface
Message-ID: <20180724010649.GH30024@minitux>
References: <05c235df7bbcc4b898e7b263bf38338d9c822005.1531711385.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05c235df7bbcc4b898e7b263bf38338d9c822005.1531711385.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16 Jul 04:10 PDT 2018, Baolin Wang wrote:

> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Some LED controllers have support for autonomously controlling
> brightness over time, according to some preprogrammed pattern or
> function.
> 
> This adds a new optional operator that LED class drivers can implement
> if they support such functionality as well as a new device attribute to
> configure the pattern for a given LED.
> 
> [Baolin Wang did some improvements.]
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

I'm happy to see that you found this patch useful and think the patch
looks good.

> ---
> Changes from v4:
>  - Fix some typos.
>  - Check if pattern_clear() is initialized.
> 
> Changes from v3:
>  - Move the check in pattern_show() to of_led_classdev_register().
>  - Add more documentation to explain how to set/clear one pattern.
> 
> Changes from v2:
>  - Change kernel version to 4.19.
>  - Force user to return error pointer if failed to issue pattern_get().
>  - Use strstrip() to trim trailing newline.
>  - Other optimization.
> 
> Changes from v1:
>  - Add some comments suggested by Pavel.
>  - Change 'delta_t' can be 0.
> 
> Note: I removed the pattern repeat check and will get the repeat number by adding
> one extra file named 'pattern_repeat' according to previous discussion.

In the Qualcomm LPG it's possible to specify if the pattern should be
run through once of repeated continuously, so if you provide the means
to control this by a separately I don't see a problem with this.

Regards,
Bjorn

> ---
>  Documentation/ABI/testing/sysfs-class-led |   20 +++++
>  drivers/leds/led-class.c                  |  118 +++++++++++++++++++++++++++++
>  include/linux/leds.h                      |   19 +++++
>  3 files changed, 157 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentation/ABI/testing/sysfs-class-led
> index 5f67f7a..a040fd0 100644
> --- a/Documentation/ABI/testing/sysfs-class-led
> +++ b/Documentation/ABI/testing/sysfs-class-led
> @@ -61,3 +61,23 @@ Description:
>  		gpio and backlight triggers. In case of the backlight trigger,
>  		it is useful when driving a LED which is intended to indicate
>  		a device in a standby like state.
> +
> +What: /sys/class/leds/<led>/pattern
> +Date:		July 2018
> +KernelVersion:	4.19
> +Description:
> +		Specify a pattern for the LED, for LED hardware that support
> +		altering the brightness as a function of time.
> +
> +		The pattern is given by a series of tuples, of brightness and
> +		duration (ms). The LED is expected to traverse the series and
> +		each brightness value for the specified duration. Duration of
> +		0 means brightness should immediately change to new value.
> +
> +		As LED hardware might have different capabilities and precision
> +		the requested pattern might be slighly adjusted by the driver
> +		and the resulting pattern of such operation should be returned
> +		when this file is read.
> +
> +		Writing non-empty string to this file will activate the pattern,
> +		and empty string will disable the pattern.
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 3c7e348..5c6d2e9 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -74,6 +74,118 @@ static ssize_t max_brightness_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(max_brightness);
>  
> +static ssize_t pattern_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct led_pattern *pattern;
> +	size_t offset = 0;
> +	int count, n, i;
> +
> +	pattern = led_cdev->pattern_get(led_cdev, &count);
> +	if (IS_ERR(pattern))
> +		return PTR_ERR(pattern);
> +
> +	for (i = 0; i < count; i++) {
> +		n = snprintf(buf + offset, PAGE_SIZE - offset, "%d %d ",
> +			     pattern[i].brightness, pattern[i].delta_t);
> +
> +		if (offset + n >= PAGE_SIZE)
> +			goto err_nospc;
> +
> +		offset += n;
> +	}
> +
> +	buf[offset - 1] = '\n';
> +
> +	kfree(pattern);
> +	return offset;
> +
> +err_nospc:
> +	kfree(pattern);
> +	return -ENOSPC;
> +}
> +
> +static ssize_t pattern_store(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t size)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct led_pattern *pattern = NULL;
> +	char *sbegin, *elem, *s;
> +	unsigned long val;
> +	int ret = 0, len = 0;
> +	bool odd = true;
> +
> +	sbegin = kstrndup(buf, size, GFP_KERNEL);
> +	if (!sbegin)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Trim trailing newline, if the remaining string is empty,
> +	 * clear the pattern.
> +	 */
> +	s = strstrip(sbegin);
> +	if (!*s) {
> +		ret = led_cdev->pattern_clear(led_cdev);
> +		goto out;
> +	}
> +
> +	pattern = kcalloc(size, sizeof(*pattern), GFP_KERNEL);
> +	if (!pattern) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Parse out the brightness & delta_t touples */
> +	while ((elem = strsep(&s, " ")) != NULL) {
> +		ret = kstrtoul(elem, 10, &val);
> +		if (ret)
> +			goto out;
> +
> +		if (odd) {
> +			pattern[len].brightness = val;
> +		} else {
> +			pattern[len].delta_t = val;
> +			len++;
> +		}
> +
> +		odd = !odd;
> +	}
> +
> +	/*
> +	 * Fail if we didn't find any data points or last data point was partial
> +	 */
> +	if (!len || !odd) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = led_cdev->pattern_set(led_cdev, pattern, len);
> +
> +out:
> +	kfree(pattern);
> +	kfree(sbegin);
> +	return ret < 0 ? ret : size;
> +}
> +static DEVICE_ATTR_RW(pattern);
> +
> +static umode_t led_class_attrs_mode(struct kobject *kobj,
> +				    struct attribute *attr, int index)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +
> +	if (attr == &dev_attr_brightness.attr)
> +		return attr->mode;
> +	if (attr == &dev_attr_max_brightness.attr)
> +		return attr->mode;
> +	if (attr == &dev_attr_pattern.attr && led_cdev->pattern_set)
> +		return attr->mode;
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_LEDS_TRIGGERS
>  static DEVICE_ATTR(trigger, 0644, led_trigger_show, led_trigger_store);
>  static struct attribute *led_trigger_attrs[] = {
> @@ -88,11 +200,13 @@ static ssize_t max_brightness_show(struct device *dev,
>  static struct attribute *led_class_attrs[] = {
>  	&dev_attr_brightness.attr,
>  	&dev_attr_max_brightness.attr,
> +	&dev_attr_pattern.attr,
>  	NULL,
>  };
>  
>  static const struct attribute_group led_group = {
>  	.attrs = led_class_attrs,
> +	.is_visible = led_class_attrs_mode,
>  };
>  
>  static const struct attribute_group *led_groups[] = {
> @@ -256,6 +370,10 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
>  	char name[LED_MAX_NAME_SIZE];
>  	int ret;
>  
> +	if (led_cdev->pattern_set &&
> +	    (!led_cdev->pattern_get || !led_cdev->pattern_clear))
> +		return -EINVAL;
> +
>  	ret = led_classdev_next_name(led_cdev->name, name, sizeof(name));
>  	if (ret < 0)
>  		return ret;
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index b7e8255..5f1c751 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -22,6 +22,7 @@
>  #include <linux/workqueue.h>
>  
>  struct device;
> +struct led_pattern;
>  /*
>   * LED Core
>   */
> @@ -88,6 +89,14 @@ struct led_classdev {
>  				     unsigned long *delay_on,
>  				     unsigned long *delay_off);
>  
> +	int (*pattern_set)(struct led_classdev *led_cdev,
> +			   struct led_pattern *pattern, int len);
> +
> +	int (*pattern_clear)(struct led_classdev *led_cdev);
> +
> +	struct led_pattern *(*pattern_get)(struct led_classdev *led_cdev,
> +					   int *len);
> +
>  	struct device		*dev;
>  	const struct attribute_group	**groups;
>  
> @@ -446,4 +455,14 @@ static inline void led_classdev_notify_brightness_hw_changed(
>  	struct led_classdev *led_cdev, enum led_brightness brightness) { }
>  #endif
>  
> +/**
> + * struct led_pattern - brightness value in a pattern
> + * @delta_t: delay until next entry, in milliseconds
> + * @brightness: brightness at time = 0
> + */
> +struct led_pattern {
> +	int delta_t;
> +	int brightness;
> +};
> +
>  #endif		/* __LINUX_LEDS_H_INCLUDED */
> -- 
> 1.7.9.5
> 
