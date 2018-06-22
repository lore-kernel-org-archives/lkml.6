Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E317EC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B16241C1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B16241C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeFVMZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:25:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbeFVMZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:25:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCPWZN066491
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:25:32 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCPVnS066488;
        Fri, 22 Jun 2018 05:25:31 -0700
Date:   Fri, 22 Jun 2018 05:25:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Marc Zyngier <tipbot@zytor.com>
Message-ID: <tip-893fbfff976cd069f2e60c3b186dbe3f85504db2@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, yangyingliang@huawei.com,
        linux-kernel@vger.kernel.org, sumit.garg@linaro.org,
        mingo@kernel.org, marc.zyngier@arm.com, jason@lakedaemon.net,
        alexandre.belloni@bootlin.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, sumit.garg@linaro.org,
          linux-kernel@vger.kernel.org, yangyingliang@huawei.com,
          jason@lakedaemon.net, marc.zyngier@arm.com, mingo@kernel.org,
          alexandre.belloni@bootlin.com
In-Reply-To: <20180622095254.5906-3-marc.zyngier@arm.com>
References: <20180622095254.5906-3-marc.zyngier@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irqchip/ls-scfg-msi: Fix MSI affinity handling
Git-Commit-ID: 893fbfff976cd069f2e60c3b186dbe3f85504db2
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

Commit-ID:  893fbfff976cd069f2e60c3b186dbe3f85504db2
Gitweb:     https://git.kernel.org/tip/893fbfff976cd069f2e60c3b186dbe3f85504db2
Author:     Marc Zyngier <marc.zyngier@arm.com>
AuthorDate: Fri, 22 Jun 2018 10:52:49 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:22:00 +0200

irqchip/ls-scfg-msi: Fix MSI affinity handling

The ls-scfs-msi driver is not dealing with the effective affinity
as it should. Let's fix that, and make it clear that the effective
affinity is restricted to a single CPU. Also prevent the driver from
messing with the internals of the affinity setting infrastructure.

Reported-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Link: https://lkml.kernel.org/r/20180622095254.5906-3-marc.zyngier@arm.com

---
 drivers/irqchip/irq-ls-scfg-msi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 1ec3bfe56693..c671b3212010 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -93,8 +93,12 @@ static void ls_scfg_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->address_lo = lower_32_bits(msi_data->msiir_addr);
 	msg->data = data->hwirq;
 
-	if (msi_affinity_flag)
-		msg->data |= cpumask_first(data->common->affinity);
+	if (msi_affinity_flag) {
+		const struct cpumask *mask;
+
+		mask = irq_data_get_effective_affinity_mask(data);
+		msg->data |= cpumask_first(mask);
+	}
 
 	iommu_dma_map_msi_msg(data->irq, msg);
 }
@@ -121,7 +125,7 @@ static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
 		return -EINVAL;
 	}
 
-	cpumask_copy(irq_data->common->affinity, mask);
+	irq_data_update_effective_affinity(irq_data, cpumask_of(cpu));
 
 	return IRQ_SET_MASK_OK;
 }
