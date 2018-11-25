Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8AFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 00:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCA720892
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 00:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PnrFkwHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCA720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbeKYLFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 06:05:22 -0500
Received: from m12-13.163.com ([220.181.12.13]:35300 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbeKYLFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 06:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=V//pgdwWyIpBtkQ4QT
        0cmTEgA+uszkNlv1QKI8RdRew=; b=PnrFkwHJGXycyVw6X7cv7g9g0xCEgfvNvU
        BxiTiKykOd/aHCkOeW3xXOfg6mhqP1MlaRdTe+7867dvqH/J6tTFbtRau2bpI1LS
        3fYwWJTziOHmDBkeU1I4g1ssNzslkryHoHdIp/H59VkKaBAI0YtaMqw+NNp6Vq4N
        JWLrkeEWY=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp9 (Coremail) with SMTP id DcCowACXaiSq6flbotuuBg--.56571S3;
        Sun, 25 Nov 2018 08:15:40 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH V2] namei: free new_dentry late
Date:   Sun, 25 Nov 2018 08:15:23 +0800
Message-Id: <1543104923-81192-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DcCowACXaiSq6flbotuuBg--.56571S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw48Ar4DWFyxCw17tr1rtFb_yoWDZrg_Cr
        W0va1xuFW8Wrs7J3y3C3yYkF4Iga1rtrs3GFsYqFZrta98Kr98AF4kCwn3ZryxurWfG345
        Cr97try5AFya9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8dgA7UUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBzwwKclaD0ZreWwAAsg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After calling dput(new_dentry), new_dentry is passed to fsnotify_move.
This may result in a use-after-free bug. This patch moves the put
operation late.

Fixes: da1ce0670c14("vfs: add cross-rename")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
V2: correct the fixes commit information
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 0cab649..8b104d9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4498,7 +4498,6 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		unlock_two_nondirectories(source, target);
 	else if (target)
 		inode_unlock(target);
-	dput(new_dentry);
 	if (!error) {
 		fsnotify_move(old_dir, new_dir, old_name.name, is_dir,
 			      !(flags & RENAME_EXCHANGE) ? target : NULL, old_dentry);
@@ -4507,6 +4506,7 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 				      new_is_dir, NULL, new_dentry);
 		}
 	}
+	dput(new_dentry);
 	release_dentry_name_snapshot(&old_name);
 
 	return error;
-- 
2.7.4


