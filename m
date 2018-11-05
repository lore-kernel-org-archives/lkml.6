Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9FCC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E3020827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E3020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeKEU5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:57:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39535 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeKEU5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:57:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA5BapER314610
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Nov 2018 03:36:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA5Bapff314607;
        Mon, 5 Nov 2018 03:36:51 -0800
Date:   Mon, 5 Nov 2018 03:36:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Eial Czerwacki <tipbot@zytor.com>
Message-ID: <tip-7f2d7f8190d856949d8aaab55d3902cd10ea1048@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        eial@scalemp.com, jgross@suse.com, shai@scalemp.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, shai@scalemp.com, jgross@suse.com,
          eial@scalemp.com, mingo@kernel.org, hpa@zytor.com,
          tglx@linutronix.de
In-Reply-To: <1541404864-31603-1-git-send-email-eial@scalemp.com>
References: <1541404864-31603-1-git-send-email-eial@scalemp.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/vsmp: Remove dependency on pv_irq_ops
Git-Commit-ID: 7f2d7f8190d856949d8aaab55d3902cd10ea1048
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

Commit-ID:  7f2d7f8190d856949d8aaab55d3902cd10ea1048
Gitweb:     https://git.kernel.org/tip/7f2d7f8190d856949d8aaab55d3902cd10ea1048
Author:     Eial Czerwacki <eial@scalemp.com>
AuthorDate: Mon, 5 Nov 2018 10:01:04 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 5 Nov 2018 12:33:47 +0100

x86/vsmp: Remove dependency on pv_irq_ops

vsmp dependency on pv_irq_ops has been removed some years ago, but the code
still deals with pv_irq_ops.

In short, "cap & ctl & (1 << 4)" is always returning 0, so all
PARAVIRT/PARAVIRT_XXL code related to that can be removed.

However, the rest of the code depends on CONFIG_PCI, so fix it accordingly.

Rename set_vsmp_pv_ops to set_vsmp_ctl as the original name does not make
sense anymore.

[ tglx: Minor changelog tweaks ]

Signed-off-by: Eial Czerwacki <eial@scalemp.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Shai Fultheim <shai@scalemp.com>
Cc: Juergen Gross <jgross@suse.com>
Link: https://lkml.kernel.org/r/1541404864-31603-1-git-send-email-eial@scalemp.com

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
index 1eae5af491c2..48625766c7a4 100644
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
+#if defined CONFIG_PCI
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
