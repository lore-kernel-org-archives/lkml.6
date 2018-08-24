Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63323C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A3020A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A3020A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeHXX1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:27:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbeHXX1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:27:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DCF287A74;
        Fri, 24 Aug 2018 19:51:08 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-4.rdu2.redhat.com [10.10.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10C012166BA4;
        Fri, 24 Aug 2018 19:51:02 +0000 (UTC)
Date:   Fri, 24 Aug 2018 15:47:03 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH ghak10 v5 2/2] timekeeping/ntp: Audit clock/NTP params
 adjustments
Message-ID: <20180824194703.h3mbuhrxzixmna4e@madcap2.tricolour.ca>
References: <20180824120001.20771-1-omosnace@redhat.com>
 <20180824120001.20771-3-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824120001.20771-3-omosnace@redhat.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 24 Aug 2018 19:51:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 24 Aug 2018 19:51:08 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-24 14:00, Ondrej Mosnacek wrote:
> This patch adds logging of all attempts to either inject an offset into
> the clock (producing an AUDIT_TIME_INJOFFSET record) or adjust an NTP
> parameter (producing an AUDIT_TIME_ADJNTPVAL record).

I thought I saw it suggested earlier in one of the replies to a previous
revision of the patchset to separate the two types of records with their
calling circumstances.  The inj-offset bits could stand alone in their
own patch leaving all the rest in its own patch.  The record numbers and
examples are easier to offer when given together, but they aren't as
clear they are indepnendent records and callers.  That way, each patch
stands on its own.  (more below)

> For reference, running the following commands:
> 
>     auditctl -D
>     auditctl -a exit,always -F arch=b64 -S adjtimex
>     chronyd -q
> 
> produces audit records like this:
> 
> type=TIME_ADJNTPVAL msg=audit(1530616044.507:5): op=adjust old=0 new=0
> type=SYSCALL msg=audit(1530616044.507:5): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78c00 a1=0 a2=4 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
> type=PROCTITLE msg=audit(1530616044.507:5): proctitle=6368726F6E7964002D71
> type=SYSCALL msg=audit(1530616044.507:6): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78c00 a1=1 a2=1 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
> type=PROCTITLE msg=audit(1530616044.507:6): proctitle=6368726F6E7964002D71
> type=TIME_INJOFFSET msg=audit(1530616044.507:7): sec=0 nsec=0
> type=TIME_ADJNTPVAL msg=audit(1530616044.507:7): op=status old=64 new=8256
> type=SYSCALL msg=audit(1530616044.507:7): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78c00 a1=1 a2=1 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
> type=PROCTITLE msg=audit(1530616044.507:7): proctitle=6368726F6E7964002D71
> type=TIME_ADJNTPVAL msg=audit(1530616044.507:8): op=status old=8256 new=8257
> type=TIME_ADJNTPVAL msg=audit(1530616044.507:8): op=offset old=0 new=0
> type=TIME_ADJNTPVAL msg=audit(1530616044.507:8): op=freq old=0 new=0
> type=SYSCALL msg=audit(1530616044.507:8): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78ab0 a1=0 a2=55e129c850c0 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
> type=PROCTITLE msg=audit(1530616044.507:8): proctitle=6368726F6E7964002D71
> type=TIME_ADJNTPVAL msg=audit(1530616044.507:9): op=status old=8257 new=64
> type=SYSCALL msg=audit(1530616044.507:9): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78ab0 a1=0 a2=55e129c850c0 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
> type=PROCTITLE msg=audit(1530616044.507:9): proctitle=6368726F6E7964002D71
> type=SYSCALL msg=audit(1530616044.507:10): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78a70 a1=0 a2=55e129c850c0 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
> type=PROCTITLE msg=audit(1530616044.507:10): proctitle=6368726F6E7964002D71
> type=TIME_ADJNTPVAL msg=audit(1530616044.511:11): op=freq old=0 new=49180377088000
> type=TIME_ADJNTPVAL msg=audit(1530616044.511:11): op=tick old=10000 new=10000
> type=SYSCALL msg=audit(1530616044.511:11): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78ad0 a1=0 a2=2710 a3=f42f82a800000 items=0 ppid=626 pid=629 auid=0 uid=385 gid=382 euid=385 suid=385 fsuid=385 egid=382 sgid=382 fsgid=382 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
> type=PROCTITLE msg=audit(1530616044.511:11): proctitle=6368726F6E7964002D71
> type=TIME_ADJNTPVAL msg=audit(1530616044.521:12): op=status old=64 new=64
> type=SYSCALL msg=audit(1530616044.521:12): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78b40 a1=1 a2=40 a3=f91f6ef84fbab items=0 ppid=626 pid=629 auid=0 uid=385 gid=382 euid=385 suid=385 fsuid=385 egid=382 sgid=382 fsgid=382 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
> type=PROCTITLE msg=audit(1530616044.521:12): proctitle=6368726F6E7964002D71
> type=TIME_INJOFFSET msg=audit(1530616049.652:13): sec=-16 nsec=124887145
> type=TIME_ADJNTPVAL msg=audit(1530616049.652:13): op=status old=64 new=8256
> type=SYSCALL msg=audit(1530616049.652:13): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78270 a1=1 a2=fffffffffffffff0 a3=137b828205ca12 items=0 ppid=626 pid=629 auid=0 uid=385 gid=382 euid=385 suid=385 fsuid=385 egid=382 sgid=382 fsgid=382 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
> type=PROCTITLE msg=audit(1530616049.652:13): proctitle=6368726F6E7964002D71
> type=TIME_ADJNTPVAL msg=audit(1530616033.783:14): op=freq old=49180377088000 new=49180377088000
> type=TIME_ADJNTPVAL msg=audit(1530616033.783:14): op=tick old=10000 new=10000
> type=SYSCALL msg=audit(1530616033.783:14): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78bc0 a1=0 a2=2710 a3=0 items=0 ppid=626 pid=629 auid=0 uid=385 gid=382 euid=385 suid=385 fsuid=385 egid=382 sgid=382 fsgid=382 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
> type=PROCTITLE msg=audit(1530616033.783:14): proctitle=6368726F6E7964002D71
> 
> The chronyd command that produced the above records executed the
> following adjtimex(2) syscalls (as per strace output):
> 
> adjtimex({modes=ADJ_OFFSET|0x8000, offset=0, freq=0, maxerror=16000000, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=507215}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
> adjtimex({modes=ADJ_MAXERROR, offset=0, freq=0, maxerror=0, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=507438}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
> adjtimex({modes=ADJ_SETOFFSET|ADJ_NANO, offset=0, freq=0, maxerror=16000000, esterror=16000000, status=STA_UNSYNC|STA_NANO, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=507604737}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
> adjtimex({modes=ADJ_OFFSET|ADJ_STATUS, offset=0, freq=0, maxerror=16000000, esterror=16000000, status=STA_PLL|STA_UNSYNC|STA_NANO, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=507698330}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
> adjtimex({modes=ADJ_STATUS, offset=0, freq=0, maxerror=16000000, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=507792}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
> adjtimex({modes=0, offset=0, freq=0, maxerror=16000000, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=508000}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
> adjtimex({modes=ADJ_FREQUENCY|ADJ_TICK, offset=0, freq=750433, maxerror=16000000, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=512146}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
> adjtimex({modes=ADJ_MAXERROR|ADJ_ESTERROR|ADJ_STATUS, offset=0, freq=750433, maxerror=16000000, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=522506}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
> adjtimex({modes=ADJ_SETOFFSET|ADJ_NANO, offset=0, freq=750433, maxerror=16000000, esterror=16000000, status=STA_UNSYNC|STA_NANO, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616033, tv_usec=778717675}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
> adjtimex({modes=ADJ_FREQUENCY|ADJ_TICK, offset=0, freq=750433, maxerror=16000000, esterror=16000000, status=STA_UNSYNC|STA_NANO, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616033, tv_usec=784644657}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
> 
> (The struct timex fields above are from *after* the syscall was
> executed, so they contain the current (new) values as set from the
> kernel, except of the 'modes' field, which contains the original value
> sent by the caller.)
> 
> The changes to the time_maxerror, time_esterror, and time_constant
> variables are not logged, as these are not important for security.
> 
> Note that the records are emitted even when the actual value does not
> change (i.e. when there is an explicit attempt to change a value, but
> the new value equals the old one).
> 
> An overview of changes that can be done via adjtimex(2) (based on
> information from Miroslav Lichvar) and whether they are audited:
>   timekeeping_inject_offset() -- injects offset directly into system
>                                  time (AUDITED)
>   __timekeeping_set_tai_offset() -- sets the offset from the
>                                     International Atomic Time
>                                     (AUDITED)
>   NTP variables:
>     time_offset -- can adjust the clock by up to 0.5 seconds per call
>                    and also speed it up or slow down by up to about
>                    0.05% (43 seconds per day) (AUDITED)
>     time_freq -- can speed up or slow down by up to about 0.05%
>     time_status -- can insert/delete leap seconds and it also enables/
>                    disables synchronization of the hardware real-time
>                    clock (AUDITED)
>     time_maxerror, time_esterror -- change error estimates used to
>                                     inform userspace applications
>                                     (NOT AUDITED)
>     time_constant -- controls the speed of the clock adjustments that
>                      are made when time_offset is set (NOT AUDITED)
>     time_adjust -- can temporarily speed up or slow down the clock by up
>                    to 0.05% (AUDITED)
>     tick_usec -- a more extreme version of time_freq; can speed up or
>                  slow down the clock by up to 10% (AUDITED)
> 
> Cc: Miroslav Lichvar <mlichvar@redhat.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  kernel/time/ntp.c         | 38 ++++++++++++++++++++++++++++++--------
>  kernel/time/timekeeping.c |  3 +++
>  2 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> index a09ded765f6c..f96c6d326aae 100644
> --- a/kernel/time/ntp.c
> +++ b/kernel/time/ntp.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/rtc.h>
>  #include <linux/math64.h>
> +#include <linux/audit.h>
>  
>  #include "ntp_internal.h"
>  #include "timekeeping_internal.h"
> @@ -294,6 +295,8 @@ static inline s64 ntp_update_offset_fll(s64 offset64, long secs)
>  
>  static void ntp_update_offset(long offset)
>  {
> +	s64 old_offset = time_offset;
> +	s64 old_freq = time_freq;
>  	s64 freq_adj;
>  	s64 offset64;
>  	long secs;
> @@ -342,6 +345,9 @@ static void ntp_update_offset(long offset)
>  	time_freq   = max(freq_adj, -MAXFREQ_SCALED);
>  
>  	time_offset = div_s64(offset64 << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
> +
> +	audit_ntp_adjust("offset", old_offset, time_offset);
> +	audit_ntp_adjust("freq", old_freq, time_freq);
>  }
>  
>  /**
> @@ -669,21 +675,31 @@ static inline void process_adjtimex_modes(struct timex *txc,
>  						struct timespec64 *ts,
>  						s32 *time_tai)
>  {
> -	if (txc->modes & ADJ_STATUS)
> -		process_adj_status(txc, ts);
> +	if (txc->modes & (ADJ_STATUS | ADJ_NANO | ADJ_MICRO)) {
> +		int old_status = time_status;
> +
> +		if (txc->modes & ADJ_STATUS)
> +			process_adj_status(txc, ts);
>  
> -	if (txc->modes & ADJ_NANO)
> -		time_status |= STA_NANO;
> +		if (txc->modes & ADJ_NANO)
> +			time_status |= STA_NANO;
>  
> -	if (txc->modes & ADJ_MICRO)
> -		time_status &= ~STA_NANO;
> +		if (txc->modes & ADJ_MICRO)
> +			time_status &= ~STA_NANO;
> +
> +		audit_ntp_adjust("status", old_status, time_status);
> +	}
>  
>  	if (txc->modes & ADJ_FREQUENCY) {
> +		s64 old_freq = time_freq;
> +
>  		time_freq = txc->freq * PPM_SCALE;
>  		time_freq = min(time_freq, MAXFREQ_SCALED);
>  		time_freq = max(time_freq, -MAXFREQ_SCALED);
>  		/* update pps_freq */
>  		pps_set_freq(time_freq);
> +
> +		audit_ntp_adjust("freq", old_freq, time_freq);
>  	}
>  
>  	if (txc->modes & ADJ_MAXERROR)
> @@ -700,14 +716,18 @@ static inline void process_adjtimex_modes(struct timex *txc,
>  		time_constant = max(time_constant, 0l);
>  	}
>  
> -	if (txc->modes & ADJ_TAI && txc->constant > 0)
> +	if (txc->modes & ADJ_TAI && txc->constant > 0) {
> +		audit_ntp_adjust("tai", *time_tai, txc->constant);
>  		*time_tai = txc->constant;
> +	}

It appears this time_tai use of "constant" is different than
time_constant, the former not mentioned by Miroslav Lichvar.  What is it
and is it important to log for security?  It sounds like it is
important.

>  	if (txc->modes & ADJ_OFFSET)
>  		ntp_update_offset(txc->offset);
>  
> -	if (txc->modes & ADJ_TICK)
> +	if (txc->modes & ADJ_TICK) {
> +		audit_ntp_adjust("tick", tick_usec, txc->tick);
>  		tick_usec = txc->tick;
> +	}
>  
>  	if (txc->modes & (ADJ_TICK|ADJ_FREQUENCY|ADJ_OFFSET))
>  		ntp_update_frequency();
> @@ -729,6 +749,8 @@ int __do_adjtimex(struct timex *txc, struct timespec64 *ts, s32 *time_tai)
>  			/* adjtime() is independent from ntp_adjtime() */
>  			time_adjust = txc->offset;
>  			ntp_update_frequency();
> +
> +			audit_ntp_adjust("adjust", save_adjust, txc->offset);
>  		}
>  		txc->offset = save_adjust;
>  	} else {
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 4786df904c22..9089ac329e69 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -25,6 +25,7 @@
>  #include <linux/stop_machine.h>
>  #include <linux/pvclock_gtod.h>
>  #include <linux/compiler.h>
> +#include <linux/audit.h>
>  
>  #include "tick-internal.h"
>  #include "ntp_internal.h"
> @@ -2308,6 +2309,8 @@ int do_adjtimex(struct timex *txc)
>  		ret = timekeeping_inject_offset(&delta);
>  		if (ret)
>  			return ret;
> +
> +		audit_tk_injoffset(delta);
>  	}
>  
>  	getnstimeofday64(&ts);
> -- 
> 2.17.1
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
