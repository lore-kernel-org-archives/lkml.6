Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A18C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF09325015
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF09325015
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755526AbeFXPhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:37:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59622 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbeFXPhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:37:09 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3051193C;
        Sun, 24 Jun 2018 15:37:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Song Liu <songliubraving@fb.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <liu.song.a23@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Mike Travis <mike.travis@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: [PATCH 4.16 52/64] irq_remapping: Use apic_ack_irq()
Date:   Sun, 24 Jun 2018 23:22:33 +0800
Message-Id: <20180624142746.939227433@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 8a2b7d142e7ac477d52f5f92251e59fc136d7ddd upstream.

To address the EBUSY fail of interrupt affinity settings in case that the
previous setting has not been cleaned up yet, use the new apic_ack_irq()
function instead of the special ir_ack_apic_edge() implementation which is
merily a wrapper around ack_APIC_irq().

Preparatory change for the real fix

Fixes: dccfe3147b42 ("x86/vector: Simplify vector move cleanup")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Song Liu <songliubraving@fb.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <liu.song.a23@gmail.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: stable@vger.kernel.org
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tariq Toukan <tariqt@mellanox.com>
Link: https://lkml.kernel.org/r/20180604162224.555716895@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/amd_iommu.c           |    2 +-
 drivers/iommu/intel_irq_remapping.c |    2 +-
 drivers/iommu/irq_remapping.c       |    5 -----
 drivers/iommu/irq_remapping.h       |    2 --
 4 files changed, 2 insertions(+), 9 deletions(-)

--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4352,7 +4352,7 @@ static void ir_compose_msi_msg(struct ir
 
 static struct irq_chip amd_ir_chip = {
 	.name			= "AMD-IR",
-	.irq_ack		= ir_ack_apic_edge,
+	.irq_ack		= apic_ack_irq,
 	.irq_set_affinity	= amd_ir_set_affinity,
 	.irq_set_vcpu_affinity	= amd_ir_set_vcpu_affinity,
 	.irq_compose_msi_msg	= ir_compose_msi_msg,
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1223,7 +1223,7 @@ static int intel_ir_set_vcpu_affinity(st
 
 static struct irq_chip intel_ir_chip = {
 	.name			= "INTEL-IR",
-	.irq_ack		= ir_ack_apic_edge,
+	.irq_ack		= apic_ack_irq,
 	.irq_set_affinity	= intel_ir_set_affinity,
 	.irq_compose_msi_msg	= intel_ir_compose_msi_msg,
 	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -156,11 +156,6 @@ void panic_if_irq_remap(const char *msg)
 		panic(msg);
 }
 
-void ir_ack_apic_edge(struct irq_data *data)
-{
-	ack_APIC_irq();
-}
-
 /**
  * irq_remapping_get_ir_irq_domain - Get the irqdomain associated with the IOMMU
  *				     device serving request @info
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -65,8 +65,6 @@ struct irq_remap_ops {
 extern struct irq_remap_ops intel_irq_remap_ops;
 extern struct irq_remap_ops amd_iommu_irq_ops;
 
-extern void ir_ack_apic_edge(struct irq_data *data);
-
 #else  /* CONFIG_IRQ_REMAP */
 
 #define irq_remapping_enabled 0


