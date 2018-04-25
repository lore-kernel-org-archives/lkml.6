Return-Path: <BATV+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx48yjiXdEIzNKWSG2U5X8hjo8FRPNPYlV3BSS/tCI3z+bDhqxAhUpJpOxLl0oI/VcgErqbLR
ARC-Seal: i=1; a=rsa-sha256; t=1524671385; cv=none;
        d=google.com; s=arc-20160816;
        b=JTWZmku9Z0bnNvobi6Fh/bJZNds05jagMRTKEy/LuRVbK26UTcxbwMv9aS304+kB0f
         hqlKnlqiY0TFZkcu4pULi3SnnLHXci1GpkBWmDf5DmfB1jH9ISfXMrZ4OeUBAnZhWJZB
         u6IG2vb+Wu/sxg7lfwEEAvZVAQCzMWnX8C5qSErtTa3EN7v0JgUPKSqLCiU7AdAGRUiy
         9p+wYnKVyJgswuUkkXQqPsMv4y3v4PvsRQ/IMTLwMG/dEL/ELkVJ3290YlngmtlfLzot
         QEE5KHjAMU44LxegS0mcNJKPZWvOKvG5tVDOobT4iyersK1LoRogSTnevRTfPsqS52ID
         g7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=IBw29W98o9JhaE0Ol1cLFdA5CBPn6ll6ey0TFerNt7I=;
        b=sNJLwWHlcS31hWT1NCXvtq29gIGNAlGhSEQp3ZKpWjhLYfLtFyoCtChDH52aSeDYaQ
         R1ok6n1ji9g1HkY1Oq0i5IJZaiPn0eYB3IliA/yotgy47Cvv6gdsGmDUuOLgd7S86RqU
         tBn61UtmV6+wm5xF16QraOHbZSSGDK6/8kLg6EjNdU9embXvp9aUJzTxNyzLbwJgK4B5
         j+f3KeXp/71su9P4ymq15mMBqPbKemBirV5CdUvhvOb7usDPmk7r9yby5+AJyqjHExho
         B8lTjfGstfxznofpzwOgJ4y52jry9DtcOpZ9cYsEvf3eDqHqnJt4x6t5YVpurlI5Kbqf
         9zsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=W6dJALOl;
       spf=pass (google.com: best guess record for domain of batv+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=W6dJALOl;
       spf=pass (google.com: best guess record for domain of batv+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
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
Subject: [PATCH 12/40] net/kcm: simplify proc registration
Date: Wed, 25 Apr 2018 17:47:59 +0200
Message-Id: <20180425154827.32251-13-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425154827.32251-1-hch@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598733822970546032?=
X-GMAIL-MSGID: =?utf-8?q?1598733822970546032?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove a couple indirections to make the code look like most other
protocols.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/kcm/kcmproc.c | 71 ++++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 54 deletions(-)

diff --git a/net/kcm/kcmproc.c b/net/kcm/kcmproc.c
index 1fac92543094..6d0667e62baf 100644
--- a/net/kcm/kcmproc.c
+++ b/net/kcm/kcmproc.c
@@ -15,12 +15,6 @@
 #include <net/tcp.h>
 
 #ifdef CONFIG_PROC_FS
-struct kcm_seq_muxinfo {
-	char				*name;
-	const struct file_operations	*seq_fops;
-	const struct seq_operations	seq_ops;
-};
-
 static struct kcm_mux *kcm_get_first(struct seq_file *seq)
 {
 	struct net *net = seq_file_net(seq);
@@ -86,14 +80,6 @@ struct kcm_proc_mux_state {
 	int idx;
 };
 
-static int kcm_seq_open(struct inode *inode, struct file *file)
-{
-	struct kcm_seq_muxinfo *muxinfo = PDE_DATA(inode);
-
-	return seq_open_net(inode, file, &muxinfo->seq_ops,
-			   sizeof(struct kcm_proc_mux_state));
-}
-
 static void kcm_format_mux_header(struct seq_file *seq)
 {
 	struct net *net = seq_file_net(seq);
@@ -246,6 +232,19 @@ static int kcm_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
+static const struct seq_operations kcm_seq_ops = {
+	.show	= kcm_seq_show,
+	.start	= kcm_seq_start,
+	.next	= kcm_seq_next,
+	.stop	= kcm_seq_stop,
+};
+
+static int kcm_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open_net(inode, file, &kcm_seq_ops,
+			   sizeof(struct kcm_proc_mux_state));
+}
+
 static const struct file_operations kcm_seq_fops = {
 	.open		= kcm_seq_open,
 	.read		= seq_read,
@@ -253,37 +252,6 @@ static const struct file_operations kcm_seq_fops = {
 	.release	= seq_release_net,
 };
 
-static struct kcm_seq_muxinfo kcm_seq_muxinfo = {
-	.name		= "kcm",
-	.seq_fops	= &kcm_seq_fops,
-	.seq_ops	= {
-		.show	= kcm_seq_show,
-		.start	= kcm_seq_start,
-		.next	= kcm_seq_next,
-		.stop	= kcm_seq_stop,
-	}
-};
-
-static int kcm_proc_register(struct net *net, struct kcm_seq_muxinfo *muxinfo)
-{
-	struct proc_dir_entry *p;
-	int rc = 0;
-
-	p = proc_create_data(muxinfo->name, 0444, net->proc_net,
-			     muxinfo->seq_fops, muxinfo);
-	if (!p)
-		rc = -ENOMEM;
-	return rc;
-}
-EXPORT_SYMBOL(kcm_proc_register);
-
-static void kcm_proc_unregister(struct net *net,
-				struct kcm_seq_muxinfo *muxinfo)
-{
-	remove_proc_entry(muxinfo->name, net->proc_net);
-}
-EXPORT_SYMBOL(kcm_proc_unregister);
-
 static int kcm_stats_seq_show(struct seq_file *seq, void *v)
 {
 	struct kcm_psock_stats psock_stats;
@@ -404,16 +372,11 @@ static const struct file_operations kcm_stats_seq_fops = {
 
 static int kcm_proc_init_net(struct net *net)
 {
-	int err;
-
 	if (!proc_create("kcm_stats", 0444, net->proc_net,
-			 &kcm_stats_seq_fops)) {
-		err = -ENOMEM;
+			 &kcm_stats_seq_fops))
 		goto out_kcm_stats;
-	}
 
-	err = kcm_proc_register(net, &kcm_seq_muxinfo);
-	if (err)
+	if (!proc_create("kcm", 0444, net->proc_net, &kcm_seq_fops))
 		goto out_kcm;
 
 	return 0;
@@ -421,12 +384,12 @@ static int kcm_proc_init_net(struct net *net)
 out_kcm:
 	remove_proc_entry("kcm_stats", net->proc_net);
 out_kcm_stats:
-	return err;
+	return -ENOMEM;
 }
 
 static void kcm_proc_exit_net(struct net *net)
 {
-	kcm_proc_unregister(net, &kcm_seq_muxinfo);
+	remove_proc_entry("kcm", net->proc_net);
 	remove_proc_entry("kcm_stats", net->proc_net);
 }
 
-- 
2.17.0
