Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbeCPACK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 20:02:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54700 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbeCPACJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 20:02:09 -0400
Date: Fri, 16 Mar 2018 01:02:04 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
cc: John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] y2038: introduce struct __kernel_old_timeval
In-Reply-To: <20180315161739.576085-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1803160059380.1520@nanos.tec.linutronix.de>
References: <20180315161739.576085-1-arnd@arndb.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Arnd Bergmann wrote:
> + * legacy timeval structure, only embedded in structures that
> + * traditionally used 'timeval' to pass time intervals (not absolute
> + * times). Do not add new users. If user space fails to compile
> + * here, this is probably because it is not y2038 safe and needs to
> + * be changed to use another interface.
> + */
> +struct __kernel_old_timeval {
> +	__kernel_long_t tv_sec;
> +	__kernel_long_t tv_usec;
> +};
> +
> +/*
>   * The IDs of the various system clocks (for POSIX.1b interval timers):
>   */
>  #define CLOCK_REALTIME			0
> diff --git a/kernel/time/time.c b/kernel/time/time.c
> index 5db8f15ec056..6fa99213fc72 100644
> --- a/kernel/time/time.c
> +++ b/kernel/time/time.c
> @@ -486,6 +486,18 @@ struct timeval ns_to_timeval(const s64 nsec)
>  }
>  EXPORT_SYMBOL(ns_to_timeval);
>  
> +struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)
> +{
> +	struct timespec64 ts = ns_to_timespec64(nsec);
> +	struct __kernel_old_timeval tv;
> +
> +	tv.tv_sec = ts.tv_sec;

We might think about adding some debug aid here which yells when ts.tv_sec
is > than the cutoff.

Hmm?

	tglx
