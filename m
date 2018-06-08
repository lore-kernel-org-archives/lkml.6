Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id k70PACzQGlsaEgAAmS7hNA
	; Fri, 08 Jun 2018 18:53:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7A1D2607DC; Fri,  8 Jun 2018 18:53:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 095686074D;
	Fri,  8 Jun 2018 18:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 095686074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753265AbeFHSxQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:53:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53798 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752691AbeFHSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:50:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRMSp-0006Nh-Td; Fri, 08 Jun 2018 18:50:19 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] pull fput() on late failures into path_openat()
Date: Fri,  8 Jun 2018 19:50:11 +0100
Message-Id: <20180608185019.24472-5-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
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
index b34ead1b8790..2abd00079b26 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3375,8 +3375,6 @@ static int do_last(struct nameidata *nd,
 	if (!error && will_truncate)
 		error = handle_truncate(file);
 out:
-	if (unlikely(error) && (*opened & FILE_OPENED))
-		fput(file);
 	if (unlikely(error > 0)) {
 		WARN_ON(1);
 		error = -EINVAL;
@@ -3454,8 +3452,6 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 	if (file->f_mode & FMODE_OPENED)
 		*opened |= FILE_OPENED;
 	error = open_check_o_direct(file);
-	if (error)
-		fput(file);
 out2:
 	mnt_drop_write(path.mnt);
 out:
@@ -3517,20 +3513,23 @@ static struct file *path_openat(struct nameidata *nd,
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
