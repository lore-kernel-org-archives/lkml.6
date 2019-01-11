Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAA9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBB720874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218766;
	bh=yIoDZR4h0aF2nxBoV4coHjPS8pFl2XiTUaMbnIHYcd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K57suZ1M9e40IE/BBTa/ypirkFnQP08nUUz2aSYIzH7wLly6lHt7ThZJT5ZaynRUE
	 Z4FDUkrFppbbm1C9kRdiMXiyHIKqZNPRYiUyuqzn8AmTrxd9dkzOXz9t57UY9u40p/
	 2OAJ24HcXOCfhizipfWz/cjNpCT2SWKhdfoHLC6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389730AbfAKOdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:33:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389280AbfAKOdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:33:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 159E0204EC;
        Fri, 11 Jan 2019 14:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217224;
        bh=yIoDZR4h0aF2nxBoV4coHjPS8pFl2XiTUaMbnIHYcd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2mTo9SRsfNe6h8F+jNdLDY8Ic1cZ7RnfIz2YvvPZX/QPSL8/sYK0jFBVOHKMG1cEM
         sEBgh0NUP7VE/ZoyJ1Edon7zL/XANumXrLwziRP0homfTarXaZgggvQrfRK6Tuu8Pl
         /HNvfSEOdmVgD+2j9SGx0CaoMVihkK/uvTnaxGlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH 4.14 088/105] gfs2: Get rid of potential double-freeing in gfs2_create_inode
Date:   Fri, 11 Jan 2019 15:14:59 +0100
Message-Id: <20190111131110.329078534@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

commit 6ff9b09e00a441599f3aacdf577254455a048bc9 upstream.

In gfs2_create_inode, after setting and releasing the acl / default_acl, the
acl / default_acl pointers are not set to NULL as they should be.  In that
state, when the function reaches label fail_free_acls, gfs2_create_inode will
try to release the same acls again.

Fix that by setting the pointers to NULL after releasing the acls.  Slightly
simplify the logic.  Also, posix_acl_release checks for NULL already, so
there is no need to duplicate those checks here.

Fixes: e01580bf9e4d ("gfs2: use generic posix ACL infrastructure")
Reported-by: Pan Bian <bianpan2016@163.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org # v4.9+
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/inode.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -743,17 +743,19 @@ static int gfs2_create_inode(struct inod
 			       the gfs2 structures. */
 	if (default_acl) {
 		error = __gfs2_set_acl(inode, default_acl, ACL_TYPE_DEFAULT);
+		if (error)
+			goto fail_gunlock3;
 		posix_acl_release(default_acl);
+		default_acl = NULL;
 	}
 	if (acl) {
-		if (!error)
-			error = __gfs2_set_acl(inode, acl, ACL_TYPE_ACCESS);
+		error = __gfs2_set_acl(inode, acl, ACL_TYPE_ACCESS);
+		if (error)
+			goto fail_gunlock3;
 		posix_acl_release(acl);
+		acl = NULL;
 	}
 
-	if (error)
-		goto fail_gunlock3;
-
 	error = security_inode_init_security(&ip->i_inode, &dip->i_inode, name,
 					     &gfs2_initxattrs, NULL);
 	if (error)
@@ -788,10 +790,8 @@ fail_free_inode:
 	}
 	gfs2_rsqa_delete(ip, NULL);
 fail_free_acls:
-	if (default_acl)
-		posix_acl_release(default_acl);
-	if (acl)
-		posix_acl_release(acl);
+	posix_acl_release(default_acl);
+	posix_acl_release(acl);
 fail_gunlock:
 	gfs2_dir_no_add(&da);
 	gfs2_glock_dq_uninit(ghs);


