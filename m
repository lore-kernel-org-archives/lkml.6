Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx4/o97SMZ2+GdFD9mWko99+T2C+0b5ehwGooGIjJ6o8yX2buWHU5uPdLvZQbLmzlqt5rtAsC
ARC-Seal: i=1; a=rsa-sha256; t=1524141819; cv=none;
        d=google.com; s=arc-20160816;
        b=gro8XhCrcPgvnfstUTRLM8WljnVbzeEbh+248N2hJocr2vHBJUxpBtaGpKsPPTc4km
         1r9W4HTC35S6B05hdg6vZkunUlwNH7FCE2M1OhtYECgvwwPTKhKYVpakx+FmqMM3c7KO
         6QubwrSTL1u2F5mi2keTlc9z5SSlzS+rlUDa+TeaISd9DfDSuvEUPN9uKVziIJ10M9Ra
         bN+Xqu5ME/1iH0ACjx+v6uVh0cNx/2amPACJBjXjwozIaymBJd2B8NLZzgjgSjhcwSd5
         CQVWXOlAElBXbDas078I2kN6fHsOgBE8k3f0owO85q2BbZZZU79r48YXMlv717Ly93FL
         EQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=IG61pFy4GkP3GnA8qp8UiJ1fXufhht5pH9kvurAP8uA=;
        b=KHYHw7qPWSO3ZM5FtzoMkEewAGv26Q8/kMLZSODs4vyGkjuF79k2ElsUG6VSchNMMd
         3OiJ0vN8ygbmqVHOHMcVw/A+ie2iC1HQSiYaOj6uBthsCGvmo9IBEUyCQ9dvjBI1daaP
         7JNINwEULPry3+3g0w40QG2bgUXAxyLuatfnx1LqDOS7uT7IltFAAEvja79NUifpb3Nv
         xmdQo6I+gkjwZNGSCPuIUGLC4TWf3jR7NAT/A0NRloY6A+KnMqLLrH0kUu1FBkGOmeu+
         sDfOg1v9wK89qNTj920h1Ir2IeptRU5J+1jPFgtKAtoZnijTEFY1+bq77MJAmkim1one
         kapw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=sXPXJr/Q;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=sXPXJr/Q;
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
Subject: [PATCH 32/39] bluetooth: switch to proc_create_seq_data
Date: Thu, 19 Apr 2018 14:41:33 +0200
Message-Id: <20180419124140.9309-33-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178532535447600?=
X-GMAIL-MSGID: =?utf-8?q?1598178532535447600?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

And use proc private data directly instead of doing a detour
through seq->private and private state.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/bluetooth/af_bluetooth.c | 40 +++++-------------------------------
 1 file changed, 5 insertions(+), 35 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 84d92a077834..3264e1873219 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -605,15 +605,10 @@ int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
 EXPORT_SYMBOL(bt_sock_wait_ready);
 
 #ifdef CONFIG_PROC_FS
-struct bt_seq_state {
-	struct bt_sock_list *l;
-};
-
 static void *bt_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(seq->private->l->lock)
 {
-	struct bt_seq_state *s = seq->private;
-	struct bt_sock_list *l = s->l;
+	struct bt_sock_list *l = PDE_DATA(file_inode(seq->file));
 
 	read_lock(&l->lock);
 	return seq_hlist_start_head(&l->head, *pos);
@@ -621,8 +616,7 @@ static void *bt_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *bt_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct bt_seq_state *s = seq->private;
-	struct bt_sock_list *l = s->l;
+	struct bt_sock_list *l = PDE_DATA(file_inode(seq->file));
 
 	return seq_hlist_next(v, &l->head, pos);
 }
@@ -630,16 +624,14 @@ static void *bt_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 static void bt_seq_stop(struct seq_file *seq, void *v)
 	__releases(seq->private->l->lock)
 {
-	struct bt_seq_state *s = seq->private;
-	struct bt_sock_list *l = s->l;
+	struct bt_sock_list *l = PDE_DATA(file_inode(seq->file));
 
 	read_unlock(&l->lock);
 }
 
 static int bt_seq_show(struct seq_file *seq, void *v)
 {
-	struct bt_seq_state *s = seq->private;
-	struct bt_sock_list *l = s->l;
+	struct bt_sock_list *l = PDE_DATA(file_inode(seq->file));
 
 	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq ,"sk               RefCnt Rmem   Wmem   User   Inode  Parent");
@@ -681,35 +673,13 @@ static const struct seq_operations bt_seq_ops = {
 	.show  = bt_seq_show,
 };
 
-static int bt_seq_open(struct inode *inode, struct file *file)
-{
-	struct bt_sock_list *sk_list;
-	struct bt_seq_state *s;
-
-	sk_list = PDE_DATA(inode);
-	s = __seq_open_private(file, &bt_seq_ops,
-			       sizeof(struct bt_seq_state));
-	if (!s)
-		return -ENOMEM;
-
-	s->l = sk_list;
-	return 0;
-}
-
-static const struct file_operations bt_fops = {
-	.open = bt_seq_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = seq_release_private
-};
-
 int bt_procfs_init(struct net *net, const char *name,
 		   struct bt_sock_list *sk_list,
 		   int (* seq_show)(struct seq_file *, void *))
 {
 	sk_list->custom_seq_show = seq_show;
 
-	if (!proc_create_data(name, 0, net->proc_net, &bt_fops, sk_list))
+	if (!proc_create_seq_data(name, 0, net->proc_net, &bt_seq_ops, sk_list))
 		return -ENOMEM;
 	return 0;
 }
-- 
2.17.0
