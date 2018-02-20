Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x226VjitV9mOYRd1IZPjk4lScBnGNWe2NXvvdPtZqyPf0E0D1FdiWxdFpkRw6pCsnoP0U4ShF
ARC-Seal: i=1; a=rsa-sha256; t=1519093595; cv=none;
        d=google.com; s=arc-20160816;
        b=vSSlRK2tKelfMsTzw0KYmENRpabkDZIINzkF+kYi6fOy4NqE5p/hA69WjsoKAMn7Tu
         QNDm5uFxZLYOBuxcvDIhaH3t8OeywZou4N5BZYTTA86ApXy9OCsSSQ3WiH41B8kQBSsS
         QUQIGqCzKnYmafK5dCB0Y1qcMAGunRa60V4C+AEWXt1OKgNF5wGcFBWtX3gCIs5R44Mq
         GLjPZxhhoQs3SDnmyb+Cbw6TBR7Q3cRslOYmLghfCaGpFNAw296zoMizwHltCqxIxrPC
         6ClNoWoX18REk4MQC+x++tYr80/Uw88nQs+ALa0M7vi/h3CUd6HgmfyNRaEAPAno3RXd
         CCZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=oXrk9q9fH10cE0RjnJiprP1b4lqHwUEf7nsMUSA214s=;
        b=v6gos3xt5wUTx4PZB7rthCWziS+qPe7XV832FFDLTJtWbJX/+bqzMGYTvMXy3UtfUd
         bmOqyRiZv38QV6YroINk4NJN4QrULNEYU+g9IfvTVLQkY+htYY1EEHfZWp+OBZ77hv3y
         EJ6pmQsb46TDZQ4L/Ekcte/D4lWY1V2FC96bnYFrSwFT/useQe0zzeoUBHAS0G96+YjV
         g6guEQ0qeZntN6follKhT6Dthe2Z8BummEsQWEd1JzchGbL4rLWkuQkeTD5e/8nldoX7
         m9H4LNy6BAQxmPXeTJboQadfokBByaZBRXEOqeKf3/+irjCR6YyhbZkCPrvQzd3GaU7Y
         voiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>, James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 20 Feb 2018 13:23:38 +1100
Subject: [PATCH 19/21] staging: lustre: fid: fix up debugfs access to
 ->lcs_space
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151909341819.25814.15953004503314348403.stgit@noble>
In-Reply-To: <151909308778.25814.9912662268627044409.stgit@noble>
References: <151909308778.25814.9912662268627044409.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592885085229334200?=
X-GMAIL-MSGID: =?utf-8?q?1592885085229334200?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

lcs_space can change while the lock is not held
if an RPC in underway.  This can be detected by
seq->ls_update being set.

In this case, reading or writing the value should return
-EBUSY.

Also, the D_INFO CDEBUG() which reports the lcs_space being
updated never fires, as it tests the wrong value -
ldebugfs_fid_write_common() returns 'count' on success.

Finally, this return value should be returned from
ldebugfs_fid_space_seq_write(), rather than always returning 'count',
so that errors can be detected.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/fid/lproc_fid.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/lustre/lustre/fid/lproc_fid.c b/drivers/staging/lustre/lustre/fid/lproc_fid.c
index e05487662afd..a1e5bf9f36ec 100644
--- a/drivers/staging/lustre/lustre/fid/lproc_fid.c
+++ b/drivers/staging/lustre/lustre/fid/lproc_fid.c
@@ -106,28 +106,35 @@ ldebugfs_fid_space_seq_write(struct file *file,
 	rc = ldebugfs_fid_write_common(buffer, count, &range);
 
 	spin_lock(&seq->lcs_lock);
+	if (seq->lcs_update)
+		/* An RPC call is active to update lcs_space */
+		rc = -EBUSY;
 	if (rc > 0)
 		seq->lcs_space = range;
 	spin_unlock(&seq->lcs_lock);
 
-	if (rc == 0) {
+	if (rc > 0) {
 		CDEBUG(D_INFO, "%s: Space: " DRANGE "\n",
 		       seq->lcs_name, PRANGE(&range));
 	}
 
-	return count;
+	return rc;
 }
 
 static int
 ldebugfs_fid_space_seq_show(struct seq_file *m, void *unused)
 {
 	struct lu_client_seq *seq = (struct lu_client_seq *)m->private;
+	int rc = 0;
 
 	spin_lock(&seq->lcs_lock);
-	seq_printf(m, "[%#llx - %#llx]:%x:%s\n", PRANGE(&seq->lcs_space));
+	if (seq->lcs_update)
+		rc = -EBUSY;
+	else
+		seq_printf(m, "[%#llx - %#llx]:%x:%s\n", PRANGE(&seq->lcs_space));
 	spin_unlock(&seq->lcs_lock);
 
-	return 0;
+	return rc;
 }
 
 static ssize_t
