Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4969CC5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1936208D9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1936208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754444AbeFMBBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:01:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:64685 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754136AbeFMBBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:01:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 18:01:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,216,1526367600"; 
   d="scan'208";a="47283455"
Received: from voyager.sc.intel.com ([10.3.52.149])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2018 18:01:30 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Juergen Gross <jgross@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wincy Van <fanwenyi0529@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        iommu@lists.linux-foundation.org
Subject: [RFC PATCH 01/23] x86/apic: Add a parameter for the APIC delivery mode
Date:   Tue, 12 Jun 2018 17:57:21 -0700
Message-Id: <1528851463-21140-2-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, the delivery mode of APIC interrupts is set to the default
mode set in the APIC driver. However, there are no restrictions in hardware
to configure each interrupt with a different delivery mode. Specifying the
delivery mode per interrupt is useful when one is interested in changing
the delivery mode of a particular interrupt. For instance, this can be used
to deliver an interrupt as non-maskable.

Add a new member, delivery_mode, to struct irq_cfg. Also, update the
configuration of the delivery mode in the IO APIC, the MSI APIC and the
Intel interrupt remapping driver to use this new per-interrupt member to
configure their respective interrupt tables.

In order to keep the current behavior, initialize the delivery mode of
each interrupt with the with the delivery mode of the APIC driver in use
when the interrupt data is allocated.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wincy Van <fanwenyi0529@gmail.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hw_irq.h       |  5 +++--
 arch/x86/include/asm/msidef.h       |  3 +++
 arch/x86/kernel/apic/io_apic.c      |  2 +-
 arch/x86/kernel/apic/msi.c          |  2 +-
 arch/x86/kernel/apic/vector.c       |  8 ++++++++
 arch/x86/platform/uv/uv_irq.c       |  2 +-
 drivers/iommu/intel_irq_remapping.c | 10 +++++-----
 7 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 32e666e..c024e59 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -117,8 +117,9 @@ struct irq_alloc_info {
 };
 
 struct irq_cfg {
-	unsigned int		dest_apicid;
-	unsigned int		vector;
+	unsigned int				dest_apicid;
+	unsigned int				vector;
+	enum ioapic_irq_destination_types	delivery_mode;
 };
 
 extern struct irq_cfg *irq_cfg(unsigned int irq);
diff --git a/arch/x86/include/asm/msidef.h b/arch/x86/include/asm/msidef.h
index ee2f8cc..6aef434 100644
--- a/arch/x86/include/asm/msidef.h
+++ b/arch/x86/include/asm/msidef.h
@@ -16,6 +16,9 @@
 					 MSI_DATA_VECTOR_MASK)
 
 #define MSI_DATA_DELIVERY_MODE_SHIFT	8
+#define MSI_DATA_DELIVERY_MODE_MASK	0x00000700
+#define MSI_DATA_DELIVERY_MODE(dm)	(((dm) << MSI_DATA_DELIVERY_MODE_SHIFT) & \
+					 MSI_DATA_DELIVERY_MODE_MASK)
 #define  MSI_DATA_DELIVERY_FIXED	(0 << MSI_DATA_DELIVERY_MODE_SHIFT)
 #define  MSI_DATA_DELIVERY_LOWPRI	(1 << MSI_DATA_DELIVERY_MODE_SHIFT)
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7553819..10a20f8 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2887,8 +2887,8 @@ static void mp_setup_entry(struct irq_cfg *cfg, struct mp_chip_data *data,
 			   struct IO_APIC_route_entry *entry)
 {
 	memset(entry, 0, sizeof(*entry));
-	entry->delivery_mode = apic->irq_delivery_mode;
 	entry->dest_mode     = apic->irq_dest_mode;
+	entry->delivery_mode = cfg->delivery_mode;
 	entry->dest	     = cfg->dest_apicid;
 	entry->vector	     = cfg->vector;
 	entry->trigger	     = data->trigger;
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index ce503c9..12202ac 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -45,7 +45,7 @@ static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->data =
 		MSI_DATA_TRIGGER_EDGE |
 		MSI_DATA_LEVEL_ASSERT |
-		MSI_DATA_DELIVERY_FIXED |
+		MSI_DATA_DELIVERY_MODE(cfg->delivery_mode) |
 		MSI_DATA_VECTOR(cfg->vector);
 }
 
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index bb6f7a2..dfe0a2a 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -547,6 +547,14 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		irqd->chip_data = apicd;
 		irqd->hwirq = virq + i;
 		irqd_set_single_target(irqd);
+
+		/*
+		 * Initialize the delivery mode of this irq to match
+		 * the default delivery mode of the APIC. This could be
+		 * changed later when the interrupt is activated.
+		 */
+		 apicd->hw_irq_cfg.delivery_mode = apic->irq_delivery_mode;
+
 		/*
 		 * Legacy vectors are already assigned when the IOAPIC
 		 * takes them over. They stay on the same vector. This is
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index e4cb9f4..c88508b 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -35,7 +35,7 @@ static void uv_program_mmr(struct irq_cfg *cfg, struct uv_irq_2_mmr_pnode *info)
 	mmr_value = 0;
 	entry = (struct uv_IO_APIC_route_entry *)&mmr_value;
 	entry->vector		= cfg->vector;
-	entry->delivery_mode	= apic->irq_delivery_mode;
+	entry->delivery_mode	= cfg->delivery_mode;
 	entry->dest_mode	= apic->irq_dest_mode;
 	entry->polarity		= 0;
 	entry->trigger		= 0;
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 3062a15..9f3a04d 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1045,7 +1045,7 @@ static int reenable_irq_remapping(int eim)
 	return -1;
 }
 
-static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
+static void prepare_irte(struct irte *irte, struct irq_cfg *irq_cfg)
 {
 	memset(irte, 0, sizeof(*irte));
 
@@ -1059,9 +1059,9 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	 * irq migration in the presence of interrupt-remapping.
 	*/
 	irte->trigger_mode = 0;
-	irte->dlvry_mode = apic->irq_delivery_mode;
-	irte->vector = vector;
-	irte->dest_id = IRTE_DEST(dest);
+	irte->dlvry_mode = irq_cfg->delivery_mode;
+	irte->vector = irq_cfg->vector;
+	irte->dest_id = IRTE_DEST(irq_cfg->dest_apicid);
 	irte->redir_hint = 1;
 }
 
@@ -1238,7 +1238,7 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 	struct irte *irte = &data->irte_entry;
 	struct msi_msg *msg = &data->msi_entry;
 
-	prepare_irte(irte, irq_cfg->vector, irq_cfg->dest_apicid);
+	prepare_irte(irte, irq_cfg);
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
 		/* Set source-id of interrupt request */
-- 
2.7.4

