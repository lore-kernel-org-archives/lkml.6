Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx49wf2vTBwhh9jWdjVQxysQ1Bk1PlnngybxXnFgAYvlgt4910uwfINRfp1csGlDBBFYHuPRl
ARC-Seal: i=1; a=rsa-sha256; t=1524141730; cv=none;
        d=google.com; s=arc-20160816;
        b=W8utUeEC4n/bzGMHOm6kKxFR8zojyO6uy+xGzYsnpCqvYoxeDL4TrQmwypj9eDWkG+
         ic0Qh5LGZEyi56pDFkfLZ0KNFq0vxidCDNzBCpqd64KJZSGCo8KRKnzmwwfuxLRwnfnP
         mU5+v0gEYqKDfKTpW4bxLmr86IrSrzRGmckgVwEEvPTNS7deYCUJoQXMwMHkKO+WHi8I
         jVknbElfJbBh7y4KnK+m4htjGi1qN92KVoEgbH35YEcNGoGj6p+qUSOkdIkykePg2+/+
         Y4W5KSIEj5NnutpIt3I0dPIr6k3HMJECyzXagvEucWSpHe/bNoApEtXiUd5aEgC5OVyu
         G62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=0gAsRZ0ygc5+4tN/PV+3KgQjCIDrOdKDQ8tZ4Dhab5Q=;
        b=ISJT55Tv9duNydwGEiYHyPkpd8gDPpMCNGzsWrFqdx8/bUH4g32lBTos5/CBvEqtFv
         Km7rZ53+6v4P4iDh1yk/WGNp0ORb7M8eq6pIHirlgaYESSmLa26Kp6jb06khs8pILYTI
         XPsBipzmrAPIQS/v4L6oA6eHzx3/FlL+MWg0sIvPdlWqFEFKbRXdj2iNR6gRo5l86wge
         8PNC6wkcgZvd4nQ+DVbCTdGec+oTffe+IlUAqkR4Z9Q88ax0jQYmnYY4SQ9XbVVv6PuT
         oQInq2wDAt8UibMV61XHmW1MDMWaP/yMdoifBywDIWos0g4UyMMzrJT/WiWrRkUOjXC9
         IP9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=NCkbmfzS;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=NCkbmfzS;
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
Subject: [PATCH 07/39] ipv{4,6}/ping: simplify proc file creation
Date: Thu, 19 Apr 2018 14:41:08 +0200
Message-Id: <20180419124140.9309-8-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178439888723934?=
X-GMAIL-MSGID: =?utf-8?q?1598178439888723934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove the pointless ping_seq_afinfo indirection and make the code look
like most other protocols.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/ping.h | 11 ----------
 net/ipv4/ping.c    | 50 +++++++++++++---------------------------------
 net/ipv6/ping.c    | 35 +++++++++++++++++++++-----------
 3 files changed, 37 insertions(+), 59 deletions(-)

diff --git a/include/net/ping.h b/include/net/ping.h
index 4cd90d6b5c25..fd080e043a6e 100644
--- a/include/net/ping.h
+++ b/include/net/ping.h
@@ -83,20 +83,9 @@ int  ping_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
 bool ping_rcv(struct sk_buff *skb);
 
 #ifdef CONFIG_PROC_FS
-struct ping_seq_afinfo {
-	char				*name;
-	sa_family_t			family;
-	const struct file_operations	*seq_fops;
-	const struct seq_operations	seq_ops;
-};
-
-extern const struct file_operations ping_seq_fops;
-
 void *ping_seq_start(struct seq_file *seq, loff_t *pos, sa_family_t family);
 void *ping_seq_next(struct seq_file *seq, void *v, loff_t *pos);
 void ping_seq_stop(struct seq_file *seq, void *v);
-int ping_proc_register(struct net *net, struct ping_seq_afinfo *afinfo);
-void ping_proc_unregister(struct net *net, struct ping_seq_afinfo *afinfo);
 
 int __init ping_proc_init(void);
 void ping_proc_exit(void);
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 05e47d777009..83170ebf5dfc 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -1147,58 +1147,36 @@ static int ping_v4_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int ping_seq_open(struct inode *inode, struct file *file)
+static const struct seq_operations ping_v4_seq_ops = {
+	.start		= ping_v4_seq_start,
+	.show		= ping_v4_seq_show,
+	.next		= ping_seq_next,
+	.stop		= ping_seq_stop,
+};
+
+static int ping_v4_seq_open(struct inode *inode, struct file *file)
 {
-	struct ping_seq_afinfo *afinfo = PDE_DATA(inode);
-	return seq_open_net(inode, file, &afinfo->seq_ops,
+	return seq_open_net(inode, file, &ping_v4_seq_ops,
 			   sizeof(struct ping_iter_state));
 }
 
-const struct file_operations ping_seq_fops = {
-	.open		= ping_seq_open,
+const struct file_operations ping_v4_seq_fops = {
+	.open		= ping_v4_seq_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= seq_release_net,
 };
-EXPORT_SYMBOL_GPL(ping_seq_fops);
-
-static struct ping_seq_afinfo ping_v4_seq_afinfo = {
-	.name		= "icmp",
-	.family		= AF_INET,
-	.seq_fops	= &ping_seq_fops,
-	.seq_ops	= {
-		.start		= ping_v4_seq_start,
-		.show		= ping_v4_seq_show,
-		.next		= ping_seq_next,
-		.stop		= ping_seq_stop,
-	},
-};
 
-int ping_proc_register(struct net *net, struct ping_seq_afinfo *afinfo)
+static int __net_init ping_v4_proc_init_net(struct net *net)
 {
-	struct proc_dir_entry *p;
-	p = proc_create_data(afinfo->name, 0444, net->proc_net,
-			     afinfo->seq_fops, afinfo);
-	if (!p)
+	if (!proc_create("icmp", 0444, net->proc_net, &ping_v4_seq_fops))
 		return -ENOMEM;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ping_proc_register);
-
-void ping_proc_unregister(struct net *net, struct ping_seq_afinfo *afinfo)
-{
-	remove_proc_entry(afinfo->name, net->proc_net);
-}
-EXPORT_SYMBOL_GPL(ping_proc_unregister);
-
-static int __net_init ping_v4_proc_init_net(struct net *net)
-{
-	return ping_proc_register(net, &ping_v4_seq_afinfo);
-}
 
 static void __net_exit ping_v4_proc_exit_net(struct net *net)
 {
-	ping_proc_unregister(net, &ping_v4_seq_afinfo);
+	remove_proc_entry("icmp", net->proc_net);
 }
 
 static struct pernet_operations ping_v4_net_ops = {
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 746eeae7f581..45d5c8e0f2bf 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -24,6 +24,7 @@
 #include <net/protocol.h>
 #include <net/udp.h>
 #include <net/transp_v6.h>
+#include <linux/proc_fs.h>
 #include <net/ping.h>
 
 /* Compatibility glue so we can support IPv6 when it's compiled as a module */
@@ -215,26 +216,36 @@ static int ping_v6_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static struct ping_seq_afinfo ping_v6_seq_afinfo = {
-	.name		= "icmp6",
-	.family		= AF_INET6,
-	.seq_fops       = &ping_seq_fops,
-	.seq_ops	= {
-		.start		= ping_v6_seq_start,
-		.show		= ping_v6_seq_show,
-		.next		= ping_seq_next,
-		.stop		= ping_seq_stop,
-	},
+static const struct seq_operations ping_v6_seq_ops = {
+	.start		= ping_v6_seq_start,
+	.show		= ping_v6_seq_show,
+	.next		= ping_seq_next,
+	.stop		= ping_seq_stop,
+};
+
+static int ping_v6_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open_net(inode, file, &ping_v6_seq_ops,
+			   sizeof(struct ping_iter_state));
+}
+
+const struct file_operations ping_v6_seq_fops = {
+	.open		= ping_v6_seq_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release_net,
 };
 
 static int __net_init ping_v6_proc_init_net(struct net *net)
 {
-	return ping_proc_register(net, &ping_v6_seq_afinfo);
+	if (!proc_create("icmp6", 0444, net->proc_net, &ping_v6_seq_fops))
+		return -ENOMEM;
+	return 0;
 }
 
 static void __net_init ping_v6_proc_exit_net(struct net *net)
 {
-	return ping_proc_unregister(net, &ping_v6_seq_afinfo);
+	remove_proc_entry("icmp6", net->proc_net);
 }
 
 static struct pernet_operations ping_v6_net_ops = {
-- 
2.17.0
