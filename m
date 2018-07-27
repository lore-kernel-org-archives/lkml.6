Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44C3C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86159208A1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86159208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbeG0LhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:37:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40862 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729547AbeG0LhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:37:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 847BF15BE;
        Fri, 27 Jul 2018 03:15:59 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 08E343F575;
        Fri, 27 Jul 2018 03:15:56 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org, robh@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        matt.sealey@arm.com, charles.garcia-tobin@arm.com,
        john.horley@arm.com, al.grant@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v3 1/9] coresight: Document error handling in coresight_register
Date:   Fri, 27 Jul 2018 11:15:29 +0100
Message-Id: <1532686537-12380-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
References: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 6403587a930c ("coresight: use put_device() instead of kfree()")
fixes the double freeing of resources and ensures that the device
refcount is dropped properly. Add a comment to explain this to
help the readers and prevent people trying to "unfix" it again.

While at it, rename the labels for better readability.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Change since v1:
 - Document the error handling than trying to "unfix" the
   problem.
---
 drivers/hwtracing/coresight/coresight.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 3e07fd3..9fd0c38 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1006,7 +1006,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	csdev = kzalloc(sizeof(*csdev), GFP_KERNEL);
 	if (!csdev) {
 		ret = -ENOMEM;
-		goto err_kzalloc_csdev;
+		goto err_out;
 	}
 
 	if (desc->type == CORESIGHT_DEV_TYPE_LINK ||
@@ -1022,7 +1022,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	refcnts = kcalloc(nr_refcnts, sizeof(*refcnts), GFP_KERNEL);
 	if (!refcnts) {
 		ret = -ENOMEM;
-		goto err_kzalloc_refcnts;
+		goto err_free_csdev;
 	}
 
 	csdev->refcnt = refcnts;
@@ -1035,7 +1035,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 		conns = kcalloc(csdev->nr_outport, sizeof(*conns), GFP_KERNEL);
 		if (!conns) {
 			ret = -ENOMEM;
-			goto err_kzalloc_conns;
+			goto err_free_refcnts;
 		}
 
 		for (i = 0; i < csdev->nr_outport; i++) {
@@ -1062,7 +1062,11 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	ret = device_register(&csdev->dev);
 	if (ret) {
 		put_device(&csdev->dev);
-		goto err_kzalloc_csdev;
+		/*
+		 * All resources are free'd explicitly via
+		 * coresight_device_release(), triggered from put_device().
+		 */
+		goto err_out;
 	}
 
 	mutex_lock(&coresight_mutex);
@@ -1074,11 +1078,11 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 
 	return csdev;
 
-err_kzalloc_conns:
+err_free_refcnts:
 	kfree(refcnts);
-err_kzalloc_refcnts:
+err_free_csdev:
 	kfree(csdev);
-err_kzalloc_csdev:
+err_out:
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(coresight_register);
-- 
2.7.4

