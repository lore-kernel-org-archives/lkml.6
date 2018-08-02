Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B571C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F322152E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vptbi5Fn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F322152E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeHBSZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:25:35 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:32995 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeHBSZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:25:35 -0400
Received: by mail-qt0-f202.google.com with SMTP id j11-v6so2058356qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 09:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=X7AMIZZW0YjhSSdo2dLShPBjsqNnTIu4wKGzXbNEGJo=;
        b=Vptbi5FnZjH0bFDH9BBAactA2UTxocRA0dQTo9Y04csNHUU6XZxM2ZAlyhZXZLTbwL
         oOd9NBXJUpfVHdzIZedPTYMpSljiruqqLwB4GK+198bDB5ewpZGVC8pJaDbLGyrm8rg4
         ohO7o3iH6KaayOGdqzpvth9rgc3T2Am7WGYbQ9OdE+EqjuDLNB7oRGrCYvF8hLBfXTtD
         dLvYBTy+ifywPwJAk6HZrzfQuu/D+tpoSDKjxKAtqYS5VcFzY0wZZ4k5mvqE9z7Adovi
         y/LJKrPHv7+F0a9Ycui4rqNqhupwfDruBoNEoBjxa7xOWYL2NfCr42qrf/xuW+rSCrnO
         /z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=X7AMIZZW0YjhSSdo2dLShPBjsqNnTIu4wKGzXbNEGJo=;
        b=T8S1rjiheKH2g+5Ov0DonU5z+Xuk6R8IqVNIT4fTaNs3ox+YCMvMv9hL2UXi+5br3T
         hCTiuTUsk85+hiZIVgzMqrVS01NQXc5wjYzsedZ7+EAFaujzontAhwBZzzISVDDpoye5
         7u17ThdnDG3q2ReDxNupccRzPsA/s3cajmA7x9EjHwG1bNEtiISKwyN7w/iL/gBQN9T5
         0GDQAiu1TXi58eGuS2vhx441ah9Vdiq0LA547bCO2l3OO3EfQPyDQ23SNZlFNLMEu/Me
         ChjVCyKiEFVRy4hYjCHiam7tBBpZdM620VQtXI2+7PE2WnBT9oOTj7BsiYMXNbZXJ2r+
         Xj6A==
X-Gm-Message-State: AOUpUlGQFnC85HKwdyywM+h52Vbw88BFQMp3OA1N88GpuNIDHqJT0gDK
        GKVa/aug/nCyLuf3jS14vviKYGTfEw==
X-Google-Smtp-Source: AAOMgpdVR9Amdxm9esytxBWw8JGWjXvW5xhRCIycf+YZGa5Y3y66p52/FKtyRv6nwcU8/6hWcQjyIko2/Q==
X-Received: by 2002:a0c:b488:: with SMTP id c8-v6mr1876587qve.19.1533227620933;
 Thu, 02 Aug 2018 09:33:40 -0700 (PDT)
Date:   Thu,  2 Aug 2018 18:33:35 +0200
Message-Id: <20180802163335.83312-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] reiserfs: propagate errors from fill_with_dentries properly
From:   Jann Horn <jannh@google.com>
To:     reiserfs-devel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        Eric Biggers <ebiggers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fill_with_dentries() failed to propagate errors up to
reiserfs_for_each_xattr() properly. Plumb them through.

Note that reiserfs_for_each_xattr() is only used by
reiserfs_delete_xattrs() and reiserfs_chown_xattrs().
The result of reiserfs_delete_xattrs() is discarded anyway, the only
difference there is whether a warning is printed to dmesg.
The result of reiserfs_chown_xattrs() does matter because it can block
chowning of the file to which the xattrs belong; but either way, the
resulting state can have misaligned ownership, so my patch doesn't improve
things greatly.

Credit for making me look at this code goes to Al Viro, who pointed
out that the ->actor calling convention is suboptimal and should be
changed.

Signed-off-by: Jann Horn <jannh@google.com>
---
I have tested this by manually patching error injection into
fill_with_dentries().

Opinions? Is this a sensible change?

Because the changes in this patch are more superficial than the changes
in the other one, I split this out so that the security patch is a
clean change that obviously belongs in stable and can hopefully go in
quickly.

After the cases I can see where errors are returned improperly are
cleaned up, I plan to change the calling convention for ->actor as
suggested by Al Viro.

 fs/reiserfs/xattr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index ff94fad477e4..ae4a28410dbd 100644
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
2.18.0.597.ga71716f1ad-goog

