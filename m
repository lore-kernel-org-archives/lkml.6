Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D41C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BADF2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BADF2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbeI3EWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:22:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52032 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728750AbeI3ESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:35 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6E-0000H1-SF; Sat, 29 Sep 2018 22:48:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006s9-GM; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Borislav Petkov" <bp@suse.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "David Woodhouse" <dwmw@amazon.co.uk>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.859095881@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 041/131] x86/bugs: Unify x86_spec_ctrl_{set_guest,restore_host}
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

From: Borislav Petkov <bp@suse.de>

commit cc69b34989210f067b2c51d5539b5f96ebcc3a01 upstream.

Function bodies are very similar and are going to grow more almost
identical code. Add a bool arg to determine whether SPEC_CTRL is being set
for the guest or restored to the host.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/spec-ctrl.h | 33 +++++++++++++++---
 arch/x86/kernel/cpu/bugs.c       | 60 ++++++++------------------------
 2 files changed, 44 insertions(+), 49 deletions(-)

--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -13,10 +13,35 @@
  * Takes the guest view of SPEC_CTRL MSR as a parameter and also
  * the guest's version of VIRT_SPEC_CTRL, if emulated.
  */
-extern void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl,
-				    u64 guest_virt_spec_ctrl);
-extern void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl,
-				       u64 guest_virt_spec_ctrl);
+extern void x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool guest);
+
+/**
+ * x86_spec_ctrl_set_guest - Set speculation control registers for the guest
+ * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
+ * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
+ *				(may get translated to MSR_AMD64_LS_CFG bits)
+ *
+ * Avoids writing to the MSR if the content/bits are the same
+ */
+static inline
+void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
+{
+	x86_virt_spec_ctrl(guest_spec_ctrl, guest_virt_spec_ctrl, true);
+}
+
+/**
+ * x86_spec_ctrl_restore_host - Restore host speculation control registers
+ * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
+ * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
+ *				(may get translated to MSR_AMD64_LS_CFG bits)
+ *
+ * Avoids writing to the MSR if the content/bits are the same
+ */
+static inline
+void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
+{
+	x86_virt_spec_ctrl(guest_spec_ctrl, guest_virt_spec_ctrl, false);
+}
 
 /* AMD specific Speculative Store Bypass MSR data */
 extern u64 x86_amd_ls_cfg_base;
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -212,55 +212,25 @@ u64 x86_spec_ctrl_get_default(void)
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
 
-/**
- * x86_spec_ctrl_set_guest - Set speculation control registers for the guest
- * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
- * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
- *				(may get translated to MSR_AMD64_LS_CFG bits)
- *
- * Avoids writing to the MSR if the content/bits are the same
- */
-void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
+void
+x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
-	u64 host = x86_spec_ctrl_base;
+	struct thread_info *ti = current_thread_info();
+	u64 msr, host = x86_spec_ctrl_base;
 
 	/* Is MSR_SPEC_CTRL implemented ? */
-	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
-		return;
-
-	/* SSBD controlled in MSR_SPEC_CTRL */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
-		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
-
-	if (host != guest_spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, guest_spec_ctrl);
-}
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_set_guest);
-
-/**
- * x86_spec_ctrl_restore_host - Restore host speculation control registers
- * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
- * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
- *				(may get translated to MSR_AMD64_LS_CFG bits)
- *
- * Avoids writing to the MSR if the content/bits are the same
- */
-void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
-{
-	u64 host = x86_spec_ctrl_base;
-
-	/* Is MSR_SPEC_CTRL implemented ? */
-	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
-		return;
-
-	/* SSBD controlled in MSR_SPEC_CTRL */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
-		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
-
-	if (host != guest_spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, host);
+	if (static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
+		/* SSBD controlled in MSR_SPEC_CTRL */
+		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
+			host |= ssbd_tif_to_spec_ctrl(ti->flags);
+
+		if (host != guest_spec_ctrl) {
+			msr = setguest ? guest_spec_ctrl : host;
+			wrmsrl(MSR_IA32_SPEC_CTRL, msr);
+		}
+	}
 }
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_restore_host);
+EXPORT_SYMBOL_GPL(x86_virt_spec_ctrl);
 
 static void x86_amd_ssb_disable(void)
 {

