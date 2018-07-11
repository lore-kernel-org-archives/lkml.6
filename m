Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DDEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0659208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0659208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbeGKCYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:24:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45732 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732601AbeGKCYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:08 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4lf-0003M4-NZ; Wed, 11 Jul 2018 02:22:11 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 41/42] allow link_path_walk() to take ERR_PTR()
Date:   Wed, 11 Jul 2018 03:22:05 +0100
Message-Id: <20180711022206.12571-41-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

There is a check for IS_ERR(name) immediately upstream of each call
of link_path_walk(name, nd), with positives treated as if link_path_walk()
failed with PTR_ERR(name).  Taking that check into link_path_walk() itself
simplifies things nicely.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a9a2a8ac8b9d..a55da43f169c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2028,6 +2028,8 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 {
 	int err;
 
+	if (IS_ERR(name))
+		return PTR_ERR(name);
 	while (*name=='/')
 		name++;
 	if (!*name)
@@ -2265,12 +2267,7 @@ static int path_lookupat(struct nameidata *nd, unsigned flags, struct path *path
 	const char *s = path_init(nd, flags);
 	int err;
 
-	if (IS_ERR(s)) {
-		terminate_walk(nd);
-		return PTR_ERR(s);
-	}
-
-	if (unlikely(flags & LOOKUP_DOWN)) {
+	if (unlikely(flags & LOOKUP_DOWN) && !IS_ERR(s)) {
 		err = handle_lookup_down(nd);
 		if (unlikely(err < 0)) {
 			terminate_walk(nd);
@@ -2281,10 +2278,6 @@ static int path_lookupat(struct nameidata *nd, unsigned flags, struct path *path
 	while (!(err = link_path_walk(s, nd))
 		&& ((err = lookup_last(nd)) > 0)) {
 		s = trailing_symlink(nd);
-		if (IS_ERR(s)) {
-			err = PTR_ERR(s);
-			break;
-		}
 	}
 	if (!err)
 		err = complete_walk(nd);
@@ -2331,12 +2324,7 @@ static int path_parentat(struct nameidata *nd, unsigned flags,
 				struct path *parent)
 {
 	const char *s = path_init(nd, flags);
-	int err;
-	if (IS_ERR(s)) {
-		terminate_walk(nd);
-		return PTR_ERR(s);
-	}
-	err = link_path_walk(s, nd);
+	int err = link_path_walk(s, nd);
 	if (!err)
 		err = complete_walk(nd);
 	if (!err) {
@@ -2663,17 +2651,10 @@ path_mountpoint(struct nameidata *nd, unsigned flags, struct path *path)
 {
 	const char *s = path_init(nd, flags);
 	int err;
-	if (IS_ERR(s)) {
-		terminate_walk(nd);
-		return PTR_ERR(s);
-	}
+
 	while (!(err = link_path_walk(s, nd)) &&
 		(err = mountpoint_last(nd)) > 0) {
 		s = trailing_symlink(nd);
-		if (IS_ERR(s)) {
-			err = PTR_ERR(s);
-			break;
-		}
 	}
 	if (!err) {
 		*path = nd->path;
@@ -3512,19 +3493,10 @@ static struct file *path_openat(struct nameidata *nd,
 	}
 
 	s = path_init(nd, flags);
-	if (IS_ERR(s)) {
-		terminate_walk(nd);
-		fput(file);
-		return ERR_CAST(s);
-	}
 	while (!(error = link_path_walk(s, nd)) &&
 		(error = do_last(nd, file, op)) > 0) {
 		nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
 		s = trailing_symlink(nd);
-		if (IS_ERR(s)) {
-			error = PTR_ERR(s);
-			break;
-		}
 	}
 	terminate_walk(nd);
 out2:
-- 
2.11.0

