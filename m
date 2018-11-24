Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8943C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 09:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92382204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 09:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OCAV3cyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92382204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbeKXUL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 15:11:27 -0500
Received: from m12-12.163.com ([220.181.12.12]:38408 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeKXUL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 15:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=mfAzntdli1b0HQ7bV8
        FT8wmaCJ4HtmXXBv8S0eD1ucI=; b=OCAV3cyPFG+w8lgIN+TwChuBwdtgnbMH0w
        jCzLiSKhflGpNr6NXkmpd+QCO0ZBKGDJ2QW/18WGHBLtvudVhXfJeIFPCCLHD5/l
        k/HSuObUZl4xrurDmW9bWUXuWxo10jXOS++i1d4KONdIuOnDguIV2Us3SHQo8n05
        GDTCZ6Z9U=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp8 (Coremail) with SMTP id DMCowAB3m3WMGPlbckPZBg--.51995S3;
        Sat, 24 Nov 2018 17:23:26 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] namei: free new_dentry late
Date:   Sat, 24 Nov 2018 17:23:24 +0800
Message-Id: <1543051404-42498-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMCowAB3m3WMGPlbckPZBg--.51995S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw48Ar4DWFyxCw1kZw1rXrb_yoWDXFb_Cr
        Wvvw4xuFW8Wrs7J3y3C3y5KF4IgF1rtrs7AFsYvFsrtay5Gry5Aan5Aw1fZryxurWfWw15
        Cr97try5CFy5tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU829aPUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBzwgJclaD0ZIEJQABsK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After calling dput(new_dentry), new_dentry is passed to fsnotify_move.
This may result in a use-after-free bug. This patch moves the put
operation late.

Fixes: 49d31c2f389a("dentry name snapshots")
Signed-off-by: Pan Bian <bianpan2016@163.com>
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


