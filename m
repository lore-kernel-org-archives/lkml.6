Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A897C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5665F20449
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298372;
	bh=CQoa8tkN9XRcIu5DxZl/dn0q88aPICM+wfWWNP8e9u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2pxrIlLJdgnkaS743M0t2W/t5JCJWu6l6Lf30HhODAXpMGr2MIKuvkKGFJZoqdFJu
	 2+DQ8hMpTySe6GeApVuPASG90SomTU7AHClq8E19ujaDkxe+tPt/Fq7uzss3ddMYcm
	 9BV4/FD+wHWOUGUz9OcXAPKYSEVuO/X6zNI6rzsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733070AbeLTJcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:32:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733020AbeLTJaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DFA921741;
        Thu, 20 Dec 2018 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298254;
        bh=CQoa8tkN9XRcIu5DxZl/dn0q88aPICM+wfWWNP8e9u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z3RQBIDidFhyD0pMCj98rOiGYGdFBCP8GDSLw7CDoJPBGgmqncu3nx/HAg5xkAkTm
         1W1LD9ojdxl93L+1Qac2q4ueJSwmgqkcdPvcibGC/1BVdGvf8edUcTrAvBNfNwHH3k
         6OsElhnc6zfhLFkJmSW1MvIequXA9q61KbLOoXPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 55/67] tools/testing/nvdimm: Align test resources to 128M
Date:   Thu, 20 Dec 2018 10:19:07 +0100
Message-Id: <20181220085905.725572376@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



