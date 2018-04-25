Return-Path: <opensource.ganesh@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524653991; cv=none;
        d=google.com; s=arc-20160816;
        b=iRFgsp42QlQv5rC8q13I8QyZjVxfMvis6uE9/J2VYywWi2Ryc1tnpZPksncawhc/nd
         q0znYbTL5c7n+uY1IvLCrJdtqdNaOD227ysaEvGmXMOY3vV2opD4F7F/8SglJhy2FTTf
         eohvyoizZUjxx0azmkkAcvJohQYtUkTsauPowM4/xZtlFRCziOAM5MPTxPp/6oWt7ZW5
         e7/Wzk1fI5V8QFlaJTvplq9OPixKTnzA1fh05zXYx0LwQSjgbsraJi8GhSpxQwSUhF/n
         2d1iBzwMFC/6rtgHJn63jDsFypigwOdsuYz1wGQPcu72PAruz47fJTpYd4Pk4TlKSLnM
         t7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=+YSK0If6uDJ4RXABIIMZbZ61AcmWkpQ4NLM5aaDPbFk=;
        b=xS71/NyC7fGQh3qwnoGYCtBnR/Nfjevr3jfzEIKm3R1AaFZtWK/+QWa47H8C0mKKc9
         2zHjxQ2TMWKQN8UVJI1RxAEUl86dY355XO//gByetOjEndQJexAmL3SWcgmELhGap6Wz
         KbWtzUOg1JWnDQKJorCIba6q/t2ySe2IUhF3fNUZugHhMiRmecYav51daJC2altfc4Sz
         DFFRt3daFEkvmb514mlAYpo0PLwWOOeLJZx4F1fXsyZlZMrFmb5gHKRu3pNK9/9OoFGX
         yN1HRHVDrFjo1AlttJZ/mT4xrj2LR3Pa6Zr7luDf1p2lrkVqiGTDinBGQ2v1WDYhbPt4
         iI2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TWKjFWeZ;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TWKjFWeZ;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49NtScbSQCWoJGXX6lC2mJPHoBae8HaJ9GxOMJjry7zy/kbOILTxfHYLsokJEMqtt5cZJj21w==
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
To: rjw@rjwysocki.net,
	pavel@ucw.cz,
	len.brown@intel.com,
	rafael@kernel.org,
	gregkh@linuxfoundation.org,
	geert@linux-m68k.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ganesh Mahendran <opensource.ganesh@gmail.com>
Subject: [PATCH v3] PM / wakeup: use seq_open() to show wakeup stats
Date: Wed, 25 Apr 2018 18:59:31 +0800
Message-Id: <1524653971-10425-1-git-send-email-opensource.ganesh@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598715584055641513?=
X-GMAIL-MSGID: =?utf-8?q?1598715584055641513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

single_open() interface requires that the whole output must
fit into a single buffer. This will lead to timeout when
system memory is not in a good situation.

This patch use seq_open() to show wakeup stats. This method
need only one page, so timeout will not be observed.

Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
----
v3: simplify wakeup_sources_stats_seq_start
v2: use srcu_read_lock instead of rcu_read_lock
---
 drivers/base/power/wakeup.c | 75 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 16 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index ea01621..5872705 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1029,32 +1029,75 @@ static int print_wakeup_source_stats(struct seq_file *m,
 	return 0;
 }
 
-/**
- * wakeup_sources_stats_show - Print wakeup sources statistics information.
- * @m: seq_file to print the statistics into.
- */
-static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
+static void *wakeup_sources_stats_seq_start(struct seq_file *m,
+					loff_t *pos)
 {
 	struct wakeup_source *ws;
-	int srcuidx;
+	loff_t n = *pos;
+	int *srcuidx = m->private;
 
-	seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
-		"expire_count\tactive_since\ttotal_time\tmax_time\t"
-		"last_change\tprevent_suspend_time\n");
+	if (n == 0) {
+		seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
+			"expire_count\tactive_since\ttotal_time\tmax_time\t"
+			"last_change\tprevent_suspend_time\n");
+	}
 
-	srcuidx = srcu_read_lock(&wakeup_srcu);
-	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
-		print_wakeup_source_stats(m, ws);
-	srcu_read_unlock(&wakeup_srcu, srcuidx);
+	*srcuidx = srcu_read_lock(&wakeup_srcu);
+	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
+		if (n-- <= 0)
+			return ws;
+	}
+
+	return NULL;
+}
+
+static void *wakeup_sources_stats_seq_next(struct seq_file *m,
+					void *v, loff_t *pos)
+{
+	struct wakeup_source *ws = v;
+	struct wakeup_source *next_ws = NULL;
+
+	++(*pos);
 
-	print_wakeup_source_stats(m, &deleted_ws);
+	list_for_each_entry_continue_rcu(ws, &wakeup_sources, entry) {
+		next_ws = ws;
+		break;
+	}
+
+	return next_ws;
+}
+
+static void wakeup_sources_stats_seq_stop(struct seq_file *m, void *v)
+{
+	int *srcuidx = m->private;
+
+	srcu_read_unlock(&wakeup_srcu, *srcuidx);
+}
+
+/**
+ * wakeup_sources_stats_seq_show - Print wakeup sources statistics information.
+ * @m: seq_file to print the statistics into.
+ * @v: wakeup_source of each iteration
+ */
+static int wakeup_sources_stats_seq_show(struct seq_file *m, void *v)
+{
+	struct wakeup_source *ws = v;
+
+	print_wakeup_source_stats(m, ws);
 
 	return 0;
 }
 
+static const struct seq_operations wakeup_sources_stats_seq_ops = {
+	.start = wakeup_sources_stats_seq_start,
+	.next  = wakeup_sources_stats_seq_next,
+	.stop  = wakeup_sources_stats_seq_stop,
+	.show  = wakeup_sources_stats_seq_show,
+};
+
 static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, wakeup_sources_stats_show, NULL);
+	return seq_open_private(file, &wakeup_sources_stats_seq_ops, sizeof(int));
 }
 
 static const struct file_operations wakeup_sources_stats_fops = {
@@ -1062,7 +1105,7 @@ static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
 	.open = wakeup_sources_stats_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = single_release,
+	.release = seq_release_private,
 };
 
 static int __init wakeup_sources_debugfs_init(void)
-- 
1.9.1
