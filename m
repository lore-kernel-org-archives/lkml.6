Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ECAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6F7205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6F7205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966720AbeFSPoh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:44:37 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53989 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964999AbeFSPof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:44:35 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MSTdP-1fcDsf2nmN-00TRzx; Tue, 19 Jun 2018 17:44:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] reiserfs: use monotonic time for j_trans_start_time
Date:   Tue, 19 Jun 2018 17:43:14 +0200
Message-Id: <20180619154343.3640484-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180619154343.3640484-1-arnd@arndb.de>
References: <20180619154343.3640484-1-arnd@arndb.de>
X-Provags-ID: V03:K1:+zzcWiLbZF4eRVpZBZyHbYgyWmydPM4yH5ASZxe+8CP6IHZpbT0
 OjdSxSrB4TTRhLYDaq2SXdQkHWx7IqhumAjSQOE0Vzyo5rUGOP3DLb9AUsZvZergDkvhDZO
 Cpmsx1VOy/OE358bWnIf7YJgltKG9rghWPP7H6NVb5H7KN9tuqBw/oyQqa9+3H8vdAk7Gpp
 a1Bcw+FBkMeoPqkXiSKqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U4Oi6eDsVqo=:9zQ2lRqPxqCn5HGFdwK2Ms
 uy9ico2jkgsIAhubCyoRWufPcMNq8CzkZzMeUfFymaduLPNW6s304gQppdUywlpFsPVyQWFpd
 CoRYlSgbqzrYp0az4Kpw7957nFfKPRgmE8bdu3g3+BgwhG/eiTyC8Z/0rTtjR1svNx2yyiJsk
 raiIY0HI3nf5t5Nqf8UKf1Bae613WawL4/Xb9cNuRRtAnhwdD9on7EHadIAEuV1M4hx9/P+oB
 HkqCVQEsSdZ2HpBxTknt9FSx0QJoF19vL5NeuDhYqcrItX2eOiGDsK86Ji8kIgW3fKBVAxhyr
 ok4VXlJoR5Zfg/NOn+J9k+SzOaLoYikCilB5qcq22NHNkmPkeuDmDIfWerrTFWARWxFTUKGer
 NKrTnyS0PNJFNBPggbY6KYJHVDnPN7hubI3TfBoGhj/aXpXkf0lMYSyFZAH1Jh/hC3zIwgL5H
 RGnwKykrXAJ5UJ3LOdYKgt/vXRqSYCs3HQelrjzHjRWxR81KaQwFhK3LSkI+EarEAJqUXIJ2G
 XNZcP5+LabY3kUpl10sHI4VDCd3h2XS3GrP6vZsDrApyGLDo/W6u62jWlyUfaTKBYNVJdG8fK
 LD/kCqeRWkoSNyha1AjW4WZdM/S4T9snNPSVv6SzQO8nRMadoFlimX2kSDooHQfDPiMuBOq/y
 3Bs+olLgJxwS7ivUqNvU5EdrK1gp5DqUaHzF1wTE2tlPKvQOrimYx/NsqfdX+oMDTiLM=
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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/reiserfs/journal.c  | 22 +++++++++++-----------
 fs/reiserfs/procfs.c   |  8 ++++++--
 fs/reiserfs/reiserfs.h |  2 +-
 3 files changed, 18 insertions(+), 14 deletions(-)

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
index e39b3910d24d..520f9003c13a 100644
--- a/fs/reiserfs/procfs.c
+++ b/fs/reiserfs/procfs.c
@@ -303,6 +303,10 @@ static int show_journal(struct seq_file *m, void *unused)
 	struct reiserfs_sb_info *r = REISERFS_SB(sb);
 	struct reiserfs_super_block *rs = r->s_rs;
 	struct journal_params *jp = &rs->s_v1.s_journal;
+	ktime_t j_trans_start_ktime = ktime_set(JF(j_trans_start_time), 0);
+
+	/* print as CLOCK_REALTIME */
+	j_trans_start_ktime = ktime_mono_to_real(j_trans_start_ktime);
 
 	seq_printf(m,		/* on-disk fields */
 		   "jp_journal_1st_block: \t%i\n"
@@ -325,7 +329,7 @@ static int show_journal(struct seq_file *m, void *unused)
 		   "j_bcount: \t%lu\n"
 		   "j_first_unflushed_offset: \t%lu\n"
 		   "j_last_flush_trans_id: \t%u\n"
-		   "j_trans_start_time: \t%li\n"
+		   "j_trans_start_time: \t%lli\n"
 		   "j_list_bitmap_index: \t%i\n"
 		   "j_must_wait: \t%i\n"
 		   "j_next_full_flush: \t%i\n"
@@ -366,7 +370,7 @@ static int show_journal(struct seq_file *m, void *unused)
 		   JF(j_bcount),
 		   JF(j_first_unflushed_offset),
 		   JF(j_last_flush_trans_id),
-		   JF(j_trans_start_time),
+		   ktime_divns(j_trans_start_ktime, NSEC_PER_SEC),
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

