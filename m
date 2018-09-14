Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150ADFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A2420882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A2420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeINSGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:06:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49597 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbeINSGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:06:23 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0nZp-0005wV-CE; Fri, 14 Sep 2018 14:52:01 +0200
Message-Id: <20180914125118.827005379@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 14 Sep 2018 14:50:14 +0200
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
Subject: [patch 08/11] x86/vdso: Replace the clockid switch case
References: <20180914125006.349747096@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-vdso--Replace-the-clockid-switch-case.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the time getter functions use the clockid as index into the
storage array for the base time access, the switch case can be replaced.

- Check for clockid >= MAX_CLOCKS and for negative clockid (CPU/FD) first
  and call the fallback function right away.

- After establishing that clockid is < MAX_CLOCKS, convert the clockid to a
  bitmask

- Check for the supported high resolution and coarse functions by anding
  the bitmask of supported clocks and check whether a bit is set.

This completely avoids jump tables, reduces the number of conditionals and
makes the VDSO extensible for other clock ids.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c |   38 ++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -239,29 +239,27 @@ notrace static void do_coarse(clockid_t
 
 notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 {
-	switch (clock) {
-	case CLOCK_REALTIME:
-		if (do_hres(CLOCK_REALTIME, ts) == VCLOCK_NONE)
-			goto fallback;
-		break;
-	case CLOCK_MONOTONIC:
-		if (do_hres(CLOCK_MONOTONIC, ts) == VCLOCK_NONE)
-			goto fallback;
-		break;
-	case CLOCK_REALTIME_COARSE:
-		do_coarse(CLOCK_REALTIME_COARSE, ts);
-		break;
-	case CLOCK_MONOTONIC_COARSE:
-		do_coarse(CLOCK_MONOTONIC_COARSE, ts);
-		break;
-	default:
-		goto fallback;
-	}
+	unsigned int msk;
+
+	/* Sort out negative (CPU/FD) and invalid clocks */
+	if (unlikely((unsigned int) clock >= MAX_CLOCKS))
+		return vdso_fallback_gettime(clock, ts);
 
-	return 0;
-fallback:
+	/*
+	 * Convert the clockid to a bitmask and use it to check which
+	 * clocks are handled in the VDSO directly.
+	 */
+	msk = 1U << clock;
+	if (likely(msk & VGTOD_HRES)) {
+		if (do_hres(clock, ts) != VCLOCK_NONE)
+			return 0;
+	} else if (msk & VGTOD_COARSE) {
+		do_coarse(clock, ts);
+		return 0;
+	}
 	return vdso_fallback_gettime(clock, ts);
 }
+
 int clock_gettime(clockid_t, struct timespec *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 


