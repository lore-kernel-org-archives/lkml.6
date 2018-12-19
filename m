Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B55BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111012184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbeLSMFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:05:07 -0500
Received: from www.osadl.org ([62.245.132.105]:37965 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbeLSMFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:05:07 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wBJC1gHi020816;
        Wed, 19 Dec 2018 13:01:42 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Steve French <sfrench@samba.org>
Cc:     Joe Perches <joe@perches.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] cifs: handle allocation failures early
Date:   Wed, 19 Dec 2018 12:58:17 +0100
Message-Id: <1545220697-29183-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc can return NULL so a check is needed. Further move the
allocation checks before the remaining initialization and bail
out without initialization if allocation failed returning NULL.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 3d4ef9a15343 ("smb3: fix redundant opens on root")
---

Missing kzalloc check located with an experimental coccinelle script

While at it make checkpatch happy by using *ret_buf->crfid.fid
rather than struct cifs_fid and use a more common style by returning
early on the first possible failure too so the block can be unindented.

Patch was compile tested with: x86_64_defconfig + CIFS=m
(with an unrelated smatch warnings and some pending cocci fixes)

Patch is against v4.20-rc7 (localversion-next is next-20181219)

 fs/cifs/misc.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 113980d..2d4b5fb 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -111,21 +111,26 @@ struct cifs_tcon *
 tconInfoAlloc(void)
 {
 	struct cifs_tcon *ret_buf;
-	ret_buf = kzalloc(sizeof(struct cifs_tcon), GFP_KERNEL);
-	if (ret_buf) {
-		atomic_inc(&tconInfoAllocCount);
-		ret_buf->tidStatus = CifsNew;
-		++ret_buf->tc_count;
-		INIT_LIST_HEAD(&ret_buf->openFileList);
-		INIT_LIST_HEAD(&ret_buf->tcon_list);
-		spin_lock_init(&ret_buf->open_file_lock);
-		mutex_init(&ret_buf->crfid.fid_mutex);
-		ret_buf->crfid.fid = kzalloc(sizeof(struct cifs_fid),
-					     GFP_KERNEL);
-		spin_lock_init(&ret_buf->stat_lock);
-		atomic_set(&ret_buf->num_local_opens, 0);
-		atomic_set(&ret_buf->num_remote_opens, 0);
+	ret_buf = kzalloc(sizeof(*ret_buf), GFP_KERNEL);
+	if (!ret_buf)
+		return NULL;
+	ret_buf->crfid.fid = kzalloc(sizeof(*ret_buf->crfid.fid), GFP_KERNEL);
+	if (!ret_buf->crfid.fid) {
+		kfree(ret_buf);
+		return NULL;
 	}
+
+	atomic_inc(&tconInfoAllocCount);
+	ret_buf->tidStatus = CifsNew;
+	++ret_buf->tc_count;
+	INIT_LIST_HEAD(&ret_buf->openFileList);
+	INIT_LIST_HEAD(&ret_buf->tcon_list);
+	spin_lock_init(&ret_buf->open_file_lock);
+	mutex_init(&ret_buf->crfid.fid_mutex);
+	spin_lock_init(&ret_buf->stat_lock);
+	atomic_set(&ret_buf->num_local_opens, 0);
+	atomic_set(&ret_buf->num_remote_opens, 0);
+
 	return ret_buf;
 }
 
-- 
2.1.4

