Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeCJILb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 03:11:31 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38573 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeCJILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 03:11:30 -0500
X-Google-Smtp-Source: AG47ELtCKElhwJ8VF38rTXKR4z205/M9VoJn9gz5pW/4VbLyImTDCeK9zklhcNWJVxTd+PRF+LCOLw==
Date: Sat, 10 Mar 2018 09:11:23 +0100
From: Ingo Molnar <mingo@kernel.org>
To: John Stultz <john.stultz@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <stephen.boyd@linaro.org>
Subject: Re: [PATCH 3/4] y2038: time: Introduce struct __kernel_old_timeval
Message-ID: <20180310081123.thin6wphgk7tongy@gmail.com>
References: <1520620971-9567-1-git-send-email-john.stultz@linaro.org>
 <1520620971-9567-4-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520620971-9567-4-git-send-email-john.stultz@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +extern struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec);

Generally there's no need to mark arguments with arithmethic types as const, as 
they are never modified in the calling scope.

> + * legacy timeval structure, only embedded in structures that
> + * traditionally used 'timeval' to pass time intervals (not absolute
> + * times). Do not add new users. If user space fails to compile
> + * here, this is probably because it is not y2038 safe and needs to
> + * be changed to use another interface.
> + */
> +struct __kernel_old_timeval {
> +	__kernel_long_t tv_sec;			/* seconds */
> +	__kernel_long_t tv_usec;		/* seconds */

s/seconds/microseconds

> +struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)
> +{
> +	struct timespec64 ts = ns_to_timespec64(nsec);
> +	struct __kernel_old_timeval tv;
> +
> +	tv.tv_sec = ts.tv_sec;
> +	tv.tv_usec = (suseconds_t) ts.tv_nsec / 1000;

Is ts.tv_nsec guaranteed to never have bits set in the high 32 bits?

In any case, the space before the type cast is a bit confusing to me, I think it 
should be written as:

	tv.tv_usec = (suseconds_t)ts.tv_nsec / 1000;

To better show was the higher precedence of the cast is going to result in.

Thanks,

	Ingo
