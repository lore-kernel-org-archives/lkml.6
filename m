Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932951AbeCOWz5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:55:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51708 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752926AbeCOWzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:55:52 -0400
X-Google-Smtp-Source: AG47ELuSo+LQa/ogNMwWEHDIrp4pzNLuc3w9YuOjRyzb9sW6llvBkc46QDP1YyzZb7Ylq2Kk74EFEw==
From: jason.vas.dias@gmail.com
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, andi@firstfloor.org
Subject: [PATCH v4.16-rc5 1/1] x86/vdso: VDSO should handle clock_gettime(CLOCK_MONOTONIC_RAW) without syscall
Date: Thu, 15 Mar 2018 22:55:36 +0000
Message-Id: <1521154536-13050-2-git-send-email-jason.vas.dias@gmail.com>
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1521154536-13050-1-git-send-email-jason.vas.dias@gmail.com>
References: <1521154536-13050-1-git-send-email-jason.vas.dias@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index f19856d..8b9b9cf 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -182,27 +182,49 @@ notrace static u64 vread_tsc(void)
 	return last;
 }
 
-notrace static inline u64 vgetsns(int *mode)
+notrace static inline __always_inline u64 vgetcycles(int *mode)
 {
-	u64 v;
-	cycles_t cycles;
-
-	if (gtod->vclock_mode == VCLOCK_TSC)
-		cycles = vread_tsc();
+	switch (gtod->vclock_mode) {
+	case VCLOCK_TSC:
+		return vread_tsc();
 #ifdef CONFIG_PARAVIRT_CLOCK
-	else if (gtod->vclock_mode == VCLOCK_PVCLOCK)
-		cycles = vread_pvclock(mode);
+	case VCLOCK_PVCLOCK:
+		return vread_pvclock(mode);
 #endif
 #ifdef CONFIG_HYPERV_TSCPAGE
-	else if (gtod->vclock_mode == VCLOCK_HVCLOCK)
-		cycles = vread_hvclock(mode);
+	case VCLOCK_HVCLOCK:
+		return vread_hvclock(mode);
 #endif
-	else
+	default:
+		break;
+	}
+	return 0;
+}
+
+notrace static inline u64 vgetsns(int *mode)
+{
+	u64 v;
+	cycles_t cycles = vgetcycles(mode);
+
+	if (cycles == 0)
 		return 0;
+
 	v = (cycles - gtod->cycle_last) & gtod->mask;
 	return v * gtod->mult;
 }
 
+notrace static inline u64 vgetsns_raw(int *mode)
+{
+	u64 v;
+	cycles_t cycles = vgetcycles(mode);
+
+	if (cycles == 0)
+		return 0;
+
+	v = (cycles - gtod->cycle_last) & gtod->raw_mask;
+	return v * gtod->raw_mult;
+}
+
 /* Code size doesn't matter (vdso is 4k anyway) and this is faster. */
 notrace static int __always_inline do_realtime(struct timespec *ts)
 {
@@ -246,6 +268,27 @@ notrace static int __always_inline do_monotonic(struct timespec *ts)
 	return mode;
 }
 
+notrace static __always_inline int do_monotonic_raw(struct timespec *ts)
+{
+	unsigned long seq;
+	u64 ns;
+	int mode;
+
+	do {
+		seq = gtod_read_begin(gtod);
+		mode = gtod->vclock_mode;
+		ts->tv_sec = gtod->monotonic_time_raw_sec;
+		ns = gtod->monotonic_time_raw_nsec;
+		ns += vgetsns_raw(&mode);
+		ns >>= gtod->raw_shift;
+	} while (unlikely(gtod_read_retry(gtod, seq)));
+
+	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return mode;
+}
+
 notrace static void do_realtime_coarse(struct timespec *ts)
 {
 	unsigned long seq;
@@ -277,6 +320,10 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 		if (do_monotonic(ts) == VCLOCK_NONE)
 			goto fallback;
 		break;
+	case CLOCK_MONOTONIC_RAW:
+		if (do_monotonic_raw(ts) == VCLOCK_NONE)
+			goto fallback;
+		break;
 	case CLOCK_REALTIME_COARSE:
 		do_realtime_coarse(ts);
 		break;
diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
index e1216dd..83f5c21 100644
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -44,6 +44,9 @@ void update_vsyscall(struct timekeeper *tk)
 	vdata->mask		= tk->tkr_mono.mask;
 	vdata->mult		= tk->tkr_mono.mult;
 	vdata->shift		= tk->tkr_mono.shift;
+	vdata->raw_mask		= tk->tkr_raw.mask;
+	vdata->raw_mult		= tk->tkr_raw.mult;
+	vdata->raw_shift	= tk->tkr_raw.shift;
 
 	vdata->wall_time_sec		= tk->xtime_sec;
 	vdata->wall_time_snsec		= tk->tkr_mono.xtime_nsec;
@@ -74,5 +77,8 @@ void update_vsyscall(struct timekeeper *tk)
 		vdata->monotonic_time_coarse_sec++;
 	}
 
+	vdata->monotonic_time_raw_sec  = tk->raw_sec;
+	vdata->monotonic_time_raw_nsec = tk->tkr_raw.xtime_nsec;
+
 	gtod_write_end(vdata);
 }
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index fb856c9..941e9d6 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -22,7 +22,9 @@ struct vsyscall_gtod_data {
 	u64	mask;
 	u32	mult;
 	u32	shift;
-
+	u32	raw_mask;
+	u32	raw_mult;
+	u32	raw_shift;
 	/* open coded 'struct timespec' */
 	u64		wall_time_snsec;
 	gtod_long_t	wall_time_sec;
@@ -32,6 +34,8 @@ struct vsyscall_gtod_data {
 	gtod_long_t	wall_time_coarse_nsec;
 	gtod_long_t	monotonic_time_coarse_sec;
 	gtod_long_t	monotonic_time_coarse_nsec;
+	gtod_long_t	monotonic_time_raw_sec;
+	gtod_long_t	monotonic_time_raw_nsec;
 
 	int		tz_minuteswest;
 	int		tz_dsttime;
