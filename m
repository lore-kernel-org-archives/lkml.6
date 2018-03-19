Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtrGOHniU0tiFqz1XHlEcWoZYM7xfwHpSKNCARiLJLFrdlxQvnSzSMS1Fz0qV03f9cvCyPm
ARC-Seal: i=1; a=rsa-sha256; t=1521482994; cv=none;
        d=google.com; s=arc-20160816;
        b=HiTWb6sC5lXODlvyQXdlXtBC9yFXWq/ZH5ZnL4T6WFD7JNa2VuEHtEJg0IjLoToyFo
         qS17vJjBQpizJ+Lcb5z1IA59ngPoUfPTGDodA8tVFDeEaiL/wUa/wuCiFAybCkZ28EJP
         UFridx6eJrS7X/FnoOfHUXVxubUioJlVxOrvc3fus+u4ckIdCcPcnwuAlxeOQWbIB0gt
         soMaEHARFaSalT6IFUsfvbgZBSEE2SezsPC3yKLE1TSzHykH+4esDK8lgWaG3ja2+EdH
         RjNpJsVroK/bUGfSL/0qnmRcg50lafrwn4Bt/LY5BsFz0yL8pnGiIVy3LiJY9T8lZwTG
         7hGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PvjVJLt5MXao/RbdLt0mzDSA2HDPl6a0ShXmMrAvRoc=;
        b=FPOp+8DIbpCGYhYvusJqlFKKCbMCKwpZLacBExe5+2/B4AffPSvLlCw8CDvSm49vdy
         c4zK+cdZSdKFq5sR6T3zO34ie5UI9fA3cf6WEOiPhSs8FBor4jvpKGYXVmV3qPTzfz4G
         IVatYSXhQBnmH4uzEiwjDOeNV68dtgPQ4y5DQB0F6oZsRavFhXHZSV4iIKY/nRhDnZ73
         csYCUm4qd/GS+GT/trqqxi05i+gpd3ea7ajJKdlewBzDGhE4vPUXk3JUXjwv28DjvIRE
         gJyHJTvJhDhzLFVBlHSDBzNQNQAobOdsiEGkF8zbSvpIUcHSxSrrHgTA+Wq6kHf3VvKn
         zlQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 28/68] reiserfs: Make cancel_old_flush() reliable
Date: Mon, 19 Mar 2018 19:06:06 +0100
Message-Id: <20180319171831.735736338@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390552017688761?=
X-GMAIL-MSGID: =?utf-8?q?1595390552017688761?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>


[ Upstream commit 71b0576bdb862e964a82c73327cdd1a249c53e67 ]

Currently canceling of delayed work that flushes old data using
cancel_old_flush() does not prevent work from being requeued. Thus
in theory new work can be queued after cancel_old_flush() from
reiserfs_freeze() has run. This will become larger problem once
flush_old_commits() can requeue the work itself.

Fix the problem by recording in sbi->work_queue that flushing work is
canceled and should not be requeued.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/reiserfs/journal.c  |    2 +-
 fs/reiserfs/reiserfs.h |    1 +
 fs/reiserfs/super.c    |   21 +++++++++++++++------
 3 files changed, 17 insertions(+), 7 deletions(-)

--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -1961,7 +1961,7 @@ static int do_journal_release(struct rei
 	 * will be requeued because superblock is being shutdown and doesn't
 	 * have MS_ACTIVE set.
 	 */
-	cancel_delayed_work_sync(&REISERFS_SB(sb)->old_work);
+	reiserfs_cancel_old_flush(sb);
 	/* wait for all commits to finish */
 	cancel_delayed_work_sync(&SB_JOURNAL(sb)->j_work);
 
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -2946,6 +2946,7 @@ int reiserfs_allocate_list_bitmaps(struc
 				   struct reiserfs_list_bitmap *, unsigned int);
 
 void reiserfs_schedule_old_flush(struct super_block *s);
+void reiserfs_cancel_old_flush(struct super_block *s);
 void add_save_link(struct reiserfs_transaction_handle *th,
 		   struct inode *inode, int truncate);
 int remove_save_link(struct inode *inode, int truncate);
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -89,7 +89,9 @@ static void flush_old_commits(struct wor
 	s = sbi->s_journal->j_work_sb;
 
 	spin_lock(&sbi->old_work_lock);
-	sbi->work_queued = 0;
+	/* Avoid clobbering the cancel state... */
+	if (sbi->work_queued == 1)
+		sbi->work_queued = 0;
 	spin_unlock(&sbi->old_work_lock);
 
 	reiserfs_sync_fs(s, 1);
@@ -116,21 +118,22 @@ void reiserfs_schedule_old_flush(struct
 	spin_unlock(&sbi->old_work_lock);
 }
 
-static void cancel_old_flush(struct super_block *s)
+void reiserfs_cancel_old_flush(struct super_block *s)
 {
 	struct reiserfs_sb_info *sbi = REISERFS_SB(s);
 
-	cancel_delayed_work_sync(&REISERFS_SB(s)->old_work);
 	spin_lock(&sbi->old_work_lock);
-	sbi->work_queued = 0;
+	/* Make sure no new flushes will be queued */
+	sbi->work_queued = 2;
 	spin_unlock(&sbi->old_work_lock);
+	cancel_delayed_work_sync(&REISERFS_SB(s)->old_work);
 }
 
 static int reiserfs_freeze(struct super_block *s)
 {
 	struct reiserfs_transaction_handle th;
 
-	cancel_old_flush(s);
+	reiserfs_cancel_old_flush(s);
 
 	reiserfs_write_lock(s);
 	if (!(s->s_flags & MS_RDONLY)) {
@@ -151,7 +154,13 @@ static int reiserfs_freeze(struct super_
 
 static int reiserfs_unfreeze(struct super_block *s)
 {
+	struct reiserfs_sb_info *sbi = REISERFS_SB(s);
+
 	reiserfs_allow_writes(s);
+	spin_lock(&sbi->old_work_lock);
+	/* Allow old_work to run again */
+	sbi->work_queued = 0;
+	spin_unlock(&sbi->old_work_lock);
 	return 0;
 }
 
@@ -2164,7 +2173,7 @@ error_unlocked:
 	if (sbi->commit_wq)
 		destroy_workqueue(sbi->commit_wq);
 
-	cancel_delayed_work_sync(&REISERFS_SB(s)->old_work);
+	reiserfs_cancel_old_flush(s);
 
 	reiserfs_free_bitmap_cache(s);
 	if (SB_BUFFER_WITH_SB(s))
