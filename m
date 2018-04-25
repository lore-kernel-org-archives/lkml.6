Return-Path: <BATV+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx49xPK+eZK8zICHRKeawmE1s2Pi8Js5yZtQyhV60gnbpDoLOXlFcHiuJ2QqKNwoGVVY8BSFn
ARC-Seal: i=1; a=rsa-sha256; t=1524671361; cv=none;
        d=google.com; s=arc-20160816;
        b=vsKiSKptJRipJMv+ZuOcPNFZToO8W+gFlHS+Db5Jw1tvNdo5cDdmJC0cR31b4EiCIp
         q2/DsCOFxIBjzVlm2NT8Aeqn0iktqVUmqT8IN38mE22hiCioGsAlKNYFqbX4J+ikn3FX
         /0WP64UofHlF9a2t5eU9DojJewFlTM92PiKQLWobjaN/KXWPJ6Zx7mFeJFA7jauImB9L
         spSQNp4DJkRgqRhdjXFBrLwFpHJHENt4lUrYC6WBR/V5E4IoQmybueWgHnnfsiCS9NJq
         MNTGSMcbqlei8vvdtFeqQWCjtzS8rk1f4jkbtnbGUmTLe9gkWRqkeWCUVl1wecjvJUmt
         43fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=TMuCfKKQjyWim4anhqnZA2laNKWSZisLMOm6l0WLu9Q=;
        b=QVfpnKfHwnd58ABWOPXsb6OYUDiUlqIBLIJDapehDtHp1bzQuT8gTWGnnQkayfTOGJ
         S3GpPH2uuJ/fFvB34lEYMj4o09egia74UQNQVKUViQx6VHPDBKhXqggmZ2jWpHCPyUeP
         JabGn/qyxaNXYmy3kl1xy59I8v1BBywlCQclY2Y6uBo6soY76A5kvtsJOhEpF9U1WMJ2
         Z2IB/M9PPhqJWmwEjfFSLCcixNZhgV3X7THfE/OUEi4Bt/tPp2JEUWoZ8i2jw2v2SXIb
         c1k7NM4c7g1zTodcsBtomq6KvFT5Q/USKuvoCi6h8u86Wu3XPt9zDTZJOncUd0E/ueMt
         iMsw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=oJ8dgexB;
       spf=pass (google.com: best guess record for domain of batv+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=oJ8dgexB;
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
Subject: [PATCH 08/40] ipv{4,6}/tcp: simplify procfs registration
Date: Wed, 25 Apr 2018 17:47:55 +0200
Message-Id: <20180425154827.32251-9-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425154827.32251-1-hch@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598733797585234714?=
X-GMAIL-MSGID: =?utf-8?q?1598733797585234714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Avoid most of the afinfo indirections and just call the proc helpers
directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/tcp.h   | 11 ++----
 net/ipv4/tcp_ipv4.c | 85 +++++++++++++++++----------------------------
 net/ipv6/tcp_ipv6.c | 27 +++++++++-----
 3 files changed, 53 insertions(+), 70 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9c9b3768b350..51dc7a26a2fa 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1747,27 +1747,22 @@ enum tcp_seq_states {
 	TCP_SEQ_STATE_ESTABLISHED,
 };
 
-int tcp_seq_open(struct inode *inode, struct file *file);
+void *tcp_seq_start(struct seq_file *seq, loff_t *pos);
+void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos);
+void tcp_seq_stop(struct seq_file *seq, void *v);
 
 struct tcp_seq_afinfo {
-	char				*name;
 	sa_family_t			family;
-	const struct file_operations	*seq_fops;
-	struct seq_operations		seq_ops;
 };
 
 struct tcp_iter_state {
 	struct seq_net_private	p;
-	sa_family_t		family;
 	enum tcp_seq_states	state;
 	struct sock		*syn_wait_sk;
 	int			bucket, offset, sbucket, num;
 	loff_t			last_pos;
 };
 
-int tcp_proc_register(struct net *net, struct tcp_seq_afinfo *afinfo);
-void tcp_proc_unregister(struct net *net, struct tcp_seq_afinfo *afinfo);
-
 extern struct request_sock_ops tcp_request_sock_ops;
 extern struct request_sock_ops tcp6_request_sock_ops;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f70586b50838..645f259d0972 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1961,6 +1961,7 @@ EXPORT_SYMBOL(tcp_v4_destroy_sock);
  */
 static void *listening_get_next(struct seq_file *seq, void *cur)
 {
+	struct tcp_seq_afinfo *afinfo = PDE_DATA(file_inode(seq->file));
 	struct tcp_iter_state *st = seq->private;
 	struct net *net = seq_file_net(seq);
 	struct inet_listen_hashbucket *ilb;
@@ -1983,7 +1984,7 @@ static void *listening_get_next(struct seq_file *seq, void *cur)
 	sk_for_each_from(sk) {
 		if (!net_eq(sock_net(sk), net))
 			continue;
-		if (sk->sk_family == st->family)
+		if (sk->sk_family == afinfo->family)
 			return sk;
 	}
 	spin_unlock(&ilb->lock);
@@ -2020,6 +2021,7 @@ static inline bool empty_bucket(const struct tcp_iter_state *st)
  */
 static void *established_get_first(struct seq_file *seq)
 {
+	struct tcp_seq_afinfo *afinfo = PDE_DATA(file_inode(seq->file));
 	struct tcp_iter_state *st = seq->private;
 	struct net *net = seq_file_net(seq);
 	void *rc = NULL;
@@ -2036,7 +2038,7 @@ static void *established_get_first(struct seq_file *seq)
 
 		spin_lock_bh(lock);
 		sk_nulls_for_each(sk, node, &tcp_hashinfo.ehash[st->bucket].chain) {
-			if (sk->sk_family != st->family ||
+			if (sk->sk_family != afinfo->family ||
 			    !net_eq(sock_net(sk), net)) {
 				continue;
 			}
@@ -2051,6 +2053,7 @@ static void *established_get_first(struct seq_file *seq)
 
 static void *established_get_next(struct seq_file *seq, void *cur)
 {
+	struct tcp_seq_afinfo *afinfo = PDE_DATA(file_inode(seq->file));
 	struct sock *sk = cur;
 	struct hlist_nulls_node *node;
 	struct tcp_iter_state *st = seq->private;
@@ -2062,7 +2065,8 @@ static void *established_get_next(struct seq_file *seq, void *cur)
 	sk = sk_nulls_next(sk);
 
 	sk_nulls_for_each_from(sk, node) {
-		if (sk->sk_family == st->family && net_eq(sock_net(sk), net))
+		if (sk->sk_family == afinfo->family &&
+		    net_eq(sock_net(sk), net))
 			return sk;
 	}
 
@@ -2135,7 +2139,7 @@ static void *tcp_seek_last_pos(struct seq_file *seq)
 	return rc;
 }
 
-static void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
+void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct tcp_iter_state *st = seq->private;
 	void *rc;
@@ -2156,8 +2160,9 @@ static void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
 	st->last_pos = *pos;
 	return rc;
 }
+EXPORT_SYMBOL(tcp_seq_start);
 
-static void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct tcp_iter_state *st = seq->private;
 	void *rc = NULL;
@@ -2186,8 +2191,9 @@ static void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	st->last_pos = *pos;
 	return rc;
 }
+EXPORT_SYMBOL(tcp_seq_next);
 
-static void tcp_seq_stop(struct seq_file *seq, void *v)
+void tcp_seq_stop(struct seq_file *seq, void *v)
 {
 	struct tcp_iter_state *st = seq->private;
 
@@ -2202,47 +2208,7 @@ static void tcp_seq_stop(struct seq_file *seq, void *v)
 		break;
 	}
 }
-
-int tcp_seq_open(struct inode *inode, struct file *file)
-{
-	struct tcp_seq_afinfo *afinfo = PDE_DATA(inode);
-	struct tcp_iter_state *s;
-	int err;
-
-	err = seq_open_net(inode, file, &afinfo->seq_ops,
-			  sizeof(struct tcp_iter_state));
-	if (err < 0)
-		return err;
-
-	s = ((struct seq_file *)file->private_data)->private;
-	s->family		= afinfo->family;
-	s->last_pos		= 0;
-	return 0;
-}
-EXPORT_SYMBOL(tcp_seq_open);
-
-int tcp_proc_register(struct net *net, struct tcp_seq_afinfo *afinfo)
-{
-	int rc = 0;
-	struct proc_dir_entry *p;
-
-	afinfo->seq_ops.start		= tcp_seq_start;
-	afinfo->seq_ops.next		= tcp_seq_next;
-	afinfo->seq_ops.stop		= tcp_seq_stop;
-
-	p = proc_create_data(afinfo->name, 0444, net->proc_net,
-			     afinfo->seq_fops, afinfo);
-	if (!p)
-		rc = -ENOMEM;
-	return rc;
-}
-EXPORT_SYMBOL(tcp_proc_register);
-
-void tcp_proc_unregister(struct net *net, struct tcp_seq_afinfo *afinfo)
-{
-	remove_proc_entry(afinfo->name, net->proc_net);
-}
-EXPORT_SYMBOL(tcp_proc_unregister);
+EXPORT_SYMBOL(tcp_seq_stop);
 
 static void get_openreq4(const struct request_sock *req,
 			 struct seq_file *f, int i)
@@ -2377,6 +2343,19 @@ static int tcp4_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
+static const struct seq_operations tcp4_seq_ops = {
+	.show		= tcp4_seq_show,
+	.start		= tcp_seq_start,
+	.next		= tcp_seq_next,
+	.stop		= tcp_seq_stop,
+};
+
+static int tcp_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open_net(inode, file, &tcp4_seq_ops,
+			  sizeof(struct tcp_iter_state));
+}
+
 static const struct file_operations tcp_afinfo_seq_fops = {
 	.open    = tcp_seq_open,
 	.read    = seq_read,
@@ -2385,22 +2364,20 @@ static const struct file_operations tcp_afinfo_seq_fops = {
 };
 
 static struct tcp_seq_afinfo tcp4_seq_afinfo = {
-	.name		= "tcp",
 	.family		= AF_INET,
-	.seq_fops	= &tcp_afinfo_seq_fops,
-	.seq_ops	= {
-		.show		= tcp4_seq_show,
-	},
 };
 
 static int __net_init tcp4_proc_init_net(struct net *net)
 {
-	return tcp_proc_register(net, &tcp4_seq_afinfo);
+	if (!proc_create_data("tcp", 0444, net->proc_net,
+			&tcp_afinfo_seq_fops, &tcp4_seq_afinfo))
+		return -ENOMEM;
+	return 0;
 }
 
 static void __net_exit tcp4_proc_exit_net(struct net *net)
 {
-	tcp_proc_unregister(net, &tcp4_seq_afinfo);
+	remove_proc_entry("tcp", net->proc_net);
 }
 
 static struct pernet_operations tcp4_net_ops = {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 6d664d83cd16..c0329bb1692f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1909,30 +1909,41 @@ static int tcp6_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
+static const struct seq_operations tcp6_seq_ops = {
+	.show		= tcp6_seq_show,
+	.start		= tcp_seq_start,
+	.next		= tcp_seq_next,
+	.stop		= tcp_seq_stop,
+};
+
+static int tcp6_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open_net(inode, file, &tcp6_seq_ops,
+			  sizeof(struct tcp_iter_state));
+}
+
 static const struct file_operations tcp6_afinfo_seq_fops = {
-	.open    = tcp_seq_open,
+	.open    = tcp6_seq_open,
 	.read    = seq_read,
 	.llseek  = seq_lseek,
 	.release = seq_release_net
 };
 
 static struct tcp_seq_afinfo tcp6_seq_afinfo = {
-	.name		= "tcp6",
 	.family		= AF_INET6,
-	.seq_fops	= &tcp6_afinfo_seq_fops,
-	.seq_ops	= {
-		.show		= tcp6_seq_show,
-	},
 };
 
 int __net_init tcp6_proc_init(struct net *net)
 {
-	return tcp_proc_register(net, &tcp6_seq_afinfo);
+	if (!proc_create_data("tcp6", 0444, net->proc_net,
+			&tcp6_afinfo_seq_fops, &tcp6_seq_afinfo))
+		return -ENOMEM;
+	return 0;
 }
 
 void tcp6_proc_exit(struct net *net)
 {
-	tcp_proc_unregister(net, &tcp6_seq_afinfo);
+	remove_proc_entry("tcp6", net->proc_net);
 }
 #endif
 
-- 
2.17.0
