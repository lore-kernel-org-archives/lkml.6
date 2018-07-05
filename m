Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DD8C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDDC2400F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDDC2400F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753981AbeGESVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:21:05 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5422 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753807AbeGESVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:21:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3e618c0002>; Thu, 05 Jul 2018 11:21:00 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Jul 2018 11:21:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Jul 2018 11:21:04 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul
 2018 18:21:03 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Thu, 5 Jul 2018 18:21:03 +0000
Received: from byan-linux.NVIDIA.COM (Not Verified[172.17.136.14]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b3e618f0000>; Thu, 05 Jul 2018 11:21:03 -0700
From:   Bo Yan <byan@nvidia.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>
CC:     <linux-kernel@vger.kernel.org>, Bo Yan <byan@nvidia.com>
Subject: [PATCH] irqchip/gic: check return value of of_address_to_resource
Date:   Thu, 5 Jul 2018 11:20:59 -0700
Message-ID: <1530814859-11610-1-git-send-email-byan@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_address_to_resource returns 0 if successful. gic_check_eoimode
calls it without checking the return value. This induces Coverity
warning: "Unchecked return value".

Return false from gic_check_eoimode if of_address_to_resource returns
non-0 value.

Signed-off-by: Bo Yan <byan@nvidia.com>
---
 drivers/irqchip/irq-gic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index ced10c4..0bceb10 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1284,7 +1284,8 @@ static bool gic_check_eoimode(struct device_node *node, void __iomem **base)
 {
 	struct resource cpuif_res;
 
-	of_address_to_resource(node, 1, &cpuif_res);
+	if (of_address_to_resource(node, 1, &cpuif_res))
+		return false;
 
 	if (!is_hyp_mode_available())
 		return false;
-- 
2.7.4

