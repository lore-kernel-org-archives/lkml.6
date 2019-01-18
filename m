Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC04C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F9220883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="o4mo5ipB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfARPTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:19:45 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39518 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfARPTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:19:45 -0500
Received: by mail-qt1-f196.google.com with SMTP id u47so15542090qtj.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 07:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=98FiCnrw9JYgf+A9kHZFlw177h7QnYfW6Bgdqo25DKk=;
        b=o4mo5ipBUk9/xXbZPBEGvBRxyd/7L8tovfv5XeLAX8wHtUXaUJ/7HumfdP7lY4Fiyy
         kofMpIEOnPfHiiDBKEAln2q3rDCs8BzWmWIJFCVDHYigGlvBcPmdfvs6K+A+FOUnovv0
         lX0rEihiwRxKSqWT5NqjKkOq8ryf6FVZpZMxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=98FiCnrw9JYgf+A9kHZFlw177h7QnYfW6Bgdqo25DKk=;
        b=PtuSY6vVn0CM87FgOs7jPaLDaWYw58UzIAyaXnUKqq1qbvsiulSl9AqjJFYNo3Tq7H
         pDzKJeijgUvpLskQRWXM8jAH/DE/7wYuRN1e8jCsxZdF1WEoSA3FIJy7oTlbzwOZTu2P
         Io+hd7INTDfOKgXPsmW8NE+5CCUGpNEHRgOLrSrMwhwyx7RLjYuaepNTrUu+RhAupK5s
         iCUDvFCaAi1Z1MpDHBQWwnbt2RlEyZtUd67OpI1kmiorp9DrIMAf2nxZaMGXarWVdSNz
         qBBksXvzBp0BHzzhQpTE+arKP/6N7AAjq/X4weMH95uXQ+9gXZnS43cBeyH1KCm4fKFl
         5+Wg==
X-Gm-Message-State: AJcUukfo2YlooiFZMMkh1hTNCx3bJ/iqILCr5C7wox1TsO0Lu9IoQZ+l
        b1kevcvpgCQbSheL+G641aQ++Q==
X-Google-Smtp-Source: ALg8bN6JQ9yLqwJtt6abwCTF8Y+DzgF+buONxjLcEAHu3fbOkBjGnY7MNj+YYFiRUDl8z6jiLB1rmg==
X-Received: by 2002:aed:3aa7:: with SMTP id o36mr16268389qte.240.1547824783575;
        Fri, 18 Jan 2019 07:19:43 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id g23sm66585862qta.24.2019.01.18.07.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 07:19:42 -0800 (PST)
Date:   Fri, 18 Jan 2019 10:19:41 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <strachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/wait: introduce wait_event_freezable_hrtimeout
Message-ID: <20190118151941.GB187589@google.com>
References: <20190117224135.GC8100@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117224135.GC8100@hle-laptop.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugo,

On Thu, Jan 17, 2019 at 11:41:35PM +0100, Hugo Lefeuvre wrote:
> introduce wait_event_freezable_hrtimeout, an interruptible and freezable
> version of wait_event_hrtimeout.
> 
> simplify handle_vsoc_cond_wait (drivers/staging/android/vsoc.c) using this
> newly added helper and remove useless includes.

I believe these should be 2 patches. In the first patch you introduce the
new API, in the second one you would simplify the VSOC driver.

In fact, in one part of the patch you are using wait_event_freezable which
already exists so that's unrelated to the new API you are adding.

More comments below:

> Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
> ---
>  drivers/staging/android/vsoc.c | 69 +++++-----------------------------
>  include/linux/wait.h           | 25 ++++++++++--
>  2 files changed, 31 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
> index 22571abcaa4e..7e620e69f39d 100644
> --- a/drivers/staging/android/vsoc.c
> +++ b/drivers/staging/android/vsoc.c
> @@ -17,7 +17,6 @@
>   */
>  
>  #include <linux/dma-mapping.h>
> -#include <linux/freezer.h>
>  #include <linux/futex.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -29,7 +28,6 @@
>  #include <linux/syscalls.h>
>  #include <linux/uaccess.h>
>  #include <linux/interrupt.h>
> -#include <linux/mutex.h>
>  #include <linux/cdev.h>
>  #include <linux/file.h>
>  #include "uapi/vsoc_shm.h"
> @@ -401,7 +399,6 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
>  	DEFINE_WAIT(wait);
>  	u32 region_number = iminor(file_inode(filp));
>  	struct vsoc_region_data *data = vsoc_dev.regions_data + region_number;
> -	struct hrtimer_sleeper timeout, *to = NULL;
>  	int ret = 0;
>  	struct vsoc_device_region *region_p = vsoc_region_from_filep(filp);
>  	atomic_t *address = NULL;
> @@ -420,69 +417,23 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
>  	/* Ensure that the type of wait is valid */
>  	switch (arg->wait_type) {
>  	case VSOC_WAIT_IF_EQUAL:
> +		ret = wait_event_freezable(data->futex_wait_queue,
> +					   arg->wakes++ &&
> +					   atomic_read(address) != arg->value);
>  		break;
>  	case VSOC_WAIT_IF_EQUAL_TIMEOUT:
> -		to = &timeout;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	if (to) {
> -		/* Copy the user-supplied timesec into the kernel structure.
> -		 * We do things this way to flatten differences between 32 bit
> -		 * and 64 bit timespecs.
> -		 */
>  		if (arg->wake_time_nsec >= NSEC_PER_SEC)
>  			return -EINVAL;
>  		wake_time = ktime_set(arg->wake_time_sec, arg->wake_time_nsec);
> -
> -		hrtimer_init_on_stack(&to->timer, CLOCK_MONOTONIC,
> -				      HRTIMER_MODE_ABS);
> -		hrtimer_set_expires_range_ns(&to->timer, wake_time,
> -					     current->timer_slack_ns);
> -
> -		hrtimer_init_sleeper(to, current);
> +		ret = wait_event_freezable_hrtimeout(data->futex_wait_queue,
> +						     arg->wakes++ &&
> +						     atomic_read(address) != arg->value,
> +						     wake_time);
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
> -	while (1) {
> -		prepare_to_wait(&data->futex_wait_queue, &wait,
> -				TASK_INTERRUPTIBLE);
> -		/*
> -		 * Check the sentinel value after prepare_to_wait. If the value
> -		 * changes after this check the writer will call signal,
> -		 * changing the task state from INTERRUPTIBLE to RUNNING. That
> -		 * will ensure that schedule() will eventually schedule this
> -		 * task.
> -		 */
> -		if (atomic_read(address) != arg->value) {
> -			ret = 0;
> -			break;
> -		}
> -		if (to) {
> -			hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);
> -			if (likely(to->task))
> -				freezable_schedule();
> -			hrtimer_cancel(&to->timer);
> -			if (!to->task) {
> -				ret = -ETIMEDOUT;
> -				break;
> -			}
> -		} else {
> -			freezable_schedule();
> -		}
> -		/* Count the number of times that we woke up. This is useful
> -		 * for unit testing.
> -		 */
> -		++arg->wakes;
> -		if (signal_pending(current)) {
> -			ret = -EINTR;
> -			break;
> -		}
> -	}
> -	finish_wait(&data->futex_wait_queue, &wait);
> -	if (to)
> -		destroy_hrtimer_on_stack(&to->timer);
>  	return ret;
>  }
>  
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index ed7c122cb31f..13a454884f8b 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -483,7 +483,7 @@ do {										\
>  	__ret;									\
>  })
>  
> -#define __wait_event_hrtimeout(wq_head, condition, timeout, state)		\
> +#define __wait_event_hrtimeout(wq_head, condition, timeout, state, cmd)		\
>  ({										\
>  	int __ret = 0;								\
>  	struct hrtimer_sleeper __t;						\
> @@ -500,7 +500,7 @@ do {										\
>  			__ret = -ETIME;						\
>  			break;							\
>  		}								\
> -		schedule());							\
> +		cmd);							        \
>  										\
>  	hrtimer_cancel(&__t.timer);						\
>  	destroy_hrtimer_on_stack(&__t.timer);					\
> @@ -529,7 +529,23 @@ do {										\
>  	might_sleep();								\
>  	if (!(condition))							\
>  		__ret = __wait_event_hrtimeout(wq_head, condition, timeout,	\
> -					       TASK_UNINTERRUPTIBLE);		\
> +					       TASK_UNINTERRUPTIBLE,		\
> +					       schedule());			\
> +	__ret;									\
> +})
> +
> +/*
> + * like wait_event_hrtimeout() -- except it uses TASK_INTERRUPTIBLE to avoid
> + * increasing load and is freezable.
> + */
> +#define wait_event_freezable_hrtimeout(wq_head, condition, timeout)		\

You should document the variable names in the header comments.

Also, this new API appears to conflict with definition of 'freezable' in
wait_event_freezable I think,

wait_event_freezable - sleep or freeze until condition is true.

wait_event_freezable_hrtimeout - sleep but make sure freezer is not blocked.
(your API)

It seems to me these are 2 different definitions of 'freezing' (or I could be
completely confused). But in the first case it calls try_to_freeze after
schedule(). In the second case (your new API), it calls freezable_schedule().

So I am wondering why is there this difference in the 'meaning of freezable'.
In the very least, any such subtle differences should be documented in the
header comments IMO.

thanks!

 - Joel

