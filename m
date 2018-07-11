Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FA3C38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6C82146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RbcNPTfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6C82146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390459AbeGKVIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:08:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733024AbeGKVIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KQwMWMrlfhptUGUgG/1qH/mpQGgKQiKOF01kGmprnow=; b=RbcNPTfdCsiVDP9Jggb2HBgbi
        /XB+I6TUMW361TaJgCthxZnQm8CZNLY7x9iwAEAtoFyXO5CBFciv92nCWtQgqqsbRlQGiEd4mU8PU
        U4XNdVyLNF7EVNFI27Ud1WbIwyXCLDp3a2fG19TgjU7mT3foZnTDqSOApei3gCn3I290Cv+LpCH41
        X1uA9f74kVMBBnYIDRiOwNCW+BDPeqmJyT2cFK40uKkSZPDnefyIX/KOFzc9gOF5942J9GLSmugTk
        6dMy9+EMgaoIOqUhm/PaNH9bii1xYS3VZDoEGQwK6UJXr3Vvb7JxoVDvAeFDdH62kW0AFoHOuM+cm
        SxYhfvm3Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdMFq-0005AB-01; Wed, 11 Jul 2018 21:02:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/6] 9p: Change p9_fid_create calling convention
Date:   Wed, 11 Jul 2018 14:02:21 -0700
Message-Id: <20180711210225.19730-3-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180711210225.19730-1-willy@infradead.org>
References: <20180711210225.19730-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return NULL instead of ERR_PTR when we can't allocate a FID.  The ENOSPC
return value was getting all the way back to userspace, and that's
confusing for a userspace program which isn't expecting read() to tell it
there's no space left on the filesystem.  The best error we can return to
indicate a temporary failure caused by lack of client resources is ENOMEM.

Maybe it would be better to sleep until a FID is available, but that's
not a change I'm comfortable making.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 net/9p/client.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 999eceb8af98..389a2904b7b3 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -913,13 +913,11 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
 	p9_debug(P9_DEBUG_FID, "clnt %p\n", clnt);
 	fid = kmalloc(sizeof(struct p9_fid), GFP_KERNEL);
 	if (!fid)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	ret = p9_idpool_get(clnt->fidpool);
-	if (ret < 0) {
-		ret = -ENOSPC;
+	if (ret < 0)
 		goto error;
-	}
 	fid->fid = ret;
 
 	memset(&fid->qid, 0, sizeof(struct p9_qid));
@@ -935,7 +933,7 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
 
 error:
 	kfree(fid);
-	return ERR_PTR(ret);
+	return NULL;
 }
 
 static void p9_fid_destroy(struct p9_fid *fid)
@@ -1137,9 +1135,8 @@ struct p9_fid *p9_client_attach(struct p9_client *clnt, struct p9_fid *afid,
 	p9_debug(P9_DEBUG_9P, ">>> TATTACH afid %d uname %s aname %s\n",
 		 afid ? afid->fid : -1, uname, aname);
 	fid = p9_fid_create(clnt);
-	if (IS_ERR(fid)) {
-		err = PTR_ERR(fid);
-		fid = NULL;
+	if (!fid) {
+		err = -ENOMEM;
 		goto error;
 	}
 	fid->uid = n_uname;
@@ -1188,9 +1185,8 @@ struct p9_fid *p9_client_walk(struct p9_fid *oldfid, uint16_t nwname,
 	clnt = oldfid->clnt;
 	if (clone) {
 		fid = p9_fid_create(clnt);
-		if (IS_ERR(fid)) {
-			err = PTR_ERR(fid);
-			fid = NULL;
+		if (!fid) {
+			err = -ENOMEM;
 			goto error;
 		}
 
@@ -2018,9 +2014,8 @@ struct p9_fid *p9_client_xattrwalk(struct p9_fid *file_fid,
 	err = 0;
 	clnt = file_fid->clnt;
 	attr_fid = p9_fid_create(clnt);
-	if (IS_ERR(attr_fid)) {
-		err = PTR_ERR(attr_fid);
-		attr_fid = NULL;
+	if (!attr_fid) {
+		err = -ENOMEM;
 		goto error;
 	}
 	p9_debug(P9_DEBUG_9P,
-- 
2.18.0

