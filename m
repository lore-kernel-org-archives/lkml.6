Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F93C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049A4206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049A4206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbeITVyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:54:52 -0400
Received: from foss.arm.com ([217.140.101.70]:48580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731009AbeITVyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:54:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DB3615BE;
        Thu, 20 Sep 2018 09:10:40 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3C513F557;
        Thu, 20 Sep 2018 09:10:38 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v8 3/7] iommu: Add "iommu.strict" command line option
Date:   Thu, 20 Sep 2018 17:10:23 +0100
Message-Id: <799fad801970298385af3abc8ca82620ad62c000.1537458163.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.0.dirty
In-Reply-To: <cover.1537458163.git.robin.murphy@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Add a generic command line option to enable lazy unmapping via IOVA
flush queues, which will initally be suuported by iommu-dma. This echoes
the semantics of "intel_iommu=strict" (albeit with the opposite default
value), but in the driver-agnostic fashion of "iommu.passthrough".

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
[rm: move handling out of SMMUv3 driver, clean up documentation]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v8:
 - Rename "non-strict" to "strict" to better match existing options
 - Rewrite doc text/commit message
 - Downgrade boot-time message from warn/taint to info

 .../admin-guide/kernel-parameters.txt         | 12 ++++++++++
 drivers/iommu/iommu.c                         | 23 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..92ae12aeabf4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1749,6 +1749,18 @@
 		nobypass	[PPC/POWERNV]
 			Disable IOMMU bypass, using IOMMU for PCI devices.
 
+	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
+			Format: { "0" | "1" }
+			0 - Lazy mode.
+			  Request that DMA unmap operations use deferred
+			  invalidation of hardware TLBs, for increased
+			  throughput at the cost of reduced device isolation.
+			  Will fall back to strict mode if not supported by
+			  the relevant IOMMU driver.
+			1 - Strict mode (default).
+			  DMA unmap operations invalidate IOMMU hardware TLBs
+			  synchronously.
+
 	iommu.passthrough=
 			[ARM64] Configure DMA to bypass the IOMMU by default.
 			Format: { "0" | "1" }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c15c5980299..02b6603f0616 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -41,6 +41,7 @@ static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
 #else
 static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 #endif
+static bool iommu_dma_strict __read_mostly = true;
 
 struct iommu_callback_data {
 	const struct iommu_ops *ops;
@@ -131,6 +132,21 @@ static int __init iommu_set_def_domain_type(char *str)
 }
 early_param("iommu.passthrough", iommu_set_def_domain_type);
 
+static int __init iommu_dma_setup(char *str)
+{
+	int ret;
+
+	ret = kstrtobool(str, &iommu_dma_strict);
+	if (ret)
+		return ret;
+
+	if (!iommu_dma_strict)
+		pr_info("Enabling deferred TLB invalidation for DMA; protection against malicious/malfunctioning devices may be reduced.\n");
+
+	return 0;
+}
+early_param("iommu.strict", iommu_dma_setup);
+
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
 				     struct attribute *__attr, char *buf)
 {
@@ -1072,6 +1088,13 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 		group->default_domain = dom;
 		if (!group->domain)
 			group->domain = dom;
+
+		if (dom && !iommu_dma_strict) {
+			int attr = 1;
+			iommu_domain_set_attr(dom,
+					      DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+					      &attr);
+		}
 	}
 
 	ret = iommu_group_add_device(group, dev);
-- 
2.19.0.dirty

