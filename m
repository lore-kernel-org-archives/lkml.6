Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B64C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901DD2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901DD2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeI3ESi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52053 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728778AbeI3ESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:35 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6E-0000H0-Pv; Sat, 29 Sep 2018 22:48:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006sE-Hg; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Borislav Petkov" <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "David Woodhouse" <dwmw@amazon.co.uk>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.910470277@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 042/131] x86/bugs: Expose x86_spec_ctrl_base directly
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit fa8ac4988249c38476f6ad678a4848a736373403 upstream.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/nospec-branch.h | 16 +++++-----------
 arch/x86/include/asm/spec-ctrl.h     |  3 ---
 arch/x86/kernel/cpu/bugs.c           | 11 +----------
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
@@ -202,16 +203,6 @@ void x86_spec_ctrl_set(u64 val)
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

