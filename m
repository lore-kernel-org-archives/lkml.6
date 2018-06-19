Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFC3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DA920652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DA920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757351AbeFSVPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:15:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58312 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755424AbeFSVPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:15:01 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVNxj-0003va-6z; Tue, 19 Jun 2018 23:14:51 +0200
Date:   Tue, 19 Jun 2018 23:14:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: Re: [PATCH v10 2/7] time: sync read_boot_clock64() with persistent
 clock
In-Reply-To: <20180615174204.30581-3-pasha.tatashin@oracle.com>
Message-ID: <alpine.DEB.2.21.1806192129460.10546@nanos.tec.linutronix.de>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com> <20180615174204.30581-3-pasha.tatashin@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018, Pavel Tatashin wrote:

> read_boot_clock64() returns a boot start timestamp from epoch. Some arches
> may need to access the persistent clock interface in order to calculate the
> epoch offset. The resolution of the persistent clock, however, might be
> low.  Therefore, in order to avoid time discrepancies a new argument 'now'
> is added to read_boot_clock64() parameters. Arch may decide to use it
> instead of accessing persistent clock again.

I kinda know what you are trying to say, but it's all but obvious.

> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 4786df904c22..fb6898fab374 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1502,9 +1502,13 @@ void __weak read_persistent_clock64(struct timespec64 *ts64)
>   * Function to read the exact time the system has been started.
>   * Returns a timespec64 with tv_sec=0 and tv_nsec=0 if unsupported.
>   *
> + * Argument 'now' contains time from persistent clock to calculate offset from
> + * epoch. May contain zeros if persist ant clock is not available.

What's a 'persist ant' ? 

> + *
>   *  XXX - Do be sure to remove it once all arches implement it.
>   */
> -void __weak read_boot_clock64(struct timespec64 *ts)
> +void __weak __init read_boot_clock64(struct timespec64 *now,
> +				     struct timespec64 *ts)
>  {
>  	ts->tv_sec = 0;
>  	ts->tv_nsec = 0;
> @@ -1535,7 +1539,7 @@ void __init timekeeping_init(void)
>  	} else if (now.tv_sec || now.tv_nsec)
>  		persistent_clock_exists = true;
>  
> -	read_boot_clock64(&boot);
> +	read_boot_clock64(&now, &boot);

This interface was already bolted on and this extension just makes it
worse. If 'now' is invalid then you need the same checks as after
read_persistent_clock() replicated along with conditionals of some sort.

'boot' time is used to adjust the wall to monotonic offset. So looking at
the math behind all of that:

   read_persistent_clock(&now);
   read_boot_clock(&boot);

   tk_set_xtime(tk, now)
     tk->xtime_sec = now.sec;
     tk->xtime_nsec = now.nsec;

  tk_set_wall_to_mono(tk, -boot);
     tk->wall_to_mono = boot;
     tk->offs_real = -boot;

  timekeeping_update(tk)
     tk->tkr_mono = tk->xtime + tk->wall_to_mono;

tkr_mono.base is guaranteed to be >= 0. So you need to make sure that

     tk->xtime + tk->wall_to_mono >= 0

Yet another check which you need to do in that magic function. That's just
wrong. If this grows more users then they all have to copy the same sanity
checks over and over and half of them will be wrong.

Fortunately there is only a single real user of read_boot_clock() in the
tree: S390. By virtue of being S390 there is no worry about any sanity
checks. It just works.

ARM has the function, but there is no single subarch which actually
implements the thing, so this is easy to fix by removing it.

So the right thing to do is the following:

Provide a new function:

void __weak read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
					         ktime_t *boot_offset)
{
	read_persistent_clock(wall_time);
}

Then add the new function to S390:

void read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
     					  ktime_t *boot_offset)
{
        unsigned char clk[STORE_CLOCK_EXT_SIZE];
	struct timespec64 boot_time;
        __u64 delta;

	read_persistent_clock(wall_time);

        delta = initial_leap_seconds + TOD_UNIX_EPOCH;
	memcpy(clk, tod_clock_base, 16);
        *(__u64 *) &clk[1] -= delta;
        if (*(__u64 *) &clk[1] > delta)
                clk[0]--;
        ext_to_timespec64(clk, boot_time);
	*boot_offset = timespec64_to_ns(timespec64_sub(wall_time, boot_time));
}

Then rework timekeeping_init():

timekeeping_init()
   struct timespec64 wall_time, wall_to_mono, offs;
   ktime_t boot_offset = 0;
   
   read_persistent_wall_and_boot_offset(&walltime, &boot_offset);

   if (!valid(walltime))
        boottime = wall_time.tv_sec = wall_time.tv_nsec = 0;
   else
   	persistent_clock = true;

   if (boot_offset > timespec64_to_nsec(wall_time))
       offs.tv_sec = offs.tv_nsec = 0;
   else
       offs = ns_to_timespec64(boot_offset);
  
   wall_to_mono = timespec64_sub(offs, wall_time);
   tk_set_wall_to_mono(tk, wall_time);


After that remove the read_boot_time() leftovers all over the place. And
then the x86 implementation boils down to:

void read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
     					  ktime_t *boot_offset)
{
	 x86_platform.get_wallclock(ts);
	 *boot_offset = sched_clock();
}

And doing it this way - by adding the extra math to the only architecture
on the planet which has sane timers - is the right thing to do because all
other architectures will have to fall back to tricks similar to x86 by
doing clocksource/schedclock based guestimation of the time where the
machine actually reached the kernel.

Hmm?

Thanks,

	tglx
