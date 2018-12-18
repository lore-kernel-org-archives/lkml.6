Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B1BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C393721873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMesuXgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeLRTk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:40:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38979 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbeLRTk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:40:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so8269641pgl.6;
        Tue, 18 Dec 2018 11:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FFIR56EPPMtxpRI59NyRK3PwR1fe0YI9MbaLl494NEI=;
        b=oMesuXgOxh3rffuZdb2VG3kMN2EgZm0eenELSQ9/8FZLHdrikxwu3pPoGFWqqSN/Ne
         O4AfSIWfCfUxfQAq6De1Shrzkh74aUdEqGlFNEExVweVkbp+12LftWeOKEsdorQI/tVI
         94eMIt0dIyjhs4F4jIQ1GWGT55XeCupedkYFOLZTpFpvrXhq9G0Agj96LR62Wcx6fTFs
         xiVo2kTW1/ZgopJ1OfxUrkmmEThEud9IIp8KJjchWEJAV46INdfFZgqJhxJgMVn6qirT
         BPzoHYALpjGYQZXt4x17F1KQnaY8XXS2Vuen1KqfREZoPwTPsOArF7pecLnrJWctsPIl
         Oo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FFIR56EPPMtxpRI59NyRK3PwR1fe0YI9MbaLl494NEI=;
        b=dezMXYZqYTxo36Q1lBtufCyy5+N2WDjNYoFojMo2/1PKcI863IiCjBHhGYbgyceSYn
         ePWev+Vru2ANhc6/E6SVvicMJnwf7kqcu4d/UxXztxQyfCBH1wA2c+4HgmPfWluGmnZ4
         0UlUsj8JzeqyCaEEMvk0e5axsFjJy2StwOCJsHFO/ZlzAs3t0gHG08imb0xgfZ8cnnC5
         f0QRN75T2loHmgZQepV39sPUwR4c/nhdVD+5w0iPDkvIONYMght8+N0j2a8t0Se0me3Z
         gLgQ5B8zNeL+yd5p+urh7VRB26cZRG2OkHuoHsxbhZPt/J4ETtK5iBOmG8aU31pPVR72
         YKUw==
X-Gm-Message-State: AA+aEWbOfSrmgPdaDBAcEP86Nf9sfNost3CPemlgTK65axjhtf58kZOR
        9NHDJcVPYyOzCJeUg19IO0Q=
X-Google-Smtp-Source: AFSGD/XB5RxrA+Vo26Mis+VOsHyU9tLICH1XvHi0jMUo+CSL4elZ1+OfbPs5sTmWiZ1ddzmSKaS9ug==
X-Received: by 2002:a62:de06:: with SMTP id h6mr18383172pfg.158.1545162024350;
        Tue, 18 Dec 2018 11:40:24 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id b202sm29493069pfb.88.2018.12.18.11.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Dec 2018 11:40:23 -0800 (PST)
From:   frowand.list@gmail.com
To:     robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] of: of_node_get()/of_node_put() nodes held in phandle cache
Date:   Tue, 18 Dec 2018 11:40:02 -0800
Message-Id: <1545162003-11577-2-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545162003-11577-1-git-send-email-frowand.list@gmail.com>
References: <1545162003-11577-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

The phandle cache contains struct device_node pointers.  The refcount
of the pointers was not incremented while in the cache, allowing use
after free error after kfree() of the node.  Add the proper increment
and decrement of the use count.

Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

do not "cc: stable", unless the following commits are also in stable:

  commit e54192b48da7 ("of: fix phandle cache creation for DTs with no phandles")
  commit b9952b5218ad ("of: overlay: update phandle cache on overlay apply and remove")
  commit 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")


 drivers/of/base.c | 70 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 09692c9b32a7..6c33d63361b8 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -116,9 +116,6 @@ int __weak of_node_to_nid(struct device_node *np)
 }
 #endif
 
-static struct device_node **phandle_cache;
-static u32 phandle_cache_mask;
-
 /*
  * Assumptions behind phandle_cache implementation:
  *   - phandle property values are in a contiguous range of 1..n
@@ -127,6 +124,44 @@ int __weak of_node_to_nid(struct device_node *np)
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
@@ -136,8 +171,7 @@ void of_populate_phandle_cache(void)
 
 	raw_spin_lock_irqsave(&devtree_lock, flags);
 
-	kfree(phandle_cache);
-	phandle_cache = NULL;
+	__of_free_phandle_cache();
 
 	for_each_of_allnodes(np)
 		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
@@ -155,30 +189,15 @@ void of_populate_phandle_cache(void)
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
@@ -1195,8 +1214,11 @@ struct device_node *of_find_node_by_phandle(phandle handle)
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
-- 
Frank Rowand <frank.rowand@sony.com>

