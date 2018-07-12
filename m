Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE32C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C2220878
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C2220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbeGLPuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:50:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:40020 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbeGLPuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:50:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE62DAE54;
        Thu, 12 Jul 2018 15:40:43 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] xen: setup pv irq ops vector earlier
Date:   Thu, 12 Jul 2018 17:40:34 +0200
Message-Id: <20180712154034.28010-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting pv_irq_ops for Xen PV domains should be done as early as
possible in order to support e.g. very early printk() usage.

The same applies to xen_vcpu_info_reset(0), as it is needed for the
pv irq ops.

Move the call of xen_setup_machphys_mapping() after initializing the
pv functions as it contains a WARN_ON(), too.

Remove the no longer necessary conditional in xen_init_irq_ops()
from PVH V1 times to make clear this is a PV only function.

Cc: <stable@vger.kernel.org> # 4.14
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/enlighten_pv.c | 24 +++++++++++-------------
 arch/x86/xen/irq.c          |  4 +---
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 4816b6f82a9a..439a94bf89ad 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1207,12 +1207,20 @@ asmlinkage __visible void __init xen_start_kernel(void)
 
 	xen_setup_features();
 
-	xen_setup_machphys_mapping();
-
 	/* Install Xen paravirt ops */
 	pv_info = xen_info;
 	pv_init_ops.patch = paravirt_patch_default;
 	pv_cpu_ops = xen_cpu_ops;
+	xen_init_irq_ops();
+
+	/*
+	 * Setup xen_vcpu early because it is needed for
+	 * local_irq_disable(), irqs_disabled(), e.g. in printk().
+	 *
+	 * Don't do the full vcpu_info placement stuff until we have
+	 * the cpu_possible_mask and a non-dummy shared_info.
+	 */
+	xen_vcpu_info_reset(0);
 
 	x86_platform.get_nmi_reason = xen_get_nmi_reason;
 
@@ -1225,6 +1233,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	 * Set up some pagetable state before starting to set any ptes.
 	 */
 
+	xen_setup_machphys_mapping();
 	xen_init_mmu_ops();
 
 	/* Prevent unwanted bits from being set in PTEs. */
@@ -1250,20 +1259,9 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	get_cpu_cap(&boot_cpu_data);
 	x86_configure_nx();
 
-	xen_init_irq_ops();
-
 	/* Let's presume PV guests always boot on vCPU with id 0. */
 	per_cpu(xen_vcpu_id, 0) = 0;
 
-	/*
-	 * Setup xen_vcpu early because idt_setup_early_handler needs it for
-	 * local_irq_disable(), irqs_disabled().
-	 *
-	 * Don't do the full vcpu_info placement stuff until we have
-	 * the cpu_possible_mask and a non-dummy shared_info.
-	 */
-	xen_vcpu_info_reset(0);
-
 	idt_setup_early_handler();
 
 	xen_init_capabilities();
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index 74179852e46c..7515a19fd324 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -128,8 +128,6 @@ static const struct pv_irq_ops xen_irq_ops __initconst = {
 
 void __init xen_init_irq_ops(void)
 {
-	/* For PVH we use default pv_irq_ops settings. */
-	if (!xen_feature(XENFEAT_hvm_callback_vector))
-		pv_irq_ops = xen_irq_ops;
+	pv_irq_ops = xen_irq_ops;
 	x86_init.irqs.intr_init = xen_init_IRQ;
 }
-- 
2.13.7

