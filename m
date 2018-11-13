Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6935C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC3222507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGkdZIYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC3222507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732597AbeKMPsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:48:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732578AbeKMPsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:48:30 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B7CB22510;
        Tue, 13 Nov 2018 05:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088322;
        bh=3LlgGimd2OCD3Msye+QS9EsoXHBQtAxsv4O7Aj2llvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGkdZIYbAvjI9TfgvEIhgK2adM7vKOUybJ7AYZ3JpQnzqpIbayCM+9EgADLkta8nF
         6ugIdSsHqrJ2RwUoszvhFiM11h+TfzLvpbQ84VOdCAOcOLW54RM8qjj2deAtqNUcP/
         I3F6eLao/jR4fECZwrD+iTnFLSg+LWlRTizGY1h0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Jeff Mahoney <jeffm@suse.com>,
        Eric Biggers <ebiggers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, reiserfs-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 09/26] reiserfs: propagate errors from fill_with_dentries() properly
Date:   Tue, 13 Nov 2018 00:51:33 -0500
Message-Id: <20181113055150.78773-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055150.78773-1-sashal@kernel.org>
References: <20181113055150.78773-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

[ Upstream commit b10298d56c9623f9b173f19959732d3184b35f4f ]

fill_with_dentries() failed to propagate errors up to
reiserfs_for_each_xattr() properly.  Plumb them through.

Note that reiserfs_for_each_xattr() is only used by
reiserfs_delete_xattrs() and reiserfs_chown_xattrs().  The result of
reiserfs_delete_xattrs() is discarded anyway, the only difference there is
whether a warning is printed to dmesg.  The result of
reiserfs_chown_xattrs() does matter because it can block chowning of the
file to which the xattrs belong; but either way, the resulting state can
have misaligned ownership, so my patch doesn't improve things greatly.

Credit for making me look at this code goes to Al Viro, who pointed out
that the ->actor calling convention is suboptimal and should be changed.

Link: http://lkml.kernel.org/r/20180802163335.83312-1-jannh@google.com
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Mahoney <jeffm@suse.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/reiserfs/xattr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 505f87a8c724..83423192588c 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -185,6 +185,7 @@ struct reiserfs_dentry_buf {
 	struct dir_context ctx;
 	struct dentry *xadir;
 	int count;
+	int err;
 	struct dentry *dentries[8];
 };
 
@@ -207,6 +208,7 @@ fill_with_dentries(struct dir_context *ctx, const char *name, int namelen,
 
 	dentry = lookup_one_len(name, dbuf->xadir, namelen);
 	if (IS_ERR(dentry)) {
+		dbuf->err = PTR_ERR(dentry);
 		return PTR_ERR(dentry);
 	} else if (d_really_is_negative(dentry)) {
 		/* A directory entry exists, but no file? */
@@ -215,6 +217,7 @@ fill_with_dentries(struct dir_context *ctx, const char *name, int namelen,
 			       "not found for file %pd.\n",
 			       dentry, dbuf->xadir);
 		dput(dentry);
+		dbuf->err = -EIO;
 		return -EIO;
 	}
 
@@ -262,6 +265,10 @@ static int reiserfs_for_each_xattr(struct inode *inode,
 		err = reiserfs_readdir_inode(d_inode(dir), &buf.ctx);
 		if (err)
 			break;
+		if (buf.err) {
+			err = buf.err;
+			break;
+		}
 		if (!buf.count)
 			break;
 		for (i = 0; !err && i < buf.count && buf.dentries[i]; i++) {
-- 
2.17.1

