Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7D6ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C60206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C60206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeINTp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:45:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34240 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeINTp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:45:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EA8E15BF;
        Fri, 14 Sep 2018 07:30:41 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 549373F575;
        Fri, 14 Sep 2018 07:30:39 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v7 4/6] iommu: Add bootup option "iommu.non_strict"
Date:   Fri, 14 Sep 2018 15:30:22 +0100
Message-Id: <41f81c46348db4acd9a542184f10e7ca24f6c219.1536935328.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.0.dirty
In-Reply-To: <cover.1536935328.git.robin.murphy@arm.com>
References: <cover.1536935328.git.robin.murphy@arm.com>
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
[rm: move handling out of SMMUv3 driver]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 .../admin-guide/kernel-parameters.txt         | 13 ++++++++++
 drivers/iommu/iommu.c                         | 26 +++++++++++++++++++
 2 files changed, 39 insertions(+)

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
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c15c5980299..2cabd0c0a4f3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -41,6 +41,7 @@ static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
 #else
 static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 #endif
+static bool iommu_dma_non_strict __read_mostly;
 
 struct iommu_callback_data {
 	const struct iommu_ops *ops;
@@ -131,6 +132,24 @@ static int __init iommu_set_def_domain_type(char *str)
 }
 early_param("iommu.passthrough", iommu_set_def_domain_type);
 
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
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
 				     struct attribute *__attr, char *buf)
 {
@@ -1072,6 +1091,13 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 		group->default_domain = dom;
 		if (!group->domain)
 			group->domain = dom;
+
+		if (dom && iommu_dma_non_strict) {
+			int attr = 1;
+			iommu_domain_set_attr(dom,
+					      DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+					      &attr);
+		}
 	}
 
 	ret = iommu_group_add_device(group, dev);
-- 
2.19.0.dirty

