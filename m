Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92FCC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A032089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A032089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932704AbeGIFAM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:00:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38070 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754346AbeGIEyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:54:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fcOBm-0003em-8V; Mon, 09 Jul 2018 04:54:18 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 07/27] lift fput() on late failures into path_openat()
Date:   Mon,  9 Jul 2018 05:53:57 +0100
Message-Id: <20180709045417.13988-7-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
References: <20180709045320.GF30522@ZenIV.linux.org.uk>
 <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a58e00076ba1..36c2fa804e26 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3409,8 +3409,6 @@ static int do_last(struct nameidata *nd,
 	if (!error && will_truncate)
 		error = handle_truncate(file);
 out:
-	if (unlikely(error) && (*opened & FILE_OPENED))
-		fput(file);
 	if (unlikely(error > 0)) {
 		WARN_ON(1);
 		error = -EINVAL;
@@ -3488,8 +3486,6 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 	if (file->f_mode & FMODE_OPENED)
 		*opened |= FILE_OPENED;
 	error = open_check_o_direct(file);
-	if (error)
-		fput(file);
 out2:
 	mnt_drop_write(path.mnt);
 out:
@@ -3551,20 +3547,23 @@ static struct file *path_openat(struct nameidata *nd,
 	}
 	terminate_walk(nd);
 out2:
-	if (!(opened & FILE_OPENED)) {
-		BUG_ON(!error);
-		put_filp(file);
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
+	if (opened & FILE_OPENED)
+		fput(file);
+	else
+		put_filp(file);
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

