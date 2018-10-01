Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A712C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AC320666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="tj30xD9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AC320666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbeJBAjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:39:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40020 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJBAjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:39:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id n31-v6so9996934pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q4MDyK/xpZ2rJeVO6MpkOTduxc1guqAC/giITauVW44=;
        b=tj30xD9pcDHGyPcFmZM2qpxBuDA4ap8T+j6Li2TC8PGMb6nBPmALsBxlKJW8/8183Z
         JscOrrTI3FJTBgywd8A6fYuLkjefaiTTrdAJRscO2KI+0WdZH6rN2svfDSiDSujx89we
         uaZpGSkkyW8RpdTpj5Puwhrshy1CUgTwOnu3f1BByZ75MXoYwHhKJViKihXiuYQYYaLs
         1conwfxVgZU9EX6f73v7Xz5LWZ2ayIdf1VMr1sHR0o17VRcRHxVKMgyhKqjOhiBy97Ae
         +QBmaVOlA5Kw1fGUICKGRrfNZDeUHMT7artoWjhcxiyciy4kGY3DKxEv/8vnshe1DKMw
         OetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q4MDyK/xpZ2rJeVO6MpkOTduxc1guqAC/giITauVW44=;
        b=ZvW+4d5lBsXyleO8WnlI4DzAvsgY55/dpt58CFgz22Xz/0ckypVEwO5C2Cjx+RVIVs
         df9/FqqRSI+6UlKUFiOQJyiaoWL2BRSDUxSxVQ2V91fHsDGwdAJOQsQN3kKIdsD7pUZh
         xdPCfUfen0ilzfCRqKn840JY/sn+xN/ZmT0YLQMhZUJw0E/TfqjBNVflZOu9e38Z6nH0
         gFbhJLenKkoiPHUzGoznNV0uQ1gvQpcjdKsm3V7Rk8SwGuPMYQt6MN252+J21dyuOet/
         tpvy/8E4KKgFZlBXkhweKXW+aCHuIg/T4oFAkNBswBl0wLDSb15QSvRMlBFpCTuicXFl
         habg==
X-Gm-Message-State: ABuFfoj71vD02zZZbBi18SbpHLSg5w7gThx0VEZQi9AfZWlLv6QS2lOC
        mpgR395S4u00ieX6EpBuEbkMJG/Ho2w=
X-Google-Smtp-Source: ACcGV63p6PiO4kRynN1SImA1bh+u7lfmvLd67LFZhHAhNZG1ru/jmBYEsyYKLf3kbZ2G2G45MLBwsw==
X-Received: by 2002:a62:6547:: with SMTP id z68-v6mr12539030pfb.20.1538416833339;
        Mon, 01 Oct 2018 11:00:33 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.11.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:00:32 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salyzyn <salyzyn@android.com>,
        James Morse <james.morse@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Pinski <apinski@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        android-kernel@android.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: RESEND [PATCH v5 03/12] arm: vdso: inline assembler operations to compiler.h
Date:   Mon,  1 Oct 2018 10:58:23 -0700
Message-Id: <20181001175845.168430-4-salyzyn@android.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181001175845.168430-1-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take an effort to recode the arm64 vdso code from assembler to C
previously submitted by Andrew Pinski <apinski@cavium.com>, rework
it for use in both arm and arm64, overlapping any optimizations
for each architecture. But instead of landing it in arm64, land the
result into lib/vdso and unify both implementations to simplify
future maintenance.

Move compiler-specific code to a local compiler.h file:

- CONFIG_AEABI dependency check.
- System call fallback functions standardized into a
  DEFINE_FALLBACK macro.
- Replace arch_counter_get_cntvct() with arch_vdso_read_counter.
- Deal with architecture specific unresolved references emitted
  by GCC.
- Optimize handling of fallback calls in callers.
- For time functions that always return success, do not waste time
  checking return value for switch to fallback.
- Optimize unlikely nullptr checking in __vdso_gettimeofday,
  if tv null no need to proceed to fallback, as vdso is still
  capable of filling in the tv values.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Tested-by: Mark Salyzyn <salyzyn@android.com>
Cc: James Morse <james.morse@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
Cc: android-kernel@android.com

v2:
- split first CL into 3 of 7 pieces

v4:
- switch to arch_vdso_read_counter as common API
- update commit message to reflect overall reasoning

v5:
- comment about asm/arch_timer.h and asm/processor.h regarding why
  they have been added in compiler.h for porting clarity.
- add linux/compiler.h in vgettimeofday.c because of notrace.
- remove unnecessary dependency on linux/hrtimer.h
---
 arch/arm/vdso/compiler.h      |  69 +++++++++++++++++++++
 arch/arm/vdso/vgettimeofday.c | 109 +++++++++-------------------------
 2 files changed, 96 insertions(+), 82 deletions(-)
 create mode 100644 arch/arm/vdso/compiler.h

diff --git a/arch/arm/vdso/compiler.h b/arch/arm/vdso/compiler.h
new file mode 100644
index 000000000000..af24502797e8
--- /dev/null
+++ b/arch/arm/vdso/compiler.h
@@ -0,0 +1,69 @@
+/*
+ * Userspace implementations of fallback calls
+ *
+ * Copyright (C) 2017 Cavium, Inc.
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ * Rewriten into C by: Andrew Pinski <apinski@cavium.com>
+ */
+
+#ifndef __VDSO_COMPILER_H
+#define __VDSO_COMPILER_H
+
+#include <asm/arch_timer.h>	/* for arch_counter_get_cntvct()	*/
+#include <asm/processor.h>	/* for cpu_relax()			*/
+#include <asm/unistd.h>
+#include <linux/compiler.h>
+
+#ifndef CONFIG_AEABI
+#error This code depends on AEABI system call conventions
+#endif
+
+#define DEFINE_FALLBACK(name, type_arg1, name_arg1, type_arg2, name_arg2) \
+static notrace long name##_fallback(type_arg1 _##name_arg1,		  \
+				    type_arg2 _##name_arg2)		  \
+{									  \
+	register type_arg1 name_arg1 asm("r0") = _##name_arg1;		  \
+	register type_arg2 name_arg2 asm("r1") = _##name_arg2;		  \
+	register long ret asm ("r0");					  \
+	register long nr asm("r7") = __NR_##name;			  \
+									  \
+	asm volatile(							  \
+	"	swi #0\n"						  \
+	: "=r" (ret)							  \
+	: "r" (name_arg1), "r" (name_arg2), "r" (nr)			  \
+	: "memory");							  \
+									  \
+	return ret;							  \
+}
+
+#define arch_vdso_read_counter() arch_counter_get_cntvct()
+
+/* Avoid unresolved references emitted by GCC */
+
+void __aeabi_unwind_cpp_pr0(void)
+{
+}
+
+void __aeabi_unwind_cpp_pr1(void)
+{
+}
+
+void __aeabi_unwind_cpp_pr2(void)
+{
+}
+
+#endif /* __VDSO_COMPILER_H */
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 2474c17dc356..522094b147a2 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -22,21 +22,16 @@
  * Reworked and rebased over arm version by: Mark Salyzyn <salyzyn@android.com>
  */
 
-#include <linux/compiler.h>
-#include <linux/hrtimer.h>
-#include <linux/time.h>
-#include <asm/arch_timer.h>
 #include <asm/barrier.h>
-#include <asm/bug.h>
-#include <asm/page.h>
-#include <asm/unistd.h>
-
-#ifndef CONFIG_AEABI
-#error This code depends on AEABI system call conventions
-#endif
+#include <linux/compiler.h>	/* for notrace				*/
+#include <linux/time.h>
 
+#include "compiler.h"
 #include "datapage.h"
 
+DEFINE_FALLBACK(gettimeofday, struct timeval *, tv, struct timezone *, tz)
+DEFINE_FALLBACK(clock_gettime, clockid_t, clock, struct timespec *, ts)
+
 static notrace u32 vdso_read_begin(const struct vdso_data *vd)
 {
 	u32 seq;
@@ -63,23 +58,6 @@ static notrace int vdso_read_retry(const struct vdso_data *vd, u32 start)
 	return seq != start;
 }
 
-static notrace long clock_gettime_fallback(clockid_t _clkid,
-					   struct timespec *_ts)
-{
-	register struct timespec *ts asm("r1") = _ts;
-	register clockid_t clkid asm("r0") = _clkid;
-	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_clock_gettime;
-
-	asm volatile(
-	"	swi #0\n"
-	: "=r" (ret)
-	: "r" (clkid), "r" (ts), "r" (nr)
-	: "memory");
-
-	return ret;
-}
-
 static notrace int do_realtime_coarse(const struct vdso_data *vd,
 				      struct timespec *ts)
 {
@@ -127,7 +105,7 @@ static notrace u64 get_ns(const struct vdso_data *vd)
 	u64 cycle_now;
 	u64 nsec;
 
-	cycle_now = arch_counter_get_cntvct();
+	cycle_now = arch_vdso_read_counter();
 
 	cycle_delta = (cycle_now - vd->cs_cycle_last) & vd->cs_mask;
 
@@ -200,85 +178,52 @@ static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
 
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
-notrace int __vdso_clock_gettime(clockid_t clkid, struct timespec *ts)
+notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 {
-	int ret = -1;
-
 	const struct vdso_data *vd = __get_datapage();
 
-	switch (clkid) {
+	switch (clock) {
 	case CLOCK_REALTIME_COARSE:
-		ret = do_realtime_coarse(vd, ts);
+		do_realtime_coarse(vd, ts);
 		break;
 	case CLOCK_MONOTONIC_COARSE:
-		ret = do_monotonic_coarse(vd, ts);
+		do_monotonic_coarse(vd, ts);
 		break;
 	case CLOCK_REALTIME:
-		ret = do_realtime(vd, ts);
+		if (do_realtime(vd, ts))
+			goto fallback;
 		break;
 	case CLOCK_MONOTONIC:
-		ret = do_monotonic(vd, ts);
+		if (do_monotonic(vd, ts))
+			goto fallback;
 		break;
 	default:
-		break;
+		goto fallback;
 	}
 
-	if (ret)
-		ret = clock_gettime_fallback(clkid, ts);
-
-	return ret;
-}
-
-static notrace long gettimeofday_fallback(struct timeval *_tv,
-					  struct timezone *_tz)
-{
-	register struct timezone *tz asm("r1") = _tz;
-	register struct timeval *tv asm("r0") = _tv;
-	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_gettimeofday;
-
-	asm volatile(
-	"	swi #0\n"
-	: "=r" (ret)
-	: "r" (tv), "r" (tz), "r" (nr)
-	: "memory");
-
-	return ret;
+	return 0;
+fallback:
+	return clock_gettime_fallback(clock, ts);
 }
 
 notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
-	struct timespec ts;
-	int ret;
-
 	const struct vdso_data *vd = __get_datapage();
 
-	ret = do_realtime(vd, &ts);
-	if (ret)
-		return gettimeofday_fallback(tv, tz);
+	if (likely(tv != NULL)) {
+		struct timespec ts;
+
+		if (do_realtime(vd, &ts))
+			return gettimeofday_fallback(tv, tz);
 
-	if (tv) {
 		tv->tv_sec = ts.tv_sec;
 		tv->tv_usec = ts.tv_nsec / 1000;
 	}
-	if (tz) {
+
+	if (unlikely(tz != NULL)) {
 		tz->tz_minuteswest = vd->tz_minuteswest;
 		tz->tz_dsttime = vd->tz_dsttime;
 	}
 
-	return ret;
-}
-
-/* Avoid unresolved references emitted by GCC */
-
-void __aeabi_unwind_cpp_pr0(void)
-{
-}
-
-void __aeabi_unwind_cpp_pr1(void)
-{
-}
-
-void __aeabi_unwind_cpp_pr2(void)
-{
+	return 0;
 }
-- 
2.19.0.605.g01d371f741-goog

