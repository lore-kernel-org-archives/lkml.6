Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx49FSnXNJmDI+qytny+GjrENJyQXcVxACIidOzJ1zL0HPNlXcdwkQkW5ZWFLz0x7RAzWlQJz
ARC-Seal: i=1; a=rsa-sha256; t=1524141811; cv=none;
        d=google.com; s=arc-20160816;
        b=M3WPo5Dv1xmlwWlq7JXvbOS5djk0MAlP566RZeB6yKzzvXg+qkt8tlEETnF7B/UQtn
         vuRGGKZ8px1yNw+kLxmF4VxozM2m4H1N9REwVMmTnbMr02jCNF+YxiwagaUAVxFnMce8
         +sO16QPQraFVUQotMNbCMb4gnnBq3gQO9ywgvvdRTQuyI1r0tGTK1l6UtFGNrBpWFH5B
         FvMqevxHlDb6I6g0m5MC20phAYl2DWqDLclpEepCbjKYARVo06w54gF2f3jOO7+ENWYK
         lKlqPr6KWiknXAaZdhxZ6GU1hBduCkRIZ9Nm+W9yhP8n6wxFzWT/wgsDaIbgMTVkYqnl
         HEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=DVoiL/vI33YkSWEighbc8EdmWGqkh5VT13O20/GvCfU=;
        b=N1bcnYzmZYaRv7BbAnXZ+7N1LU6yAb11F6ynPS2IV+suFGhApxkY9hTlpdTFNF0Ab6
         uwA4WYGK8la5h5grmeRhBqGQWDw3uUsnlMGDe4DUJ5DFcDDbGXuBeZQBpKLOPRmqtjrI
         0JnauOQTKjqjMRVc7byAD3vxzaSRY0Us1/EOhSkmT0LQfL56efwO9j0q0VC+Ab+mxWgm
         1zAhTIyCv8l6wk2WEE0mpXgQDgfP/yaC1lJKZbKoDn0Y4C96e+bbv57RjTrC3uwSZJeG
         o4JSmhtCp7UhM65LwIR3SmAVeD3XXgB1mYjuHfZoNkjkBXhVzbM8VA/ih1RqyFFbcBZQ
         bByA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qaKEWuXq;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qaKEWuXq;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Corey Minyard <minyard@acm.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-acpi@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	linux-ide@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-afs@lists.infradead.org,
	linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 29/39] neigh: switch to proc_create_seq_data
Date: Thu, 19 Apr 2018 14:41:30 +0200
Message-Id: <20180419124140.9309-30-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178523664338478?=
X-GMAIL-MSGID: =?utf-8?q?1598178523664338478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

And use proc private data directly instead of doing a detour
through seq->private.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/core/neighbour.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 7b7a14abba28..cbfb6d71b8be 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -58,7 +58,7 @@ static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
 static int pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev);
 
 #ifdef CONFIG_PROC_FS
-static const struct file_operations neigh_stat_seq_fops;
+static const struct seq_operations neigh_stat_seq_ops;
 #endif
 
 /*
@@ -1550,8 +1550,8 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 		panic("cannot create neighbour cache statistics");
 
 #ifdef CONFIG_PROC_FS
-	if (!proc_create_data(tbl->id, 0, init_net.proc_net_stat,
-			      &neigh_stat_seq_fops, tbl))
+	if (!proc_create_seq_data(tbl->id, 0, init_net.proc_net_stat,
+			      &neigh_stat_seq_ops, tbl))
 		panic("cannot create neighbour proc dir entry");
 #endif
 
@@ -2774,7 +2774,7 @@ EXPORT_SYMBOL(neigh_seq_stop);
 
 static void *neigh_stat_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	struct neigh_table *tbl = seq->private;
+	struct neigh_table *tbl = PDE_DATA(file_inode(seq->file));
 	int cpu;
 
 	if (*pos == 0)
@@ -2791,7 +2791,7 @@ static void *neigh_stat_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *neigh_stat_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct neigh_table *tbl = seq->private;
+	struct neigh_table *tbl = PDE_DATA(file_inode(seq->file));
 	int cpu;
 
 	for (cpu = *pos; cpu < nr_cpu_ids; ++cpu) {
@@ -2810,7 +2810,7 @@ static void neigh_stat_seq_stop(struct seq_file *seq, void *v)
 
 static int neigh_stat_seq_show(struct seq_file *seq, void *v)
 {
-	struct neigh_table *tbl = seq->private;
+	struct neigh_table *tbl = PDE_DATA(file_inode(seq->file));
 	struct neigh_statistics *st = v;
 
 	if (v == SEQ_START_TOKEN) {
@@ -2849,25 +2849,6 @@ static const struct seq_operations neigh_stat_seq_ops = {
 	.stop	= neigh_stat_seq_stop,
 	.show	= neigh_stat_seq_show,
 };
-
-static int neigh_stat_seq_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &neigh_stat_seq_ops);
-
-	if (!ret) {
-		struct seq_file *sf = file->private_data;
-		sf->private = PDE_DATA(inode);
-	}
-	return ret;
-};
-
-static const struct file_operations neigh_stat_seq_fops = {
-	.open 	 = neigh_stat_seq_open,
-	.read	 = seq_read,
-	.llseek	 = seq_lseek,
-	.release = seq_release,
-};
-
 #endif /* CONFIG_PROC_FS */
 
 static inline size_t neigh_nlmsg_size(void)
-- 
2.17.0
