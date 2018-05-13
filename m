Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeEMOED (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 10:04:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35263 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeEMOEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 10:04:01 -0400
Date: Sun, 13 May 2018 07:03:47 -0700
From: tip-bot for Marc Zyngier <tipbot@zytor.com>
Message-ID: <tip-0be8153cbc2af9a96e9ab8631fc3ba23bb52dbe3@git.kernel.org>
Cc: marc.zyngier@arm.com, thomas.petazzoni@bootlin.com, hpa@zytor.com,
        ard.biesheuvel@linaro.org, miquel.raynal@bootlin.com, robh@kernel.org,
        srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jason@lakedaemon.net, tglx@linutronix.de
Reply-To: thomas.petazzoni@bootlin.com, hpa@zytor.com,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, jason@lakedaemon.net,
        tglx@linutronix.de, robh@kernel.org, srinivas.kandagatla@linaro.org,
        miquel.raynal@bootlin.com
In-Reply-To: <20180508121438.11301-2-marc.zyngier@arm.com>
References: <20180508121438.11301-2-marc.zyngier@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/msi: Allow level-triggered MSIs to be exposed
 by MSI providers
Git-Commit-ID: 0be8153cbc2af9a96e9ab8631fc3ba23bb52dbe3
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

Commit-ID:  0be8153cbc2af9a96e9ab8631fc3ba23bb52dbe3
Gitweb:     https://git.kernel.org/tip/0be8153cbc2af9a96e9ab8631fc3ba23bb52dbe3
Author:     Marc Zyngier <marc.zyngier@arm.com>
AuthorDate: Tue, 8 May 2018 13:14:30 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 15:58:59 +0200

genirq/msi: Allow level-triggered MSIs to be exposed by MSI providers

So far, MSIs have been used to signal edge-triggered interrupts, as
a write is a good model for an edge (you can't "unwrite" something).
On the other hand, routing zillions of wires in an SoC because you
need level interrupts is a bit extreme.

People have come up with a variety of schemes to support this, which
involves sending two messages: one to signal the interrupt, and one
to clear it. Since the kernel cannot represent this, we've ended up
with side-band mechanisms that are pretty awful.

Instead, let's acknoledge the requirement, and ensure that, under the
right circumstances, the irq_compose_msg and irq_write_msg can take
as a parameter an array of two messages instead of a pointer to a
single one. We also add some checking that the compose method only
clobbers the second message if the MSI domain has been created with
the MSI_FLAG_LEVEL_CAPABLE flags.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lkml.kernel.org/r/20180508121438.11301-2-marc.zyngier@arm.com

---
 include/linux/msi.h |  2 ++
 kernel/irq/msi.c    | 33 ++++++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 1f1bbb5b4679..5839d8062dfc 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -289,6 +289,8 @@ enum {
 	 * MSI_FLAG_ACTIVATE_EARLY has been set.
 	 */
 	MSI_FLAG_MUST_REACTIVATE	= (1 << 5),
+	/* Is level-triggered capable, using two messages */
+	MSI_FLAG_LEVEL_CAPABLE		= (1 << 6),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2a8571f72b17..4ca2fd46645d 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -76,6 +76,19 @@ static inline void irq_chip_write_msi_msg(struct irq_data *data,
 	data->chip->irq_write_msi_msg(data, msg);
 }
 
+static void msi_check_level(struct irq_domain *domain, struct msi_msg *msg)
+{
+	struct msi_domain_info *info = domain->host_data;
+
+	/*
+	 * If the MSI provider has messed with the second message and
+	 * not advertized that it is level-capable, signal the breakage.
+	 */
+	WARN_ON(!((info->flags & MSI_FLAG_LEVEL_CAPABLE) &&
+		  (info->chip->flags & IRQCHIP_SUPPORTS_LEVEL_MSI)) &&
+		(msg[1].address_lo || msg[1].address_hi || msg[1].data));
+}
+
 /**
  * msi_domain_set_affinity - Generic affinity setter function for MSI domains
  * @irq_data:	The irq data associated to the interrupt
@@ -89,13 +102,14 @@ int msi_domain_set_affinity(struct irq_data *irq_data,
 			    const struct cpumask *mask, bool force)
 {
 	struct irq_data *parent = irq_data->parent_data;
-	struct msi_msg msg;
+	struct msi_msg msg[2] = { [1] = { }, };
 	int ret;
 
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
 	if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
-		BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
-		irq_chip_write_msi_msg(irq_data, &msg);
+		BUG_ON(irq_chip_compose_msi_msg(irq_data, msg));
+		msi_check_level(irq_data->domain, msg);
+		irq_chip_write_msi_msg(irq_data, msg);
 	}
 
 	return ret;
@@ -104,20 +118,21 @@ int msi_domain_set_affinity(struct irq_data *irq_data,
 static int msi_domain_activate(struct irq_domain *domain,
 			       struct irq_data *irq_data, bool early)
 {
-	struct msi_msg msg;
+	struct msi_msg msg[2] = { [1] = { }, };
 
-	BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
-	irq_chip_write_msi_msg(irq_data, &msg);
+	BUG_ON(irq_chip_compose_msi_msg(irq_data, msg));
+	msi_check_level(irq_data->domain, msg);
+	irq_chip_write_msi_msg(irq_data, msg);
 	return 0;
 }
 
 static void msi_domain_deactivate(struct irq_domain *domain,
 				  struct irq_data *irq_data)
 {
-	struct msi_msg msg;
+	struct msi_msg msg[2];
 
-	memset(&msg, 0, sizeof(msg));
-	irq_chip_write_msi_msg(irq_data, &msg);
+	memset(msg, 0, sizeof(msg));
+	irq_chip_write_msi_msg(irq_data, msg);
 }
 
 static int msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
