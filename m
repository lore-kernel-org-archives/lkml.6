Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC4CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08B820652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mi/LtUF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389676AbfAKSFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:05:50 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44224 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389626AbfAKSFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:05:45 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BI5ZUF067776;
        Fri, 11 Jan 2019 12:05:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547229935;
        bh=kedV1S7Qo3zNTOmFpiB+JK+j8l2W1E6CQQL/KEBLSY8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Mi/LtUF67VzpSkWPJpfaq7LtUD5aNeUO4AnbtN46qgH7kSuRJMqNl6PnRYm+mRgAL
         XnvAo+CowVhDC7Xr7DRZwN7oB6uNEsUNjC1cu1dfJhvSo/SAT0wPDMVrGN/EKTNAX4
         9hautAfo/W2XK7jGKV+fxgzxi537aFlWS6W4oS5k=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BI5Zgi059332
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 12:05:35 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 12:05:34 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 12:05:35 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BI5ZRL017209;
        Fri, 11 Jan 2019 12:05:35 -0600
Received: from localhost (uda0226330.dhcp.ti.com [172.22.109.196])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BI5YU07760;
        Fri, 11 Jan 2019 12:05:34 -0600 (CST)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
CC:     <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 12/14] staging: android: ion: Declare helpers for carveout and chunk heaps
Date:   Fri, 11 Jan 2019 12:05:21 -0600
Message-ID: <20190111180523.27862-13-afd@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111180523.27862-1-afd@ti.com>
References: <20190111180523.27862-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabled the helpers functions for creating carveout and chunk heaps
should have declarations in the ION header.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/staging/android/ion/ion.h | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index e291299fd35f..97b2876b165a 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -308,4 +308,37 @@ void ion_page_pool_free(struct ion_page_pool *pool, struct page *page);
 int ion_page_pool_shrink(struct ion_page_pool *pool, gfp_t gfp_mask,
 			 int nr_to_scan);
 
+#ifdef CONFIG_ION_CARVEOUT_HEAP
+/**
+ * ion_carveout_heap_create
+ * @base:		base address of carveout memory
+ * @size:		size of carveout memory region
+ *
+ * Creates a carveout ion_heap using the passed in data
+ */
+struct ion_heap *ion_carveout_heap_create(phys_addr_t base, size_t size);
+#else
+static inline struct ion_heap *ion_carveout_heap_create(phys_addr_t base, size_t size)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+
+#ifdef CONFIG_ION_CHUNK_HEAP
+/**
+ * ion_chunk_heap_create
+ * @base:		base address of carveout memory
+ * @size:		size of carveout memory region
+ * @chunk_size:		minimum allocation granularity
+ *
+ * Creates a chunk ion_heap using the passed in data
+ */
+struct ion_heap *ion_chunk_heap_create(phys_addr_t base, size_t size, size_t chunk_size);
+#else
+static inline struct ion_heap *ion_chunk_heap_create(phys_addr_t base, size_t size, size_t chunk_size)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+
 #endif /* _ION_H */
-- 
2.19.1

