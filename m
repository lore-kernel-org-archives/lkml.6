Return-Path: <BATV+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AB8JxZqiwG83Hu0IM58tZq1wUxaSp4afxGEXpBZYA1llA9ywRBMYkGsP3NI9CU4IgxnRRuxwnEo5
ARC-Seal: i=1; a=rsa-sha256; t=1526463889; cv=none;
        d=google.com; s=arc-20160816;
        b=PuNSdifes0dwInZnbX1A5L2q4ejBv4M+i3R9G0Rcm0UF4FFF33n3sKDFZs+zgbQT6m
         XaeLsnxI+zXyxdNdZZhtaxQQncDek12m6hwb2jKCnk1qMp0zk87093fud9VzG76c06Du
         Hh3NtI+O7wNwV5jvVAVS9Y1iSG5g9Vccck9ybaIBpB/lLdmjniikcZnhfbAAvsqfq7Nc
         4ecio5KNaRP55UWO4Wil8zs64F4OMbqYdaSxzGYLRJheRDFy1U5CC7Q18mfKu4dcRBPl
         35QSZbzotYUfyOSQJGVB27rNDZPPBDUh23IjGmfBfTzHgpqoXBHDasVAWrGS/yjb8Fsz
         gFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=mYNbrhXkFkIaTP2vew1JoFR2pdbQAhs6jADC5xu9PW8=;
        b=poMzpKpBtNU1nqYcvzFC0Wy2lc8TMuyN98ps6flo9d+690WRBRSPm+ic7JEHDWgmJU
         Ba//ubdnDGeeLKt9/wrNXgc15AyuXHmyww4gLy9qO8YbE2CpkzT8GFf+PVvZ3KDqK/9e
         bTOe3CINCKMT02Nqst+FVLt9PYZfDwBcyzxfjTtzX8Tif4EwYI1/gKG+Pfl81tf6SsKe
         0jrzyZyUNqdV0PcAxT286r5bFGTnzImFLG7j3lKi0uo/20RKHEoQlkBF+Pk/vS8cjfmO
         VSuvv0dtRcnoHoB0NSXoPzD+Vwb722VSke71+WHLwcSELQ9zqmuPU3cVjOtq5ft7vFxT
         Yi4w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=KaZPGraA;
       spf=pass (google.com: best guess record for domain of batv+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=KaZPGraA;
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
Subject: [PATCH 13/42] ipv6/flowlabel: simplify pid namespace lookup
Date: Wed, 16 May 2018 11:43:17 +0200
Message-Id: <20180516094346.20506-14-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600613400354862578?=
X-GMAIL-MSGID: =?utf-8?q?1600613400354862578?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The code should be using the pid namespace from the procfs mount
instead of trying to look it up during open.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/ipv6/ip6_flowlabel.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index c05c4e82a7ca..2fbd9bed764a 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -754,6 +754,10 @@ static struct ip6_flowlabel *ip6fl_get_idx(struct seq_file *seq, loff_t pos)
 static void *ip6fl_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(RCU)
 {
+	struct ip6fl_iter_state *state = ip6fl_seq_private(seq);
+
+	state->pid_ns = proc_pid_ns(file_inode(seq->file));
+
 	rcu_read_lock_bh();
 	return *pos ? ip6fl_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 }
@@ -810,36 +814,15 @@ static const struct seq_operations ip6fl_seq_ops = {
 
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
