Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11777C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B962084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B962084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeJEEDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:03:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725758AbeJEEDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:03:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94L7u6W2885087
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 14:07:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94L7twc2885084;
        Thu, 4 Oct 2018 14:07:55 -0700
Date:   Thu, 4 Oct 2018 14:07:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-f3e839384164cf86faedd185b8f6024f73050f5e@git.kernel.org>
Cc:     fweimer@redhat.com, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, kys@microsoft.com, peterz@infradead.org,
        arnd@arndb.de, tglx@linutronix.de, luto@kernel.org,
        mingo@kernel.org, john.stultz@linaro.org, hpa@zytor.com,
        matt@softrans.com.au, sboyd@kernel.org, pbonzini@redhat.com,
        jgross@suse.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, luto@kernel.org,
          peterz@infradead.org, arnd@arndb.de, fweimer@redhat.com,
          kys@microsoft.com, vkuznets@redhat.com,
          linux-kernel@vger.kernel.org, sboyd@kernel.org, jgross@suse.com,
          pbonzini@redhat.com, hpa@zytor.com, john.stultz@linaro.org,
          matt@softrans.com.au
In-Reply-To: <20180917130707.574315796@linutronix.de>
References: <20180917130707.574315796@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] x86/vdso: Replace the clockid switch case
Git-Commit-ID: f3e839384164cf86faedd185b8f6024f73050f5e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f3e839384164cf86faedd185b8f6024f73050f5e
Gitweb:     https://git.kernel.org/tip/f3e839384164cf86faedd185b8f6024f73050f5e
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 14:45:41 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 4 Oct 2018 23:00:26 +0200

x86/vdso: Replace the clockid switch case

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
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Matt Rickard <matt@softrans.com.au>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: devel@linuxdriverproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Juergen Gross <jgross@suse.com>
Link: https://lkml.kernel.org/r/20180917130707.574315796@linutronix.de

---
 arch/x86/entry/vdso/vclock_gettime.c | 38 +++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index b27dea0e23af..672e50e35d6c 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -241,29 +241,27 @@ notrace static void do_coarse(clockid_t clk, struct timespec *ts)
 
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
 
-	return 0;
-fallback:
+	/* Sort out negative (CPU/FD) and invalid clocks */
+	if (unlikely((unsigned int) clock >= MAX_CLOCKS))
+		return vdso_fallback_gettime(clock, ts);
+
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
 
