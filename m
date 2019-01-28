Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A08C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C812175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="NtipgHkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbfA1RLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:11:45 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41059 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732306AbfA1RLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:11:42 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so13634129edc.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 09:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBfZXAU4d+bQna5+CfH1nfF9ZKEuBVSmCnVCcMfv/ac=;
        b=NtipgHkrU1iJVU+sPCrun9ThT6/TYAt2u6X/2xVmtYU9txThMc1MhhCFYYlOag/sZx
         6w2NzjEyaJg1HlJeYKCo78UFtx6nE6Cn5h5ZKhRAmm4o8Z/KniHzqdvr4KK/iu0dEJ4p
         TQH0eXLpuhCBaahjXt8X6wcU4NbWTyFF2AUFTb9D6k6eiBTL4JFPAf6zbhOVharFglso
         1S9Q6IQMNd05Rlczu0Diuuas0zQyCASeTMM8ONs9QaoCHfqUFWoHTfI5kz/06B827tub
         EPuuxoReLvTOBsL5iiwFHPAilPVQ1jtyAd5q2vK7SIumzy11+suqql6bgJcbk6M4Awz0
         qP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBfZXAU4d+bQna5+CfH1nfF9ZKEuBVSmCnVCcMfv/ac=;
        b=ET9n7HWsLAQ0+89eWTfMRawK9Srb/0z9NJYOZfWx6P+Nx1CrggodIX6CQBdhRt+F3e
         QzhZQQGHNzSUMZchZ6kzOL09hNqac4XgeU1ytC6v7Z4ZeU8ZhV6cDD8pwLRGNEhiMFQy
         Cg6Up2HkkdTtUwCTyOgHw2QlLhwIm0yTjNlsb+yIhgWDpAwT9s/BfeK+j6JeqE+sp7fV
         D4V9cy0nP2C9j2xuyAyKuqP6TNor5XoAnz+TbNmbnjEsIi8Kz6Id/lWVPgYGlFzEtydb
         r2JcsdYXDg8GMHgJbsyaOf6sfNpBB3IesJwkLvosT2JAsV7YLwOvjBipEG3owl2IPyEa
         cntA==
X-Gm-Message-State: AJcUukezlJCT64C99pCGxEFdFS/GEHaTH7Ig+rmRHMza9S0xM/4K7pdA
        VdDwYKPCbP1IrI5WUgdiTOFbEabHl5VXXA==
X-Google-Smtp-Source: ALg8bN4Y6sBEfjTNkzS4Rj/U1vtIpB0hmIgfDv7AUYPk5Q0odh2WJqTXxNocpT2ZrEMRZ8vtfZOX9g==
X-Received: by 2002:a05:6402:8d2:: with SMTP id d18mr22802354edz.119.1548695500372;
        Mon, 28 Jan 2019 09:11:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6bf:f9e4:2130:3a9e:3894:d6a6])
        by smtp.gmail.com with ESMTPSA id l51sm13989804edb.36.2019.01.28.09.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 09:11:39 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, ebiederm@xmission.com,
        ebiggers@google.com, willy@infradead.org, dhowells@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 1/2] devpts: remove unneeded inode_lock in mknod_ptmx
Date:   Mon, 28 Jan 2019 18:11:32 +0100
Message-Id: <20190128171133.539-1-christian@brauner.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Afaict, the mknod_ptmx() call is a no-op on subsequent calls and the first
call is done before we unlock the suberblock. If I'm not mistaken this is
exactly parallel to what Al pointed out for binderfs 29ef1c8e16a
("binderfs: drop lock in binderfs_binder_ctl_create"). In both filesystems
it should not be necessary to take inode_lock() in there. Let's remove it
and remove the goto.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
 fs/devpts/inode.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index c53814539070..8fa1492f9712 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -325,7 +325,6 @@ static int parse_mount_options(char *data, int op, struct pts_mount_opts *opts)
 static int mknod_ptmx(struct super_block *sb)
 {
 	int mode;
-	int rc = -ENOMEM;
 	struct dentry *dentry;
 	struct inode *inode;
 	struct dentry *root = sb->s_root;
@@ -334,18 +333,14 @@ static int mknod_ptmx(struct super_block *sb)
 	kuid_t ptmx_uid = current_fsuid();
 	kgid_t ptmx_gid = current_fsgid();
 
-	inode_lock(d_inode(root));
-
 	/* If we have already created ptmx node, return */
-	if (fsi->ptmx_dentry) {
-		rc = 0;
-		goto out;
-	}
+	if (fsi->ptmx_dentry)
+		return 0;
 
 	dentry = d_alloc_name(root, "ptmx");
 	if (!dentry) {
 		pr_err("Unable to alloc dentry for ptmx node\n");
-		goto out;
+		return -ENOMEM;
 	}
 
 	/*
@@ -355,7 +350,7 @@ static int mknod_ptmx(struct super_block *sb)
 	if (!inode) {
 		pr_err("Unable to alloc inode for ptmx node\n");
 		dput(dentry);
-		goto out;
+		return -ENOMEM;
 	}
 
 	inode->i_ino = 2;
@@ -369,10 +364,8 @@ static int mknod_ptmx(struct super_block *sb)
 	d_add(dentry, inode);
 
 	fsi->ptmx_dentry = dentry;
-	rc = 0;
-out:
-	inode_unlock(d_inode(root));
-	return rc;
+
+	return 0;
 }
 
 static void update_ptmx_mode(struct pts_fs_info *fsi)
-- 
2.20.1

