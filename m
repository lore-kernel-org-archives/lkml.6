Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8470EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6D62146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y6ckdp+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6D62146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbeLDK51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:57:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeLDK5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:57:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D96C2146D;
        Tue,  4 Dec 2018 10:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921041;
        bh=P7psbqmqRAIT3xF1xOmH2JA8sbEbZnhWRMvVo6L1Td8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y6ckdp+2e1c7/0QEAnznyXkp9fz4J1QMH5B+xFyp6FdZytlgJ5YqL2bWfKj8Yz9sO
         Sz0FpUpDed6lHRLSMt56Psj4xxq3dKTIUoBr7szhLKdeQvI+WfDP+RMe7sg9J8bbKf
         YfGPzG2EVEiSq2aRPQyGvYHweHwujgJLRgY4UWlQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.19 057/139] x86/speculation: Prepare arch_smt_update() for PRCTL mode
Date:   Tue,  4 Dec 2018 11:48:58 +0100
Message-Id: <20181204103652.316353783@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner tglx@linutronix.de

commit 6893a959d7fdebbab5f5aa112c277d5a44435ba1 upstream

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   46 ++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -528,40 +528,44 @@ specv2_set_mode:
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
 


