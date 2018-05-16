Return-Path: <BATV+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AB8JxZr2seIbiPb9dDWdEHpL3Btg5/jyyHj/8zX2bnpmkzmKcTitwnjAmpjGwuhhrIukKsFfKBf+
ARC-Seal: i=1; a=rsa-sha256; t=1526463873; cv=none;
        d=google.com; s=arc-20160816;
        b=GhEnnm0ER4kIlu43QJsV22EOmQxzJP8PAOnx3o9Bjj6QgvxQ9eZf8ll4iuwIERriN1
         RgfDw1rGLgzXMZWSG5jv7DF/9HsZgMs96zVZuLLVTr7VS95Xru94N5gmuvFnO3cnR+w1
         qWjyvYwPP4lkV7pG19rlERWWJIab3QKp+pvnso2ZKp4XrQxADqAdaK5j2YTli2Hezq1z
         j9oXKSw9VHSzkmAqil5Q8RqXpRxFyHUm+hTPW92Fk4L75fliwPIe7pxMC5RZ05WaCcZt
         doWz+GBvv4dcq8caKffWgteW3Bx3cTUQaHZXjezZ5BntQ54epBmjVtxQV7/JZoA8HI8g
         1k4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=ZlXkpvHfU8TjY3lyvjoVaxOl1eQL734kY+j+Xo5HjoU=;
        b=AEAATlAp4/34VBGGljO3rq69Ba2xnNCtXevDm14wpw9u0eUvnp/DgMzAWU4vXyQUMo
         3yf/SyGrGiMd+sQDJMfOqQRYsen0nd/qZSguV6reoXgkGYxFfghB8xNG/8oXft+6Qh/T
         loBDHMUM6JjwJjrY07Ix6ZLmad2WzRM8KUKwhsfCHZ/pZHZe+7lsjfY3antbiWjlqlxP
         oxm84hHc4hw3eH8kLCwMGMsriQLqvcF0gzsgiDP1ES/2U33v2/nJkkq88R4GdhIFR/HI
         p0yUc/fZLW6RyGvanitmMKiDIbIHcHmPSO5V+t32Sw24oWAlZcQYQo0efOvWrfHHDde3
         l3Eg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=NFRC6eh2;
       spf=pass (google.com: best guess record for domain of batv+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=NFRC6eh2;
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
Subject: [PATCH 09/42] ipv{4,6}/udp{,lite}: simplify proc registration
Date: Wed, 16 May 2018 11:43:13 +0200
Message-Id: <20180516094346.20506-10-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600613382674448851?=
X-GMAIL-MSGID: =?utf-8?q?1600613382674448851?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove a couple indirections to make the code look like most other
protocols.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/udp.h  | 20 ++++------
 net/ipv4/udp.c     | 99 +++++++++++++++++-----------------------------
 net/ipv4/udplite.c | 21 +++-------
 net/ipv6/udp.c     | 30 +++++++++-----
 net/ipv6/udplite.c | 21 +++-------
 5 files changed, 78 insertions(+), 113 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 0676b272f6ac..093cd323f66a 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -408,31 +408,27 @@ do {									\
 #define __UDPX_INC_STATS(sk, field) __UDP_INC_STATS(sock_net(sk), field, 0)
 #endif
 
-/* /proc */
-int udp_seq_open(struct inode *inode, struct file *file);
-
+#ifdef CONFIG_PROC_FS
 struct udp_seq_afinfo {
-	char				*name;
 	sa_family_t			family;
 	struct udp_table		*udp_table;
-	const struct file_operations	*seq_fops;
-	struct seq_operations		seq_ops;
 };
 
 struct udp_iter_state {
 	struct seq_net_private  p;
-	sa_family_t		family;
 	int			bucket;
-	struct udp_table	*udp_table;
 };
 
-#ifdef CONFIG_PROC_FS
-int udp_proc_register(struct net *net, struct udp_seq_afinfo *afinfo);
-void udp_proc_unregister(struct net *net, struct udp_seq_afinfo *afinfo);
+void *udp_seq_start(struct seq_file *seq, loff_t *pos);
+void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos);
+void udp_seq_stop(struct seq_file *seq, void *v);
+
+extern const struct file_operations udp_afinfo_seq_fops;
+extern const struct file_operations udp6_afinfo_seq_fops;
 
 int udp4_proc_init(void);
 void udp4_proc_exit(void);
-#endif
+#endif /* CONFIG_PROC_FS */
 
 int udpv4_offload_init(void);
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b61a770884fa..51559a8c6e57 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2582,12 +2582,13 @@ EXPORT_SYMBOL(udp_prot);
 static struct sock *udp_get_first(struct seq_file *seq, int start)
 {
 	struct sock *sk;
+	struct udp_seq_afinfo *afinfo = PDE_DATA(file_inode(seq->file));
 	struct udp_iter_state *state = seq->private;
 	struct net *net = seq_file_net(seq);
 
-	for (state->bucket = start; state->bucket <= state->udp_table->mask;
+	for (state->bucket = start; state->bucket <= afinfo->udp_table->mask;
 	     ++state->bucket) {
-		struct udp_hslot *hslot = &state->udp_table->hash[state->bucket];
+		struct udp_hslot *hslot = &afinfo->udp_table->hash[state->bucket];
 
 		if (hlist_empty(&hslot->head))
 			continue;
@@ -2596,7 +2597,7 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
 		sk_for_each(sk, &hslot->head) {
 			if (!net_eq(sock_net(sk), net))
 				continue;
-			if (sk->sk_family == state->family)
+			if (sk->sk_family == afinfo->family)
 				goto found;
 		}
 		spin_unlock_bh(&hslot->lock);
@@ -2608,16 +2609,17 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
 
 static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
 {
+	struct udp_seq_afinfo *afinfo = PDE_DATA(file_inode(seq->file));
 	struct udp_iter_state *state = seq->private;
 	struct net *net = seq_file_net(seq);
 
 	do {
 		sk = sk_next(sk);
-	} while (sk && (!net_eq(sock_net(sk), net) || sk->sk_family != state->family));
+	} while (sk && (!net_eq(sock_net(sk), net) || sk->sk_family != afinfo->family));
 
 	if (!sk) {
-		if (state->bucket <= state->udp_table->mask)
-			spin_unlock_bh(&state->udp_table->hash[state->bucket].lock);
+		if (state->bucket <= afinfo->udp_table->mask)
+			spin_unlock_bh(&afinfo->udp_table->hash[state->bucket].lock);
 		return udp_get_first(seq, state->bucket + 1);
 	}
 	return sk;
@@ -2633,15 +2635,16 @@ static struct sock *udp_get_idx(struct seq_file *seq, loff_t pos)
 	return pos ? NULL : sk;
 }
 
-static void *udp_seq_start(struct seq_file *seq, loff_t *pos)
+void *udp_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct udp_iter_state *state = seq->private;
 	state->bucket = MAX_UDP_PORTS;
 
 	return *pos ? udp_get_idx(seq, *pos-1) : SEQ_START_TOKEN;
 }
+EXPORT_SYMBOL(udp_seq_start);
 
-static void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct sock *sk;
 
@@ -2653,56 +2656,17 @@ static void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	++*pos;
 	return sk;
 }
+EXPORT_SYMBOL(udp_seq_next);
 
-static void udp_seq_stop(struct seq_file *seq, void *v)
+void udp_seq_stop(struct seq_file *seq, void *v)
 {
+	struct udp_seq_afinfo *afinfo = PDE_DATA(file_inode(seq->file));
 	struct udp_iter_state *state = seq->private;
 
-	if (state->bucket <= state->udp_table->mask)
-		spin_unlock_bh(&state->udp_table->hash[state->bucket].lock);
+	if (state->bucket <= afinfo->udp_table->mask)
+		spin_unlock_bh(&afinfo->udp_table->hash[state->bucket].lock);
 }
-
-int udp_seq_open(struct inode *inode, struct file *file)
-{
-	struct udp_seq_afinfo *afinfo = PDE_DATA(inode);
-	struct udp_iter_state *s;
-	int err;
-
-	err = seq_open_net(inode, file, &afinfo->seq_ops,
-			   sizeof(struct udp_iter_state));
-	if (err < 0)
-		return err;
-
-	s = ((struct seq_file *)file->private_data)->private;
-	s->family		= afinfo->family;
-	s->udp_table		= afinfo->udp_table;
-	return err;
-}
-EXPORT_SYMBOL(udp_seq_open);
-
-/* ------------------------------------------------------------------------ */
-int udp_proc_register(struct net *net, struct udp_seq_afinfo *afinfo)
-{
-	struct proc_dir_entry *p;
-	int rc = 0;
-
-	afinfo->seq_ops.start		= udp_seq_start;
-	afinfo->seq_ops.next		= udp_seq_next;
-	afinfo->seq_ops.stop		= udp_seq_stop;
-
-	p = proc_create_data(afinfo->name, 0444, net->proc_net,
-			     afinfo->seq_fops, afinfo);
-	if (!p)
-		rc = -ENOMEM;
-	return rc;
-}
-EXPORT_SYMBOL(udp_proc_register);
-
-void udp_proc_unregister(struct net *net, struct udp_seq_afinfo *afinfo)
-{
-	remove_proc_entry(afinfo->name, net->proc_net);
-}
-EXPORT_SYMBOL(udp_proc_unregister);
+EXPORT_SYMBOL(udp_seq_stop);
 
 /* ------------------------------------------------------------------------ */
 static void udp4_format_sock(struct sock *sp, struct seq_file *f,
@@ -2742,32 +2706,43 @@ int udp4_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static const struct file_operations udp_afinfo_seq_fops = {
+static const struct seq_operations udp_seq_ops = {
+	.start		= udp_seq_start,
+	.next		= udp_seq_next,
+	.stop		= udp_seq_stop,
+	.show		= udp4_seq_show,
+};
+
+static int udp_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open_net(inode, file, &udp_seq_ops,
+			sizeof(struct udp_iter_state));
+}
+
+const struct file_operations udp_afinfo_seq_fops = {
 	.open     = udp_seq_open,
 	.read     = seq_read,
 	.llseek   = seq_lseek,
 	.release  = seq_release_net
 };
+EXPORT_SYMBOL(udp_afinfo_seq_fops);
 
-/* ------------------------------------------------------------------------ */
 static struct udp_seq_afinfo udp4_seq_afinfo = {
-	.name		= "udp",
 	.family		= AF_INET,
 	.udp_table	= &udp_table,
-	.seq_fops	= &udp_afinfo_seq_fops,
-	.seq_ops	= {
-		.show		= udp4_seq_show,
-	},
 };
 
 static int __net_init udp4_proc_init_net(struct net *net)
 {
-	return udp_proc_register(net, &udp4_seq_afinfo);
+	if (!proc_create_data("udp", 0444, net->proc_net, &udp_afinfo_seq_fops,
+			&udp4_seq_afinfo))
+		return -ENOMEM;
+	return 0;
 }
 
 static void __net_exit udp4_proc_exit_net(struct net *net)
 {
-	udp_proc_unregister(net, &udp4_seq_afinfo);
+	remove_proc_entry("udp", net->proc_net);
 }
 
 static struct pernet_operations udp4_net_ops = {
diff --git a/net/ipv4/udplite.c b/net/ipv4/udplite.c
index f96614e9b9a5..4a6e67bfbe0d 100644
--- a/net/ipv4/udplite.c
+++ b/net/ipv4/udplite.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) "UDPLite: " fmt
 
 #include <linux/export.h>
+#include <linux/proc_fs.h>
 #include "udp_impl.h"
 
 struct udp_table 	udplite_table __read_mostly;
@@ -73,32 +74,22 @@ static struct inet_protosw udplite4_protosw = {
 };
 
 #ifdef CONFIG_PROC_FS
-
-static const struct file_operations udplite_afinfo_seq_fops = {
-	.open     = udp_seq_open,
-	.read     = seq_read,
-	.llseek   = seq_lseek,
-	.release  = seq_release_net
-};
-
 static struct udp_seq_afinfo udplite4_seq_afinfo = {
-	.name		= "udplite",
 	.family		= AF_INET,
 	.udp_table 	= &udplite_table,
-	.seq_fops	= &udplite_afinfo_seq_fops,
-	.seq_ops	= {
-		.show		= udp4_seq_show,
-	},
 };
 
 static int __net_init udplite4_proc_init_net(struct net *net)
 {
-	return udp_proc_register(net, &udplite4_seq_afinfo);
+	if (!proc_create_data("udplite", 0444, net->proc_net,
+			&udp_afinfo_seq_fops, &udplite4_seq_afinfo))
+		return -ENOMEM;
+	return 0;
 }
 
 static void __net_exit udplite4_proc_exit_net(struct net *net)
 {
-	udp_proc_unregister(net, &udplite4_seq_afinfo);
+	remove_proc_entry("udplite", net->proc_net);
 }
 
 static struct pernet_operations udplite4_net_ops = {
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index ea0730028e5d..29adddeac3e5 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1480,31 +1480,43 @@ int udp6_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static const struct file_operations udp6_afinfo_seq_fops = {
-	.open     = udp_seq_open,
+static const struct seq_operations udp6_seq_ops = {
+	.start		= udp_seq_start,
+	.next		= udp_seq_next,
+	.stop		= udp_seq_stop,
+	.show		= udp6_seq_show,
+};
+
+static int udp6_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open_net(inode, file, &udp6_seq_ops,
+			sizeof(struct udp_iter_state));
+}
+
+const struct file_operations udp6_afinfo_seq_fops = {
+	.open     = udp6_seq_open,
 	.read     = seq_read,
 	.llseek   = seq_lseek,
 	.release  = seq_release_net
 };
+EXPORT_SYMBOL(udp6_afinfo_seq_fops);
 
 static struct udp_seq_afinfo udp6_seq_afinfo = {
-	.name		= "udp6",
 	.family		= AF_INET6,
 	.udp_table	= &udp_table,
-	.seq_fops	= &udp6_afinfo_seq_fops,
-	.seq_ops	= {
-		.show		= udp6_seq_show,
-	},
 };
 
 int __net_init udp6_proc_init(struct net *net)
 {
-	return udp_proc_register(net, &udp6_seq_afinfo);
+	if (!proc_create_data("udp6", 0444, net->proc_net,
+			&udp6_afinfo_seq_fops, &udp6_seq_afinfo))
+		return -ENOMEM;
+	return 0;
 }
 
 void udp6_proc_exit(struct net *net)
 {
-	udp_proc_unregister(net, &udp6_seq_afinfo);
+	remove_proc_entry("udp6", net->proc_net);
 }
 #endif /* CONFIG_PROC_FS */
 
diff --git a/net/ipv6/udplite.c b/net/ipv6/udplite.c
index 14ae32bb1f3d..a119e57196b5 100644
--- a/net/ipv6/udplite.c
+++ b/net/ipv6/udplite.c
@@ -12,6 +12,7 @@
  *		2 of the License, or (at your option) any later version.
  */
 #include <linux/export.h>
+#include <linux/proc_fs.h>
 #include "udp_impl.h"
 
 static int udplitev6_rcv(struct sk_buff *skb)
@@ -92,32 +93,22 @@ void udplitev6_exit(void)
 }
 
 #ifdef CONFIG_PROC_FS
-
-static const struct file_operations udplite6_afinfo_seq_fops = {
-	.open     = udp_seq_open,
-	.read     = seq_read,
-	.llseek   = seq_lseek,
-	.release  = seq_release_net
-};
-
 static struct udp_seq_afinfo udplite6_seq_afinfo = {
-	.name		= "udplite6",
 	.family		= AF_INET6,
 	.udp_table	= &udplite_table,
-	.seq_fops	= &udplite6_afinfo_seq_fops,
-	.seq_ops	= {
-		.show		= udp6_seq_show,
-	},
 };
 
 static int __net_init udplite6_proc_init_net(struct net *net)
 {
-	return udp_proc_register(net, &udplite6_seq_afinfo);
+	if (!proc_create_data("udplite6", 0444, net->proc_net,
+			&udp6_afinfo_seq_fops, &udplite6_seq_afinfo))
+		return -ENOMEM;
+	return 0;
 }
 
 static void __net_exit udplite6_proc_exit_net(struct net *net)
 {
-	udp_proc_unregister(net, &udplite6_seq_afinfo);
+	remove_proc_entry("udplite6", net->proc_net);
 }
 
 static struct pernet_operations udplite6_net_ops = {
-- 
2.17.0
