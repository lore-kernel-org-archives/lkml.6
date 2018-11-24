Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6889C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 18:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D3A2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 18:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D3A2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbeKYFsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 00:48:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:18871 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725738AbeKYFs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 00:48:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2018 10:59:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,275,1539673200"; 
   d="scan'208";a="107334075"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002.fm.intel.com with ESMTP; 24 Nov 2018 10:59:26 -0800
Subject: [PATCH 1/2] tools/testing/nvdimm: Align test resources to 128M
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        dave.jiang@intel.com
Date:   Sat, 24 Nov 2018 10:46:59 -0800
Message-ID: <154308521932.237140.13650270234597178173.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for libnvdimm growing new restrictions to detect section
conflicts between persistent memory regions, enable nfit_test to
allocate aligned resources. Use a gen_pool to allocate nfit_test's fake
resources in a separate address space from the virtual translation of
the same.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/nvdimm/test/nfit.c |   36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 01ec04bf91b5..ca4e61c864d5 100644
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
@@ -215,6 +216,8 @@ struct nfit_test {
 
 static struct workqueue_struct *nfit_wq;
 
+static struct gen_pool *nfit_pool;
+
 static struct nfit_test *to_nfit_test(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -1132,6 +1135,9 @@ static void release_nfit_res(void *data)
 	list_del(&nfit_res->list);
 	spin_unlock(&nfit_test_lock);
 
+	if (resource_size(&nfit_res->res) >= DIMM_SIZE)
+		gen_pool_free(nfit_pool, nfit_res->res.start,
+				resource_size(&nfit_res->res));
 	vfree(nfit_res->buf);
 	kfree(nfit_res);
 }
@@ -1144,7 +1150,7 @@ static void *__test_alloc(struct nfit_test *t, size_t size, dma_addr_t *dma,
 			GFP_KERNEL);
 	int rc;
 
-	if (!buf || !nfit_res)
+	if (!buf || !nfit_res || !*dma)
 		goto err;
 	rc = devm_add_action(dev, release_nfit_res, nfit_res);
 	if (rc)
@@ -1164,6 +1170,8 @@ static void *__test_alloc(struct nfit_test *t, size_t size, dma_addr_t *dma,
 
 	return nfit_res->buf;
  err:
+	if (*dma && size >= DIMM_SIZE)
+		gen_pool_free(nfit_pool, *dma, size);
 	if (buf)
 		vfree(buf);
 	kfree(nfit_res);
@@ -1172,9 +1180,16 @@ static void *__test_alloc(struct nfit_test *t, size_t size, dma_addr_t *dma,
 
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
 
@@ -2839,6 +2854,18 @@ static __init int nfit_test_init(void)
 		goto err_register;
 	}
 
+	nfit_pool = gen_pool_create(ilog2(SZ_4M), NUMA_NO_NODE);
+	if (!nfit_pool) {
+		rc = -ENOMEM;
+		goto err_register;
+	}
+
+	if (gen_pool_add(nfit_pool, VMALLOC_START,
+				VMALLOC_END + 1 - VMALLOC_START, NUMA_NO_NODE)) {
+		rc = -ENOMEM;
+		goto err_register;
+	}
+
 	for (i = 0; i < NUM_NFITS; i++) {
 		struct nfit_test *nfit_test;
 		struct platform_device *pdev;
@@ -2894,6 +2921,9 @@ static __init int nfit_test_init(void)
 	return 0;
 
  err_register:
+	if (nfit_pool)
+		gen_pool_destroy(nfit_pool);
+
 	destroy_workqueue(nfit_wq);
 	for (i = 0; i < NUM_NFITS; i++)
 		if (instances[i])
@@ -2917,6 +2947,8 @@ static __exit void nfit_test_exit(void)
 	platform_driver_unregister(&nfit_test_driver);
 	nfit_test_teardown();
 
+	gen_pool_destroy(nfit_pool);
+
 	for (i = 0; i < NUM_NFITS; i++)
 		put_device(&instances[i]->pdev.dev);
 	class_destroy(nfit_test_dimm);

