Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3360DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E918F2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E918F2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeIREUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:20:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45008 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeIREUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:20:46 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C853CCAD;
        Mon, 17 Sep 2018 22:51:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@suse.de>, Paul Moore <paul@paul-moore.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 11/56] selinux: use GFP_NOWAIT in the AVC kmem_caches
Date:   Tue, 18 Sep 2018 00:41:44 +0200
Message-Id: <20180917213828.433882553@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917213827.913122591@linuxfoundation.org>
References: <20180917213827.913122591@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@kernel.org>

commit 476accbe2f6ef69caeebe99f52a286e12ac35aee upstream.

There is a strange __GFP_NOMEMALLOC usage pattern in SELinux,
specifically GFP_ATOMIC | __GFP_NOMEMALLOC which doesn't make much
sense.  GFP_ATOMIC on its own allows to access memory reserves while
__GFP_NOMEMALLOC dictates we cannot use memory reserves.  Replace this
with the much more sane GFP_NOWAIT in the AVC code as we can tolerate
memory allocation failures in that code.

Signed-off-by: Michal Hocko <mhocko@kernel.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/avc.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -348,27 +348,26 @@ static struct avc_xperms_decision_node
 	struct avc_xperms_decision_node *xpd_node;
 	struct extended_perms_decision *xpd;
 
-	xpd_node = kmem_cache_zalloc(avc_xperms_decision_cachep,
-				GFP_ATOMIC | __GFP_NOMEMALLOC);
+	xpd_node = kmem_cache_zalloc(avc_xperms_decision_cachep, GFP_NOWAIT);
 	if (!xpd_node)
 		return NULL;
 
 	xpd = &xpd_node->xpd;
 	if (which & XPERMS_ALLOWED) {
 		xpd->allowed = kmem_cache_zalloc(avc_xperms_data_cachep,
-						GFP_ATOMIC | __GFP_NOMEMALLOC);
+						GFP_NOWAIT);
 		if (!xpd->allowed)
 			goto error;
 	}
 	if (which & XPERMS_AUDITALLOW) {
 		xpd->auditallow = kmem_cache_zalloc(avc_xperms_data_cachep,
-						GFP_ATOMIC | __GFP_NOMEMALLOC);
+						GFP_NOWAIT);
 		if (!xpd->auditallow)
 			goto error;
 	}
 	if (which & XPERMS_DONTAUDIT) {
 		xpd->dontaudit = kmem_cache_zalloc(avc_xperms_data_cachep,
-						GFP_ATOMIC | __GFP_NOMEMALLOC);
+						GFP_NOWAIT);
 		if (!xpd->dontaudit)
 			goto error;
 	}
@@ -396,8 +395,7 @@ static struct avc_xperms_node *avc_xperm
 {
 	struct avc_xperms_node *xp_node;
 
-	xp_node = kmem_cache_zalloc(avc_xperms_cachep,
-				GFP_ATOMIC|__GFP_NOMEMALLOC);
+	xp_node = kmem_cache_zalloc(avc_xperms_cachep, GFP_NOWAIT);
 	if (!xp_node)
 		return xp_node;
 	INIT_LIST_HEAD(&xp_node->xpd_head);
@@ -550,7 +548,7 @@ static struct avc_node *avc_alloc_node(v
 {
 	struct avc_node *node;
 
-	node = kmem_cache_zalloc(avc_node_cachep, GFP_ATOMIC|__GFP_NOMEMALLOC);
+	node = kmem_cache_zalloc(avc_node_cachep, GFP_NOWAIT);
 	if (!node)
 		goto out;
 


