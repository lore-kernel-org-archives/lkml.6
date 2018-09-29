Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202A8C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0962073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0962073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeI2N2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 09:28:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbeI2N2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 09:28:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8T70qeJ726300
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 29 Sep 2018 00:00:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8T70q46726297;
        Sat, 29 Sep 2018 00:00:52 -0700
Date:   Sat, 29 Sep 2018 00:00:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-1182a49529edde899be4b4f0e1ab76e626976eb6@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, reinette.chatre@intel.com,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org,
          reinette.chatre@intel.com, tglx@linutronix.de, mingo@kernel.org,
          peterz@infradead.org
In-Reply-To: <b277ffa78a51254f5414f7b1bc1923826874566e.1537377064.git.reinette.chatre@intel.com>
References: <b277ffa78a51254f5414f7b1bc1923826874566e.1537377064.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] perf/x86: Add helper to obtain performance counter
 index
Git-Commit-ID: 1182a49529edde899be4b4f0e1ab76e626976eb6
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

Commit-ID:  1182a49529edde899be4b4f0e1ab76e626976eb6
Gitweb:     https://git.kernel.org/tip/1182a49529edde899be4b4f0e1ab76e626976eb6
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Wed, 19 Sep 2018 10:29:07 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Sep 2018 22:48:26 +0200

perf/x86: Add helper to obtain performance counter index

perf_event_read_local() is the safest way to obtain measurements
associated with performance events. In some cases the overhead
introduced by perf_event_read_local() affects the measurements and the
use of rdpmcl() is needed. rdpmcl() requires the index
of the performance counter used so a helper is introduced to determine
the index used by a provided performance event.

The index used by a performance event may change when interrupts are
enabled. A check is added to ensure that the index is only accessed
with interrupts disabled. Even with this check the use of this counter
needs to be done with care to ensure it is queried and used within the
same disabled interrupts section.

This change introduces a new checkpatch warning:
CHECK: extern prototypes should be avoided in .h files
+extern int x86_perf_rdpmc_index(struct perf_event *event);

This warning was discussed and designated as a false positive in
http://lkml.kernel.org/r/20180919091759.GZ24124@hirez.programming.kicks-ass.net

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: acme@kernel.org
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/b277ffa78a51254f5414f7b1bc1923826874566e.1537377064.git.reinette.chatre@intel.com

---
 arch/x86/events/core.c            | 21 +++++++++++++++++++++
 arch/x86/include/asm/perf_event.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index dfb2f7c0d019..3550d800b030 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1033,6 +1033,27 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 	}
 }
 
+/**
+ * x86_perf_rdpmc_index - Return PMC counter used for event
+ * @event: the perf_event to which the PMC counter was assigned
+ *
+ * The counter assigned to this performance event may change if interrupts
+ * are enabled. This counter should thus never be used while interrupts are
+ * enabled. Before this function is used to obtain the assigned counter the
+ * event should be checked for validity using, for example,
+ * perf_event_read_local(), within the same interrupt disabled section in
+ * which this counter is planned to be used.
+ *
+ * Return: The index of the performance monitoring counter assigned to
+ * @perf_event.
+ */
+int x86_perf_rdpmc_index(struct perf_event *event)
+{
+	lockdep_assert_irqs_disabled();
+
+	return event->hw.event_base_rdpmc;
+}
+
 static inline int match_prev_assignment(struct hw_perf_event *hwc,
 					struct cpu_hw_events *cpuc,
 					int i)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 12f54082f4c8..b2cf84c35a6d 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -270,6 +270,7 @@ struct perf_guest_switch_msr {
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
 extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
 extern void perf_check_microcode(void);
+extern int x86_perf_rdpmc_index(struct perf_event *event);
 #else
 static inline struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
 {
