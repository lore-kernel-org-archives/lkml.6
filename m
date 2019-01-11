Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD87C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D737206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218193;
	bh=YQi2Eb++361fhbDNsL6sArryVFucH91GPm12GaXI/mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MJmdxrTFaGPfj8f2+7DGcuFCfLnKfdw994oXAuSCudH8DFlSMGXqDWrssvRWnACFP
	 ZsDD39TZ9nWjJ97BNJIYoXFpMzRs88eoyYiFXdhzOKWxvy0CzK65kOH6Dc60Pmz5cu
	 3ep8jz8obP4er+qMr8JfvZ/3DwQ+ZnhZsoHFcLmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391636AbfAKOtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:49:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403946AbfAKOlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:41:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B11206B6;
        Fri, 11 Jan 2019 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217659;
        bh=YQi2Eb++361fhbDNsL6sArryVFucH91GPm12GaXI/mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXNW88LWOEUVsGeK3WZBACUUwku3JAk0MjyEVO/Zxgb/no73Co7cYRRBe/nIiN9uM
         PIw/19G+5gs1o3Noz29aX4Nc1ufpRLtnPOAlKk9CWwJpzkNHVu7xnc+CGTN29jlc42
         OYRWbldZjZrZY3X4qA0HlaJftReSsDymKJvi5TxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.19 142/148] of: of_node_get()/of_node_put() nodes held in phandle cache
Date:   Fri, 11 Jan 2019 15:15:20 +0100
Message-Id: <20190111131119.989945022@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

From: Frank Rowand <frank.rowand@sony.com>

commit b8a9ac1a5b99a2fcbed19fd29d2d59270c281a31 upstream.

The phandle cache contains struct device_node pointers.  The refcount
of the pointers was not incremented while in the cache, allowing use
after free error after kfree() of the node.  Add the proper increment
and decrement of the use count.

Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
Cc: stable@vger.kernel.org # v4.17+
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/base.c |   70 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 24 deletions(-)

--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -115,9 +115,6 @@ int __weak of_node_to_nid(struct device_
 }
 #endif
 
-static struct device_node **phandle_cache;
-static u32 phandle_cache_mask;
-
 /*
  * Assumptions behind phandle_cache implementation:
  *   - phandle property values are in a contiguous range of 1..n
@@ -126,6 +123,44 @@ static u32 phandle_cache_mask;
  *   - the phandle lookup overhead reduction provided by the cache
  *     will likely be less
  */
+
+static struct device_node **phandle_cache;
+static u32 phandle_cache_mask;
+
+/*
+ * Caller must hold devtree_lock.
+ */
+static void __of_free_phandle_cache(void)
+{
+	u32 cache_entries = phandle_cache_mask + 1;
+	u32 k;
+
+	if (!phandle_cache)
+		return;
+
+	for (k = 0; k < cache_entries; k++)
+		of_node_put(phandle_cache[k]);
+
+	kfree(phandle_cache);
+	phandle_cache = NULL;
+}
+
+int of_free_phandle_cache(void)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+
+	__of_free_phandle_cache();
+
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+
+	return 0;
+}
+#if !defined(CONFIG_MODULES)
+late_initcall_sync(of_free_phandle_cache);
+#endif
+
 void of_populate_phandle_cache(void)
 {
 	unsigned long flags;
@@ -135,8 +170,7 @@ void of_populate_phandle_cache(void)
 
 	raw_spin_lock_irqsave(&devtree_lock, flags);
 
-	kfree(phandle_cache);
-	phandle_cache = NULL;
+	__of_free_phandle_cache();
 
 	for_each_of_allnodes(np)
 		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
@@ -154,30 +188,15 @@ void of_populate_phandle_cache(void)
 		goto out;
 
 	for_each_of_allnodes(np)
-		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
+		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL) {
+			of_node_get(np);
 			phandle_cache[np->phandle & phandle_cache_mask] = np;
+		}
 
 out:
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 }
 
-int of_free_phandle_cache(void)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&devtree_lock, flags);
-
-	kfree(phandle_cache);
-	phandle_cache = NULL;
-
-	raw_spin_unlock_irqrestore(&devtree_lock, flags);
-
-	return 0;
-}
-#if !defined(CONFIG_MODULES)
-late_initcall_sync(of_free_phandle_cache);
-#endif
-
 void __init of_core_init(void)
 {
 	struct device_node *np;
@@ -1155,8 +1174,11 @@ struct device_node *of_find_node_by_phan
 	if (!np) {
 		for_each_of_allnodes(np)
 			if (np->phandle == handle) {
-				if (phandle_cache)
+				if (phandle_cache) {
+					/* will put when removed from cache */
+					of_node_get(np);
 					phandle_cache[masked_handle] = np;
+				}
 				break;
 			}
 	}


