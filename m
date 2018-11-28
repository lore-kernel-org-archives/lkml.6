Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F2DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA542081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA542081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeK2Bgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:36:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44007 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbeK2Bgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:36:51 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEYEGr2324116
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:34:14 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEYEwl2324113;
        Wed, 28 Nov 2018 06:34:14 -0800
Date:   Wed, 28 Nov 2018 06:34:14 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-6893a959d7fdebbab5f5aa112c277d5a44435ba1@git.kernel.org>
Cc:     jkosina@suse.cz, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, longman9394@gmail.com,
        dwmw@amazon.co.uk, luto@kernel.org, ak@linux.intel.com,
        gregkh@linuxfoundation.org, thomas.lendacky@amd.com,
        david.c.stewart@intel.com, torvalds@linux-foundation.org,
        dave.hansen@intel.com, arjan@linux.intel.com, jpoimboe@redhat.com,
        mingo@kernel.org, peterz@infradead.org, asit.k.mallick@intel.com,
        keescook@chromium.org, casey.schaufler@intel.com,
        tim.c.chen@linux.intel.com, aarcange@redhat.com, jcm@redhat.com
Reply-To: casey.schaufler@intel.com, keescook@chromium.org,
          aarcange@redhat.com, jcm@redhat.com, tim.c.chen@linux.intel.com,
          dave.hansen@intel.com, asit.k.mallick@intel.com,
          peterz@infradead.org, mingo@kernel.org, arjan@linux.intel.com,
          jpoimboe@redhat.com, luto@kernel.org, dwmw@amazon.co.uk,
          longman9394@gmail.com, torvalds@linux-foundation.org,
          david.c.stewart@intel.com, gregkh@linuxfoundation.org,
          thomas.lendacky@amd.com, ak@linux.intel.com, jkosina@suse.cz,
          hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20181125185005.759457117@linutronix.de>
References: <20181125185005.759457117@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Prepare arch_smt_update() for PRCTL
 mode
Git-Commit-ID: 6893a959d7fdebbab5f5aa112c277d5a44435ba1
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

Commit-ID:  6893a959d7fdebbab5f5aa112c277d5a44435ba1
Gitweb:     https://git.kernel.org/tip/6893a959d7fdebbab5f5aa112c277d5a44435ba1
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:52 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:13 +0100

x86/speculation: Prepare arch_smt_update() for PRCTL mode

The upcoming fine grained per task STIBP control needs to be updated on CPU
hotplug as well.

Split out the code which controls the strict mode so the prctl control code
can be added later. Mark the SMP function call argument __unused while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Casey Schaufler <casey.schaufler@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Waiman Long <longman9394@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Stewart <david.c.stewart@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181125185005.759457117@linutronix.de


---
 arch/x86/kernel/cpu/bugs.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 29f40a92f5a8..9cab538e10f1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -530,40 +530,44 @@ specv2_set_mode:
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
+	pr_info("Update user space SMT mitigation: STIBP %s\n",
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
 
