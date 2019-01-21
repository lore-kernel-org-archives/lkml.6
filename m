Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF38AC7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBDB20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfAULVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:21:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49155 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfAULVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:21:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBKYAI2493219
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:20:34 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBKYQx2493216;
        Mon, 21 Jan 2019 03:20:34 -0800
Date:   Mon, 21 Jan 2019 03:20:34 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrew Murray <tipbot@zytor.com>
Message-ID: <tip-a66b0010f89e50ca0dd8bb3dc5187cd21e1da891@git.kernel.org>
Cc:     peterz@infradead.org, linux@armlinux.org.uk, mingo@kernel.org,
        acme@kernel.org, torvalds@linux-foundation.org, mpe@ellerman.id.au,
        bp@alien8.de, mattst88@gmail.com, mark.rutland@arm.com,
        andrew.murray@arm.com, shawnguo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, benh@kernel.crashing.org,
        ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org,
        rth@twiddle.net, paulus@samba.org, will.deacon@arm.com,
        s.hauer@pengutronix.de
Reply-To: mark.rutland@arm.com, mattst88@gmail.com, mpe@ellerman.id.au,
          bp@alien8.de, mingo@kernel.org, linux@armlinux.org.uk,
          acme@kernel.org, torvalds@linux-foundation.org,
          peterz@infradead.org, s.hauer@pengutronix.de, rth@twiddle.net,
          paulus@samba.org, will.deacon@arm.com, ink@jurassic.park.msu.ru,
          linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
          andrew.murray@arm.com, hpa@zytor.com, tglx@linutronix.de,
          shawnguo@kernel.org
In-Reply-To: <1547128414-50693-9-git-send-email-andrew.murray@arm.com>
References: <1547128414-50693-9-git-send-email-andrew.murray@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/drivers: Strengthen exclusion checks with
 PERF_PMU_CAP_NO_EXCLUDE
Git-Commit-ID: a66b0010f89e50ca0dd8bb3dc5187cd21e1da891
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

Commit-ID:  a66b0010f89e50ca0dd8bb3dc5187cd21e1da891
Gitweb:     https://git.kernel.org/tip/a66b0010f89e50ca0dd8bb3dc5187cd21e1da891
Author:     Andrew Murray <andrew.murray@arm.com>
AuthorDate: Thu, 10 Jan 2019 13:53:30 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:01:25 +0100

perf/drivers: Strengthen exclusion checks with PERF_PMU_CAP_NO_EXCLUDE

For drivers that do not support context exclusion let's advertise the
PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that perf will
prevent us from handling events where any exclusion flags are set.
Let's also remove the now unnecessary check for exclusion flags.

This change means that qcom_{l2|l3}_pmu will now also indicate that
they do not support exclude_{host|guest} and that xgene_pmu does
not also support exclude_idle and exclude_hv.

Note that for qcom_l2_pmu we now implictly return -EINVAL instead
of -EOPNOTSUPP. This change will result in the perf userspace
utility retrying the perf_event_open system call with fallback
event attributes that do not fail.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
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
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: robin.murphy@arm.com
Cc: suzuki.poulose@arm.com
Link: https://lkml.kernel.org/r/1547128414-50693-9-git-send-email-andrew.murray@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/perf/qcom_l2_pmu.c | 9 +--------
 drivers/perf/qcom_l3_pmu.c | 8 +-------
 drivers/perf/xgene_pmu.c   | 6 +-----
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 842135cf35a3..091b4d7d32c4 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -509,14 +509,6 @@ static int l2_cache_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
-	/* We cannot filter accurately so we just don't allow it. */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_hv || event->attr.exclude_idle) {
-		dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,
-				    "Can't exclude execution levels\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (((L2_EVT_GROUP(event->attr.config) > L2_EVT_GROUP_MAX) ||
 	     ((event->attr.config & ~L2_EVT_MASK) != 0)) &&
 	    (event->attr.config != L2CYCLE_CTR_RAW_CODE)) {
@@ -982,6 +974,7 @@ static int l2_cache_pmu_probe(struct platform_device *pdev)
 		.stop		= l2_cache_event_stop,
 		.read		= l2_cache_event_read,
 		.attr_groups	= l2_cache_pmu_attr_grps,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	l2cache_pmu->num_counters = get_num_counters();
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 2dc63d61f2ea..5d70646da8c7 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -494,13 +494,6 @@ static int qcom_l3_cache__event_init(struct perf_event *event)
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
-	/*
-	 * There are no per-counter mode filters in the PMU.
-	 */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_hv || event->attr.exclude_idle)
-		return -EINVAL;
-
 	/*
 	 * Sampling not supported since these events are not core-attributable.
 	 */
@@ -777,6 +770,7 @@ static int qcom_l3_cache_pmu_probe(struct platform_device *pdev)
 		.read		= qcom_l3_cache__event_read,
 
 		.attr_groups	= qcom_l3_cache_pmu_attr_grps,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	memrc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 0dc9ff0f8894..d4ec04868d59 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -917,11 +917,6 @@ static int xgene_perf_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	/* SOC counters do not have usr/os/guest/host bits */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_host || event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 	/*
@@ -1136,6 +1131,7 @@ static int xgene_init_perf(struct xgene_pmu_dev *pmu_dev, char *name)
 		.start		= xgene_perf_start,
 		.stop		= xgene_perf_stop,
 		.read		= xgene_perf_read,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	/* Hardware counter init */
