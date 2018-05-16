Return-Path: <BATV+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AB8JxZokKKWrmchCcDaS1JuSvwbgknoJBHL5SKNRdKpKydVAfo9khfJeHzvYCtlpmInIC/J2YCeF
ARC-Seal: i=1; a=rsa-sha256; t=1526463894; cv=none;
        d=google.com; s=arc-20160816;
        b=M+duepP9YOW3PuyvfLEA/iVawpTaazeQMh9xuuN3JX5/ZPNyv10RXvmjJk9OP0HL+P
         smZP7g/GeLjSNiwcvFpF2w6x4XHH+oNThJ4wAeJJFMB5zKFMPHBUXL4JR856CMSBF+oW
         g9e+GouO5b2Dm9z27tzhx2C1XAPZf4XX7He9aucho9j8IWVL8/c5pTyNHkoDDFU4e6Eu
         p6Sw+W7OfnwGNuMARKFf9f5ZCD98A4nCm/3ZoT3YMFFgj5NzOC1RxQscOvRKvImIb10D
         pKqmqtYaPXObiOulnk7abtx/U3REvKVxP7KvRO8mq25c8kJeg5ME7yLdTXu1LhPirFUE
         d1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=IBw29W98o9JhaE0Ol1cLFdA5CBPn6ll6ey0TFerNt7I=;
        b=zvqDgMQSJl2YKsRAI/K8DbWDAR7GZs2AUU8y2cRGnxydbRfAFYVpoyp3XK0MNiFWBM
         mdftwZD3P8wUnaLoy9J67RrMgzVxo8oNG/lvsaiH2Hig/iRDfAFF15D7QewqOmAosnCV
         W6YzSOl0LOmwwBeTA4jZWNgNHFvYXtzDZIO9n8rn+AnkcFGr7oTAjVdRD8RnGbMyj3Q3
         gvFy+qMfywd8ZSDJItRmPCra9HWWPDwf/Jz1qtoQjGAFAMU+6U4hK1SUlor4WbQRbsW/
         YfO9hQoHaI/efTY5PCEOcsJ0IjLefRiBYv1c1GN5QN+6OycaB/zwPWCqACcHC2fEkHT4
         BYzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=oCTiSmwD;
       spf=pass (google.com: best guess record for domain of batv+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=oCTiSmwD;
       spf=pass (google.com: best guess record for domain of batv+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org
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
Subject: [PATCH 14/42] net/kcm: simplify proc registration
Date: Wed, 16 May 2018 11:43:18 +0200
Message-Id: <20180516094346.20506-15-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600613404140378891?=
X-GMAIL-MSGID: =?utf-8?q?1600613404140378891?=
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
