Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE004ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E51E20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E51E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeINSGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:06:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49617 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbeINSG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:06:27 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0nZs-0005wt-Ds; Fri, 14 Sep 2018 14:52:04 +0200
Message-Id: <20180914125119.081037164@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 14 Sep 2018 14:50:17 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: [patch 11/11] x66/vdso: Add CLOCK_TAI support
References: <20180914125006.349747096@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=x66-vdso--Add-CLOCK_TAI-support.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the storage array in place it's now trivial to support CLOCK_TAI in
the vdso. Instead of extending the array to accomodate CLOCK_TAI, make use
of the fact that:

 - CLOCK ids are set in stone
 - CLOCK_THREAD_CPUTIME is never going to be supported in the VDSO so
   the array slot 3 is unused
 - CLOCK_TAI is id 11 which results in 3 when masked with 0x3

Add the mask to the basetime array lookup and set up the CLOCK_TAI base
time in update_vsyscall().

The performance impact of the mask operation is within the noise.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c    |    2 +-
 arch/x86/entry/vsyscall/vsyscall_gtod.c |    4 ++++
 arch/x86/include/asm/vgtod.h            |    6 +++++-
 3 files changed, 10 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -140,7 +140,7 @@ notrace static inline u64 vgetcyc(int mo
 
 notrace static int do_hres(clockid_t clk, struct timespec *ts)
 {
-	struct vgtod_ts *base = &gtod->basetime[clk];
+	struct vgtod_ts *base = &gtod->basetime[clk & VGTOD_HRES_MASK];
 	u64 cycles, last, ns;
 	unsigned int seq;
 
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -51,6 +51,10 @@ void update_vsyscall(struct timekeeper *
 	base->sec = tk->xtime_sec;
 	base->nsec = tk->tkr_mono.xtime_nsec;
 
+	base = &vdata->basetime[VGTOD_TAI];
+	base->sec = tk->xtime_sec + (s64)tk->tai_offset;
+	base->nsec = tk->tkr_mono.xtime_nsec;
+
 	base = &vdata->basetime[CLOCK_MONOTONIC];
 	base->sec = tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
 	nsec = tk->tkr_mono.xtime_nsec;
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -19,9 +19,13 @@ struct vgtod_ts {
 };
 
 #define VGTOD_BASES	(CLOCK_MONOTONIC_COARSE + 1)
-#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC))
+#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC) | BIT(CLOCK_TAI))
 #define VGTOD_COARSE	(BIT(CLOCK_REALTIME_COARSE) | BIT(CLOCK_MONOTONIC_COARSE))
 
+/* Abuse CLOCK_THREAD_CPUTIME_ID for VGTOD CLOCK TAI */
+#define VGTOD_HRES_MASK	0x3
+#define VGTOD_TAI	(CLOCK_TAI & VGTOD_HRES_MASK)
+
 /*
  * vsyscall_gtod_data will be accessed by 32 and 64 bit code at the same time
  * so be carefull by modifying this structure.


