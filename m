Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887C0C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EA020844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfAULSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:18:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60387 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfAULSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:18:00 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBHJSV2492693
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:17:19 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBHJOF2492690;
        Mon, 21 Jan 2019 03:17:19 -0800
Date:   Mon, 21 Jan 2019 03:17:19 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrew Murray <tipbot@zytor.com>
Message-ID: <tip-cc6795aeffea0a80d0baf9ad31ba926a6c42cef5@git.kernel.org>
Cc:     acme@kernel.org, mark.rutland@arm.com, rth@twiddle.net,
        shawnguo@kernel.org, mattst88@gmail.com, benh@kernel.crashing.org,
        paulus@samba.org, andrew.murray@arm.com, tglx@linutronix.de,
        peterz@infradead.org, linux@armlinux.org.uk,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com,
        ink@jurassic.park.msu.ru, mingo@kernel.org, will.deacon@arm.com,
        bp@alien8.de, mpe@ellerman.id.au
Reply-To: ink@jurassic.park.msu.ru, mingo@kernel.org, will.deacon@arm.com,
          bp@alien8.de, mpe@ellerman.id.au, linux@armlinux.org.uk,
          peterz@infradead.org, s.hauer@pengutronix.de,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          hpa@zytor.com, mark.rutland@arm.com, rth@twiddle.net,
          shawnguo@kernel.org, mattst88@gmail.com,
          benh@kernel.crashing.org, paulus@samba.org,
          andrew.murray@arm.com, tglx@linutronix.de, acme@kernel.org
In-Reply-To: <1547128414-50693-4-git-send-email-andrew.murray@arm.com>
References: <1547128414-50693-4-git-send-email-andrew.murray@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Add PERF_PMU_CAP_NO_EXCLUDE for
 exclusion incapable PMUs
Git-Commit-ID: cc6795aeffea0a80d0baf9ad31ba926a6c42cef5
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

Commit-ID:  cc6795aeffea0a80d0baf9ad31ba926a6c42cef5
Gitweb:     https://git.kernel.org/tip/cc6795aeffea0a80d0baf9ad31ba926a6c42cef5
Author:     Andrew Murray <andrew.murray@arm.com>
AuthorDate: Thu, 10 Jan 2019 13:53:25 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:01:20 +0100

perf/core: Add PERF_PMU_CAP_NO_EXCLUDE for exclusion incapable PMUs

Many PMU drivers do not have the capability to exclude counting events
that occur in specific contexts such as idle, kernel, guest, etc. These
drivers indicate this by returning an error in their event_init upon
testing the events attribute flags. This approach is error prone and
often inconsistent.

Let's instead allow PMU drivers to advertise their inability to exclude
based on context via a new capability: PERF_PMU_CAP_NO_EXCLUDE. This
allows the perf core to reject requests for exclusion events where
there is no support in the PMU.

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
Link: https://lkml.kernel.org/r/1547128414-50693-4-git-send-email-andrew.murray@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/perf_event.h | 1 +
 kernel/events/core.c       | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 54a78d22f0a6..cec02dc63b51 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -244,6 +244,7 @@ struct perf_event;
 #define PERF_PMU_CAP_EXCLUSIVE			0x10
 #define PERF_PMU_CAP_ITRACE			0x20
 #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
+#define PERF_PMU_CAP_NO_EXCLUDE			0x80
 
 /**
  * struct pmu - generic performance monitoring unit
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3cd13a30f732..fbe59b793b36 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9772,6 +9772,15 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 	if (ctx)
 		perf_event_ctx_unlock(event->group_leader, ctx);
 
+	if (!ret) {
+		if (pmu->capabilities & PERF_PMU_CAP_NO_EXCLUDE &&
+				event_has_any_exclude_flag(event)) {
+			if (event->destroy)
+				event->destroy(event);
+			ret = -EINVAL;
+		}
+	}
+
 	if (ret)
 		module_put(pmu->module);
 
