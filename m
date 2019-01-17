Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEFBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E06F20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF1ItXkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfAQVY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:24:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35086 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfAQVY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:24:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so5451934pfi.2;
        Thu, 17 Jan 2019 13:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NWGobzW0BYoOoe4sPTgj6HUlUWE+wmwldwmLOgXsgc0=;
        b=FF1ItXkFJeN9zJSqe3b0wpCdljB//VtxEpNWDdqXWZARIBgeeh0E/VgREqWe7bWl0h
         K6LYRaY2OpjCcKHuhAQjsV8Ha4sFwpl09SK3o+WbQVGqCD+8NcwZhzNmcwh0PZB6lOks
         Ijf5PXE0ebqkTenmvSrRV460B7fAKBw2MAF9YCTl6zOAmZfodUgas5ylXHnaflKUSl8r
         mtciYrj/B2+osABSo1+PC13cE0wm3bXUBvjFbhmtNiIoeznrMD5czz1NUZpG9YKH9KjT
         nkXatCNSFFDi2rTBO08NIpwSVlpX8rRfSqf5inc6a5WCg/bMAZHtV8mUhZJJTFDHz7Pt
         DLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NWGobzW0BYoOoe4sPTgj6HUlUWE+wmwldwmLOgXsgc0=;
        b=Q8j+j85+yi6uIYlBKpwpH7BLxuBaqZ0QY0pV7Xldw7erZBR7M52Nb4ZwfNYf6qtZwy
         A7H+RUmGHMy07oXVEZds6VP27ypFycgvRNWeZGBhWHIFZ+eWvtTuHVK7m4iJ+291JPgo
         b7SkkaYUq5jLBEfECEA9rG1BxO76B+MapeM709gm0dcxcbrAHaESQE91/YibYrcepDz4
         K8SwC6mynSve7dLmZJS3r23uo/V1OAN9bM4nWJTR+9w/I3unsVg9bLjslpjSNCj039iW
         nQ/Ft1XUMQKZ40mRi90WSoHz1w7VLIF5tXP6unTXBhrDPUGj/OZifKAEC4/MO6MTya0P
         pvbw==
X-Gm-Message-State: AJcUukcEqX63jpVI7fC0AVutTZK+TlKE2vetmjwPPFpPuOyV0fqsoBSk
        bJlzMAfkT3WOUHFyF64HBSg=
X-Google-Smtp-Source: ALg8bN4cVA5bppw+sIvFAqyvxZwwO3gZAjZJQgilq2K0MvKcr/+z5r8kCoAWM6nMqHL/07oBWJa7LA==
X-Received: by 2002:a63:9501:: with SMTP id p1mr15002034pgd.149.1547760265539;
        Thu, 17 Jan 2019 13:24:25 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b9sm3304218pfi.118.2019.01.17.13.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 13:24:24 -0800 (PST)
Date:   Thu, 17 Jan 2019 13:24:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Esben Haabendal <esben@haabendal.dk>,
        "martin@hundeboll.net" <martin@hundeboll.net>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: Re: [PATCH v8 1/3] watchdog: introduce watchdog.open_timeout
 commandline parameter
Message-ID: <20190117212423.GA14108@roeck-us.net>
References: <20190116121432.26732-1-rasmus.villemoes@prevas.dk>
 <20190116121432.26732-2-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116121432.26732-2-rasmus.villemoes@prevas.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 12:14:42PM +0000, Rasmus Villemoes wrote:
> The watchdog framework takes care of feeding a hardware watchdog until
> userspace opens /dev/watchdogN. If that never happens for some reason
> (buggy init script, corrupt root filesystem or whatnot) but the kernel
> itself is fine, the machine stays up indefinitely. This patch allows
> setting an upper limit for how long the kernel will take care of the
> watchdog, thus ensuring that the watchdog will eventually reset the
> machine.
> 
> A value of 0 (the default) means infinite timeout, preserving the
> current behaviour.
> 
> This is particularly useful for embedded devices where some fallback
> logic is implemented in the bootloader (e.g., use a different root
> partition, boot from network, ...).
> 
> There is already handle_boot_enabled serving a similar purpose. However,
> such a binary choice is unsuitable if the hardware watchdog cannot be
> programmed by the bootloader to provide a timeout long enough for
> userspace to get up and running. Many of the embedded devices we see use
> external (gpio-triggered) watchdogs with a fixed timeout of the order of
> 1-2 seconds.
> 
> The open timeout is also used as a maximum time for an application to
> re-open /dev/watchdogN after closing it. Again, while the kernel already
> has a nowayout mechanism, using that means userspace is at the mercy of
> whatever timeout the hardware has.
> 
> Being a module parameter, one can revert to the ordinary behaviour of
> having the kernel maintain the watchdog indefinitely by simply writing 0
> to /sys/... after initially opening /dev/watchdog; conversely, one can
> of course also have the current behaviour of allowing indefinite time
> until the first open, and then set that module parameter.
> 
> The unit is milliseconds rather than seconds because that covers more
> use cases. For example, userspace might need a long time to get in the
> air initially, requiring a somewhat liberal open_timeout, but when (for
> whatever reason) the application might then want to re-exec itself, it
> can set a much smaller threshold.
> 

I don't buy this use case. We are not in control of the exact time between
hand-off to the Linux kernel and to driver instantiation, and we can not even
measure it. A less-than-one second granularity, especially since it is from
instantiation time and not even from handoff time, does not really make
sense and would only create a false impression of accuracy. Let's stick with
seconds.

Guenter

> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  .../watchdog/watchdog-parameters.txt          |  8 +++++
>  drivers/watchdog/watchdog_dev.c               | 30 +++++++++++++++++--
>  2 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index 0b88e333f9e1..5e4235989154 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -8,6 +8,14 @@ See Documentation/admin-guide/kernel-parameters.rst for information on
>  providing kernel parameters for builtin drivers versus loadable
>  modules.
>  
> +The watchdog core parameter watchdog.open_timeout is the maximum time,
> +in milliseconds, for which the watchdog framework will take care of
> +pinging a hardware watchdog until userspace opens the corresponding
> +/dev/watchdogN device. A value of 0 (the default) means an infinite
> +timeout. Setting this to a non-zero value can be useful to ensure that
> +either userspace comes up properly, or the board gets reset and allows
> +fallback logic in the bootloader to try something else.
> +
>  
>  -------------------------------------------------
>  acquirewdt:
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index f6c24b22b37c..a9585925458f 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -69,6 +69,7 @@ struct watchdog_core_data {
>  	struct mutex lock;
>  	ktime_t last_keepalive;
>  	ktime_t last_hw_keepalive;
> +	ktime_t open_deadline;
>  	struct hrtimer timer;
>  	struct kthread_work work;
>  	unsigned long status;		/* Internal status bits */
> @@ -87,6 +88,19 @@ static struct kthread_worker *watchdog_kworker;
>  static bool handle_boot_enabled =
>  	IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED);
>  
> +static unsigned open_timeout;
> +
> +static bool watchdog_past_open_deadline(struct watchdog_core_data *data)
> +{
> +	return ktime_after(ktime_get(), data->open_deadline);
> +}
> +
> +static void watchdog_set_open_deadline(struct watchdog_core_data *data)
> +{
> +	data->open_deadline = open_timeout ?
> +		ktime_get() + ms_to_ktime(open_timeout) : KTIME_MAX;
> +}
> +
>  static inline bool watchdog_need_worker(struct watchdog_device *wdd)
>  {
>  	/* All variables in milli-seconds */
> @@ -211,7 +225,13 @@ static bool watchdog_worker_should_ping(struct watchdog_core_data *wd_data)
>  {
>  	struct watchdog_device *wdd = wd_data->wdd;
>  
> -	return wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd));
> +	if (!wdd)
> +		return false;
> +
> +	if (watchdog_active(wdd))
> +		return true;
> +
> +	return watchdog_hw_running(wdd) && !watchdog_past_open_deadline(wd_data);
>  }
>  
>  static void watchdog_ping_work(struct kthread_work *work)
> @@ -297,7 +317,7 @@ static int watchdog_stop(struct watchdog_device *wdd)
>  		return -EBUSY;
>  	}
>  
> -	if (wdd->ops->stop) {
> +	if (wdd->ops->stop && !open_timeout) {
>  		clear_bit(WDOG_HW_RUNNING, &wdd->status);
>  		err = wdd->ops->stop(wdd);
>  	} else {
> @@ -883,6 +903,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
>  		watchdog_ping(wdd);
>  	}
>  
> +	watchdog_set_open_deadline(wd_data);
>  	watchdog_update_worker(wdd);
>  
>  	/* make sure that /dev/watchdog can be re-opened */
> @@ -983,6 +1004,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
>  
>  	/* Record time of most recent heartbeat as 'just before now'. */
>  	wd_data->last_hw_keepalive = ktime_sub(ktime_get(), 1);
> +	watchdog_set_open_deadline(wd_data);
>  
>  	/*
>  	 * If the watchdog is running, prevent its driver from being unloaded,
> @@ -1181,3 +1203,7 @@ module_param(handle_boot_enabled, bool, 0444);
>  MODULE_PARM_DESC(handle_boot_enabled,
>  	"Watchdog core auto-updates boot enabled watchdogs before userspace takes over (default="
>  	__MODULE_STRING(IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)) ")");
> +
> +module_param(open_timeout, uint, 0644);
> +MODULE_PARM_DESC(open_timeout,
> +	"Maximum time (in milliseconds, 0 means infinity) for userspace to take over a running watchdog (default=0)");
> -- 
> 2.20.1
> 
