Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x227NQZM9oI8putqbcxXetbnjKnsLDREYzLZhCgx+qqNhlAJCh5UfegC0jo2+AvSQTp/9+Ssf
ARC-Seal: i=1; a=rsa-sha256; t=1518479382; cv=none;
        d=google.com; s=arc-20160816;
        b=L4NEMLbG2Wu62qkmGjfYTnvI/VGeQFbyKY1WREpnr4R0FOmpmmtvX5Fjbk9kzjitVr
         tiqcyjpdc2Aqf6nKMsXhRR52fsTuiRQIVH/MNAfPsmjDj1aAVxiq+8U8bcG+87UAwM3v
         CjJdxv9RpyGMxDS6XXBYn6HdFfnoD2jsUP4Yg0Mp00S5UgFNSL8uggz+svO8EAl9xiUZ
         DmOLnS1SCbNOUcYxjq0FxA3GJWcy6Jwm+dj3uzc3HpQqBeX8N8kdsWbS+ePajMez6R49
         FuL2BFPresrgC/jnWbRAZjpeQb5B2ZowWrGNyhXV2+kFOZbobs9aAOE/hHsMIMwQDQ0d
         lIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=Kv97LvDSSMvgiuLDTy14SBsJpibsfv/e9CQKty1jCg8=;
        b=V+4+4/qCVvYr0x4uuHsezuF5uI5lmJ+uOq+E0Zh4y6AkwGNcHXQbWTkrOQXpX8AARe
         42r0c4f4Zq76Q2+MhpLo11+HQudLK7+o2P9swz0/2OOwnwTWWf5sZGTYWLwfgFaH/MnJ
         5+NXEtIzI49jqT1YHRb6tBUxysuEgrNNPFwlj9cf0A8bFSly6y9MZVP1PJqa6cj6XgIj
         nqYdtmh+ipncnC7VcDvMC9/JTwKuRealGlk7VvFCAnub59Sw9wCfe6qT8WbikVTSVYtN
         Yyxw/gbliuBElCJmfNaxAI/+cfWVqcURBxH/5ehXyaGNiWJfC85arWj/hBpFqGLkJrW0
         pgdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 13 Feb 2018 10:47:59 +1100
Subject: [PATCH 09/19] staging: lustre: open code polling loop instead of
 using l_wait_event()
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847927897.19840.8283814090245785502.stgit@noble>
In-Reply-To: <151847037709.22826.16175867257667686132.stgit@noble>
References: <151847037709.22826.16175867257667686132.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592241037181173129?=
X-GMAIL-MSGID: =?utf-8?q?1592241037181173129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Two places that LWI_TIMEOUT_INTERVAL() is used, the outcome is a
simple polling loop that polls every second for some event (with a
limit).

So write a simple loop to make this more apparent.

Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Patrick Farrell <paf@cray.com>
---
 drivers/staging/lustre/lustre/llite/llite_lib.c |   11 +++++------
 drivers/staging/lustre/lustre/lov/lov_request.c |   12 +++++-------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/llite_lib.c b/drivers/staging/lustre/lustre/llite/llite_lib.c
index ccb614bd7f53..9e96a8ee1783 100644
--- a/drivers/staging/lustre/lustre/llite/llite_lib.c
+++ b/drivers/staging/lustre/lustre/llite/llite_lib.c
@@ -1984,8 +1984,7 @@ void ll_umount_begin(struct super_block *sb)
 	struct ll_sb_info *sbi = ll_s2sbi(sb);
 	struct obd_device *obd;
 	struct obd_ioctl_data *ioc_data;
-	wait_queue_head_t waitq;
-	struct l_wait_info lwi;
+	int cnt = 0;
 
 	CDEBUG(D_VFSTRACE, "VFS Op: superblock %p count %d active %d\n", sb,
 	       sb->s_count, atomic_read(&sb->s_active));
@@ -2021,10 +2020,10 @@ void ll_umount_begin(struct super_block *sb)
 	 * and then continue. For now, we just periodically checking for vfs
 	 * to decrement mnt_cnt and hope to finish it within 10sec.
 	 */
-	init_waitqueue_head(&waitq);
-	lwi = LWI_TIMEOUT_INTERVAL(10 * HZ,
-				   HZ, NULL, NULL);
-	l_wait_event(waitq, may_umount(sbi->ll_mnt.mnt), &lwi);
+	while (cnt < 10 && !may_umount(sbi->ll_mnt.mnt)) {
+		schedule_timeout_uninterruptible(HZ);
+		cnt ++;
+	}
 
 	schedule();
 }
diff --git a/drivers/staging/lustre/lustre/lov/lov_request.c b/drivers/staging/lustre/lustre/lov/lov_request.c
index fb3b7a7fa32a..c1e58fcc30b3 100644
--- a/drivers/staging/lustre/lustre/lov/lov_request.c
+++ b/drivers/staging/lustre/lustre/lov/lov_request.c
@@ -99,8 +99,7 @@ static int lov_check_set(struct lov_obd *lov, int idx)
  */
 static int lov_check_and_wait_active(struct lov_obd *lov, int ost_idx)
 {
-	wait_queue_head_t waitq;
-	struct l_wait_info lwi;
+	int cnt = 0;
 	struct lov_tgt_desc *tgt;
 	int rc = 0;
 
@@ -125,11 +124,10 @@ static int lov_check_and_wait_active(struct lov_obd *lov, int ost_idx)
 
 	mutex_unlock(&lov->lov_lock);
 
-	init_waitqueue_head(&waitq);
-	lwi = LWI_TIMEOUT_INTERVAL(obd_timeout * HZ,
-				   HZ, NULL, NULL);
-
-	rc = l_wait_event(waitq, lov_check_set(lov, ost_idx), &lwi);
+	while (cnt < obd_timeout && !lov_check_set(lov, ost_idx)) {
+		schedule_timeout_uninterruptible(HZ);
+		cnt ++;
+	}
 	if (tgt->ltd_active)
 		return 1;
 
