Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5143C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D9820844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D9820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeIGVdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:33:05 -0400
Received: from nautica.notk.org ([91.121.71.147]:38100 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbeIGVdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:33:03 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 49F5CC01D; Fri,  7 Sep 2018 18:51:15 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 4/4] 9p locks: fix glock.client_id leak in do_lock
Date:   Fri,  7 Sep 2018 18:50:57 +0200
Message-Id: <1536339057-21974-5-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1536339057-21974-1-git-send-email-asmadeus@codewreck.org>
References: <1536339057-21974-1-git-send-email-asmadeus@codewreck.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

the 9p client code overwrites our glock.client_id pointing to a static
buffer by an allocated string holding the network provided value which
we do not care about; free and reset the value as appropriate.

This is almost identical to the leak in v9fs_file_getlock() fixed by
Al Viro in commit ce85dd58ad5a6 ("9p: we are leaking glock.client_id
in v9fs_file_getlock()"), which was returned as an error by a coverity
false positive -- while we are here attempt to make the code slightly
more robust to future change of the net/9p/client code and hopefully
more clear to coverity that there is no problem.

Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
---
 fs/9p/vfs_file.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 73857ebaedfb..a25efa782fcc 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -208,6 +208,14 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 		if (schedule_timeout_interruptible(v9ses->session_lock_timeout)
 				!= 0)
 			break;
+		/*
+		 * p9_client_lock_dotl overwrites flock.client_id with the
+		 * server message, free and reuse the client name
+		 */
+		if (flock.client_id != fid->clnt->name) {
+			kfree(flock.client_id);
+			flock.client_id = fid->clnt->name;
+		}
 	}
 
 	/* map 9p status to VFS status */
@@ -239,6 +247,8 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 		locks_lock_file_wait(filp, fl);
 		fl->fl_type = fl_type;
 	}
+	if (flock.client_id != fid->clnt->name)
+		kfree(flock.client_id);
 out:
 	return res;
 }
@@ -273,7 +283,7 @@ static int v9fs_file_getlock(struct file *filp, struct file_lock *fl)
 
 	res = p9_client_getlock_dotl(fid, &glock);
 	if (res < 0)
-		return res;
+		goto out;
 	/* map 9p lock type to os lock type */
 	switch (glock.type) {
 	case P9_LOCK_TYPE_RDLCK:
@@ -294,7 +304,9 @@ static int v9fs_file_getlock(struct file *filp, struct file_lock *fl)
 			fl->fl_end = glock.start + glock.length - 1;
 		fl->fl_pid = -glock.proc_id;
 	}
-	kfree(glock.client_id);
+out:
+	if (glock.client_id != fid->clnt->name)
+		kfree(glock.client_id);
 	return res;
 }
 
-- 
2.17.1

