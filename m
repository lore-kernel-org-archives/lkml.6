Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A53CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1FF2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1FF2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeJaESa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:18:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:23880 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbeJaERZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:17:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 12:22:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="103876756"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2018 12:22:40 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [Patch v4 07/18] x86/smt: Convert cpu_smt_control check to cpu_smt_enabled static key
Date:   Tue, 30 Oct 2018 11:49:14 -0700
Message-Id: <55b8a35095d778d257c7b22d86e45eace6905ae5.1540923609.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1540923609.git.tim.c.chen@linux.intel.com>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1540923609.git.tim.c.chen@linux.intel.com>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the SMT code paths check from using cpu_smt_control to
cpu_smt_enabled static key.  This saves a branching check.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 arch/x86/kvm/vmx.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index eb07ab6..32d962e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -355,7 +355,7 @@ void arch_smt_update(void)
 
 	mutex_lock(&spec_ctrl_mutex);
 	mask = x86_spec_ctrl_base;
-	if (cpu_smt_control == CPU_SMT_ENABLED)
+	if (static_branch_likely(&cpu_smt_enabled))
 		mask |= SPEC_CTRL_STIBP;
 	else
 		mask &= ~SPEC_CTRL_STIBP;
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 533a327..8ec0ea3 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11072,7 +11072,7 @@ static int vmx_vm_init(struct kvm *kvm)
 			 * Warn upon starting the first VM in a potentially
 			 * insecure environment.
 			 */
-			if (cpu_smt_control == CPU_SMT_ENABLED)
+			if (static_branch_likely(&cpu_smt_enabled))
 				pr_warn_once(L1TF_MSG_SMT);
 			if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_NEVER)
 				pr_warn_once(L1TF_MSG_L1D);
-- 
2.9.4

