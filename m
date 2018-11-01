Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617A8C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E57820657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E57820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeKBGx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:53:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58258 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbeKBGx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:53:56 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1gIKpw-0008Jg-4i
        for linux-kernel@vger.kernel.org; Thu, 01 Nov 2018 21:49:08 +0000
Received: by mail-it1-f198.google.com with SMTP id w20-v6so429682itb.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WpsqCbr7w6G1e66H+z4zXCEMfE/WMPxAtYiui+F+0TQ=;
        b=dXQiRx5PJvlFiescLhmlj2QAIAugtmQBatPe2sMLtkOHdzfeeqM6CPtxJRxsgy5VdD
         30AJAJ+2QLahlAf1VhrSWDI5XoGIpN49gELrgGljt+vSvKLdHR3CovDLaetO/jaqwS3S
         Q4w/LX0jLZcZLH8RhVTYEJhzDINJkN5wI3mu8DuacSho7mrRDhyz7fqB+4TCV76HhHGm
         Fk3JvlYeemvgNUjTwZyKVeRkG9eja6vuAE9knFSUbEzle5QVfvm9tu28dAttkOEf5bEJ
         4j6HwvmWg79qZZaeyLbPlr6bvEuSos2ujp9ZenYYWGTWbuHRZFZYTSBNM0jnvnYmJBHK
         nRlQ==
X-Gm-Message-State: AGRZ1gLjhhlSZsYWq4kXsznAXPm6OBOc1+4egliz7/djdNlnPY9y5KO8
        meY2lUXWE0YVRTSdhwpmZqkP8lPz04GtmTjzEWmdsIvx+ZgW2xqIKOqPW2RhWysLL2j0aDk7F4a
        glJGq+oRVEMp5QtmiaNEdjNOPAOyBtXdW2JD0R/liOw==
X-Received: by 2002:a6b:abc5:: with SMTP id u188-v6mr6751447ioe.211.1541108946964;
        Thu, 01 Nov 2018 14:49:06 -0700 (PDT)
X-Google-Smtp-Source: AJdET5fjfZ7jrynE6AvGM6JEoWp141CvRE5cDt6y0xbNn7gwywf5aXDUTjg2PXVVig5KIofZ+e7igg==
X-Received: by 2002:a6b:abc5:: with SMTP id u188-v6mr6751433ioe.211.1541108946470;
        Thu, 01 Nov 2018 14:49:06 -0700 (PDT)
Received: from localhost ([2605:a601:ac7:2a20:7c8b:4047:a2ef:69cd])
        by smtp.gmail.com with ESMTPSA id x21-v6sm11574038ita.6.2018.11.01.14.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 14:49:05 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [RFC PATCH 3/6] shiftfs: copy inode attrs up from underlying fs
Date:   Thu,  1 Nov 2018 16:48:53 -0500
Message-Id: <20181101214856.4563-4-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101214856.4563-1-seth.forshee@canonical.com>
References: <20181101214856.4563-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all inode permission checks go through the permission
callback, e.g. some checks related to file capabilities. Always
copy up the inode attrs to ensure these checks work as expected.

Also introduce helpers helpers for shifting kernel ids from one
user ns to another, as this is an operation that is going to be
repeated.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 fs/shiftfs.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/shiftfs.c b/fs/shiftfs.c
index b179a1be7bc1..556594988dd2 100644
--- a/fs/shiftfs.c
+++ b/fs/shiftfs.c
@@ -266,6 +266,33 @@ static int shiftfs_xattr_set(const struct xattr_handler *handler,
 	return shiftfs_setxattr(dentry, inode, name, value, size, flags);
 }
 
+static kuid_t shift_kuid(struct user_namespace *from, struct user_namespace *to,
+			 kuid_t kuid)
+{
+	uid_t uid = from_kuid(from, kuid);
+	return make_kuid(to, uid);
+}
+
+static kgid_t shift_kgid(struct user_namespace *from, struct user_namespace *to,
+			 kgid_t kgid)
+{
+	gid_t gid = from_kgid(from, kgid);
+	return make_kgid(to, gid);
+}
+
+static void shiftfs_copyattr(struct inode *from, struct inode *to)
+{
+	struct user_namespace *from_ns = from->i_sb->s_user_ns;
+	struct user_namespace *to_ns = to->i_sb->s_user_ns;
+
+	to->i_uid = shift_kuid(from_ns, to_ns, from->i_uid);
+	to->i_gid = shift_kgid(from_ns, to_ns, from->i_gid);
+	to->i_mode = from->i_mode;
+	to->i_atime = from->i_atime;
+	to->i_mtime = from->i_mtime;
+	to->i_ctime = from->i_ctime;
+}
+
 static void shiftfs_fill_inode(struct inode *inode, struct dentry *dentry)
 {
 	struct inode *reali;
@@ -278,6 +305,7 @@ static void shiftfs_fill_inode(struct inode *inode, struct dentry *dentry)
 	if (!reali->i_op->get_link)
 		inode->i_opflags |= IOP_NOFOLLOW;
 
+	shiftfs_copyattr(reali, inode);
 	inode->i_mapping = reali->i_mapping;
 	inode->i_private = reali;
 	set_nlink(inode, reali->i_nlink);
@@ -573,7 +601,7 @@ static int shiftfs_setattr(struct dentry *dentry, struct iattr *attr)
 		return err;
 
 	/* all OK, reflect the change on our inode */
-	setattr_copy(d_inode(dentry), attr);
+	shiftfs_copyattr(reali, d_inode(dentry));
 	return 0;
 }
 
-- 
2.19.1

