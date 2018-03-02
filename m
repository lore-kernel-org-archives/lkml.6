Return-Path: <opensource.ganesh@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519966872; cv=none;
        d=google.com; s=arc-20160816;
        b=zQh+OiyGMcHnFdnupx3JsWTIbvpYZT6Hxdwe1pRGYGbpJNSbLENyxHwU4LS0jhORvH
         RBIsoHu73ntmBjyi/0murn5vWgenN0ZqnqFjcBveG1MqKM1l67plcKIeFMZwi9KJN923
         BgaS+TNqYyQQDyPqvrVMA1p/3pkH+GRz86H4AfrWOw597Et5D4CmVw7Kc53A52tqkKoQ
         V5xqDK2vQXXomlui/wjSiUufcxxjy+TXKigNygOwxASWedNW1CZRhMXvmcZXVgKWIWLG
         B+OfNKFSHoeHNRmvbRnAXtlD07Sv+41wsMvj4WI7j53T4M5E9LkP6zj8KceNM17eEYEn
         9dXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=cWyjGul+LC3Nx4Bg+vZmY3IZvVwez3KsRrrXRSiydzY=;
        b=QGq1+k7p1ouhWq7L0TvUot98i4SBKCuVIvz2xBKNHfh5aHkYe9KjBg5Naj7C7kl5Oc
         lssu1eiEFenMNekDOe1KKVx5PDMgYSyTFLborJzbf6nL9ZMmwRNFrRMl6y06lru45XG2
         34b1IGaTVDYFPIc4kROSWiYmSZtnIW5TL1kKUbptMTWbUDRkAeO1LK9f9RM1L4/YxOr6
         Kq5i3pmEKjGr0m+0BKGU/Y35pxbVJ+4OUyNKb9T5bh3OM4jq5JrFiF+6sUah3iGhpquW
         XZ954WY+fQ3b+pGv75eOTAk9RgN8JzomewygYuWS+rx3+Hu7dW8u+hvr20iNJgKgJ7g4
         erRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bhbwFHRV;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bhbwFHRV;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsc/DZW5RQiMsRC0/JWdnwkCFCncROKVyuHRFTdHC8Kx7+Zzs+r1eBuMAXwIW8uGcJjPXofTA==
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
To: rjw@rjwysocki.net,
	pavel@ucw.cz,
	len.brown@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ganesh Mahendran <opensource.ganesh@gmail.com>
Subject: [PATCH] PM / wakeup: use seq_open() to show wakeup stats
Date: Fri,  2 Mar 2018 13:01:00 +0800
Message-Id: <1519966860-32519-1-git-send-email-opensource.ganesh@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593800783059204124?=
X-GMAIL-MSGID: =?utf-8?q?1593800783059204124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

single_open() interface requires that the whole output must
fit into a single buffer. This will lead to timeout when
system memory is not in a good situation.

This patch use seq_open() to show wakeup stats. This method
need only one page, so timeout will not be observed.

Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
---
 drivers/base/power/wakeup.c | 71 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index ea01621..c64609a 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1029,32 +1029,73 @@ static int print_wakeup_source_stats(struct seq_file *m,
 	return 0;
 }
 
+static void *wakeup_sources_stats_seq_start(struct seq_file *m,
+					loff_t *pos)
+{
+	struct wakeup_source *ws;
+	loff_t n = *pos;
+
+	if (n == 0) {
+		seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
+			"expire_count\tactive_since\ttotal_time\tmax_time\t"
+			"last_change\tprevent_suspend_time\n");
+	}
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
+		if (n-- > 0)
+			continue;
+		goto out;
+	}
+	ws = NULL;
+out:
+	return ws;
+}
+
+static void *wakeup_sources_stats_seq_next(struct seq_file *m,
+					void *v, loff_t *pos)
+{
+	struct wakeup_source *ws = v;
+	struct wakeup_source *next_ws = NULL;
+
+	++(*pos);
+
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
+	rcu_read_unlock();
+}
+
 /**
  * wakeup_sources_stats_show - Print wakeup sources statistics information.
  * @m: seq_file to print the statistics into.
  */
-static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
+static int wakeup_sources_stats_seq_show(struct seq_file *m, void *v)
 {
-	struct wakeup_source *ws;
-	int srcuidx;
+	struct wakeup_source *ws = v;
 
-	seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
-		"expire_count\tactive_since\ttotal_time\tmax_time\t"
-		"last_change\tprevent_suspend_time\n");
-
-	srcuidx = srcu_read_lock(&wakeup_srcu);
-	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
-		print_wakeup_source_stats(m, ws);
-	srcu_read_unlock(&wakeup_srcu, srcuidx);
-
-	print_wakeup_source_stats(m, &deleted_ws);
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
+	return seq_open(file, &wakeup_sources_stats_seq_ops);
 }
 
 static const struct file_operations wakeup_sources_stats_fops = {
@@ -1062,7 +1103,7 @@ static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
 	.open = wakeup_sources_stats_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = single_release,
+	.release = seq_release,
 };
 
 static int __init wakeup_sources_debugfs_init(void)
-- 
1.9.1
