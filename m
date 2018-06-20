Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EF9C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858EE20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858EE20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932149AbeFTOZw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:25:52 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53835 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeFTOZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:25:51 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.129]) with ESMTPA (Nemesis) id
 0ME24x-1fPrYS49Lb-00HONR; Wed, 20 Jun 2018 16:25:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] [v2] reiserfs: use monotonic time for j_trans_start_time
Date:   Wed, 20 Jun 2018 16:25:03 +0200
Message-Id: <20180620142522.27639-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180620142522.27639-1-arnd@arndb.de>
References: <20180620142522.27639-1-arnd@arndb.de>
X-Provags-ID: V03:K1:W1JUts3BL3F5UNzhQ36vvXL2GrsEwYC9oioYyls/7/VWnkCmW7m
 +hKVB8Dmpm6x/+bx445hoiEPYS3eaYFyoQ7k70/mXv0ESJl7fTHUf/1DgaupZwcqTDchHvf
 IeFZ8cUAKATiAUy6YPcXTkr93pGuHci1Jk5DFwbzrYUoHQal0LZOmJZEOPn4hKohYmhJYh5
 qy0FyQrR7CZ77Led6rHuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aoCcdoAY2oY=:TNIURq/auzo3sOEDfRTHYO
 Q+ApU3MqQ04l7aoAYax2yu0iGRDfYLiyK/ogo0rWVVul6H6hp5W2A2w5PIRBMhIcFonUuL4sj
 Gqq73PpGeR1lk4s8mw6Zh9+XrUprVQV3ZpIIuVVajzk5WGjTvu5g7G5vuwnRDuTch19l9yWiN
 poqf0Os2TyCiVRh/qduuk9X5Sgt36PTr/b8HowW6Dt1JmjREhGDuQOsJAA8P6JMi5LPHTYjnY
 TZXHUD+j5D05ojcWQW5Zy3Da1COyxc5DQQhUm+tuZ/p3tlIjxs+UQDVxqeC+UvGr9UcTpoaqN
 MpzzpSJ5TuWzNrwYgcRf1+ZmKZeDUHZ4QNeqrBN4pJbGBZrxm6IGuF+QtTmE2RnJ2RSComIvB
 DT4hdzS43QbXTuNVumaLRlih9yljAXtcWivicKX0oWWRP0VdCgBXM6RtSesyDNIJpHJaW+4eq
 5lBKWzlWeZMfb8VZg4Z1qhpw+ddVyRYEVNQXlAmZSRd/vp9WqKDpRPlGQM+eJ7YL5zzmzl6vK
 KrQezjwPRA6xnKcEbNAGT5MSkXt3sSNNQ0/bc9uleN/COogVmzLBVHmxpa8M4VVRu+4s2YU32
 irsxOr0OqWQxd9qRYQFejyjrpWPgt3vjMIjpIWAwTBp4CH0kK3ROX9oV6IvXUgDVfsQMahwxJ
 QMrzvS7Y6lgR/uXHYTLd/JolHwSznc5Vn61fDCvGaSlWdpTOHI0IL6NLuU9LTFWk9Hf8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using CLOCK_REALTIME time_t timestamps breaks on 32-bit systems
in 2038, and gives surprising results with a concurrent settimeofday().

This changes the reiserfs journal timestamps to use ktime_get_seconds()
instead, which makes it use a 64-bit CLOCK_MONOTONIC stamp.

In the procfs output, the monotonic timestamp needs to be converted
back to CLOCK_REALTIME to keep the existing ABI.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: I split out the conversion from monotonic to real time into
    a separate function for readability, though I decided against
    making it a global function. I looked at almost all uses of
    CLOCK_REALTIME in the kernel several times and don't remember
    any other file that would benefit from making it a generic
    helper, and it can be slightly inaccurate because of the double
    rounding.
---
 fs/reiserfs/journal.c  | 22 +++++++++++-----------
 fs/reiserfs/procfs.c   | 11 +++++++++--
 fs/reiserfs/reiserfs.h |  2 +-
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 1e7f733b2a12..e809da912c00 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2381,7 +2381,7 @@ static int journal_read(struct super_block *sb)
 	struct reiserfs_journal_desc *desc;
 	unsigned int oldest_trans_id = 0;
 	unsigned int oldest_invalid_trans_id = 0;
-	time_t start;
+	time64_t start;
 	unsigned long oldest_start = 0;
 	unsigned long cur_dblock = 0;
 	unsigned long newest_mount_id = 9;
@@ -2395,7 +2395,7 @@ static int journal_read(struct super_block *sb)
 	cur_dblock = SB_ONDISK_JOURNAL_1st_BLOCK(sb);
 	reiserfs_info(sb, "checking transaction log (%pg)\n",
 		      journal->j_dev_bd);
-	start = get_seconds();
+	start = ktime_get_seconds();
 
 	/*
 	 * step 1, read in the journal header block.  Check the transaction
@@ -2556,7 +2556,7 @@ static int journal_read(struct super_block *sb)
 	if (replay_count > 0) {
 		reiserfs_info(sb,
 			      "replayed %d transactions in %lu seconds\n",
-			      replay_count, get_seconds() - start);
+			      replay_count, ktime_get_seconds() - start);
 	}
 	/* needed to satisfy the locking in _update_journal_header_block */
 	reiserfs_write_lock(sb);
@@ -2914,7 +2914,7 @@ int journal_transaction_should_end(struct reiserfs_transaction_handle *th,
 				   int new_alloc)
 {
 	struct reiserfs_journal *journal = SB_JOURNAL(th->t_super);
-	time_t now = get_seconds();
+	time64_t now = ktime_get_seconds();
 	/* cannot restart while nested */
 	BUG_ON(!th->t_trans_id);
 	if (th->t_refcount > 1)
@@ -3023,7 +3023,7 @@ static int do_journal_begin_r(struct reiserfs_transaction_handle *th,
 			      struct super_block *sb, unsigned long nblocks,
 			      int join)
 {
-	time_t now = get_seconds();
+	time64_t now = ktime_get_seconds();
 	unsigned int old_trans_id;
 	struct reiserfs_journal *journal = SB_JOURNAL(sb);
 	struct reiserfs_transaction_handle myth;
@@ -3056,7 +3056,7 @@ static int do_journal_begin_r(struct reiserfs_transaction_handle *th,
 		PROC_INFO_INC(sb, journal.journal_relock_writers);
 		goto relock;
 	}
-	now = get_seconds();
+	now = ktime_get_seconds();
 
 	/*
 	 * if there is no room in the journal OR
@@ -3119,7 +3119,7 @@ static int do_journal_begin_r(struct reiserfs_transaction_handle *th,
 	}
 	/* we are the first writer, set trans_id */
 	if (journal->j_trans_start_time == 0) {
-		journal->j_trans_start_time = get_seconds();
+		journal->j_trans_start_time = ktime_get_seconds();
 	}
 	atomic_inc(&journal->j_wcount);
 	journal->j_len_alloc += nblocks;
@@ -3559,11 +3559,11 @@ static void flush_async_commits(struct work_struct *work)
  */
 void reiserfs_flush_old_commits(struct super_block *sb)
 {
-	time_t now;
+	time64_t now;
 	struct reiserfs_transaction_handle th;
 	struct reiserfs_journal *journal = SB_JOURNAL(sb);
 
-	now = get_seconds();
+	now = ktime_get_seconds();
 	/*
 	 * safety check so we don't flush while we are replaying the log during
 	 * mount
@@ -3613,7 +3613,7 @@ void reiserfs_flush_old_commits(struct super_block *sb)
 static int check_journal_end(struct reiserfs_transaction_handle *th, int flags)
 {
 
-	time_t now;
+	time64_t now;
 	int flush = flags & FLUSH_ALL;
 	int commit_now = flags & COMMIT_NOW;
 	int wait_on_commit = flags & WAIT;
@@ -3694,7 +3694,7 @@ static int check_journal_end(struct reiserfs_transaction_handle *th, int flags)
 	}
 
 	/* deal with old transactions where we are the last writers */
-	now = get_seconds();
+	now = ktime_get_seconds();
 	if ((now - journal->j_trans_start_time) > journal->j_max_trans_age) {
 		commit_now = 1;
 		journal->j_next_async_flush = 1;
diff --git a/fs/reiserfs/procfs.c b/fs/reiserfs/procfs.c
index e39b3910d24d..f2cf3441fdfc 100644
--- a/fs/reiserfs/procfs.c
+++ b/fs/reiserfs/procfs.c
@@ -297,6 +297,13 @@ static int show_oidmap(struct seq_file *m, void *unused)
 	return 0;
 }
 
+static time64_t ktime_mono_to_real_seconds(time64_t mono)
+{
+	ktime_t kt = ktime_set(mono, NSEC_PER_SEC/2);
+
+	return ktime_divns(ktime_mono_to_real(kt), NSEC_PER_SEC);
+}
+
 static int show_journal(struct seq_file *m, void *unused)
 {
 	struct super_block *sb = m->private;
@@ -325,7 +332,7 @@ static int show_journal(struct seq_file *m, void *unused)
 		   "j_bcount: \t%lu\n"
 		   "j_first_unflushed_offset: \t%lu\n"
 		   "j_last_flush_trans_id: \t%u\n"
-		   "j_trans_start_time: \t%li\n"
+		   "j_trans_start_time: \t%lli\n"
 		   "j_list_bitmap_index: \t%i\n"
 		   "j_must_wait: \t%i\n"
 		   "j_next_full_flush: \t%i\n"
@@ -366,7 +373,7 @@ static int show_journal(struct seq_file *m, void *unused)
 		   JF(j_bcount),
 		   JF(j_first_unflushed_offset),
 		   JF(j_last_flush_trans_id),
-		   JF(j_trans_start_time),
+		   ktime_mono_to_real_seconds(JF(j_trans_start_time)),
 		   JF(j_list_bitmap_index),
 		   JF(j_must_wait),
 		   JF(j_next_full_flush),
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 1536ebbaf6ab..d0fc829bd760 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -330,7 +330,7 @@ struct reiserfs_journal {
 
 	struct buffer_head *j_header_bh;
 
-	time_t j_trans_start_time;	/* time this transaction started */
+	time64_t j_trans_start_time;	/* time this transaction started */
 	struct mutex j_mutex;
 	struct mutex j_flush_mutex;
 
-- 
2.9.0

