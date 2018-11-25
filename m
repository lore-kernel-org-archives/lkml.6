Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D58C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EA32084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EA32084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeKZFtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 00:49:18 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52963 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeKZFtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 00:49:18 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gQzb3-0003US-Ab; Sun, 25 Nov 2018 19:57:33 +0100
Message-Id: <20181125185005.759457117@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 25 Nov 2018 19:33:52 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch V2 24/28] x86/speculation: Prepare arch_smt_update() for PRCTL
 mode
References: <20181125183328.318175777@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation-Prepare-arch-smt-update-for-PRCTL-mode.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upcoming fine grained per task STIBP control needs to be updated on CPU
hotplug as well.

Split out the code which controls the strict mode so the prctl control code
can be added later. Mark the SMP function call argument __unused while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---

v1 -> v2: s/app2app/user/. Mark smp function argument __unused

---
 arch/x86/kernel/cpu/bugs.c |   46 ++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -530,40 +530,44 @@ static void __init spectre_v2_select_mit
 	arch_smt_update();
 }
 
-static bool stibp_needed(void)
+static void update_stibp_msr(void * __unused)
 {
-	/* Enhanced IBRS makes using STIBP unnecessary. */
-	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
-		return false;
-
-	/* Check for strict user mitigation mode */
-	return spectre_v2_user == SPECTRE_V2_USER_STRICT;
+	wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 }
 
-static void update_stibp_msr(void *info)
+/* Update x86_spec_ctrl_base in case SMT state changed. */
+static void update_stibp_strict(void)
 {
-	wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+	u64 mask = x86_spec_ctrl_base & ~SPEC_CTRL_STIBP;
+
+	if (sched_smt_active())
+		mask |= SPEC_CTRL_STIBP;
+
+	if (mask == x86_spec_ctrl_base)
+		return;
+
+	pr_info("Spectre v2 user space SMT mitigation: STIBP %s\n",
+		mask & SPEC_CTRL_STIBP ? "always-on" : "off");
+	x86_spec_ctrl_base = mask;
+	on_each_cpu(update_stibp_msr, NULL, 1);
 }
 
 void arch_smt_update(void)
 {
-	u64 mask;
-
-	if (!stibp_needed())
+	/* Enhanced IBRS implies STIBP. No update required. */
+	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
 		return;
 
 	mutex_lock(&spec_ctrl_mutex);
 
-	mask = x86_spec_ctrl_base & ~SPEC_CTRL_STIBP;
-	if (sched_smt_active())
-		mask |= SPEC_CTRL_STIBP;
-
-	if (mask != x86_spec_ctrl_base) {
-		pr_info("Spectre v2 cross-process SMT mitigation: %s STIBP\n",
-			mask & SPEC_CTRL_STIBP ? "Enabling" : "Disabling");
-		x86_spec_ctrl_base = mask;
-		on_each_cpu(update_stibp_msr, NULL, 1);
+	switch (spectre_v2_user) {
+	case SPECTRE_V2_USER_NONE:
+		break;
+	case SPECTRE_V2_USER_STRICT:
+		update_stibp_strict();
+		break;
 	}
+
 	mutex_unlock(&spec_ctrl_mutex);
 }
 


