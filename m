Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C92C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAC72081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=scalemp.com header.i=@scalemp.com header.b="2hrMaia/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAC72081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=scalemp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeKERTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:19:35 -0500
Received: from www.scalemp.com ([169.44.78.149]:53303 "EHLO scalemp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725737AbeKERTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=scalemp.com
        ; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iAmGYZb0MerJ4GQBVG1/hRbftkacv6bG+uzFOFMuFXs=; b=2hrMaia/LOS+J7JtGp7hqnGZII
        F1oZVBKBrHByacuSPRBF6YkJMXm3N3Z5wji6Q8sc9/BOF+txw31K36lh5Em+xTxpet7cAqsMobyFg
        p0+nw697sXYVTdTKsA61TLe/Xpl9p7rL+UMsd+sapbOBJZwE73gzIwd554YbEdBSu2NY=;
Received: from bzq-80-45-146.red.bezeqint.net ([82.80.45.146]:20062 helo=eial.scalemp)
        by hosting.virtualsmp.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-SHA256:128)
        (Exim 4.91)
        (envelope-from <eial@scalemp.com>)
        id 1gJZoq-000CJR-CV; Mon, 05 Nov 2018 03:01:08 -0500
From:   Eial Czerwacki <eial@scalemp.com>
To:     linux-kernel@vger.kernel.org
Cc:     Eial Czerwacki <eial@scalemp.com>, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] x86/vsmp: Remove dependency on pv_irq_ops
Date:   Mon,  5 Nov 2018 10:01:04 +0200
Message-Id: <1541404864-31603-1-git-send-email-eial@scalemp.com>
X-Mailer: git-send-email 2.7.4
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting.virtualsmp.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalemp.com
X-Get-Message-Sender-Via: hosting.virtualsmp.com: authenticated_id: eial@scalemp.com
X-Authenticated-Sender: hosting.virtualsmp.com: eial@scalemp.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vsmp dependency on pv_irq_ops removed some years ago, so now let's clean it up from vsmp_64.c.

In short, "cap & ctl & (1 << 4)" was always returning 0, as such we can
remove all the PARAVIRT/PARAVIRT_XXL code handling that.

However, the rest of the code depends on CONFIG_PCI, so fix it accordingly.
in addition, rename set_vsmp_pv_ops to set_vsmp_ctl.

Signed-off-by: Eial Czerwacki <eial@scalemp.com>
Acked-by: Shai Fultheim <shai@scalemp.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig          |  1 -
 arch/x86/kernel/vsmp_64.c | 84 ++++-------------------------------------------
 2 files changed, 7 insertions(+), 78 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ba7e346..9d734f3 100644
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
index 1eae5af..4862576 100644
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
-- 
2.7.4

