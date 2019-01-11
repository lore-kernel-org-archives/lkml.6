Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348C3C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF799206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217966;
	bh=8Hjs2BNd7XV9satEaGpNrDIhN2iN5zPfaY5P0HXZuLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hsOfB3lmeqnhRX+MHpfcrlVSmpAEt1bWnW3TEPw7tn6TpvmPuukvTccHnTmQFzgoO
	 en+7D1dqNAIPZYN2WG4w5pMLpo48pJrHoK6ek/PP09lOQ7Vn8wp3JCA61qjw84RE8I
	 QIiyeAqvyiAjs8blwkC0ZvbyFCzHtAyLeNykOteU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404410AbfAKOng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:43:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404026AbfAKOnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:43:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63069206B6;
        Fri, 11 Jan 2019 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217812;
        bh=8Hjs2BNd7XV9satEaGpNrDIhN2iN5zPfaY5P0HXZuLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WaAnBetfV/HAol0yvXR2VtdeM2pPGHtSgAtQTA8HOG45MdaszOst/CwsU0xVahlCp
         NZepks9hFagr4lwkG2qZolJSU3kcd/F33odj0nMCIQc6SlS8Tu1icLveBzy9iGFOwq
         bcRuOUTQhcDTxLgFfaQxnVFEQYDTH88DuKJwGokE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH 4.20 33/65] gfs2: Get rid of potential double-freeing in gfs2_create_inode
Date:   Fri, 11 Jan 2019 15:15:19 +0100
Message-Id: <20190111131100.894748678@linuxfoundation.org>
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
@@ -744,17 +744,19 @@ static int gfs2_create_inode(struct inod
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
@@ -789,10 +791,8 @@ fail_free_inode:
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


