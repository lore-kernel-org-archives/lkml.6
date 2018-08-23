Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74783C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386F6208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386F6208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbeHWMbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:31:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55882 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbeHWMbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:31:36 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B6EE0BBF;
        Thu, 23 Aug 2018 09:02:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Tull <atull@kernel.org>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 268/324] of: overlay: update phandle cache on overlay apply and remove
Date:   Thu, 23 Aug 2018 09:55:34 +0200
Message-Id: <20180823075009.376639539@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Rowand <frank.rowand@sony.com>

[ Upstream commit b9952b5218added5577e4a3443969bc20884cea9 ]

A comment in the review of the patch adding the phandle cache said that
the cache would have to be updated when modules are applied and removed.
This patch implements the cache updates.

Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
Reported-by: Alan Tull <atull@kernel.org>
Suggested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/base.c       |    6 +++---
 drivers/of/of_private.h |    2 ++
 drivers/of/overlay.c    |   11 +++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -102,7 +102,7 @@ static u32 phandle_cache_mask;
  *   - the phandle lookup overhead reduction provided by the cache
  *     will likely be less
  */
-static void of_populate_phandle_cache(void)
+void of_populate_phandle_cache(void)
 {
 	unsigned long flags;
 	u32 cache_entries;
@@ -134,8 +134,7 @@ out:
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 }
 
-#ifndef CONFIG_MODULES
-static int __init of_free_phandle_cache(void)
+int of_free_phandle_cache(void)
 {
 	unsigned long flags;
 
@@ -148,6 +147,7 @@ static int __init of_free_phandle_cache(
 
 	return 0;
 }
+#if !defined(CONFIG_MODULES)
 late_initcall_sync(of_free_phandle_cache);
 #endif
 
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -79,6 +79,8 @@ int of_resolve_phandles(struct device_no
 #if defined(CONFIG_OF_OVERLAY)
 void of_overlay_mutex_lock(void);
 void of_overlay_mutex_unlock(void);
+int of_free_phandle_cache(void);
+void of_populate_phandle_cache(void);
 #else
 static inline void of_overlay_mutex_lock(void) {};
 static inline void of_overlay_mutex_unlock(void) {};
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -804,6 +804,8 @@ static int of_overlay_apply(const void *
 		goto err_free_overlay_changeset;
 	}
 
+	of_populate_phandle_cache();
+
 	ret = __of_changeset_apply_notify(&ovcs->cset);
 	if (ret)
 		pr_err("overlay changeset entry notify error %d\n", ret);
@@ -1046,8 +1048,17 @@ int of_overlay_remove(int *ovcs_id)
 
 	list_del(&ovcs->ovcs_list);
 
+	/*
+	 * Disable phandle cache.  Avoids race condition that would arise
+	 * from removing cache entry when the associated node is deleted.
+	 */
+	of_free_phandle_cache();
+
 	ret_apply = 0;
 	ret = __of_changeset_revert_entries(&ovcs->cset, &ret_apply);
+
+	of_populate_phandle_cache();
+
 	if (ret) {
 		if (ret_apply)
 			devicetree_state_flags |= DTSF_REVERT_FAIL;


