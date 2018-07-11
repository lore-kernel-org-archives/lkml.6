Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DACC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EC4208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EC4208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732900AbeGKC1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:27:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45568 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732383AbeGKCYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4lb-0003Iu-MR; Wed, 11 Jul 2018 02:22:07 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 15/42] lift fput() on late failures into path_openat()
Date:   Wed, 11 Jul 2018 03:21:39 +0100
Message-Id: <20180711022206.12571-15-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3d4e20a1c756..5a79bd170410 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3407,8 +3407,6 @@ static int do_last(struct nameidata *nd,
 	if (!error && will_truncate)
 		error = handle_truncate(file);
 out:
-	if (unlikely(error) && (*opened & FILE_OPENED))
-		fput(file);
 	if (unlikely(error > 0)) {
 		WARN_ON(1);
 		error = -EINVAL;
@@ -3484,8 +3482,6 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 	if (error)
 		goto out2;
 	error = open_check_o_direct(file);
-	if (error)
-		fput(file);
 out2:
 	mnt_drop_write(path.mnt);
 out:
@@ -3547,20 +3543,20 @@ static struct file *path_openat(struct nameidata *nd,
 	}
 	terminate_walk(nd);
 out2:
-	if (!(opened & FILE_OPENED)) {
-		BUG_ON(!error);
-		fput(file);
+	if (likely(!error)) {
+		if (likely(opened & FILE_OPENED))
+			return file;
+		WARN_ON(1);
+		error = -EINVAL;
 	}
-	if (unlikely(error)) {
-		if (error == -EOPENSTALE) {
-			if (flags & LOOKUP_RCU)
-				error = -ECHILD;
-			else
-				error = -ESTALE;
-		}
-		file = ERR_PTR(error);
+	fput(file);
+	if (error == -EOPENSTALE) {
+		if (flags & LOOKUP_RCU)
+			error = -ECHILD;
+		else
+			error = -ESTALE;
 	}
-	return file;
+	return ERR_PTR(error);
 }
 
 struct file *do_filp_open(int dfd, struct filename *pathname,
-- 
2.11.0

