Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24E7B60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeFFNd0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:33:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57521 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbeFFNdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:33:23 -0400
Date: Wed, 6 Jun 2018 06:32:51 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-8a2b7d142e7ac477d52f5f92251e59fc136d7ddd@git.kernel.org>
Cc: liu.song.a23@gmail.com, songliubraving@fb.com,
        peterz@infradead.org, bp@alien8.de, mingo@kernel.org,
        mike.travis@hpe.com, 0x7f454c46@gmail.com, hpa@zytor.com,
        tariqt@mellanox.com, linux-kernel@vger.kernel.org, jroedel@suse.de,
        tglx@linutronix.de
Reply-To: peterz@infradead.org, bp@alien8.de, mike.travis@hpe.com,
          0x7f454c46@gmail.com, mingo@kernel.org, liu.song.a23@gmail.com,
          songliubraving@fb.com, tglx@linutronix.de, tariqt@mellanox.com,
          hpa@zytor.com, jroedel@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20180604162224.555716895@linutronix.de>
References: <20180604162224.555716895@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] irq_remapping: Use apic_ack_irq()
Git-Commit-ID: 8a2b7d142e7ac477d52f5f92251e59fc136d7ddd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8a2b7d142e7ac477d52f5f92251e59fc136d7ddd
Gitweb:     https://git.kernel.org/tip/8a2b7d142e7ac477d52f5f92251e59fc136d7ddd
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 4 Jun 2018 17:33:56 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 15:18:20 +0200

irq_remapping: Use apic_ack_irq()

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

---
 drivers/iommu/amd_iommu.c           | 2 +-
 drivers/iommu/intel_irq_remapping.c | 2 +-
 drivers/iommu/irq_remapping.c       | 5 -----
 drivers/iommu/irq_remapping.h       | 2 --
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8fb8c737fffe..b0b30a568db7 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4379,7 +4379,7 @@ static void ir_compose_msi_msg(struct irq_data *irq_data, struct msi_msg *msg)
 
 static struct irq_chip amd_ir_chip = {
 	.name			= "AMD-IR",
-	.irq_ack		= ir_ack_apic_edge,
+	.irq_ack		= apic_ack_irq,
 	.irq_set_affinity	= amd_ir_set_affinity,
 	.irq_set_vcpu_affinity	= amd_ir_set_vcpu_affinity,
 	.irq_compose_msi_msg	= ir_compose_msi_msg,
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 3062a154a9fb..967450bd421a 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1223,7 +1223,7 @@ static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 
 static struct irq_chip intel_ir_chip = {
 	.name			= "INTEL-IR",
-	.irq_ack		= ir_ack_apic_edge,
+	.irq_ack		= apic_ack_irq,
 	.irq_set_affinity	= intel_ir_set_affinity,
 	.irq_compose_msi_msg	= intel_ir_compose_msi_msg,
 	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 496deee3ae3a..7d0f3074d41d 100644
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
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 039c7af7b190..0afef6e43be4 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -65,8 +65,6 @@ struct irq_remap_ops {
 extern struct irq_remap_ops intel_irq_remap_ops;
 extern struct irq_remap_ops amd_iommu_irq_ops;
 
-extern void ir_ack_apic_edge(struct irq_data *data);
-
 #else  /* CONFIG_IRQ_REMAP */
 
 #define irq_remapping_enabled 0
