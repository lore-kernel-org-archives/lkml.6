Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35683ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFD2206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFD2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbeGPIFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:05:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeGPIFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:05:16 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 87546C03;
        Mon, 16 Jul 2018 07:39:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 4.17 50/67] xen: setup pv irq ops vector earlier
Date:   Mon, 16 Jul 2018 09:35:19 +0200
Message-Id: <20180716073451.270607519@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit 0ce0bba4e5e0eb9b753bb821785de5d23c494392 upstream.

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
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/enlighten_pv.c |   24 +++++++++++-------------
 arch/x86/xen/irq.c          |    4 +---
 2 files changed, 12 insertions(+), 16 deletions(-)

--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1206,12 +1206,20 @@ asmlinkage __visible void __init xen_sta
 
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
 
@@ -1224,6 +1232,7 @@ asmlinkage __visible void __init xen_sta
 	 * Set up some pagetable state before starting to set any ptes.
 	 */
 
+	xen_setup_machphys_mapping();
 	xen_init_mmu_ops();
 
 	/* Prevent unwanted bits from being set in PTEs. */
@@ -1249,20 +1258,9 @@ asmlinkage __visible void __init xen_sta
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
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -128,8 +128,6 @@ static const struct pv_irq_ops xen_irq_o
 
 void __init xen_init_irq_ops(void)
 {
-	/* For PVH we use default pv_irq_ops settings. */
-	if (!xen_feature(XENFEAT_hvm_callback_vector))
-		pv_irq_ops = xen_irq_ops;
+	pv_irq_ops = xen_irq_ops;
 	x86_init.irqs.intr_init = xen_init_IRQ;
 }


