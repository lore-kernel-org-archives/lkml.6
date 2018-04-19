Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx4/XxkYZDZNIJddJjhAnUyNNXdXQz4vLhl+ovWYNIupwWnuaz+v2DaV1BHQJUr/K6jo4GYyr
ARC-Seal: i=1; a=rsa-sha256; t=1524141770; cv=none;
        d=google.com; s=arc-20160816;
        b=rrzNKoY2c37FrPF6sn1E2tK596gNHqJyp+WlVT7gkxGeQP9i+0NoaJE/oTX0en04vP
         Lj1oB7Uo5V73NX3Dtfpmm8CsWSGfB4j4P8QGTFCkg/oMGqx/xpV4hY5NwpxsDLEO4I0x
         /ljr91D3WPJ8r1IvADmPycjQibztnjcv3vmzHb5dqmstLX4MOUQhocHM5WIxuoBQjbNh
         eeD9ur/tKN0acb9z1kMbcHRrDXDh1pkiCw+wxECmRQ2cW9Rfyigm3MhEMH5J5TtWII+m
         fkE+42R7+XkgPEo2AUis6VoPzPHHBT8m6z2oWpujMixjjwpJM7MoORV26iB+g71YptG+
         sMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Gffy/CkB8TxFGyTQON5c0S4rP35wzv4ymcQPSLJXg80=;
        b=tOWnjaak5s2oBdJJOyR8MfXF3LpaVSHBocdrV9RxUJREIpjb0xbiiKbbCefrGqvexO
         V80skzNOei9WFVce3C6rwg2Ca5OIuevNPf2ylY89dN8TAtG3Hy6Ggzp17zNv3Mvcpagd
         fTOMMY/6Hk5b/a00hygUrvoEdfGV25gn9hQhY/UOvWu/W16AjzwjN2hMeAvAFw+Sk6kY
         0x8IUoQRC/bUx3IhTAuAfZNN9G+c8BkmLcfUUav7KeHXEWr2oopprvataQNhk6HOn+hD
         oGEdx9Fk0qWQEEnUV3xqsIitQfj55pXk5ubo6ltjlwgGSPzS2q8t3QlvVZEK/PQGlaAL
         YlNw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Sg558AEZ;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Sg558AEZ;
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
Subject: [PATCH 19/39] sg: simplify procfs code
Date: Thu, 19 Apr 2018 14:41:20 +0200
Message-Id: <20180419124140.9309-20-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178481297337899?=
X-GMAIL-MSGID: =?utf-8?q?1598178481297337899?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use remove_proc_subtree to remove the whole subtree on cleanup, and
unwind the registration loop into individual calls.  Switch to use
proc_create_seq where applicable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sg.c | 124 +++++-----------------------------------------
 1 file changed, 12 insertions(+), 112 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index c198b96368dd..8ff687158704 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -66,7 +66,6 @@ static int sg_version_num = 30536;	/* 2 digits for each component */
 static char *sg_version_date = "20140603";
 
 static int sg_proc_init(void);
-static void sg_proc_cleanup(void);
 #endif
 
 #define SG_ALLOW_DIO_DEF 0
@@ -1661,7 +1660,7 @@ static void __exit
 exit_sg(void)
 {
 #ifdef CONFIG_SCSI_PROC_FS
-	sg_proc_cleanup();
+	remove_proc_subtree("scsi/sg", NULL);
 #endif				/* CONFIG_SCSI_PROC_FS */
 	scsi_unregister_interface(&sg_interface);
 	class_destroy(sg_sysfs_class);
@@ -2274,11 +2273,6 @@ sg_get_dev(int dev)
 }
 
 #ifdef CONFIG_SCSI_PROC_FS
-
-static struct proc_dir_entry *sg_proc_sgp = NULL;
-
-static char sg_proc_sg_dirname[] = "scsi/sg";
-
 static int sg_proc_seq_show_int(struct seq_file *s, void *v);
 
 static int sg_proc_single_open_adio(struct inode *inode, struct file *file);
@@ -2306,37 +2300,11 @@ static const struct file_operations dressz_fops = {
 };
 
 static int sg_proc_seq_show_version(struct seq_file *s, void *v);
-static int sg_proc_single_open_version(struct inode *inode, struct file *file);
-static const struct file_operations version_fops = {
-	.owner = THIS_MODULE,
-	.open = sg_proc_single_open_version,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
 static int sg_proc_seq_show_devhdr(struct seq_file *s, void *v);
-static int sg_proc_single_open_devhdr(struct inode *inode, struct file *file);
-static const struct file_operations devhdr_fops = {
-	.owner = THIS_MODULE,
-	.open = sg_proc_single_open_devhdr,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
 static int sg_proc_seq_show_dev(struct seq_file *s, void *v);
-static int sg_proc_open_dev(struct inode *inode, struct file *file);
 static void * dev_seq_start(struct seq_file *s, loff_t *pos);
 static void * dev_seq_next(struct seq_file *s, void *v, loff_t *pos);
 static void dev_seq_stop(struct seq_file *s, void *v);
-static const struct file_operations dev_fops = {
-	.owner = THIS_MODULE,
-	.open = sg_proc_open_dev,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = seq_release,
-};
 static const struct seq_operations dev_seq_ops = {
 	.start = dev_seq_start,
 	.next  = dev_seq_next,
@@ -2345,14 +2313,6 @@ static const struct seq_operations dev_seq_ops = {
 };
 
 static int sg_proc_seq_show_devstrs(struct seq_file *s, void *v);
-static int sg_proc_open_devstrs(struct inode *inode, struct file *file);
-static const struct file_operations devstrs_fops = {
-	.owner = THIS_MODULE,
-	.open = sg_proc_open_devstrs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = seq_release,
-};
 static const struct seq_operations devstrs_seq_ops = {
 	.start = dev_seq_start,
 	.next  = dev_seq_next,
@@ -2361,14 +2321,6 @@ static const struct seq_operations devstrs_seq_ops = {
 };
 
 static int sg_proc_seq_show_debug(struct seq_file *s, void *v);
-static int sg_proc_open_debug(struct inode *inode, struct file *file);
-static const struct file_operations debug_fops = {
-	.owner = THIS_MODULE,
-	.open = sg_proc_open_debug,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = seq_release,
-};
 static const struct seq_operations debug_seq_ops = {
 	.start = dev_seq_start,
 	.next  = dev_seq_next,
@@ -2376,50 +2328,23 @@ static const struct seq_operations debug_seq_ops = {
 	.show  = sg_proc_seq_show_debug,
 };
 
-
-struct sg_proc_leaf {
-	const char * name;
-	const struct file_operations * fops;
-};
-
-static const struct sg_proc_leaf sg_proc_leaf_arr[] = {
-	{"allow_dio", &adio_fops},
-	{"debug", &debug_fops},
-	{"def_reserved_size", &dressz_fops},
-	{"device_hdr", &devhdr_fops},
-	{"devices", &dev_fops},
-	{"device_strs", &devstrs_fops},
-	{"version", &version_fops}
-};
-
 static int
 sg_proc_init(void)
 {
-	int num_leaves = ARRAY_SIZE(sg_proc_leaf_arr);
-	int k;
+	struct proc_dir_entry *p;
 
-	sg_proc_sgp = proc_mkdir(sg_proc_sg_dirname, NULL);
-	if (!sg_proc_sgp)
+	p = proc_mkdir("scsi/sg", NULL);
+	if (!p)
 		return 1;
-	for (k = 0; k < num_leaves; ++k) {
-		const struct sg_proc_leaf *leaf = &sg_proc_leaf_arr[k];
-		umode_t mask = leaf->fops->write ? S_IRUGO | S_IWUSR : S_IRUGO;
-		proc_create(leaf->name, mask, sg_proc_sgp, leaf->fops);
-	}
-	return 0;
-}
 
-static void
-sg_proc_cleanup(void)
-{
-	int k;
-	int num_leaves = ARRAY_SIZE(sg_proc_leaf_arr);
-
-	if (!sg_proc_sgp)
-		return;
-	for (k = 0; k < num_leaves; ++k)
-		remove_proc_entry(sg_proc_leaf_arr[k].name, sg_proc_sgp);
-	remove_proc_entry(sg_proc_sg_dirname, NULL);
+	proc_create("allow_dio", S_IRUGO | S_IWUSR, p, &adio_fops);
+	proc_create_seq("debug", S_IRUGO, p, &debug_seq_ops);
+	proc_create("def_reserved_size", S_IRUGO | S_IWUSR, p, &dressz_fops);
+	proc_create_single("device_hdr", S_IRUGO, p, sg_proc_seq_show_devhdr);
+	proc_create_seq("devices", S_IRUGO, p, &dev_seq_ops);
+	proc_create_seq("device_strs", S_IRUGO, p, &devstrs_seq_ops);
+	proc_create_single("version", S_IRUGO, p, sg_proc_seq_show_version);
+	return 0;
 }
 
 
@@ -2482,22 +2407,12 @@ static int sg_proc_seq_show_version(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int sg_proc_single_open_version(struct inode *inode, struct file *file)
-{
-	return single_open(file, sg_proc_seq_show_version, NULL);
-}
-
 static int sg_proc_seq_show_devhdr(struct seq_file *s, void *v)
 {
 	seq_puts(s, "host\tchan\tid\tlun\ttype\topens\tqdepth\tbusy\tonline\n");
 	return 0;
 }
 
-static int sg_proc_single_open_devhdr(struct inode *inode, struct file *file)
-{
-	return single_open(file, sg_proc_seq_show_devhdr, NULL);
-}
-
 struct sg_proc_deviter {
 	loff_t	index;
 	size_t	max;
@@ -2531,11 +2446,6 @@ static void dev_seq_stop(struct seq_file *s, void *v)
 	kfree(s->private);
 }
 
-static int sg_proc_open_dev(struct inode *inode, struct file *file)
-{
-        return seq_open(file, &dev_seq_ops);
-}
-
 static int sg_proc_seq_show_dev(struct seq_file *s, void *v)
 {
 	struct sg_proc_deviter * it = (struct sg_proc_deviter *) v;
@@ -2562,11 +2472,6 @@ static int sg_proc_seq_show_dev(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int sg_proc_open_devstrs(struct inode *inode, struct file *file)
-{
-        return seq_open(file, &devstrs_seq_ops);
-}
-
 static int sg_proc_seq_show_devstrs(struct seq_file *s, void *v)
 {
 	struct sg_proc_deviter * it = (struct sg_proc_deviter *) v;
@@ -2650,11 +2555,6 @@ static void sg_proc_debug_helper(struct seq_file *s, Sg_device * sdp)
 	}
 }
 
-static int sg_proc_open_debug(struct inode *inode, struct file *file)
-{
-        return seq_open(file, &debug_seq_ops);
-}
-
 static int sg_proc_seq_show_debug(struct seq_file *s, void *v)
 {
 	struct sg_proc_deviter * it = (struct sg_proc_deviter *) v;
-- 
2.17.0
