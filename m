Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0C4C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F5427446
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rfws2Cln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F5427446
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966262AbeF1N2C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:28:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753784AbeF1N07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pKuPnBovgJ8+sywdr1QSI2Q8btKmadyyXncBiBb0Vtk=; b=rfws2ClnSSiSUXHWpu9Il866+
        dUtsxucdfVlowMEAvUPWjdH75w/uVdHFGagndPN9v4NPMC1mUtKcoV9+8HaCsf1ttAmzwru9NM+W/
        yO4MMdJrR/mJsD56PWvy7E+Wwq0MWI9zD3gFz97JpTPFEA9mqw36WGEo6+FFwPQ9hcsWd0bz8dJ5y
        +5//0DCbRsJE8hP+EZYwkZcd5l3Tju9OUp9I/T4bExkh7XI67QGzVMzMHpMfzd6EFPqiBIf4aIg2M
        /9RPIGiipfLTGHJYJ/rp9zFmVnLaRCF/7NIb+Zs/VZ17+s3D29SM6ePVnhLbYIeC561hjKno7Jlmm
        9Az7M6Rpg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYWws-0000rY-Aq; Thu, 28 Jun 2018 13:26:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/6] 9p: Change p9_fid_create calling convention
Date:   Thu, 28 Jun 2018 06:26:24 -0700
Message-Id: <20180628132629.3148-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628132629.3148-1-willy@infradead.org>
References: <20180628132629.3148-1-willy@infradead.org>
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
index 18c5271910dc..f8d58b0852fe 100644
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

