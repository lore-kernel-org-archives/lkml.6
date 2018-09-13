Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF25FC616E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BBF21722
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BBF21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbeIMVxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:53:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51170 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728430AbeIMVxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:53:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76FDD1684;
        Thu, 13 Sep 2018 09:42:52 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC5243F703;
        Thu, 13 Sep 2018 09:42:50 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v6 7/7] iommu/dma: Add bootup option "iommu.non_strict"
Date:   Thu, 13 Sep 2018 17:42:24 +0100
Message-Id: <94fe2e15d36565e13218b007b9d5d9d08f190e5e.1536856828.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.0.dirty
In-Reply-To: <cover.1536856828.git.robin.murphy@arm.com>
References: <cover.1536856828.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Add a bootup option to make the system manager can choose which mode to
be used. The default mode is strict.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
[rm: make it a generic iommu-dma feature]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 .../admin-guide/kernel-parameters.txt          | 13 +++++++++++++
 drivers/iommu/dma-iommu.c                      | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..406b91759b62 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1749,6 +1749,19 @@
 		nobypass	[PPC/POWERNV]
 			Disable IOMMU bypass, using IOMMU for PCI devices.
 
+	iommu.non_strict=	[ARM64]
+			Format: { "0" | "1" }
+			0 - strict mode, default.
+			    Release IOVAs after the related TLBs are invalid
+			    completely.
+			1 - non-strict mode.
+			    Put off TLBs invalidation and release memory first.
+			    It's good for scatter-gather performance but lacks
+			    full isolation, an untrusted device can access the
+			    reused memory because the TLBs may still valid.
+			    Please take	full consideration before choosing this
+			    mode. Note that, VFIO will always use strict mode.
+
 	iommu.passthrough=
 			[ARM64] Configure DMA to bypass the IOMMU by default.
 			Format: { "0" | "1" }
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d91849fe4ebe..04d4c5453acd 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -62,6 +62,24 @@ struct iommu_dma_cookie {
 
 static bool iommu_dma_non_strict __read_mostly;
 
+static int __init iommu_dma_setup(char *str)
+{
+	int ret;
+
+	ret = kstrtobool(str, &iommu_dma_non_strict);
+	if (ret)
+		return ret;
+
+	if (iommu_dma_non_strict) {
+		pr_warn("WARNING: iommu non-strict mode is chosen.\n"
+			"It's good for scatter-gather performance but lacks full isolation\n");
+		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
+	}
+
+	return 0;
+}
+early_param("iommu.non_strict", iommu_dma_setup);
+
 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
 {
 	if (cookie->type == IOMMU_DMA_IOVA_COOKIE)
-- 
2.19.0.dirty

