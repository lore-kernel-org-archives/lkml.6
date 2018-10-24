Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ECCC7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399C32082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399C32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeJXMEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:04:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbeJXMEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:04:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C6F281254;
        Wed, 24 Oct 2018 00:00:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B78DE76565;
        Wed, 24 Oct 2018 00:00:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 19/25] afs: Get the target vnode in afs_rmdir() and get a
 callback on it [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Oct 2018 01:00:04 +0100
Message-ID: <154033920486.12041.3074181015353053447.stgit@warthog.procyon.org.uk>
In-Reply-To: <154033906284.12041.12908874734066278152.stgit@warthog.procyon.org.uk>
References: <154033906284.12041.12908874734066278152.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 24 Oct 2018 00:00:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the target vnode in afs_rmdir() and validate it before we attempt the
deletion, The vnode pointer will be passed through to the delivery function
in a later patch so that the delivery function can mark it deleted.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 8936731c59ff..f2dd48d4363f 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1174,7 +1174,7 @@ static void afs_dir_remove_subdir(struct dentry *dentry)
 static int afs_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct afs_fs_cursor fc;
-	struct afs_vnode *dvnode = AFS_FS_I(dir);
+	struct afs_vnode *dvnode = AFS_FS_I(dir), *vnode = NULL;
 	struct key *key;
 	u64 data_version = dvnode->status.data_version;
 	int ret;
@@ -1188,6 +1188,14 @@ static int afs_rmdir(struct inode *dir, struct dentry *dentry)
 		goto error;
 	}
 
+	/* Try to make sure we have a callback promise on the victim. */
+	if (d_really_is_positive(dentry)) {
+		vnode = AFS_FS_I(d_inode(dentry));
+		ret = afs_validate(vnode, key);
+		if (ret < 0)
+			goto error_key;
+	}
+
 	ret = -ERESTARTSYS;
 	if (afs_begin_vnode_operation(&fc, dvnode, key)) {
 		while (afs_select_fileserver(&fc)) {
@@ -1206,6 +1214,7 @@ static int afs_rmdir(struct inode *dir, struct dentry *dentry)
 		}
 	}
 
+error_key:
 	key_put(key);
 error:
 	return ret;

