Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D517DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56BD206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217920;
	bh=Ca0baCC0+GHqC8VTZUBvJrm3nviRqvbp3N/3nfBpon8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iWvD76ah7UpcJKSh2HNIB8EW2Xy4dACoNP3l+xmGuKnETa+s3wBAr5XphqKi1Tbp8
	 N/rYS3NI3kD/xNqa2BuDjQ5eSGC9fs5HRpsuXnMHcIbFBJzDEDlM+uqRWgbgk8PYxs
	 bHbs6vz/uyGjkSIHB6RYzj4bL+/IIlnAZibb5JRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391426AbfAKOpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404511AbfAKOoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:44:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6AA52063F;
        Fri, 11 Jan 2019 14:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217845;
        bh=Ca0baCC0+GHqC8VTZUBvJrm3nviRqvbp3N/3nfBpon8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vq90Wau3ZZNr2zX0EnEPfS8NUysSYgLJLdYkGhAKfX3K0SGQY8vA1tWGr+vJe39+k
         y3MVmBsQdlrEBUGK70akqp/XCCvxvCR/mWmRdaAv0VkAJ7JLOzNN04IR1AQ5tJmHRl
         eU2/ZqoWE8vTNpauqvIPqPVNAIgK03mUiQ1Kl2Sw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.20 61/65] of: __of_detach_node() - remove node from phandle cache
Date:   Fri, 11 Jan 2019 15:15:47 +0100
Message-Id: <20190111131104.202310590@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Rowand <frank.rowand@sony.com>

commit 5801169a2ed20003f771acecf3ac00574cf10a38 upstream.

Non-overlay dynamic devicetree node removal may leave the node in
the phandle cache.  Subsequent calls to of_find_node_by_phandle()
will incorrectly find the stale entry.  Remove the node from the
cache.

Add paranoia checks in of_find_node_by_phandle() as a second level
of defense (do not return cached node if detached, do not add node
to cache if detached).

Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # v4.17+
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/base.c       |   31 ++++++++++++++++++++++++++++++-
 drivers/of/dynamic.c    |    3 +++
 drivers/of/of_private.h |    4 ++++
 3 files changed, 37 insertions(+), 1 deletion(-)

--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -162,6 +162,28 @@ int of_free_phandle_cache(void)
 late_initcall_sync(of_free_phandle_cache);
 #endif
 
+/*
+ * Caller must hold devtree_lock.
+ */
+void __of_free_phandle_cache_entry(phandle handle)
+{
+	phandle masked_handle;
+	struct device_node *np;
+
+	if (!handle)
+		return;
+
+	masked_handle = handle & phandle_cache_mask;
+
+	if (phandle_cache) {
+		np = phandle_cache[masked_handle];
+		if (np && handle == np->phandle) {
+			of_node_put(np);
+			phandle_cache[masked_handle] = NULL;
+		}
+	}
+}
+
 void of_populate_phandle_cache(void)
 {
 	unsigned long flags;
@@ -1209,11 +1231,18 @@ struct device_node *of_find_node_by_phan
 		if (phandle_cache[masked_handle] &&
 		    handle == phandle_cache[masked_handle]->phandle)
 			np = phandle_cache[masked_handle];
+		if (np && of_node_check_flag(np, OF_DETACHED)) {
+			WARN_ON(1); /* did not uncache np on node removal */
+			of_node_put(np);
+			phandle_cache[masked_handle] = NULL;
+			np = NULL;
+		}
 	}
 
 	if (!np) {
 		for_each_of_allnodes(np)
-			if (np->phandle == handle) {
+			if (np->phandle == handle &&
+			    !of_node_check_flag(np, OF_DETACHED)) {
 				if (phandle_cache) {
 					/* will put when removed from cache */
 					of_node_get(np);
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -268,6 +268,9 @@ void __of_detach_node(struct device_node
 	}
 
 	of_node_set_flag(np, OF_DETACHED);
+
+	/* race with of_find_node_by_phandle() prevented by devtree_lock */
+	__of_free_phandle_cache_entry(np->phandle);
 }
 
 /**
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -84,6 +84,10 @@ static inline void __of_detach_node_sysf
 int of_resolve_phandles(struct device_node *tree);
 #endif
 
+#if defined(CONFIG_OF_DYNAMIC)
+void __of_free_phandle_cache_entry(phandle handle);
+#endif
+
 #if defined(CONFIG_OF_OVERLAY)
 void of_overlay_mutex_lock(void);
 void of_overlay_mutex_unlock(void);


