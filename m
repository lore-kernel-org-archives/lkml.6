Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442D6C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0A320870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676405;
	bh=JEkotcbGwf+I+Otm/lT9frTIF8EJx2u46AOb8VUV01g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dmn/I32XslMaoq2iStQPNSeWVAcETimQjy2rXfrd9Pxf5/+BU6E3rbv5+B9C545w1
	 jUH9heFAd1kJFhW8KPXrUC8eowwUHbV4nuCWUBPBHxR6IBFHwThO8tRAHW6fE4LFs8
	 1KyDD7hwJpTRAfgAnC72zLyTOMy1iFwEcmqONSUI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0A320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbeLMEqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:46:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbeLMEaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEB3820879;
        Thu, 13 Dec 2018 04:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675434;
        bh=JEkotcbGwf+I+Otm/lT9frTIF8EJx2u46AOb8VUV01g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hz5xwo1JtnVG+89FN+QFpOg1BKUDSqo1dzKbmkO9EdgqTQlLds1e+t3OxOXdVXDlD
         opmci98jheFkY8IKqlHxH5rtISutysfsG/x278d5cp+fGjB/hjywJ3A1Z2hFF3PjfG
         cWcQ3eW/xFPjJQxAc73AbpdocE9Fs9OqJBCj1L4Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 60/73] tools/testing/nvdimm: Align test resources to 128M
Date:   Wed, 12 Dec 2018 23:28:25 -0500
Message-Id: <20181213042838.75160-60-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit e3f5df762d4a6ef6326c3c09bc9f89ea8a2eab2c ]

In preparation for libnvdimm growing new restrictions to detect section
conflicts between persistent memory regions, enable nfit_test to
allocate aligned resources. Use a gen_pool to allocate nfit_test's fake
resources in a separate address space from the virtual translation of
the same.

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Tested-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/nvdimm/test/nfit.c | 35 ++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index ec50d2a95076..fa763dbfdad7 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/workqueue.h>
 #include <linux/libnvdimm.h>
+#include <linux/genalloc.h>
 #include <linux/vmalloc.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -213,6 +214,8 @@ struct nfit_test {
 
 static struct workqueue_struct *nfit_wq;
 
+static struct gen_pool *nfit_pool;
+
 static struct nfit_test *to_nfit_test(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -1130,6 +1133,9 @@ static void release_nfit_res(void *data)
 	list_del(&nfit_res->list);
 	spin_unlock(&nfit_test_lock);
 
+	if (resource_size(&nfit_res->res) >= DIMM_SIZE)
+		gen_pool_free(nfit_pool, nfit_res->res.start,
+				resource_size(&nfit_res->res));
 	vfree(nfit_res->buf);
 	kfree(nfit_res);
 }
@@ -1142,7 +1148,7 @@ static void *__test_alloc(struct nfit_test *t, size_t size, dma_addr_t *dma,
 			GFP_KERNEL);
 	int rc;
 
-	if (!buf || !nfit_res)
+	if (!buf || !nfit_res || !*dma)
 		goto err;
 	rc = devm_add_action(dev, release_nfit_res, nfit_res);
 	if (rc)
@@ -1162,6 +1168,8 @@ static void *__test_alloc(struct nfit_test *t, size_t size, dma_addr_t *dma,
 
 	return nfit_res->buf;
  err:
+	if (*dma && size >= DIMM_SIZE)
+		gen_pool_free(nfit_pool, *dma, size);
 	if (buf)
 		vfree(buf);
 	kfree(nfit_res);
@@ -1170,9 +1178,16 @@ static void *__test_alloc(struct nfit_test *t, size_t size, dma_addr_t *dma,
 
 static void *test_alloc(struct nfit_test *t, size_t size, dma_addr_t *dma)
 {
+	struct genpool_data_align data = {
+		.align = SZ_128M,
+	};
 	void *buf = vmalloc(size);
 
-	*dma = (unsigned long) buf;
+	if (size >= DIMM_SIZE)
+		*dma = gen_pool_alloc_algo(nfit_pool, size,
+				gen_pool_first_fit_align, &data);
+	else
+		*dma = (unsigned long) buf;
 	return __test_alloc(t, size, dma, buf);
 }
 
@@ -2837,6 +2852,17 @@ static __init int nfit_test_init(void)
 		goto err_register;
 	}
 
+	nfit_pool = gen_pool_create(ilog2(SZ_4M), NUMA_NO_NODE);
+	if (!nfit_pool) {
+		rc = -ENOMEM;
+		goto err_register;
+	}
+
+	if (gen_pool_add(nfit_pool, SZ_4G, SZ_4G, NUMA_NO_NODE)) {
+		rc = -ENOMEM;
+		goto err_register;
+	}
+
 	for (i = 0; i < NUM_NFITS; i++) {
 		struct nfit_test *nfit_test;
 		struct platform_device *pdev;
@@ -2892,6 +2918,9 @@ static __init int nfit_test_init(void)
 	return 0;
 
  err_register:
+	if (nfit_pool)
+		gen_pool_destroy(nfit_pool);
+
 	destroy_workqueue(nfit_wq);
 	for (i = 0; i < NUM_NFITS; i++)
 		if (instances[i])
@@ -2915,6 +2944,8 @@ static __exit void nfit_test_exit(void)
 	platform_driver_unregister(&nfit_test_driver);
 	nfit_test_teardown();
 
+	gen_pool_destroy(nfit_pool);
+
 	for (i = 0; i < NUM_NFITS; i++)
 		put_device(&instances[i]->pdev.dev);
 	class_destroy(nfit_test_dimm);
-- 
2.19.1

