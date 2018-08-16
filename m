Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6406CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B1221477
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B1221477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeHPXRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:17:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:43390 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbeHPXRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:17:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 13:16:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,248,1531810800"; 
   d="scan'208";a="225248288"
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
Subject: [PATCH V2 4/6] x86/intel_rdt: Add helper to obtain performance counter index
Date:   Thu, 16 Aug 2018 13:16:07 -0700
Message-Id: <ec245dd86408b92b5cb1553b7004a6a391d54640.1534450299.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1534450299.git.reinette.chatre@intel.com>
References: <cover.1534450299.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1534450299.git.reinette.chatre@intel.com>
References: <cover.1534450299.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In support of the most accurate measurements rdpmcl() is used instead of
the more elaborate perf_event_read_local(). rdpmcl() requires the index
of the performance counter used so a helper is introduced to determine
the index used by a provided performance event.

The index used by a performance event may change when interrupts are
enabled. A check is added to ensure that the index is only accessed
with interrupts disabled. Even with this check the use of this counter
needs to be done with care to ensure it is queried and used within the
same disabled interrupts section.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index ab93079e9e5b..20b76024701d 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -942,6 +942,27 @@ static struct perf_event_attr __attribute__((unused)) perf_hit_attr = {
 	.exclude_user	= 1,
 };
 
+/**
+ * x86_perf_rdpmc_ctr_get - Return PMC counter used for event
+ * @event: the perf_event to which the PMC counter was assigned
+ *
+ * The counter assigned to this performance event may change if interrupts
+ * are enabled. This counter should thus never be used while interrupts are
+ * enabled. Before this function is used to obtain the assigned counter the
+ * event could be checked for validity using, for example,
+ * perf_event_read_local(), within the same interrupt disabled section in
+ * which this counter is planned to be used.
+ *
+ * Return: The index of the performance monitoring counter assigned to
+ * @perf_event, -1 if event is not valid.
+ */
+static inline int x86_perf_rdpmc_ctr_get(struct perf_event *event)
+{
+	lockdep_assert_irqs_disabled();
+
+	return IS_ERR_OR_NULL(event) ? -1 : event->hw.event_base_rdpmc;
+}
+
 static int measure_cycles_perf_fn(void *_plr)
 {
 	unsigned long long l3_hits = 0, l3_miss = 0;
-- 
2.17.0

