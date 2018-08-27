Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37F3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F42F208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F42F208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeH1AJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:09:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35492 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeH1AJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:09:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fuO13-0004vZ-Dv; Mon, 27 Aug 2018 20:21:37 +0000
Date:   Mon, 27 Aug 2018 21:21:37 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, keguang.zhang@gmail.com,
        y2038@lists.linaro.org, Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: move compat_ioctl handling into rtc-dev.c
Message-ID: <20180827202137.GD6515@ZenIV.linux.org.uk>
References: <20180827200338.220211-1-arnd@arndb.de>
 <20180827200338.220211-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827200338.220211-2-arnd@arndb.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 10:03:09PM +0200, Arnd Bergmann wrote:

> +#ifdef CONFIG_COMPAT
> +#define RTC_IRQP_READ32		_IOR('p', 0x0b, compat_ulong_t)
> +#define RTC_IRQP_SET32		_IOW('p', 0x0c, compat_ulong_t)
> +#define RTC_EPOCH_READ32	_IOR('p', 0x0d, compat_ulong_t)
> +#define RTC_EPOCH_SET32		_IOW('p', 0x0e, compat_ulong_t)
> +
> +static long rtc_dev_compat_ioctl(struct file *file, unsigned cmd, unsigned long arg)
> +{
> +	unsigned long __user *valp;
> +	compat_ulong_t __user *argp = compat_ptr(arg);
> +	unsigned long val;
> +	int ret;
> +
> +	switch (cmd) {
> +	/* pointer to 'long' needs translation. */
> +	case RTC_IRQP_READ32:
> +	case RTC_EPOCH_READ32: {
> +		valp = compat_alloc_user_space(sizeof(*valp));
> +		if (valp == NULL)
> +			return -EFAULT;
> +		ret = rtc_dev_ioctl(file, (cmd == RTC_IRQP_READ32) ?
> +					RTC_IRQP_READ : RTC_EPOCH_READ,
> +					(unsigned long)valp);
> +		if (ret)
> +			return ret;
> +		if (get_user(val, valp) || put_user(val, argp))
> +			return -EFAULT;

	No.  With the side of Hell, No.  This is bloody ridiculous - take a look
at rtc_dev_ioctl().  Seriously.  Relevant bits:
        struct rtc_device *rtc = file->private_data;
        const struct rtc_class_ops *ops = rtc->ops;
        struct rtc_time tm;
        struct rtc_wkalrm alarm;
        void __user *uarg = (void __user *) arg;

        err = mutex_lock_interruptible(&rtc->ops_lock);
        if (err)
                return err;

                err = put_user(rtc->irq_freq, (unsigned long __user *)uarg);

        mutex_unlock(&rtc->ops_lock);
        return err;

That's RTC_IRQP_READ.  IOW, all that song and dance starting with
compat_alloc_user_space() is just a way to get to rtc->irq_freq value.


RTC_EPOCH_READ is in the bowels of individual implementations, but it's
otherwise very similar; add a method returning the damn thing (e.g.
rtc->ops->get_epoch(rtc)) and lift its call into rtc_dev_ioctl(), then
this nonsense will go away as well.

> +		return 0;
> +	}
> +
> +	/* arguments are compatible, command number is not */
> +	case RTC_IRQP_SET32:
> +		return rtc_dev_ioctl(file, RTC_IRQP_SET, arg);
ITYM
		cmd = RTC_IRQP_SET;
		break;
> +	case RTC_EPOCH_SET32:
... and
		cmd = RTC_EPOCH_SET;
		break;
here.
> +		return rtc_dev_ioctl(file, RTC_EPOCH_SET, arg);
> +	}
> +
> +	/*
> +	 * all other rtc ioctls are compatible, or only
> +	 * exist on architectures without compat mode
> +	 */
> +
> +	return rtc_dev_ioctl(file, cmd, (unsigned long)argp);
> +}

compat_alloc_user_space() is usually papering over bogosities like
that; if you are moving something out to individual drivers, it's
always a red flag - most of the time it'll turn out to be pointless.
