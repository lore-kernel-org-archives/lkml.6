Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E492C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B86E206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B86E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeLDQaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:30:09 -0500
Received: from 8bytes.org ([81.169.241.247]:51520 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbeLDQaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:30:08 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5001F470; Tue,  4 Dec 2018 17:30:05 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>, Rob Clark <robdclark@gmail.com>
Subject: [PATCH 8/9] iommu/qcom: Use helper functions to access dev->iommu_fwspec
Date:   Tue,  4 Dec 2018 17:30:01 +0100
Message-Id: <20181204163002.15800-9-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204163002.15800-1-joro@8bytes.org>
References: <20181204163002.15800-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Use the new helpers dev_iommu_fwspec_get()/set() to access
the dev->iommu_fwspec pointer. This makes it easier to move
that pointer later into another struct.

Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/qcom_iommu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index ee70e9921cf1..f437bf9c5ebd 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -354,7 +354,8 @@ static void qcom_iommu_domain_free(struct iommu_domain *domain)
 
 static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
-	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev->iommu_fwspec);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct qcom_iommu_dev *qcom_iommu = to_iommu(fwspec);
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	int ret;
 
@@ -365,7 +366,7 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
 
 	/* Ensure that the domain is finalized */
 	pm_runtime_get_sync(qcom_iommu->dev);
-	ret = qcom_iommu_init_domain(domain, qcom_iommu, dev->iommu_fwspec);
+	ret = qcom_iommu_init_domain(domain, qcom_iommu, fwspec);
 	pm_runtime_put_sync(qcom_iommu->dev);
 	if (ret < 0)
 		return ret;
@@ -387,7 +388,7 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
 
 static void qcom_iommu_detach_dev(struct iommu_domain *domain, struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct qcom_iommu_dev *qcom_iommu = to_iommu(fwspec);
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	unsigned i;
@@ -500,7 +501,7 @@ static bool qcom_iommu_capable(enum iommu_cap cap)
 
 static int qcom_iommu_add_device(struct device *dev)
 {
-	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev->iommu_fwspec);
+	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev_iommu_fwspec_get(dev));
 	struct iommu_group *group;
 	struct device_link *link;
 
@@ -531,7 +532,7 @@ static int qcom_iommu_add_device(struct device *dev)
 
 static void qcom_iommu_remove_device(struct device *dev)
 {
-	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev->iommu_fwspec);
+	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev_iommu_fwspec_get(dev));
 
 	if (!qcom_iommu)
 		return;
@@ -543,6 +544,7 @@ static void qcom_iommu_remove_device(struct device *dev)
 
 static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct qcom_iommu_dev *qcom_iommu;
 	struct platform_device *iommu_pdev;
 	unsigned asid = args->args[0];
@@ -568,14 +570,14 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	    WARN_ON(asid > qcom_iommu->num_ctxs))
 		return -EINVAL;
 
-	if (!dev->iommu_fwspec->iommu_priv) {
-		dev->iommu_fwspec->iommu_priv = qcom_iommu;
+	if (!fwspec->iommu_priv) {
+		fwspec->iommu_priv = qcom_iommu;
 	} else {
 		/* make sure devices iommus dt node isn't referring to
 		 * multiple different iommu devices.  Multiple context
 		 * banks are ok, but multiple devices are not:
 		 */
-		if (WARN_ON(qcom_iommu != dev->iommu_fwspec->iommu_priv))
+		if (WARN_ON(qcom_iommu != fwspec->iommu_priv))
 			return -EINVAL;
 	}
 
-- 
2.17.1

