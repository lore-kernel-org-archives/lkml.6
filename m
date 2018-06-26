Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9727C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1FE257C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1FE257C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934845AbeFZOhV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:37:21 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54118 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934219AbeFZOhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:37:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B509D1A0110;
        Tue, 26 Jun 2018 16:37:18 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B04B1A0104;
        Tue, 26 Jun 2018 16:37:18 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id DC92E40A59;
        Tue, 26 Jun 2018 07:37:17 -0700 (MST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-fed1964-102.ea.freescale.net [10.171.82.97])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w5QEbEhh019017;
        Tue, 26 Jun 2018 07:37:15 -0700
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org
Cc:     Minghuan.Lian@nxp.com, Zhiqiang.Hou@nxp.com,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH] irqchip/ls-scfg-msi: update effective affinity mask
Date:   Tue, 26 Jun 2018 17:37:12 +0300
Message-Id: <20180626143712.30489-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the effective affinity mask to fix this warning issued by the
generic irq handling code:

"genirq: irq_chip MSI did not update eff. affinity mask of irq x"

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/irqchip/irq-ls-scfg-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 1ec3bfe56693..d81d5b016438 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -122,6 +122,7 @@ static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
 	}
 
 	cpumask_copy(irq_data->common->affinity, mask);
+	irq_data_update_effective_affinity(irq_data, mask);
 
 	return IRQ_SET_MASK_OK;
 }
-- 
2.17.1

