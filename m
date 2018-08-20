Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35716C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42382154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42382154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeHTPyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:54:14 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:54347 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeHTPyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:54:12 -0400
Received: by mail-wm0-f50.google.com with SMTP id c14-v6so14152159wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 05:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e3+bwZgGK1UVwSxi1SkygbicFf2dAHAxDhey8dSE9X0=;
        b=UqwPAa4MNRoWNCq5L7KvODEuXecvSi15C2OZpgDlb/79Kjt0sNBMQ3iJzvnNgZnPNf
         DB/OqzBbD1VmgS9ip6UAvkZdjB/ULI9sRIGUWJjPbqrBcEBGtXg0Kr3586KZuOmJCSCE
         hoLPM44TVVEyzgAnmLZJplHC5ZA5KoGv2tjkkIw9NfoSz5+VNj2p/WOdnXUxwaQYHgGU
         3RSCRkc+4RjX+qIlCyU4uD+8H76zrn0YtGC1s5KbhOGouRfsnGOOQz3QzGNdzcoiSvwH
         uPTHGIO+TE/J7O3H1RmqrauSVnccpT4Ahg1pjV8HVCLx0YMLYhz4dp29+/G2/Gy+NY9m
         toZw==
X-Gm-Message-State: AOUpUlGslJMtQuyTVMna1hQbWMpq3fMpnG946jpuwkeuunMxGm43yYj9
        +uDW691CakE0aHt8J8O0NGCdXw==
X-Google-Smtp-Source: AA+uWPw1chckuqOiEUl2dS6BO9q8hsaapJi1KUqLf+TcDSdA5yZMVJAogZ1UyJk4tnO/mlsnrAJMvg==
X-Received: by 2002:a1c:4d09:: with SMTP id o9-v6mr27807527wmh.111.1534768721489;
        Mon, 20 Aug 2018 05:38:41 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v2-v6sm496917wme.36.2018.08.20.05.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 05:38:40 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-audit@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH ghak10 v4 2/2] timekeeping/ntp: Audit clock/NTP params adjustments
Date:   Mon, 20 Aug 2018 14:38:18 +0200
Message-Id: <20180820123818.27547-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180820123818.27547-1-omosnace@redhat.com>
References: <20180820123818.27547-1-omosnace@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds logging of all attempts to either inject an offset into
the clock (producing an AUDIT_TIME_INJOFFSET record) or adjust an NTP
parameter (producing an AUDIT_TIME_ADJNTPVAL record).

For reference, running the following commands:

    auditctl -D
    auditctl -a exit,always -F arch=b64 -S adjtimex
    chronyd -q

produces audit records like this:

type=TIME_ADJNTPVAL msg=audit(1530616044.507:5): op=adjust old=0 new=0
type=SYSCALL msg=audit(1530616044.507:5): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78c00 a1=0 a2=4 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616044.507:5): proctitle=6368726F6E7964002D71
type=TIME_ADJNTPVAL msg=audit(1530616044.507:6): op=maxerr old=16000000 new=0
type=SYSCALL msg=audit(1530616044.507:6): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78c00 a1=1 a2=1 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616044.507:6): proctitle=6368726F6E7964002D71
type=TIME_INJOFFSET msg=audit(1530616044.507:7): sec=0 nsec=0
type=TIME_ADJNTPVAL msg=audit(1530616044.507:7): op=status old=64 new=8256
type=SYSCALL msg=audit(1530616044.507:7): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78c00 a1=1 a2=1 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616044.507:7): proctitle=6368726F6E7964002D71
type=TIME_ADJNTPVAL msg=audit(1530616044.507:8): op=status old=8256 new=8257
type=TIME_ADJNTPVAL msg=audit(1530616044.507:8): op=offset old=0 new=0
type=TIME_ADJNTPVAL msg=audit(1530616044.507:8): op=freq old=0 new=0
type=SYSCALL msg=audit(1530616044.507:8): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78ab0 a1=0 a2=55e129c850c0 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616044.507:8): proctitle=6368726F6E7964002D71
type=TIME_ADJNTPVAL msg=audit(1530616044.507:9): op=status old=8257 new=64
type=SYSCALL msg=audit(1530616044.507:9): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78ab0 a1=0 a2=55e129c850c0 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616044.507:9): proctitle=6368726F6E7964002D71
type=SYSCALL msg=audit(1530616044.507:10): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78a70 a1=0 a2=55e129c850c0 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616044.507:10): proctitle=6368726F6E7964002D71
type=TIME_ADJNTPVAL msg=audit(1530616044.511:11): op=freq old=0 new=49180377088000
type=TIME_ADJNTPVAL msg=audit(1530616044.511:11): op=tick old=10000 new=10000
type=SYSCALL msg=audit(1530616044.511:11): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78ad0 a1=0 a2=2710 a3=f42f82a800000 items=0 ppid=626 pid=629 auid=0 uid=385 gid=382 euid=385 suid=385 fsuid=385 egid=382 sgid=382 fsgid=382 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616044.511:11): proctitle=6368726F6E7964002D71
type=TIME_ADJNTPVAL msg=audit(1530616044.521:12): op=status old=64 new=64
type=TIME_ADJNTPVAL msg=audit(1530616044.521:12): op=maxerr old=16000000 new=16000000
type=TIME_ADJNTPVAL msg=audit(1530616044.521:12): op=esterr old=16000000 new=16000000
type=SYSCALL msg=audit(1530616044.521:12): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78b40 a1=1 a2=40 a3=f91f6ef84fbab items=0 ppid=626 pid=629 auid=0 uid=385 gid=382 euid=385 suid=385 fsuid=385 egid=382 sgid=382 fsgid=382 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616044.521:12): proctitle=6368726F6E7964002D71
type=TIME_INJOFFSET msg=audit(1530616049.652:13): sec=-16 nsec=124887145
type=TIME_ADJNTPVAL msg=audit(1530616049.652:13): op=status old=64 new=8256
type=SYSCALL msg=audit(1530616049.652:13): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78270 a1=1 a2=fffffffffffffff0 a3=137b828205ca12 items=0 ppid=626 pid=629 auid=0 uid=385 gid=382 euid=385 suid=385 fsuid=385 egid=382 sgid=382 fsgid=382 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616049.652:13): proctitle=6368726F6E7964002D71
type=TIME_ADJNTPVAL msg=audit(1530616033.783:14): op=freq old=49180377088000 new=49180377088000
type=TIME_ADJNTPVAL msg=audit(1530616033.783:14): op=tick old=10000 new=10000
type=SYSCALL msg=audit(1530616033.783:14): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78bc0 a1=0 a2=2710 a3=0 items=0 ppid=626 pid=629 auid=0 uid=385 gid=382 euid=385 suid=385 fsuid=385 egid=382 sgid=382 fsgid=382 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616033.783:14): proctitle=6368726F6E7964002D71

The chronyd command that produced the above records executed the
following adjtimex(2) syscalls (as per strace output):

adjtimex({modes=ADJ_OFFSET|0x8000, offset=0, freq=0, maxerror=16000000, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=507215}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=ADJ_MAXERROR, offset=0, freq=0, maxerror=0, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=507438}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=ADJ_SETOFFSET|ADJ_NANO, offset=0, freq=0, maxerror=16000000, esterror=16000000, status=STA_UNSYNC|STA_NANO, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=507604737}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=ADJ_OFFSET|ADJ_STATUS, offset=0, freq=0, maxerror=16000000, esterror=16000000, status=STA_PLL|STA_UNSYNC|STA_NANO, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=507698330}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=ADJ_STATUS, offset=0, freq=0, maxerror=16000000, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=507792}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=0, offset=0, freq=0, maxerror=16000000, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=508000}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=ADJ_FREQUENCY|ADJ_TICK, offset=0, freq=750433, maxerror=16000000, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=512146}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=ADJ_MAXERROR|ADJ_ESTERROR|ADJ_STATUS, offset=0, freq=750433, maxerror=16000000, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=522506}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=ADJ_SETOFFSET|ADJ_NANO, offset=0, freq=750433, maxerror=16000000, esterror=16000000, status=STA_UNSYNC|STA_NANO, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616033, tv_usec=778717675}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=ADJ_FREQUENCY|ADJ_TICK, offset=0, freq=750433, maxerror=16000000, esterror=16000000, status=STA_UNSYNC|STA_NANO, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616033, tv_usec=784644657}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)

(The struct timex fields above are from *after* the syscall was
executed, so they contain the current (new) values as set from the
kernel, except of the 'modes' field, which contains the original value
sent by the caller.)

Note that the records are emitted even when the actual value does not
change (i.e. when there is an explicit attempt to change a value, but
the new value equals the old one).

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 kernel/time/ntp.c         | 50 +++++++++++++++++++++++++++++++--------
 kernel/time/timekeeping.c |  3 +++
 2 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index a09ded765f6c..cb2073a69ada 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/math64.h>
+#include <linux/audit.h>
 
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
@@ -294,6 +295,8 @@ static inline s64 ntp_update_offset_fll(s64 offset64, long secs)
 
 static void ntp_update_offset(long offset)
 {
+	s64 old_offset = time_offset;
+	s64 old_freq = time_freq;
 	s64 freq_adj;
 	s64 offset64;
 	long secs;
@@ -342,6 +345,9 @@ static void ntp_update_offset(long offset)
 	time_freq   = max(freq_adj, -MAXFREQ_SCALED);
 
 	time_offset = div_s64(offset64 << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
+
+	audit_ntp_adjust("offset", old_offset, time_offset);
+	audit_ntp_adjust("freq", old_freq, time_freq);
 }
 
 /**
@@ -669,45 +675,67 @@ static inline void process_adjtimex_modes(struct timex *txc,
 						struct timespec64 *ts,
 						s32 *time_tai)
 {
-	if (txc->modes & ADJ_STATUS)
-		process_adj_status(txc, ts);
+	if (txc->modes & (ADJ_STATUS | ADJ_NANO | ADJ_MICRO)) {
+		int old_status = time_status;
+
+		if (txc->modes & ADJ_STATUS)
+			process_adj_status(txc, ts);
 
-	if (txc->modes & ADJ_NANO)
-		time_status |= STA_NANO;
+		if (txc->modes & ADJ_NANO)
+			time_status |= STA_NANO;
 
-	if (txc->modes & ADJ_MICRO)
-		time_status &= ~STA_NANO;
+		if (txc->modes & ADJ_MICRO)
+			time_status &= ~STA_NANO;
+
+		audit_ntp_adjust("status", old_status, time_status);
+	}
 
 	if (txc->modes & ADJ_FREQUENCY) {
+		s64 old_freq = time_freq;
+
 		time_freq = txc->freq * PPM_SCALE;
 		time_freq = min(time_freq, MAXFREQ_SCALED);
 		time_freq = max(time_freq, -MAXFREQ_SCALED);
 		/* update pps_freq */
 		pps_set_freq(time_freq);
+
+		audit_ntp_adjust("freq", old_freq, time_freq);
 	}
 
-	if (txc->modes & ADJ_MAXERROR)
+	if (txc->modes & ADJ_MAXERROR) {
+		audit_ntp_adjust("maxerr", time_maxerror, txc->maxerror);
 		time_maxerror = txc->maxerror;
+	}
 
-	if (txc->modes & ADJ_ESTERROR)
+	if (txc->modes & ADJ_ESTERROR) {
+		audit_ntp_adjust("esterr", time_esterror, txc->esterror);
 		time_esterror = txc->esterror;
+	}
 
 	if (txc->modes & ADJ_TIMECONST) {
+		long old_constant = time_constant;
+
 		time_constant = txc->constant;
 		if (!(time_status & STA_NANO))
 			time_constant += 4;
 		time_constant = min(time_constant, (long)MAXTC);
 		time_constant = max(time_constant, 0l);
+
+		audit_ntp_adjust("const", old_constant, time_constant);
 	}
 
-	if (txc->modes & ADJ_TAI && txc->constant > 0)
+	if (txc->modes & ADJ_TAI && txc->constant > 0) {
+		audit_ntp_adjust("tai", *time_tai, txc->constant);
 		*time_tai = txc->constant;
+	}
 
 	if (txc->modes & ADJ_OFFSET)
 		ntp_update_offset(txc->offset);
 
-	if (txc->modes & ADJ_TICK)
+	if (txc->modes & ADJ_TICK) {
+		audit_ntp_adjust("tick", tick_usec, txc->tick);
 		tick_usec = txc->tick;
+	}
 
 	if (txc->modes & (ADJ_TICK|ADJ_FREQUENCY|ADJ_OFFSET))
 		ntp_update_frequency();
@@ -729,6 +757,8 @@ int __do_adjtimex(struct timex *txc, struct timespec64 *ts, s32 *time_tai)
 			/* adjtime() is independent from ntp_adjtime() */
 			time_adjust = txc->offset;
 			ntp_update_frequency();
+
+			audit_ntp_adjust("adjust", save_adjust, txc->offset);
 		}
 		txc->offset = save_adjust;
 	} else {
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4786df904c22..9089ac329e69 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -25,6 +25,7 @@
 #include <linux/stop_machine.h>
 #include <linux/pvclock_gtod.h>
 #include <linux/compiler.h>
+#include <linux/audit.h>
 
 #include "tick-internal.h"
 #include "ntp_internal.h"
@@ -2308,6 +2309,8 @@ int do_adjtimex(struct timex *txc)
 		ret = timekeeping_inject_offset(&delta);
 		if (ret)
 			return ret;
+
+		audit_tk_injoffset(delta);
 	}
 
 	getnstimeofday64(&ts);
-- 
2.17.1

