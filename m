Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3FDC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B821204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B821204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeIGJ3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 05:29:46 -0400
Received: from nautica.notk.org ([91.121.71.147]:33650 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbeIGJ3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 05:29:46 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 39653C009; Fri,  7 Sep 2018 06:50:37 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Cc:     Dinu-Razvan Chis-Serban <justcsdr@gmail.com>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH] 9p locks: add mount option for lock retry interval
Date:   Fri,  7 Sep 2018 06:50:27 +0200
Message-Id: <1536295827-3181-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinu-Razvan Chis-Serban <justcsdr@gmail.com>

The default P9_LOCK_TIMEOUT can be too long for some users exporting
a local file system to a guest VM (30s), make this configurable at
mount time.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195727
Signed-off-by: Dinu-Razvan Chis-Serban <justcsdr@gmail.com>
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
---

This patch also has been in bugzilla for a bit over a year, and looks
fine to me.
I'll get it in linux-next around next week at the same time as the other
bz patch I sent recently after some testing, and will see with Razvan
(not sure how to call you in "short" version?) on how we fix comments
to it but can take are of that if required.

 fs/9p/v9fs.c     | 21 +++++++++++++++++++++
 fs/9p/v9fs.h     |  1 +
 fs/9p/vfs_file.c |  5 ++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 89bac3d2f05b..619128b55837 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -61,6 +61,8 @@ enum {
 	Opt_cache_loose, Opt_fscache, Opt_mmap,
 	/* Access options */
 	Opt_access, Opt_posixacl,
+	/* Lock timeout option */
+	Opt_locktimeout,
 	/* Error token */
 	Opt_err
 };
@@ -80,6 +82,7 @@ static const match_table_t tokens = {
 	{Opt_cachetag, "cachetag=%s"},
 	{Opt_access, "access=%s"},
 	{Opt_posixacl, "posixacl"},
+	{Opt_locktimeout, "locktimeout=%u"},
 	{Opt_err, NULL}
 };
 
@@ -187,6 +190,7 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 #ifdef CONFIG_9P_FSCACHE
 	v9ses->cachetag = NULL;
 #endif
+	v9ses->session_lock_timeout = P9_LOCK_TIMEOUT;
 
 	if (!opts)
 		return 0;
@@ -359,6 +363,23 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 #endif
 			break;
 
+		case Opt_locktimeout:
+			r = match_int(&args[0], &option);
+			if (r < 0) {
+				p9_debug(P9_DEBUG_ERROR,
+					 "integer field, but no integer?\n");
+				ret = r;
+				continue;
+			}
+			if (option < 1) {
+				p9_debug(P9_DEBUG_ERROR,
+					 "locktimeout must be a greater than zero integer.\n");
+				ret = -EINVAL;
+				continue;
+			}
+			v9ses->session_lock_timeout = (long)option * HZ;
+			break;
+
 		default:
 			continue;
 		}
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 982e017acadb..129e5243a6bf 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -116,6 +116,7 @@ struct v9fs_session_info {
 	struct p9_client *clnt;	/* 9p client */
 	struct list_head slist; /* list of sessions registered with v9fs */
 	struct rw_semaphore rename_sem;
+	long session_lock_timeout; /* retry interval for blocking locks */
 };
 
 /* cache_validity flags */
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 374bc1c72048..c608b98c0188 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -154,6 +154,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	uint8_t status = P9_LOCK_ERROR;
 	int res = 0;
 	unsigned char fl_type;
+	struct v9fs_session_info *v9ses;
 
 	fid = filp->private_data;
 	BUG_ON(fid == NULL);
@@ -189,6 +190,8 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	if (IS_SETLKW(cmd))
 		flock.flags = P9_LOCK_FLAGS_BLOCK;
 
+	v9ses = v9fs_inode2v9ses(file_inode(filp));
+
 	/*
 	 * if its a blocked request and we get P9_LOCK_BLOCKED as the status
 	 * for lock request, keep on trying
@@ -202,7 +205,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 			break;
 		if (status == P9_LOCK_BLOCKED && !IS_SETLKW(cmd))
 			break;
-		if (schedule_timeout_interruptible(P9_LOCK_TIMEOUT) != 0)
+		if (schedule_timeout_interruptible(v9ses->session_lock_timeout) != 0)
 			break;
 	}
 
-- 
2.17.1

