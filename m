Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D7121479
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahm7o644"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D7121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeKZVss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:48:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:57468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbeKZVsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:48:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E23D02089F;
        Mon, 26 Nov 2018 10:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229702;
        bh=/cXd9SuMZo2A2J9/FijOO86f+017b1kZUSOPTYddvrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahm7o644pg92MQuUEx+6yFNuW2OK7/973R4g5ZjkADhDlhQyi3Xw5qPBcwLG3QOqq
         7ABTNkPY/e7tGL8pyW2n/cNA1s3epTMporJvM7RvHcYDrZaPWkFr16NcMg2Rd8NWoK
         tiggtibC/lHLu5VrwjTjqyc6ay02xwsE21ZU9st8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Mahoney <jeffm@suse.com>,
        Eric Biggers <ebiggers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 38/70] reiserfs: propagate errors from fill_with_dentries() properly
Date:   Mon, 26 Nov 2018 11:50:53 +0100
Message-Id: <20181126105050.413575605@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
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
index 8b32fdaad468..d424b3d4bf3b 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -184,6 +184,7 @@ struct reiserfs_dentry_buf {
 	struct dir_context ctx;
 	struct dentry *xadir;
 	int count;
+	int err;
 	struct dentry *dentries[8];
 };
 
@@ -206,6 +207,7 @@ fill_with_dentries(struct dir_context *ctx, const char *name, int namelen,
 
 	dentry = lookup_one_len(name, dbuf->xadir, namelen);
 	if (IS_ERR(dentry)) {
+		dbuf->err = PTR_ERR(dentry);
 		return PTR_ERR(dentry);
 	} else if (d_really_is_negative(dentry)) {
 		/* A directory entry exists, but no file? */
@@ -214,6 +216,7 @@ fill_with_dentries(struct dir_context *ctx, const char *name, int namelen,
 			       "not found for file %pd.\n",
 			       dentry, dbuf->xadir);
 		dput(dentry);
+		dbuf->err = -EIO;
 		return -EIO;
 	}
 
@@ -261,6 +264,10 @@ static int reiserfs_for_each_xattr(struct inode *inode,
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



