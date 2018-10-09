Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03FEC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A949B214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="15F4swiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A949B214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeJISbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:31:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37259 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeJISbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:31:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so679730pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CrQSsFtokCmLSs0Sj4Lhir0OubtXeKGejowXHoxacFI=;
        b=15F4swiII7zA2GOpvLaJfMf6dIvM74l0nRwE2cvnVRiu8NVOLbpI+Qcd44Oqzdujt5
         j21d7by8h3n7IV6soIfDnqQ2I6ZzMSXnchjkmc0R19Vi3JoWkvI+4Z+Y0QfcOSiLkW2R
         hnRVtTnqWD+As0f2b/tCWvFS/mk3JHmf4gKZf3RBdiE1iqV6D+yuP6KvwSPeN4Fin98U
         4svhOf2qQIsN8W3OGjEpa0zSS/KqFvM+lAf4kLdPsHjEFKl5wIIdVXxrhU+0aEcgAWZD
         znL6/G2Vh+RRvgM+wO4lT1FP+Y/maNyt4McFXxLG3ti0wlUZ5LcjUI132XvaNi1qrZsq
         LIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CrQSsFtokCmLSs0Sj4Lhir0OubtXeKGejowXHoxacFI=;
        b=FkbW5fTw1chWZcHGdADn6eVDnWw79KbkVyCFkBZ4xGmyWVhe4EGiq3DoXUae38pxrL
         T12nssu26caKUd57fNUz/SOjj9MXstuSOaYFWgeMrmjjRIUH+Jl1PqgsXkPciCiAoQuE
         2Qg+oGsqqQ7QDCQCB1SSekKheTdgVg1VvMeo8Cfgb6cWR7AHRWHCme2lLUIFb+MOIN6m
         hG7118INf1u6JsL+N5APtae8iQsUTmLIZbzOI8ChUGq0pi/GB3IuwWkDXzA0MIPbBWcH
         lgK3GBRcJBs2DNiUs/XBHZq7waxJI8wutVgW3e9qM/hZo2R3OkJNJOdgy8g98lW0VHYz
         yWkQ==
X-Gm-Message-State: ABuFfoguZ8wqhI7LPC3QX9rV29KEF/H38f/gdzP1Fi4ZRSJOBw3s0Cgf
        5eAEMcpRdWH6KkvoSRSSQYnmZg==
X-Google-Smtp-Source: ACcGV62x4fz+BnX5mFqnWzZ8IMFCYkgkjUdvS3ChHvKJCfvxHLeL8MhNlSailLrE3PqrnP9rJJWc9g==
X-Received: by 2002:a62:8490:: with SMTP id k138-v6mr29471569pfd.177.1539083687856;
        Tue, 09 Oct 2018 04:14:47 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:14:46 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 28/45] lightnvm: pblk: stop recreating global caches
Date:   Tue,  9 Oct 2018 13:11:58 +0200
Message-Id: <20181009111215.7653-29-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Pblk should not create a set of global caches every time
a pblk instance is created. The global caches should be
made available only when there is one or more pblk instances.

This patch bundles the global caches together with a kref
keeping track of whether the caches should be available or not.

Also, turn the global pblk lock into a mutex that explicitly
protects the caches (as this was the only purpose of the lock).

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 132 +++++++++++++++++++++++------------
 1 file changed, 86 insertions(+), 46 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 9aebdee8e4c9..fb66bc84d5ca 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -26,9 +26,24 @@ static unsigned int write_buffer_size;
 module_param(write_buffer_size, uint, 0644);
 MODULE_PARM_DESC(write_buffer_size, "number of entries in a write buffer");
 
-static struct kmem_cache *pblk_ws_cache, *pblk_rec_cache, *pblk_g_rq_cache,
-				*pblk_w_rq_cache;
-static DECLARE_RWSEM(pblk_lock);
+struct pblk_global_caches {
+	struct kmem_cache	*ws;
+	struct kmem_cache	*rec;
+	struct kmem_cache	*g_rq;
+	struct kmem_cache	*w_rq;
+
+	struct kref		kref;
+
+	struct mutex		mutex; /* Ensures consistency between
+					* caches and kref
+					*/
+};
+
+static struct pblk_global_caches pblk_caches = {
+	.mutex = __MUTEX_INITIALIZER(pblk_caches.mutex),
+	.kref = KREF_INIT(0),
+};
+
 struct bio_set pblk_bio_set;
 
 static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
@@ -307,53 +322,80 @@ static int pblk_set_addrf(struct pblk *pblk)
 	return 0;
 }
 
-static int pblk_init_global_caches(struct pblk *pblk)
+static int pblk_create_global_caches(void)
 {
-	down_write(&pblk_lock);
-	pblk_ws_cache = kmem_cache_create("pblk_blk_ws",
+
+	pblk_caches.ws = kmem_cache_create("pblk_blk_ws",
 				sizeof(struct pblk_line_ws), 0, 0, NULL);
-	if (!pblk_ws_cache) {
-		up_write(&pblk_lock);
+	if (!pblk_caches.ws)
 		return -ENOMEM;
-	}
 
-	pblk_rec_cache = kmem_cache_create("pblk_rec",
+	pblk_caches.rec = kmem_cache_create("pblk_rec",
 				sizeof(struct pblk_rec_ctx), 0, 0, NULL);
-	if (!pblk_rec_cache) {
-		kmem_cache_destroy(pblk_ws_cache);
-		up_write(&pblk_lock);
-		return -ENOMEM;
-	}
+	if (!pblk_caches.rec)
+		goto fail_destroy_ws;
 
-	pblk_g_rq_cache = kmem_cache_create("pblk_g_rq", pblk_g_rq_size,
+	pblk_caches.g_rq = kmem_cache_create("pblk_g_rq", pblk_g_rq_size,
 				0, 0, NULL);
-	if (!pblk_g_rq_cache) {
-		kmem_cache_destroy(pblk_ws_cache);
-		kmem_cache_destroy(pblk_rec_cache);
-		up_write(&pblk_lock);
-		return -ENOMEM;
-	}
+	if (!pblk_caches.g_rq)
+		goto fail_destroy_rec;
 
-	pblk_w_rq_cache = kmem_cache_create("pblk_w_rq", pblk_w_rq_size,
+	pblk_caches.w_rq = kmem_cache_create("pblk_w_rq", pblk_w_rq_size,
 				0, 0, NULL);
-	if (!pblk_w_rq_cache) {
-		kmem_cache_destroy(pblk_ws_cache);
-		kmem_cache_destroy(pblk_rec_cache);
-		kmem_cache_destroy(pblk_g_rq_cache);
-		up_write(&pblk_lock);
-		return -ENOMEM;
-	}
-	up_write(&pblk_lock);
+	if (!pblk_caches.w_rq)
+		goto fail_destroy_g_rq;
 
 	return 0;
+
+fail_destroy_g_rq:
+	kmem_cache_destroy(pblk_caches.g_rq);
+fail_destroy_rec:
+	kmem_cache_destroy(pblk_caches.rec);
+fail_destroy_ws:
+	kmem_cache_destroy(pblk_caches.ws);
+
+	return -ENOMEM;
+}
+
+static int pblk_get_global_caches(void)
+{
+	int ret;
+
+	mutex_lock(&pblk_caches.mutex);
+
+	if (kref_read(&pblk_caches.kref) > 0) {
+		kref_get(&pblk_caches.kref);
+		mutex_unlock(&pblk_caches.mutex);
+		return 0;
+	}
+
+	ret = pblk_create_global_caches();
+
+	if (!ret)
+		kref_get(&pblk_caches.kref);
+
+	mutex_unlock(&pblk_caches.mutex);
+
+	return ret;
+}
+
+static void pblk_destroy_global_caches(struct kref *ref)
+{
+	struct pblk_global_caches *c;
+
+	c = container_of(ref, struct pblk_global_caches, kref);
+
+	kmem_cache_destroy(c->ws);
+	kmem_cache_destroy(c->rec);
+	kmem_cache_destroy(c->g_rq);
+	kmem_cache_destroy(c->w_rq);
 }
 
-static void pblk_free_global_caches(struct pblk *pblk)
+static void pblk_put_global_caches(void)
 {
-	kmem_cache_destroy(pblk_ws_cache);
-	kmem_cache_destroy(pblk_rec_cache);
-	kmem_cache_destroy(pblk_g_rq_cache);
-	kmem_cache_destroy(pblk_w_rq_cache);
+	mutex_lock(&pblk_caches.mutex);
+	kref_put(&pblk_caches.kref, pblk_destroy_global_caches);
+	mutex_unlock(&pblk_caches.mutex);
 }
 
 static int pblk_core_init(struct pblk *pblk)
@@ -382,7 +424,7 @@ static int pblk_core_init(struct pblk *pblk)
 	if (!pblk->pad_dist)
 		return -ENOMEM;
 
-	if (pblk_init_global_caches(pblk))
+	if (pblk_get_global_caches())
 		goto fail_free_pad_dist;
 
 	/* Internal bios can be at most the sectors signaled by the device. */
@@ -391,27 +433,27 @@ static int pblk_core_init(struct pblk *pblk)
 		goto free_global_caches;
 
 	ret = mempool_init_slab_pool(&pblk->gen_ws_pool, PBLK_GEN_WS_POOL_SIZE,
-				     pblk_ws_cache);
+				     pblk_caches.ws);
 	if (ret)
 		goto free_page_bio_pool;
 
 	ret = mempool_init_slab_pool(&pblk->rec_pool, geo->all_luns,
-				     pblk_rec_cache);
+				     pblk_caches.rec);
 	if (ret)
 		goto free_gen_ws_pool;
 
 	ret = mempool_init_slab_pool(&pblk->r_rq_pool, geo->all_luns,
-				     pblk_g_rq_cache);
+				     pblk_caches.g_rq);
 	if (ret)
 		goto free_rec_pool;
 
 	ret = mempool_init_slab_pool(&pblk->e_rq_pool, geo->all_luns,
-				     pblk_g_rq_cache);
+				     pblk_caches.g_rq);
 	if (ret)
 		goto free_r_rq_pool;
 
 	ret = mempool_init_slab_pool(&pblk->w_rq_pool, geo->all_luns,
-				     pblk_w_rq_cache);
+				     pblk_caches.w_rq);
 	if (ret)
 		goto free_e_rq_pool;
 
@@ -457,7 +499,7 @@ static int pblk_core_init(struct pblk *pblk)
 free_page_bio_pool:
 	mempool_exit(&pblk->page_bio_pool);
 free_global_caches:
-	pblk_free_global_caches(pblk);
+	pblk_put_global_caches();
 fail_free_pad_dist:
 	kfree(pblk->pad_dist);
 	return -ENOMEM;
@@ -481,7 +523,7 @@ static void pblk_core_free(struct pblk *pblk)
 	mempool_exit(&pblk->e_rq_pool);
 	mempool_exit(&pblk->w_rq_pool);
 
-	pblk_free_global_caches(pblk);
+	pblk_put_global_caches();
 	kfree(pblk->pad_dist);
 }
 
@@ -1074,7 +1116,6 @@ static void pblk_exit(void *private, bool graceful)
 {
 	struct pblk *pblk = private;
 
-	down_write(&pblk_lock);
 	pblk_gc_exit(pblk, graceful);
 	pblk_tear_down(pblk, graceful);
 
@@ -1083,7 +1124,6 @@ static void pblk_exit(void *private, bool graceful)
 #endif
 
 	pblk_free(pblk);
-	up_write(&pblk_lock);
 }
 
 static sector_t pblk_capacity(void *private)
-- 
2.17.1

