Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0C4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFB22089F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFB22089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbeKNJVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:21:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbeKNJVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:21:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B374C15552;
        Tue, 13 Nov 2018 23:20:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D55D4600D6;
        Tue, 13 Nov 2018 23:20:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/3] afs: Use d_instantiate() rather than d_add() and don't
 d_drop()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 13 Nov 2018 23:20:35 +0000
Message-ID: <154215123507.3727.11563040679486312490.stgit@warthog.procyon.org.uk>
In-Reply-To: <154215121391.3727.8471308154885635876.stgit@warthog.procyon.org.uk>
References: <154215121391.3727.8471308154885635876.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 13 Nov 2018 23:20:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use d_instantiate() rather than d_add() and don't d_drop() in
afs_vnode_new_inode().  The dentry shouldn't be removed as it's not
changing its name.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 43dea3b00c29..8a2562e3a316 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1075,8 +1075,6 @@ static void afs_vnode_new_inode(struct afs_fs_cursor *fc,
 	if (fc->ac.error < 0)
 		return;
 
-	d_drop(new_dentry);
-
 	inode = afs_iget(fc->vnode->vfs_inode.i_sb, fc->key,
 			 newfid, newstatus, newcb, fc->cbi);
 	if (IS_ERR(inode)) {
@@ -1090,7 +1088,7 @@ static void afs_vnode_new_inode(struct afs_fs_cursor *fc,
 	vnode = AFS_FS_I(inode);
 	set_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
 	afs_vnode_commit_status(fc, vnode, 0);
-	d_add(new_dentry, inode);
+	d_instantiate(new_dentry, inode);
 }
 
 /*

