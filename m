Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 244716070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932367AbeFFKKt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:10:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54413 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932265AbeFFKKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:10:47 -0400
Date: Wed, 6 Jun 2018 03:10:37 -0700
From: tip-bot for Laurentiu Tudor <tipbot@zytor.com>
Message-ID: <tip-0cdd431c337e99177e68597f3de34bedd3a20a74@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, laurentiu.tudor@nxp.com
Reply-To: mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          laurentiu.tudor@nxp.com
In-Reply-To: <20180605122727.12831-1-laurentiu.tudor@nxp.com>
References: <20180605122727.12831-1-laurentiu.tudor@nxp.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irqchip/ls-scfg-msi: Map MSIs in the iommu
Git-Commit-ID: 0cdd431c337e99177e68597f3de34bedd3a20a74
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

Commit-ID:  0cdd431c337e99177e68597f3de34bedd3a20a74
Gitweb:     https://git.kernel.org/tip/0cdd431c337e99177e68597f3de34bedd3a20a74
Author:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
AuthorDate: Tue, 5 Jun 2018 15:27:27 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 12:05:19 +0200

irqchip/ls-scfg-msi: Map MSIs in the iommu

Add the required iommu_dma_map_msi_msg() when composing the MSI message,
otherwise the interrupts will not work.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: jason@lakedaemon.net
Cc: marc.zyngier@arm.com
Cc: zhiqiang.hou@nxp.com
Cc: minghuan.lian@nxp.com
Link: https://lkml.kernel.org/r/20180605122727.12831-1-laurentiu.tudor@nxp.com

---
 drivers/irqchip/irq-ls-scfg-msi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 57e3d900f19e..1ec3bfe56693 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -21,6 +21,7 @@
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/spinlock.h>
+#include <linux/dma-iommu.h>
 
 #define MSI_IRQS_PER_MSIR	32
 #define MSI_MSIR_OFFSET		4
@@ -94,6 +95,8 @@ static void ls_scfg_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 
 	if (msi_affinity_flag)
 		msg->data |= cpumask_first(data->common->affinity);
+
+	iommu_dma_map_msi_msg(data->irq, msg);
 }
 
 static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
