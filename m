Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AA8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F1020859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfBTPGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:06:00 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:35346 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfBTPFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:05:37 -0500
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id f35b1z00p3XaVaC0135bmX; Wed, 20 Feb 2019 16:05:35 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gwTRH-0002IK-KQ; Wed, 20 Feb 2019 16:05:35 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gwTRH-0000et-Iy; Wed, 20 Feb 2019 16:05:35 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/7] iommu/ipmmu-vmsa: Make IPMMU_CTX_MAX unsigned
Date:   Wed, 20 Feb 2019 16:05:28 +0100
Message-Id: <20190220150531.2462-5-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190220150531.2462-1-geert+renesas@glider.be>
References: <20190220150531.2462-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the IPMMU_CTX_MAX constant unsigned, to match the type of
ipmmu_features.number_of_contexts.

This allows to use plain min() instead of type-casting min_t().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/ipmmu-vmsa.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 4d07c26c97848b65..4e3134a9a52f8d87 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -36,7 +36,7 @@
 #define arm_iommu_detach_device(...)	do {} while (0)
 #endif
 
-#define IPMMU_CTX_MAX 8
+#define IPMMU_CTX_MAX 8U
 
 struct ipmmu_features {
 	bool use_ns_alias_offset;
@@ -1060,8 +1060,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 	if (mmu->features->use_ns_alias_offset)
 		mmu->base += IM_NS_ALIAS_OFFSET;
 
-	mmu->num_ctx = min_t(unsigned int, IPMMU_CTX_MAX,
-			     mmu->features->number_of_contexts);
+	mmu->num_ctx = min(IPMMU_CTX_MAX, mmu->features->number_of_contexts);
 
 	irq = platform_get_irq(pdev, 0);
 
-- 
2.17.1

