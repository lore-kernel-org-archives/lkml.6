Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98834C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8BD20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfAULSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:18:45 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48581 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfAULSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:18:44 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBHvTT2492782
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:17:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBHvF52492779;
        Mon, 21 Jan 2019 03:17:57 -0800
Date:   Mon, 21 Jan 2019 03:17:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrew Murray <tipbot@zytor.com>
Message-ID: <tip-6dd273f44669de98bfff16371c09065671cbbad6@git.kernel.org>
Cc:     linux@armlinux.org.uk, shawnguo@kernel.org, paulus@samba.org,
        peterz@infradead.org, mark.rutland@arm.com, hpa@zytor.com,
        mpe@ellerman.id.au, ink@jurassic.park.msu.ru,
        s.hauer@pengutronix.de, andrew.murray@arm.com, mattst88@gmail.com,
        benh@kernel.crashing.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bp@alien8.de, acme@kernel.org,
        will.deacon@arm.com, mingo@kernel.org, rth@twiddle.net,
        torvalds@linux-foundation.org
Reply-To: ink@jurassic.park.msu.ru, hpa@zytor.com, mpe@ellerman.id.au,
          mark.rutland@arm.com, peterz@infradead.org, shawnguo@kernel.org,
          paulus@samba.org, linux@armlinux.org.uk,
          torvalds@linux-foundation.org, rth@twiddle.net,
          will.deacon@arm.com, mingo@kernel.org, acme@kernel.org,
          bp@alien8.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mattst88@gmail.com, benh@kernel.crashing.org,
          s.hauer@pengutronix.de, andrew.murray@arm.com
In-Reply-To: <1547128414-50693-5-git-send-email-andrew.murray@arm.com>
References: <1547128414-50693-5-git-send-email-andrew.murray@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core, arch/alpha: Strengthen exclusion checks
 with PERF_PMU_CAP_NO_EXCLUDE
Git-Commit-ID: 6dd273f44669de98bfff16371c09065671cbbad6
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

Commit-ID:  6dd273f44669de98bfff16371c09065671cbbad6
Gitweb:     https://git.kernel.org/tip/6dd273f44669de98bfff16371c09065671cbbad6
Author:     Andrew Murray <andrew.murray@arm.com>
AuthorDate: Thu, 10 Jan 2019 13:53:26 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:01:21 +0100

perf/core, arch/alpha: Strengthen exclusion checks with PERF_PMU_CAP_NO_EXCLUDE

As the Alpha PMU doesn't support context exclusion let's advertise
the PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that perf will
prevent us from handling events where any exclusion flags are set.
Let's also remove the now unnecessary check for exclusion flags.

This change means that __hw_perf_event_init will now also
indicate that it doesn't support exclude_host and exclude_guest and
will now implicitly return -EINVAL instead of -EPERM. This is likely
more desirable as -EPERM will result in a kernel.perf_event_paranoid
related warning from the perf userspace utility.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: robin.murphy@arm.com
Cc: suzuki.poulose@arm.com
Link: https://lkml.kernel.org/r/1547128414-50693-5-git-send-email-andrew.murray@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/alpha/kernel/perf_event.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index 5613aa378a83..4341ccf5c0c4 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -630,12 +630,6 @@ static int __hw_perf_event_init(struct perf_event *event)
 		return ev;
 	}
 
-	/* The EV67 does not support mode exclusion */
-	if (attr->exclude_kernel || attr->exclude_user
-			|| attr->exclude_hv || attr->exclude_idle) {
-		return -EPERM;
-	}
-
 	/*
 	 * We place the event type in event_base here and leave calculation
 	 * of the codes to programme the PMU for alpha_pmu_enable() because
@@ -771,6 +765,7 @@ static struct pmu pmu = {
 	.start		= alpha_pmu_start,
 	.stop		= alpha_pmu_stop,
 	.read		= alpha_pmu_read,
+	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 
