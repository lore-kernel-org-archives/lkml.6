Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F88FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6602021473
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2H+9RluU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6602021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeKZVq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:46:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbeKZVq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:46:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C0D12146F;
        Mon, 26 Nov 2018 10:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229561;
        bh=ytR9c0w9hAITEcgg4r/QTdeQDk7R5BBo8XGwODChzwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2H+9RluUb82dJ62tC3PB/YKrh3I0lY7ROF2HrVGzm7z2yNumQyTgdo1NrSK7dQsOU
         dCj5O4ZiJZoeVdaDMte3R4uyE7DSAl4Koj1Dkk45xY0aoTkpbzOBdox4rLHlOm0VAt
         tIvbTpW2OXvdj9hjGH8U1M07Lj6qiN8RV2uO3Fxk=
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
Subject: [PATCH 3.18 02/24] reiserfs: propagate errors from fill_with_dentries() properly
Date:   Mon, 26 Nov 2018 11:50:56 +0100
Message-Id: <20181126105030.173063041@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105029.790599475@linuxfoundation.org>
References: <20181126105029.790599475@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
index 59b29acb6419..0ec755043174 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -184,6 +184,7 @@ struct reiserfs_dentry_buf {
 	struct dir_context ctx;
 	struct dentry *xadir;
 	int count;
+	int err;
 	struct dentry *dentries[8];
 };
 
@@ -205,6 +206,7 @@ fill_with_dentries(void *buf, const char *name, int namelen, loff_t offset,
 
 	dentry = lookup_one_len(name, dbuf->xadir, namelen);
 	if (IS_ERR(dentry)) {
+		dbuf->err = PTR_ERR(dentry);
 		return PTR_ERR(dentry);
 	} else if (!dentry->d_inode) {
 		/* A directory entry exists, but no file? */
@@ -213,6 +215,7 @@ fill_with_dentries(void *buf, const char *name, int namelen, loff_t offset,
 			       "not found for file %s.\n",
 			       dentry->d_name.name, dbuf->xadir->d_name.name);
 		dput(dentry);
+		dbuf->err = -EIO;
 		return -EIO;
 	}
 
@@ -260,6 +263,10 @@ static int reiserfs_for_each_xattr(struct inode *inode,
 		err = reiserfs_readdir_inode(dir->d_inode, &buf.ctx);
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



