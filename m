Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E47C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AB32087E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31AB32087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbeHPCs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:48:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:61123 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbeHPCs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:48:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2018 16:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,245,1531810800"; 
   d="scan'208";a="75694064"
Received: from cschaufl-mobl.amr.corp.intel.com ([10.252.130.105])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2018 16:53:57 -0700
From:   Casey Schaufler <casey.schaufler@intel.com>
To:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        SMACK-discuss@lists.01.org, casey.schaufler@intel.com,
        dave.hansen@intel.com, deneen.t.dock@intel.com,
        kristen@linux.intel.com, arjan@linux.intel.com
Subject: [PATCH RFC 2/5] X86: Support LSM determination of side-channel vulnerability
Date:   Wed, 15 Aug 2018 16:53:52 -0700
Message-Id: <20180815235355.14908-3-casey.schaufler@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180815235355.14908-1-casey.schaufler@intel.com>
References: <20180815235355.14908-1-casey.schaufler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <cschaufler@localhost.localdomain>

When switching between tasks it may be necessary
to set an indirect branch prediction barrier if the
tasks are potentially vulnerable to side-channel
attacks. This adds a call to security_task_safe_sidechannel
so that security modules can weigh in on the decision.

Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
---
 arch/x86/mm/tlb.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 6eb1f34c3c85..8714d4af06aa 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -7,6 +7,7 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
+#include <linux/security.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -270,11 +271,14 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 * threads. It will also not flush if we switch to idle
 		 * thread and back to the same process. It will flush if we
 		 * switch to a different non-dumpable process.
+		 * If a security module thinks that the transition
+		 * is unsafe do the flush.
 		 */
-		if (tsk && tsk->mm &&
-		    tsk->mm->context.ctx_id != last_ctx_id &&
-		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
-			indirect_branch_prediction_barrier();
+		if (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id) {
+			if (get_dumpable(tsk->mm) != SUID_DUMP_USER ||
+			    security_task_safe_sidechannel(tsk) != 0)
+				indirect_branch_prediction_barrier();
+		}
 
 		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
 			/*
-- 
2.17.1

