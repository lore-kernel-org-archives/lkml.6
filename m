Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116B0C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7072206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7072206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbeKGGJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:09:58 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60963 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbeKGGJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:09:57 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6KfWHS947641
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 12:41:32 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6KfWsS947638;
        Tue, 6 Nov 2018 12:41:32 -0800
Date:   Tue, 6 Nov 2018 12:41:32 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Eial Czerwacki <tipbot@zytor.com>
Message-ID: <tip-a48777fdda7d13179979a889e1fb87655a783cc0@git.kernel.org>
Cc:     shai@scalemp.com, eial@scalemp.com, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jgross@suse.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          jgross@suse.com, shai@scalemp.com, eial@scalemp.com,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <1541439114-28297-1-git-send-email-eial@scalemp.com>
References: <1541439114-28297-1-git-send-email-eial@scalemp.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/vsmp: Remove dependency on pv_irq_ops
Git-Commit-ID: a48777fdda7d13179979a889e1fb87655a783cc0
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

Commit-ID:  a48777fdda7d13179979a889e1fb87655a783cc0
Gitweb:     https://git.kernel.org/tip/a48777fdda7d13179979a889e1fb87655a783cc0
Author:     Eial Czerwacki <eial@scalemp.com>
AuthorDate: Mon, 5 Nov 2018 19:31:54 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 6 Nov 2018 21:35:11 +0100

x86/vsmp: Remove dependency on pv_irq_ops

vSMP dependency on pv_irq_ops has been removed some years ago, but the code
still deals with pv_irq_ops.

In short, "cap & ctl & (1 << 4)" is always returning 0, so all
PARAVIRT/PARAVIRT_XXL code related to that can be removed.

However, the rest of the code depends on CONFIG_PCI, so fix it accordingly.

Rename set_vsmp_pv_ops to set_vsmp_ctl as the original name does not make
sense anymore.

Signed-off-by: Eial Czerwacki <eial@scalemp.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Shai Fultheim <shai@scalemp.com>
Cc: Juergen Gross <jgross@suse.com>
Link: https://lkml.kernel.org/r/1541439114-28297-1-git-send-email-eial@scalemp.com

---
 arch/x86/Kconfig          |  1 -
 arch/x86/kernel/vsmp_64.c | 84 ++++-------------------------------------------
 2 files changed, 7 insertions(+), 78 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ba7e3464ee92..9d734f3c8234 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -525,7 +525,6 @@ config X86_VSMP
 	bool "ScaleMP vSMP"
 	select HYPERVISOR_GUEST
 	select PARAVIRT
-	select PARAVIRT_XXL
 	depends on X86_64 && PCI
 	depends on X86_EXTENDED_PLATFORM
 	depends on SMP
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index 1eae5af491c2..891a75dbc131 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -26,65 +26,8 @@
 
 #define TOPOLOGY_REGISTER_OFFSET 0x10
 
-#if defined CONFIG_PCI && defined CONFIG_PARAVIRT_XXL
-/*
- * Interrupt control on vSMPowered systems:
- * ~AC is a shadow of IF.  If IF is 'on' AC should be 'off'
- * and vice versa.
- */
-
-asmlinkage __visible unsigned long vsmp_save_fl(void)
-{
-	unsigned long flags = native_save_fl();
-
-	if (!(flags & X86_EFLAGS_IF) || (flags & X86_EFLAGS_AC))
-		flags &= ~X86_EFLAGS_IF;
-	return flags;
-}
-PV_CALLEE_SAVE_REGS_THUNK(vsmp_save_fl);
-
-__visible void vsmp_restore_fl(unsigned long flags)
-{
-	if (flags & X86_EFLAGS_IF)
-		flags &= ~X86_EFLAGS_AC;
-	else
-		flags |= X86_EFLAGS_AC;
-	native_restore_fl(flags);
-}
-PV_CALLEE_SAVE_REGS_THUNK(vsmp_restore_fl);
-
-asmlinkage __visible void vsmp_irq_disable(void)
-{
-	unsigned long flags = native_save_fl();
-
-	native_restore_fl((flags & ~X86_EFLAGS_IF) | X86_EFLAGS_AC);
-}
-PV_CALLEE_SAVE_REGS_THUNK(vsmp_irq_disable);
-
-asmlinkage __visible void vsmp_irq_enable(void)
-{
-	unsigned long flags = native_save_fl();
-
-	native_restore_fl((flags | X86_EFLAGS_IF) & (~X86_EFLAGS_AC));
-}
-PV_CALLEE_SAVE_REGS_THUNK(vsmp_irq_enable);
-
-static unsigned __init vsmp_patch(u8 type, void *ibuf,
-				  unsigned long addr, unsigned len)
-{
-	switch (type) {
-	case PARAVIRT_PATCH(irq.irq_enable):
-	case PARAVIRT_PATCH(irq.irq_disable):
-	case PARAVIRT_PATCH(irq.save_fl):
-	case PARAVIRT_PATCH(irq.restore_fl):
-		return paravirt_patch_default(type, ibuf, addr, len);
-	default:
-		return native_patch(type, ibuf, addr, len);
-	}
-
-}
-
-static void __init set_vsmp_pv_ops(void)
+#ifdef CONFIG_PCI
+static void __init set_vsmp_ctl(void)
 {
 	void __iomem *address;
 	unsigned int cap, ctl, cfg;
@@ -109,28 +52,12 @@ static void __init set_vsmp_pv_ops(void)
 	}
 #endif
 
-	if (cap & ctl & (1 << 4)) {
-		/* Setup irq ops and turn on vSMP  IRQ fastpath handling */
-		pv_ops.irq.irq_disable = PV_CALLEE_SAVE(vsmp_irq_disable);
-		pv_ops.irq.irq_enable = PV_CALLEE_SAVE(vsmp_irq_enable);
-		pv_ops.irq.save_fl = PV_CALLEE_SAVE(vsmp_save_fl);
-		pv_ops.irq.restore_fl = PV_CALLEE_SAVE(vsmp_restore_fl);
-		pv_ops.init.patch = vsmp_patch;
-		ctl &= ~(1 << 4);
-	}
 	writel(ctl, address + 4);
 	ctl = readl(address + 4);
 	pr_info("vSMP CTL: control set to:0x%08x\n", ctl);
 
 	early_iounmap(address, 8);
 }
-#else
-static void __init set_vsmp_pv_ops(void)
-{
-}
-#endif
-
-#ifdef CONFIG_PCI
 static int is_vsmp = -1;
 
 static void __init detect_vsmp_box(void)
@@ -164,11 +91,14 @@ static int is_vsmp_box(void)
 {
 	return 0;
 }
+static void __init set_vsmp_ctl(void)
+{
+}
 #endif
 
 static void __init vsmp_cap_cpus(void)
 {
-#if !defined(CONFIG_X86_VSMP) && defined(CONFIG_SMP)
+#if !defined(CONFIG_X86_VSMP) && defined(CONFIG_SMP) && defined(CONFIG_PCI)
 	void __iomem *address;
 	unsigned int cfg, topology, node_shift, maxcpus;
 
@@ -221,6 +151,6 @@ void __init vsmp_init(void)
 
 	vsmp_cap_cpus();
 
-	set_vsmp_pv_ops();
+	set_vsmp_ctl();
 	return;
 }
