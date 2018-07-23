Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB28ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C606520856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C606520856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbeGWNu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:50:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389608AbeGWNsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:05 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A41DDC18;
        Mon, 23 Jul 2018 12:46:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 093/107] x86/bugs: Expose x86_spec_ctrl_base directly
Date:   Mon, 23 Jul 2018 14:42:27 +0200
Message-Id: <20180723122418.166772143@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit fa8ac4988249c38476f6ad678a4848a736373403 upstream

x86_spec_ctrl_base is the system wide default value for the SPEC_CTRL MSR.
x86_spec_ctrl_get_default() returns x86_spec_ctrl_base and was intended to
prevent modification to that variable. Though the variable is read only
after init and globaly visible already.

Remove the function and export the variable instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/nospec-branch.h |   16 +++++-----------
 arch/x86/include/asm/spec-ctrl.h     |    3 ---
 arch/x86/kernel/cpu/bugs.c           |   11 +----------
 3 files changed, 6 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -172,16 +172,7 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_IBRS,
 };
 
-/*
- * The Intel specification for the SPEC_CTRL MSR requires that we
- * preserve any already set reserved bits at boot time (e.g. for
- * future additions that this kernel is not currently aware of).
- * We then set any additional mitigation bits that we want
- * ourselves and always use this as the base for SPEC_CTRL.
- * We also use this when handling guest entry/exit as below.
- */
 extern void x86_spec_ctrl_set(u64);
-extern u64 x86_spec_ctrl_get_default(void);
 
 /* The Speculative Store Bypass disable variants */
 enum ssb_mitigation {
@@ -232,6 +223,9 @@ static inline void indirect_branch_predi
 	alternative_msr_write(MSR_IA32_PRED_CMD, val, X86_FEATURE_USE_IBPB);
 }
 
+/* The Intel SPEC CTRL MSR base value cache */
+extern u64 x86_spec_ctrl_base;
+
 /*
  * With retpoline, we must use IBRS to restrict branch prediction
  * before calling into firmware.
@@ -240,7 +234,7 @@ static inline void indirect_branch_predi
  */
 #define firmware_restrict_branch_speculation_start()			\
 do {									\
-	u64 val = x86_spec_ctrl_get_default() | SPEC_CTRL_IBRS;		\
+	u64 val = x86_spec_ctrl_base | SPEC_CTRL_IBRS;			\
 									\
 	preempt_disable();						\
 	alternative_msr_write(MSR_IA32_SPEC_CTRL, val,			\
@@ -249,7 +243,7 @@ do {									\
 
 #define firmware_restrict_branch_speculation_end()			\
 do {									\
-	u64 val = x86_spec_ctrl_get_default();				\
+	u64 val = x86_spec_ctrl_base;					\
 									\
 	alternative_msr_write(MSR_IA32_SPEC_CTRL, val,			\
 			      X86_FEATURE_USE_IBRS_FW);			\
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -47,9 +47,6 @@ void x86_spec_ctrl_restore_host(u64 gues
 extern u64 x86_amd_ls_cfg_base;
 extern u64 x86_amd_ls_cfg_ssbd_mask;
 
-/* The Intel SPEC CTRL MSR base value cache */
-extern u64 x86_spec_ctrl_base;
-
 static inline u64 ssbd_tif_to_spec_ctrl(u64 tifn)
 {
 	BUILD_BUG_ON(TIF_SSBD < SPEC_CTRL_SSBD_SHIFT);
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -35,6 +35,7 @@ static void __init ssb_select_mitigation
  * writes to SPEC_CTRL contain whatever reserved bits have been set.
  */
 u64 x86_spec_ctrl_base;
+EXPORT_SYMBOL_GPL(x86_spec_ctrl_base);
 
 /*
  * The vendor and possibly platform specific bits which can be modified in
@@ -139,16 +140,6 @@ void x86_spec_ctrl_set(u64 val)
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_set);
 
-u64 x86_spec_ctrl_get_default(void)
-{
-	u64 msrval = x86_spec_ctrl_base;
-
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
-		msrval |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
-	return msrval;
-}
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
-
 void
 x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {


