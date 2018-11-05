Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FD0ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3192E20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3192E20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeKEKtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 05:49:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:60684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbeKEKtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 05:49:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 81970AFD9;
        Mon,  5 Nov 2018 01:32:16 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 05 Nov 2018 12:30:47 +1100
Subject: [PATCH 06/12] locks: use properly initialized file_lock when
 unlocking.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154138144784.31651.8715342652118090206.stgit@noble>
In-Reply-To: <154138128401.31651.1381177427603557514.stgit@noble>
References: <154138128401.31651.1381177427603557514.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both locks_remove_posix() and locks_remove_flock() use a
struct file_lock without calling locks_init_lock() on it.
This means the various list_heads are not initialized, which
will become a problem with a later patch.

So change them both to initialize properly.  For flock locks,
this involves using flock_make_lock(), and changing it to
allow a file_lock to be passed in, so memory allocation isn't
always needed.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/locks.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index b8f33792a0a6..ea999ce0e93c 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -418,15 +418,15 @@ static inline int flock_translate_cmd(int cmd) {
 
 /* Fill in a file_lock structure with an appropriate FLOCK lock. */
 static struct file_lock *
-flock_make_lock(struct file *filp, unsigned int cmd)
+flock_make_lock(struct file *filp, unsigned int cmd, struct file_lock *fl)
 {
-	struct file_lock *fl;
 	int type = flock_translate_cmd(cmd);
 
 	if (type < 0)
 		return ERR_PTR(type);
 	
-	fl = locks_alloc_lock();
+	if (fl == NULL)
+		fl = locks_alloc_lock();
 	if (fl == NULL)
 		return ERR_PTR(-ENOMEM);
 
@@ -2008,7 +2008,7 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 	    !(f.file->f_mode & (FMODE_READ|FMODE_WRITE)))
 		goto out_putf;
 
-	lock = flock_make_lock(f.file, cmd);
+	lock = flock_make_lock(f.file, cmd, NULL);
 	if (IS_ERR(lock)) {
 		error = PTR_ERR(lock);
 		goto out_putf;
@@ -2483,6 +2483,7 @@ void locks_remove_posix(struct file *filp, fl_owner_t owner)
 	if (!ctx || list_empty(&ctx->flc_posix))
 		return;
 
+	locks_init_lock(&lock);
 	lock.fl_type = F_UNLCK;
 	lock.fl_flags = FL_POSIX | FL_CLOSE;
 	lock.fl_start = 0;
@@ -2506,19 +2507,15 @@ EXPORT_SYMBOL(locks_remove_posix);
 static void
 locks_remove_flock(struct file *filp, struct file_lock_context *flctx)
 {
-	struct file_lock fl = {
-		.fl_owner = filp,
-		.fl_pid = current->tgid,
-		.fl_file = filp,
-		.fl_flags = FL_FLOCK | FL_CLOSE,
-		.fl_type = F_UNLCK,
-		.fl_end = OFFSET_MAX,
-	};
+	struct file_lock fl;
 	struct inode *inode = locks_inode(filp);
 
 	if (list_empty(&flctx->flc_flock))
 		return;
 
+	flock_make_lock(filp, LOCK_UN, &fl);
+	fl.fl_flags |= FL_CLOSE;
+
 	if (filp->f_op->flock)
 		filp->f_op->flock(filp, F_SETLKW, &fl);
 	else


