Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942BBECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD7820880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD7820880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389642AbeGWNsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:48:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51698 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389607AbeGWNsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:05 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D7FA7BDB;
        Mon, 23 Jul 2018 12:46:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 092/107] x86/bugs: Unify x86_spec_ctrl_{set_guest, restore_host}
Date:   Mon, 23 Jul 2018 14:42:26 +0200
Message-Id: <20180723122418.099277233@linuxfoundation.org>
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

From: Borislav Petkov <bp@suse.de>

commit cc69b34989210f067b2c51d5539b5f96ebcc3a01 upstream

Function bodies are very similar and are going to grow more almost
identical code. Add a bool arg to determine whether SPEC_CTRL is being set
for the guest or restored to the host.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/spec-ctrl.h |   33 ++++++++++++++++++---
 arch/x86/kernel/cpu/bugs.c       |   60 +++++++++------------------------------
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
@@ -149,55 +149,25 @@ u64 x86_spec_ctrl_get_default(void)
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


