Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD93ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102DA2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102DA2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbeIQSgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:36:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54837 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbeIQSgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:36:35 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1tHC-0005FU-4r; Mon, 17 Sep 2018 15:09:18 +0200
Message-Id: <20180917130707.823878601@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 17 Sep 2018 14:45:44 +0200
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
Subject: [patch V2 11/11] x66/vdso: Add CLOCK_TAI support
References: <20180917124533.329334911@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=x66-vdso--Add-CLOCK_TAI-support.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the storage array in place it's now trivial to support CLOCK_TAI in
the vdso. Extend the base time storage array and add the update code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---

V2: Remove the masking trick

 arch/x86/entry/vsyscall/vsyscall_gtod.c |    4 ++++
 arch/x86/include/asm/vgtod.h            |    4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -51,6 +51,10 @@ void update_vsyscall(struct timekeeper *
 	base->sec = tk->xtime_sec;
 	base->nsec = tk->tkr_mono.xtime_nsec;
 
+	base = &vdata->basetime[CLOCK_TAI];
+	base->sec = tk->xtime_sec + (s64)tk->tai_offset;
+	base->nsec = tk->tkr_mono.xtime_nsec;
+
 	base = &vdata->basetime[CLOCK_MONOTONIC];
 	base->sec = tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
 	nsec = tk->tkr_mono.xtime_nsec;
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -18,8 +18,8 @@ struct vgtod_ts {
 	u64		nsec;
 };
 
-#define VGTOD_BASES	(CLOCK_MONOTONIC_COARSE + 1)
-#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC))
+#define VGTOD_BASES	(CLOCK_TAI + 1)
+#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC) | BIT(CLOCK_TAI))
 #define VGTOD_COARSE	(BIT(CLOCK_REALTIME_COARSE) | BIT(CLOCK_MONOTONIC_COARSE))
 
 /*


