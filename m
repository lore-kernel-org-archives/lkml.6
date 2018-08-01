Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E35C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102B720862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102B720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405277AbeHATXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:23:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52940 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436574AbeHATSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 981E9F36;
        Wed,  1 Aug 2018 16:56:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>, jason@lakedaemon.net,
        marc.zyngier@arm.com, zhiqiang.hou@nxp.com, minghuan.lian@nxp.com,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 042/336] irqchip/ls-scfg-msi: Map MSIs in the iommu
Date:   Wed,  1 Aug 2018 18:46:17 +0200
Message-Id: <20180801165030.690376640@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

[ Upstream commit 0cdd431c337e99177e68597f3de34bedd3a20a74 ]

Add the required iommu_dma_map_msi_msg() when composing the MSI message,
otherwise the interrupts will not work.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: jason@lakedaemon.net
Cc: marc.zyngier@arm.com
Cc: zhiqiang.hou@nxp.com
Cc: minghuan.lian@nxp.com
Link: https://lkml.kernel.org/r/20180605122727.12831-1-laurentiu.tudor@nxp.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-ls-scfg-msi.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -21,6 +21,7 @@
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/spinlock.h>
+#include <linux/dma-iommu.h>
 
 #define MSI_IRQS_PER_MSIR	32
 #define MSI_MSIR_OFFSET		4
@@ -94,6 +95,8 @@ static void ls_scfg_msi_compose_msg(stru
 
 	if (msi_affinity_flag)
 		msg->data |= cpumask_first(data->common->affinity);
+
+	iommu_dma_map_msi_msg(data->irq, msg);
 }
 
 static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,


