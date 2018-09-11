Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E145BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64D82086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64D82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeIKWPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:15:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:31116 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbeIKWPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:15:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 10:14:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,361,1531810800"; 
   d="scan'208";a="79642214"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2018 10:14:58 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 4/6] x86/intel_rdt: Create required perf event attributes
Date:   Tue, 11 Sep 2018 10:14:35 -0700
Message-Id: <060c5fa0a1f227e6119841b3b617c3f0cc9d5da1.1536685533.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1536685533.git.reinette.chatre@intel.com>
References: <cover.1536685533.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1536685533.git.reinette.chatre@intel.com>
References: <cover.1536685533.git.reinette.chatre@intel.com>
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
index 8ad83eb3fc89..2191623f1f27 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -915,6 +915,31 @@ static int measure_cycles_lat_fn(void *_plr)
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

