Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA24BC04AB9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B3921477
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B3921477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeHPXRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:17:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:43390 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbeHPXRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:17:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 13:16:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,248,1531810800"; 
   d="scan'208";a="225248285"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2018 13:16:34 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 3/6] x86/intel_rdt: Create required perf event attributes
Date:   Thu, 16 Aug 2018 13:16:06 -0700
Message-Id: <1cd63f9d4b335c7101c32b4f1755c7bb72d3aa29.1534450299.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1534450299.git.reinette.chatre@intel.com>
References: <cover.1534450299.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1534450299.git.reinette.chatre@intel.com>
References: <cover.1534450299.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A perf event has many attributes that are maintained in a separate
structure that should be provided when a new perf_event is created.

In preparation for the transition to perf_events the required attribute
structures are created for all the events that may be used in the
measurements. Most attributes for all the events are identical. The
actual configuration, what specifies what needs to be measured, is what
will be different between the events used. This configuration needs to
be done with X86_CONFIG that cannot be used as part of the designated
initializers used here, this will be introduced later.

Although they do look identical at this time the attribute structures
needs to be maintained separately since a perf_event will maintain a
pointer to its unique attributes.

In support of patch testing the new structs are given the unused attribute
until their use in later patches.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 25 +++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index f46c8afe7875..ab93079e9e5b 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -917,6 +917,31 @@ static int measure_cycles_lat_fn(void *_plr)
 	return 0;
 }
 
+/*
+ * Create a perf_event_attr for the hit and miss perf events that will
+ * be used during the performance measurement. A perf_event maintains
+ * a pointer to its perf_event_attr so a unique attribute structure is
+ * created for each perf_event.
+ *
+ * The actual configuration of the event is set right before use in order
+ * to use the X86_CONFIG macro.
+ */
+static struct perf_event_attr __attribute__((unused)) perf_miss_attr = {
+	.type		= PERF_TYPE_RAW,
+	.size		= sizeof(struct perf_event_attr),
+	.pinned		= 1,
+	.disabled	= 0,
+	.exclude_user	= 1,
+};
+
+static struct perf_event_attr __attribute__((unused)) perf_hit_attr = {
+	.type		= PERF_TYPE_RAW,
+	.size		= sizeof(struct perf_event_attr),
+	.pinned		= 1,
+	.disabled	= 0,
+	.exclude_user	= 1,
+};
+
 static int measure_cycles_perf_fn(void *_plr)
 {
 	unsigned long long l3_hits = 0, l3_miss = 0;
-- 
2.17.0

