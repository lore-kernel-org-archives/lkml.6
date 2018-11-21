Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A22C32789
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6572B214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6572B214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeKULF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:05:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:30250 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbeKULF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:05:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 16:33:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,259,1539673200"; 
   d="scan'208";a="93650249"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2018 16:33:31 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        stable@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>
Subject: [Patch v6 15/16] sched/smt: Make sched_smt_present track topology
Date:   Tue, 20 Nov 2018 16:00:07 -0800
Message-Id: <ddd382e2cb674098403932f796286f59529a5be0.1542757030.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542757030.git.tim.c.chen@linux.intel.com>
References: <cover.1542757030.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542757030.git.tim.c.chen@linux.intel.com>
References: <cover.1542757030.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

From: Peter Zijlstra (Intel) <peterz@infradead.org>

Currently the sched_smt_present static key is only enabled when we
encounter SMT topology. However there is demand to also disable the key
when the topology changes such that there is no SMT present anymore.

Implement this by making the key count the number of cores that have SMT
enabled.

In particular, the SMT topology bits are set before we enable
interrrupts and similarly, are cleared after we disable interrupts for
the last time and die.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/core.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 091e089..6fedf3a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5738,15 +5738,10 @@ int sched_cpu_activate(unsigned int cpu)
 
 #ifdef CONFIG_SCHED_SMT
 	/*
-	 * The sched_smt_present static key needs to be evaluated on every
-	 * hotplug event because at boot time SMT might be disabled when
-	 * the number of booted CPUs is limited.
-	 *
-	 * If then later a sibling gets hotplugged, then the key would stay
-	 * off and SMT scheduling would never be functional.
+	 * When going up, increment the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) > 1)
-		static_branch_enable_cpuslocked(&sched_smt_present);
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+		static_branch_inc_cpuslocked(&sched_smt_present);
 #endif
 	set_cpu_active(cpu, true);
 
@@ -5790,6 +5785,14 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 */
 	synchronize_rcu_mult(call_rcu, call_rcu_sched);
 
+#ifdef CONFIG_SCHED_SMT
+	/*
+	 * When going down, decrement the number of cores with SMT present.
+	 */
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+		static_branch_dec_cpuslocked(&sched_smt_present);
+#endif
+
 	if (!sched_smp_initialized)
 		return 0;
 
-- 
2.9.4

