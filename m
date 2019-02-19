Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC55C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE11F21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbfBSUB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:01:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:8762 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbfBSUBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:01:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 12:01:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="139918097"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2019 12:01:00 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, acme@kernel.org,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, jolsa@redhat.com, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 07/10] perf/x86/intel/uncore: Support die scope counters on CLX-AP
Date:   Tue, 19 Feb 2019 12:00:08 -0800
Message-Id: <1550606411-5313-8-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
References: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

CLX-AP has the same uncore counters as SKX, but they are die scope.
Add a bool variable to indicate die scope only uncore counters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index f795a73..f850ab9 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -20,6 +20,8 @@ static cpumask_t uncore_cpu_mask[DOMAIN_TYPE_MAX];
 
 static unsigned int uncore_domain_type_mask;
 
+static bool die_only;
+
 /* constraint for the fixed counter */
 static struct event_constraint uncore_constraint_fixed =
 	EVENT_CONSTRAINT(~0ULL, 1 << UNCORE_PMC_IDX_FIXED, ~0ULL);
@@ -895,6 +897,9 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 	if (!pmus)
 		return -ENOMEM;
 
+	if (die_only)
+		type->type.type = DIE_DOMAIN;
+
 	if (domain_type_init(&type->type)) {
 		kfree(pmus);
 		return -ENOMEM;
@@ -1503,6 +1508,15 @@ static int __init intel_uncore_init(void)
 		return -ENODEV;
 
 	uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
+
+	/*
+	 * CLX-AP has the same uncore counters as SKX,
+	 * but they are die scope.
+	 */
+	if ((boot_cpu_data.x86_model == INTEL_FAM6_SKYLAKE_X) &&
+	    (boot_cpu_data.x86_max_dies > 1))
+		die_only = true;
+
 	if (uncore_init->pci_init) {
 		pret = uncore_init->pci_init();
 		if (!pret)
-- 
2.7.4

