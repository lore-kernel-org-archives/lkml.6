Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE45BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F1C2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VQAe0AqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfBDPwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:52:17 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34013 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731387AbfBDPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:52:16 -0500
Received: by mail-qt1-f196.google.com with SMTP id b8so409056qtj.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GDbhUEUSKY3TfhUUnP6ma9YxpK9ISI/kdjGBBl6Q+cQ=;
        b=VQAe0AqRzHb2XIhhkKniVVx82OQCqd08ZREzU1OUj4f0a3x0iVuU6UNWqGOG8iD4hy
         o92L+ASCVVCpLdMuTJSRCSko+ihznAM989qXG0gIQ1dMj3ijZXYrkeRSa84Q+6PdCM+V
         5zeP9v2D8V7dh8STctGjnkZ4i5x5YetHqNHXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GDbhUEUSKY3TfhUUnP6ma9YxpK9ISI/kdjGBBl6Q+cQ=;
        b=Q766iRmFK8IlXfy+mxI9CIz5YeHW9CX+7o21x9ueOhY3YQ2aPqBjdO6te4M0uLnP9F
         Xi1/cB5/1PgqsyBJb0Py1TRqrAlbZUzpDk0CMBTi9JdvtkO26l5ahXgWXFZ5VB0YnlCc
         k1VToT2nvzgp6ui7GqQiIlkBldMyl1XzEsQznuz//FbalFClQxO2teiPEQgwftVH2yMX
         4VFFDrd8I6BHup0/TgFL7eMenqLa+Lrc80gy+wK4zrnqf6Ox88+qk5OO8mP3CyNb/6k7
         xKX+HwDRyjky4kqxtgyblNa4Iy1R+9F7oglBohRMJDY0h7yXdGU1ntfXVIQyodzP36Is
         Uu6g==
X-Gm-Message-State: AHQUAubuyFqrcFjfCAnzC2dbQaui7rRs/LoETG7Gt2wO5kRf8yjUiU8a
        jaQDGyOwvtxjJ/MSyFG5XHnSmQ==
X-Google-Smtp-Source: AHgI3IbWkWSWOflHRYgmbJS3IK2adku63rl25+56Gv4vlrcOYKzoc7EckZUZ9Tem85Zk6NHBrF+6iQ==
X-Received: by 2002:a0c:8d8d:: with SMTP id t13mr27012qvb.242.1549295535126;
        Mon, 04 Feb 2019 07:52:15 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id n3sm14882725qtc.81.2019.02.04.07.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 07:52:13 -0800 (PST)
Date:   Mon, 4 Feb 2019 10:52:13 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging/android: simplify handle_vsoc_cond_wait
Message-ID: <20190204155213.GA41502@google.com>
References: <cover.1548998323.git.hle@owl.eu.com>
 <f258c416123048ef9eb78baa8ee891b8aa4f6955.1548998323.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f258c416123048ef9eb78baa8ee891b8aa4f6955.1548998323.git.hle@owl.eu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think you sent to wrong address of Alistair on these and other patches. Corrected address.

On Fri, Feb 01, 2019 at 06:39:03AM +0100, Hugo Lefeuvre wrote:
> simplify handle_vsoc_cond_wait (drivers/staging/android/vsoc.c) using newly
> added wait_event_freezable_hrtimeout helper and remove useless includes.
> 
> Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
> ---
>  drivers/staging/android/vsoc.c | 69 +++++-----------------------------
>  1 file changed, 10 insertions(+), 59 deletions(-)
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
> -- 
> 2.20.1
