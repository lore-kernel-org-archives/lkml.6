Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx48y1WF5Q0GrX/JK+9dyHTF3xASBZXah/EM9EJK0pgKPSnOajglxm7jnmZzBFMRNjC7kQjU7
ARC-Seal: i=1; a=rsa-sha256; t=1524141738; cv=none;
        d=google.com; s=arc-20160816;
        b=uOvyoo7X6I/LViNK+meFvYwSHYKeuhy8WUTQGFDqgfJln4YuxvlY0VXK2lc2MBUtyW
         zGe5dh1RG1OXUBjfjFEXPsotpxPeeGbz/YThtzlejglkXqm7HEmEy2c66a1GIp8qbenH
         iqlYCOq7Yc+SUgnH2XOUgl/BF+e8QRnUaS9QETBwLeLbfp3M9afis3mvCusiM6cg0toU
         1UNYnQefc5Z3V272jBi3vZLgSe+elHR3075QH/K59Cgxammluv7PnLRw7J1Ek/6Lqunm
         GgpOYCoRymj/kbr58u5WBhrH+GEm0n6THihc0zjNK60H1kFv2hVrp/bjqarwhBP0CPVL
         WMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Nr/fMNa2EYIfUJMtZ3v5wAxQojen7+SQUINM1QCPTpU=;
        b=YzbW/6S6EzEqGkx/CgvZrD5Rg2SCWy+yTJT8+5Z2VUkl48ooFCJ8fvwFn2bkliLdpo
         6fkot5NJfWdcUG56oUpjRXasxSd3G01swilRUt4tEfzX5kq51duGaX8Xr3+bkFddAeNn
         ewE6NUHoOI6detJlIbXEFfMBDxasyaS7Y/VbQvyjKGmJP/YoV9RkzcF8Lhz2LuO5TwwH
         R4CD7NDmg8dLTKwCwpjJcwJKj7I7g0sVphQHOo4c6po0nbyOZaHCtuJkpv5rpRrDbdir
         ahOM70Nq95Fej47XteAruqPfhi+rzf0vvPeYcZCNrei/lQZB8Y9+WZEAhUvvwPaFOqAG
         OSKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=fDl1fDZ1;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=fDl1fDZ1;
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
Subject: [PATCH 09/39] ipv6/flowlabel: simplify pid namespace lookup
Date: Thu, 19 Apr 2018 14:41:10 +0200
Message-Id: <20180419124140.9309-10-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178447068712906?=
X-GMAIL-MSGID: =?utf-8?q?1598178447068712906?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The shole seq_file sequence already operates under a single RCU lock pair,
so move the pid namespace lookup into it, and stop grabbing a reference
and remove all kinds of boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/ipv6/ip6_flowlabel.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index c05c4e82a7ca..a9f221d45ef9 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -754,7 +754,10 @@ static struct ip6_flowlabel *ip6fl_get_idx(struct seq_file *seq, loff_t pos)
 static void *ip6fl_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(RCU)
 {
+	struct ip6fl_iter_state *state = ip6fl_seq_private(seq);
+
 	rcu_read_lock_bh();
+	state->pid_ns = task_active_pid_ns(current);
 	return *pos ? ip6fl_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 }
 
@@ -810,36 +813,15 @@ static const struct seq_operations ip6fl_seq_ops = {
 
 static int ip6fl_seq_open(struct inode *inode, struct file *file)
 {
-	struct seq_file *seq;
-	struct ip6fl_iter_state *state;
-	int err;
-
-	err = seq_open_net(inode, file, &ip6fl_seq_ops,
+	return seq_open_net(inode, file, &ip6fl_seq_ops,
 			   sizeof(struct ip6fl_iter_state));
-
-	if (!err) {
-		seq = file->private_data;
-		state = ip6fl_seq_private(seq);
-		rcu_read_lock();
-		state->pid_ns = get_pid_ns(task_active_pid_ns(current));
-		rcu_read_unlock();
-	}
-	return err;
-}
-
-static int ip6fl_seq_release(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq = file->private_data;
-	struct ip6fl_iter_state *state = ip6fl_seq_private(seq);
-	put_pid_ns(state->pid_ns);
-	return seq_release_net(inode, file);
 }
 
 static const struct file_operations ip6fl_seq_fops = {
 	.open		=	ip6fl_seq_open,
 	.read		=	seq_read,
 	.llseek		=	seq_lseek,
-	.release	=	ip6fl_seq_release,
+	.release	=	seq_release_net,
 };
 
 static int __net_init ip6_flowlabel_proc_init(struct net *net)
-- 
2.17.0
