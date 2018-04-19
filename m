Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx49pvFOvVWAfg+odID0Q0rTvX0WjHr+nKq9uytcYA8GvlrnF1DwV4C77Fd0ofEbDq0QiXjGI
ARC-Seal: i=1; a=rsa-sha256; t=1524141813; cv=none;
        d=google.com; s=arc-20160816;
        b=TxikfiACcZ6pL0o75Zb+Ve9VX53dYnaoFuUQdle9kkf7ehyhga3LcniqeAu31Ft5cG
         TM4iIQVCLY36HgvaNcdWGLP8j3Oxy9jAjMLNk7cooDiGazOMoOpp2knDBU1H+KvJ/7GI
         Sbv8/cc30T+DtEHRJYMyFxYcca4y4vQhrWHvSRYIo0Mj6DmGdChnHqEsv/k5s9dGkmm+
         rDaUzOD9h22M8hR4zauMxSIx/Bflw8CrK1MNGvUFtwi+nQw3dmSOa5UWhdRj0xEIQ27r
         hEZUSMSV5iwQ7jGsP0ldvpssN6iIC1NSUB4g3HH9ghPBe5hrJqnyEXeF6bl85yPTAGh2
         1lGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=0wLJ3bkwSeOR22OAHbcwknDQU4rMP4Ms9x2jBKkLeGg=;
        b=huHn1c9/pKQXmn/pkVp/RVsptWXquXWAB9stJv/8mb/KJGJnDgdR2tCgyp0p5R95BE
         TRNYK7O3ryv5jPi1E8DPPmN3DvYjwxKDxwPhkPcB2xl4iXUP8wAuAMnQ9/y8ZkCCfxIG
         pn3iiEwn0fyNX96d5KtH+ig4zJApsJBKPBftB0DDB1euEGW/6j4R5WcpwYHC4lAIAS8M
         9CmJIeuvvBnbYYE69lMnaIfmxvtEGiJImmbeZ2Zdf2ubG6UX6bvFpUSMX5S2MLAb5Qn/
         lp1E5cxRmFJWHps+tDxf2btABsxXqkoysDi7EhrJV0kAs6nz/9rbFxmfMlehH8omkPGJ
         YDNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=VoEXdlBc;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=VoEXdlBc;
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
Subject: [PATCH 30/39] netfilter/xt_hashlimit: switch to proc_create_{seq,single}_data
Date: Thu, 19 Apr 2018 14:41:31 +0200
Message-Id: <20180419124140.9309-31-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178525988614920?=
X-GMAIL-MSGID: =?utf-8?q?1598178525988614920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

And use proc private data directly instead of doing a detour
through seq->private.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/netfilter/xt_hashlimit.c | 92 +++++++-----------------------------
 1 file changed, 18 insertions(+), 74 deletions(-)

diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
index 0cd73567e7ff..9b16402f29af 100644
--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -57,9 +57,9 @@ static inline struct hashlimit_net *hashlimit_pernet(struct net *net)
 }
 
 /* need to declare this at the top */
-static const struct file_operations dl_file_ops_v2;
-static const struct file_operations dl_file_ops_v1;
-static const struct file_operations dl_file_ops;
+static const struct seq_operations dl_seq_ops_v2;
+static const struct seq_operations dl_seq_ops_v1;
+static const struct seq_operations dl_seq_ops;
 
 /* hash table crap */
 struct dsthash_dst {
@@ -272,7 +272,7 @@ static int htable_create(struct net *net, struct hashlimit_cfg3 *cfg,
 {
 	struct hashlimit_net *hashlimit_net = hashlimit_pernet(net);
 	struct xt_hashlimit_htable *hinfo;
-	const struct file_operations *fops;
+	const struct seq_operations *ops;
 	unsigned int size, i;
 	int ret;
 
@@ -321,19 +321,19 @@ static int htable_create(struct net *net, struct hashlimit_cfg3 *cfg,
 
 	switch (revision) {
 	case 1:
-		fops = &dl_file_ops_v1;
+		ops = &dl_seq_ops_v1;
 		break;
 	case 2:
-		fops = &dl_file_ops_v2;
+		ops = &dl_seq_ops_v2;
 		break;
 	default:
-		fops = &dl_file_ops;
+		ops = &dl_seq_ops;
 	}
 
-	hinfo->pde = proc_create_data(name, 0,
+	hinfo->pde = proc_create_seq_data(name, 0,
 		(family == NFPROTO_IPV4) ?
 		hashlimit_net->ipt_hashlimit : hashlimit_net->ip6t_hashlimit,
-		fops, hinfo);
+		ops, hinfo);
 	if (hinfo->pde == NULL) {
 		kfree(hinfo->name);
 		vfree(hinfo);
@@ -1057,7 +1057,7 @@ static struct xt_match hashlimit_mt_reg[] __read_mostly = {
 static void *dl_seq_start(struct seq_file *s, loff_t *pos)
 	__acquires(htable->lock)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket;
 
 	spin_lock_bh(&htable->lock);
@@ -1074,7 +1074,7 @@ static void *dl_seq_start(struct seq_file *s, loff_t *pos)
 
 static void *dl_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket = v;
 
 	*pos = ++(*bucket);
@@ -1088,7 +1088,7 @@ static void *dl_seq_next(struct seq_file *s, void *v, loff_t *pos)
 static void dl_seq_stop(struct seq_file *s, void *v)
 	__releases(htable->lock)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket = v;
 
 	if (!IS_ERR(bucket))
@@ -1130,7 +1130,7 @@ static void dl_seq_print(struct dsthash_ent *ent, u_int8_t family,
 static int dl_seq_real_show_v2(struct dsthash_ent *ent, u_int8_t family,
 			       struct seq_file *s)
 {
-	const struct xt_hashlimit_htable *ht = s->private;
+	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->private));
 
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1145,7 +1145,7 @@ static int dl_seq_real_show_v2(struct dsthash_ent *ent, u_int8_t family,
 static int dl_seq_real_show_v1(struct dsthash_ent *ent, u_int8_t family,
 			       struct seq_file *s)
 {
-	const struct xt_hashlimit_htable *ht = s->private;
+	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->private));
 
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1160,7 +1160,7 @@ static int dl_seq_real_show_v1(struct dsthash_ent *ent, u_int8_t family,
 static int dl_seq_real_show(struct dsthash_ent *ent, u_int8_t family,
 			    struct seq_file *s)
 {
-	const struct xt_hashlimit_htable *ht = s->private;
+	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->private));
 
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1174,7 +1174,7 @@ static int dl_seq_real_show(struct dsthash_ent *ent, u_int8_t family,
 
 static int dl_seq_show_v2(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket = (unsigned int *)v;
 	struct dsthash_ent *ent;
 
@@ -1188,7 +1188,7 @@ static int dl_seq_show_v2(struct seq_file *s, void *v)
 
 static int dl_seq_show_v1(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket = v;
 	struct dsthash_ent *ent;
 
@@ -1202,7 +1202,7 @@ static int dl_seq_show_v1(struct seq_file *s, void *v)
 
 static int dl_seq_show(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket = v;
 	struct dsthash_ent *ent;
 
@@ -1235,62 +1235,6 @@ static const struct seq_operations dl_seq_ops = {
 	.show  = dl_seq_show
 };
 
-static int dl_proc_open_v2(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &dl_seq_ops_v2);
-
-	if (!ret) {
-		struct seq_file *sf = file->private_data;
-
-		sf->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static int dl_proc_open_v1(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &dl_seq_ops_v1);
-
-	if (!ret) {
-		struct seq_file *sf = file->private_data;
-		sf->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static int dl_proc_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &dl_seq_ops);
-
-	if (!ret) {
-		struct seq_file *sf = file->private_data;
-
-		sf->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static const struct file_operations dl_file_ops_v2 = {
-	.open    = dl_proc_open_v2,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
-
-static const struct file_operations dl_file_ops_v1 = {
-	.open    = dl_proc_open_v1,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
-
-static const struct file_operations dl_file_ops = {
-	.open    = dl_proc_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
-
 static int __net_init hashlimit_proc_net_init(struct net *net)
 {
 	struct hashlimit_net *hashlimit_net = hashlimit_pernet(net);
-- 
2.17.0
