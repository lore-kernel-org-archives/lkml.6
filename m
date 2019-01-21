Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F07C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96B420663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfAULXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:23:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfAULXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:23:09 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBMWIS2493654
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:22:32 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBMWv82493651;
        Mon, 21 Jan 2019 03:22:32 -0800
Date:   Mon, 21 Jan 2019 03:22:32 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrew Murray <tipbot@zytor.com>
Message-ID: <tip-88dbe3c94e2773cbe200bf58dd88abacf27053e7@git.kernel.org>
Cc:     shawnguo@kernel.org, andrew.murray@arm.com, bp@alien8.de,
        will.deacon@arm.com, peterz@infradead.org, hpa@zytor.com,
        acme@kernel.org, mpe@ellerman.id.au, tglx@linutronix.de,
        mingo@kernel.org, mark.rutland@arm.com,
        torvalds@linux-foundation.org, ink@jurassic.park.msu.ru,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        linux@armlinux.org.uk, mattst88@gmail.com, rth@twiddle.net,
        paulus@samba.org, benh@kernel.crashing.org
Reply-To: will.deacon@arm.com, hpa@zytor.com, peterz@infradead.org,
          shawnguo@kernel.org, bp@alien8.de, andrew.murray@arm.com,
          mattst88@gmail.com, linux@armlinux.org.uk,
          linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
          torvalds@linux-foundation.org, ink@jurassic.park.msu.ru,
          benh@kernel.crashing.org, rth@twiddle.net, paulus@samba.org,
          mpe@ellerman.id.au, acme@kernel.org, mingo@kernel.org,
          mark.rutland@arm.com, tglx@linutronix.de
In-Reply-To: <1547128414-50693-12-git-send-email-andrew.murray@arm.com>
References: <1547128414-50693-12-git-send-email-andrew.murray@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core, arch/x86: Strengthen exclusion checks
 with PERF_PMU_CAP_NO_EXCLUDE
Git-Commit-ID: 88dbe3c94e2773cbe200bf58dd88abacf27053e7
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

Commit-ID:  88dbe3c94e2773cbe200bf58dd88abacf27053e7
Gitweb:     https://git.kernel.org/tip/88dbe3c94e2773cbe200bf58dd88abacf27053e7
Author:     Andrew Murray <andrew.murray@arm.com>
AuthorDate: Thu, 10 Jan 2019 13:53:33 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:01:29 +0100

perf/core, arch/x86: Strengthen exclusion checks with PERF_PMU_CAP_NO_EXCLUDE

For x86 PMUs that do not support context exclusion let's advertise the
PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that perf will
prevent us from handling events where any exclusion flags are set.
Let's also remove the now unnecessary check for exclusion flags.

This change means that amd/iommu and amd/uncore will now also
indicate that they do not support exclude_{hv|idle} and intel/uncore
that it does not support exclude_{guest|host}.

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
Link: https://lkml.kernel.org/r/1547128414-50693-12-git-send-email-andrew.murray@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/amd/iommu.c    | 6 +-----
 arch/x86/events/amd/uncore.c   | 7 ++-----
 arch/x86/events/intel/uncore.c | 9 +--------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 3210fee27e7f..7635c23f7d82 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -223,11 +223,6 @@ static int perf_iommu_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	/* IOMMU counters do not have usr/os/guest/host bits */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_host || event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 
@@ -414,6 +409,7 @@ static const struct pmu iommu_pmu __initconst = {
 	.read		= perf_iommu_read,
 	.task_ctx_nr	= perf_invalid_context,
 	.attr_groups	= amd_iommu_attr_groups,
+	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 static __init int init_one_iommu(unsigned int idx)
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 398df6eaa109..79cfd3b30ceb 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -201,11 +201,6 @@ static int amd_uncore_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	/* NB and Last level cache counters do not have usr/os/guest/host bits */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_host || event->attr.exclude_guest)
-		return -EINVAL;
-
 	/* and we do not enable counter overflow interrupts */
 	hwc->config = event->attr.config & AMD64_RAW_EVENT_MASK_NB;
 	hwc->idx = -1;
@@ -307,6 +302,7 @@ static struct pmu amd_nb_pmu = {
 	.start		= amd_uncore_start,
 	.stop		= amd_uncore_stop,
 	.read		= amd_uncore_read,
+	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 static struct pmu amd_llc_pmu = {
@@ -317,6 +313,7 @@ static struct pmu amd_llc_pmu = {
 	.start		= amd_uncore_start,
 	.stop		= amd_uncore_stop,
 	.read		= amd_uncore_read,
+	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 static struct amd_uncore *amd_uncore_alloc(unsigned int cpu)
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 27a461414b30..d516161c00c4 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -695,14 +695,6 @@ static int uncore_pmu_event_init(struct perf_event *event)
 	if (pmu->func_id < 0)
 		return -ENOENT;
 
-	/*
-	 * Uncore PMU does measure at all privilege level all the time.
-	 * So it doesn't make sense to specify any exclude bits.
-	 */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-			event->attr.exclude_hv || event->attr.exclude_idle)
-		return -EINVAL;
-
 	/* Sampling not supported yet */
 	if (hwc->sample_period)
 		return -EINVAL;
@@ -800,6 +792,7 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 			.stop		= uncore_pmu_event_stop,
 			.read		= uncore_pmu_event_read,
 			.module		= THIS_MODULE,
+			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 		};
 	} else {
 		pmu->pmu = *pmu->type->pmu;
