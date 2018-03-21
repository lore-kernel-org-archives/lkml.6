Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeCUQed (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 12:34:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35361 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeCUQcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 12:32:16 -0400
X-Google-Smtp-Source: AG47ELu5nLPvaPZnXI8th+b6/7Ikq2PUzjFg9aIwdvwrte9NTQwD8YEazjeMSbr+BblrNPWiIYIQiw==
From: jason.vas.dias@gmail.com
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, andi@firstfloor.org
Subject: [PATCH v4.16-rc6 1/1] x86/vdso: VDSO should handle clock_gettime(CLOCK_MONOTONIC_RAW) without syscall
Date: Wed, 21 Mar 2018 16:32:05 +0000
Message-Id: <1521649925-13804-2-git-send-email-jason.vas.dias@gmail.com>
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1521649925-13804-1-git-send-email-jason.vas.dias@gmail.com>
References: <1521649925-13804-1-git-send-email-jason.vas.dias@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


    This patch implements clock_gettime(CLOCK_MONOTONIC_RAW,&ts) calls entirely in the
    vDSO, without calling vdso_fallback_gettime() .

    It has been augmented to support compilation with or without -DRETPOLINE / $(RETPOLINE_CFLAGS) ;
    when compiled with -DRETPOLINE, not all functions calls can be inlined within __vdso_clock_gettime,
    and all functions invoked by __vdso_clock_gettime must have 'indirect_branch("keep")' +
    'function_return("keep")' attributes to compile, otherwise thunk relocations will be generated ;
    and the functions cannot all be declared '__always_inline_', otherwise a compiler -Werror
    ('not all __always_inline__ functions can be inlined')  is generated.
    Also, compared to previous version of same patch,  the do_*_coarse functions are still
    not inlines, and not inadvertently changed to inline.

    I still think it might be better to apply H.J. Liu's patch from
    https://bugzilla.kernel.org/show_bug.cgi?id=199129 to disable
    -DRETPOLINE compilation for the vDSO .

---
diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index f19856d..80d65d4 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -182,29 +182,62 @@ notrace static u64 vread_tsc(void)
 	return last;
 }
 
-notrace static inline u64 vgetsns(int *mode)
+notrace static inline u64 vgetcycles(int *mode)
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
+	v = (cycles - gtod->cycle_last) & gtod->mask;
+	return v * gtod->raw_mult;
+}
+
+#ifdef	RETPOLINE
+#	define	_NO_THUNK_RELOCS_()(indirect_branch("keep"),\
+				    function_return("keep"))
+#	define	_RETPOLINE_FUNC_ATTR_	__attribute__(_NO_THUNK_RELOCS_())
+#	define	_RETPOLINE_INLINE_	inline
+#else
+#	define	_RETPOLINE_FUNC_ATTR_
+#	define	_RETPOLINE_INLINE_	__always_inline
+#endif
+
 /* Code size doesn't matter (vdso is 4k anyway) and this is faster. */
-notrace static int __always_inline do_realtime(struct timespec *ts)
+notrace static _RETPOLINE_INLINE_ _RETPOLINE_FUNC_ATTR_
+int do_realtime(struct timespec *ts)
 {
 	unsigned long seq;
 	u64 ns;
@@ -225,7 +258,8 @@ notrace static int __always_inline do_realtime(struct timespec *ts)
 	return mode;
 }
 
-notrace static int __always_inline do_monotonic(struct timespec *ts)
+notrace static _RETPOLINE_INLINE_ _RETPOLINE_FUNC_ATTR_
+int do_monotonic(struct timespec *ts)
 {
 	unsigned long seq;
 	u64 ns;
@@ -246,7 +280,30 @@ notrace static int __always_inline do_monotonic(struct timespec *ts)
 	return mode;
 }
 
-notrace static void do_realtime_coarse(struct timespec *ts)
+notrace static _RETPOLINE_INLINE_ _RETPOLINE_FUNC_ATTR_
+int do_monotonic_raw(struct timespec *ts)
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
+notrace static _RETPOLINE_FUNC_ATTR_
+void do_realtime_coarse(struct timespec *ts)
 {
 	unsigned long seq;
 	do {
@@ -256,7 +313,8 @@ notrace static void do_realtime_coarse(struct timespec *ts)
 	} while (unlikely(gtod_read_retry(gtod, seq)));
 }
 
-notrace static void do_monotonic_coarse(struct timespec *ts)
+notrace static _RETPOLINE_FUNC_ATTR_
+void do_monotonic_coarse(struct timespec *ts)
 {
 	unsigned long seq;
 	do {
@@ -266,7 +324,8 @@ notrace static void do_monotonic_coarse(struct timespec *ts)
 	} while (unlikely(gtod_read_retry(gtod, seq)));
 }
 
-notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
+notrace _RETPOLINE_FUNC_ATTR_
+int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 {
 	switch (clock) {
 	case CLOCK_REALTIME:
@@ -277,6 +336,10 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
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
index e1216dd..c4d89b6 100644
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -44,6 +44,8 @@ void update_vsyscall(struct timekeeper *tk)
 	vdata->mask		= tk->tkr_mono.mask;
 	vdata->mult		= tk->tkr_mono.mult;
 	vdata->shift		= tk->tkr_mono.shift;
+	vdata->raw_mult		= tk->tkr_raw.mult;
+	vdata->raw_shift	= tk->tkr_raw.shift;
 
 	vdata->wall_time_sec		= tk->xtime_sec;
 	vdata->wall_time_snsec		= tk->tkr_mono.xtime_nsec;
@@ -74,5 +76,8 @@ void update_vsyscall(struct timekeeper *tk)
 		vdata->monotonic_time_coarse_sec++;
 	}
 
+	vdata->monotonic_time_raw_sec  = tk->raw_sec;
+	vdata->monotonic_time_raw_nsec = tk->tkr_raw.xtime_nsec;
+
 	gtod_write_end(vdata);
 }
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index fb856c9..ec1a37c 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -22,7 +22,8 @@ struct vsyscall_gtod_data {
 	u64	mask;
 	u32	mult;
 	u32	shift;
-
+	u32	raw_mult;
+	u32	raw_shift;
 	/* open coded 'struct timespec' */
 	u64		wall_time_snsec;
 	gtod_long_t	wall_time_sec;
@@ -32,6 +33,8 @@ struct vsyscall_gtod_data {
 	gtod_long_t	wall_time_coarse_nsec;
 	gtod_long_t	monotonic_time_coarse_sec;
 	gtod_long_t	monotonic_time_coarse_nsec;
+	gtod_long_t	monotonic_time_raw_sec;
+	gtod_long_t	monotonic_time_raw_nsec;
 
 	int		tz_minuteswest;
 	int		tz_dsttime;
