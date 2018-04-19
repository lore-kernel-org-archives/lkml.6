Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx4/hJjuPW1JQmegO5WmOGYZSqxnlvO7Q+ZJh6amTGk6MwFlqUCe2klv0nFUE/KmF3Ct1FhAc
ARC-Seal: i=1; a=rsa-sha256; t=1524141797; cv=none;
        d=google.com; s=arc-20160816;
        b=hbGXA3fjxJ6G1/Kyoi3+OKlc30cdR1atelWpCwWS9cuQ3lLW9xBhlDjybgwkY5pDMj
         li3TW0JKlArRilu/naDFi9HQQgBz0QGRtSKVNawlGaM+5b0o5yBOv3RbOVmVZPk4dpkO
         EfKkZK0++9O9YF2qvcQXZVQcCalVFZiKMHXvGtXuBHubsHP6tYaKG7oGAbHu+4eU8UqF
         EHPX/uW37ePLWz7Nj8T2Jg6zAkNJamXjTqtZw1f9zpRlO8lHb3kDbRMyu1SvEKO4iF0H
         aGz+3OuSwtJRgVQONC6cDhAu8cgN495tKOdkGCVEFa19KU177V0uWBV2ik4h8KYjWOgw
         +urA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Fxs1vB86YKtWq7jeY8OJ1X4ZOh0/9yrlTlsMzJNSCWo=;
        b=CXtiXcIUFhU1HuTzVQCmR8XuYtRV9x1bdY4p8N1JmpmWJmPoiAw+Q1rM9t5y9bN0G6
         7TpyatrNKWDtpdiBLe2dhAVYVKsf/leMys8SNFQ8jHmlBIJwdaUzNvfJpRUdg3r/WjzY
         9oaYKIyGhOMkKxZAoVLd/Y5DCgtwDW+5NnnTFUPFH36RrTIbcX3G7GU3TjTg+oNVZU6s
         K1gPZI0p4EfRVcOVbymJYV9xUciLOFxRoLGOWI3bF05sFaXtGrp1znRKENwN53fl8Ivr
         3IKSys6OVfAWY6/x0jebLMp0HttVy4bc9g2pkAs5LJxWlFXoHdWfOAOzuxykK1InossB
         lYpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Csr3SkhF;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Csr3SkhF;
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
Subject: [PATCH 27/39] bonding: switch to proc_create_seq_data
Date: Thu, 19 Apr 2018 14:41:28 +0200
Message-Id: <20180419124140.9309-28-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178509372204114?=
X-GMAIL-MSGID: =?utf-8?q?1598178509372204114?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

And use proc private data directly instead of doing a detour
through seq->private.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/bonding/bond_procfs.c | 36 ++++++-------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index 01059f1a7bca..9f7d83e827c3 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -10,7 +10,7 @@
 static void *bond_info_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(RCU)
 {
-	struct bonding *bond = seq->private;
+	struct bonding *bond = PDE_DATA(file_inode(seq->file));
 	struct list_head *iter;
 	struct slave *slave;
 	loff_t off = 0;
@@ -29,7 +29,7 @@ static void *bond_info_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *bond_info_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct bonding *bond = seq->private;
+	struct bonding *bond = PDE_DATA(file_inode(seq->file));
 	struct list_head *iter;
 	struct slave *slave;
 	bool found = false;
@@ -56,7 +56,7 @@ static void bond_info_seq_stop(struct seq_file *seq, void *v)
 
 static void bond_info_show_master(struct seq_file *seq)
 {
-	struct bonding *bond = seq->private;
+	struct bonding *bond = PDE_DATA(file_inode(seq->file));
 	const struct bond_opt_value *optval;
 	struct slave *curr, *primary;
 	int i;
@@ -167,7 +167,7 @@ static void bond_info_show_master(struct seq_file *seq)
 static void bond_info_show_slave(struct seq_file *seq,
 				 const struct slave *slave)
 {
-	struct bonding *bond = seq->private;
+	struct bonding *bond = PDE_DATA(file_inode(seq->file));
 
 	seq_printf(seq, "\nSlave Interface: %s\n", slave->dev->name);
 	seq_printf(seq, "MII Status: %s\n", bond_slave_link_status(slave->link));
@@ -257,38 +257,14 @@ static const struct seq_operations bond_info_seq_ops = {
 	.show  = bond_info_seq_show,
 };
 
-static int bond_info_open(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq;
-	int res;
-
-	res = seq_open(file, &bond_info_seq_ops);
-	if (!res) {
-		/* recover the pointer buried in proc_dir_entry data */
-		seq = file->private_data;
-		seq->private = PDE_DATA(inode);
-	}
-
-	return res;
-}
-
-static const struct file_operations bond_info_fops = {
-	.owner   = THIS_MODULE,
-	.open    = bond_info_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
-};
-
 void bond_create_proc_entry(struct bonding *bond)
 {
 	struct net_device *bond_dev = bond->dev;
 	struct bond_net *bn = net_generic(dev_net(bond_dev), bond_net_id);
 
 	if (bn->proc_dir) {
-		bond->proc_entry = proc_create_data(bond_dev->name,
-						    0444, bn->proc_dir,
-						    &bond_info_fops, bond);
+		bond->proc_entry = proc_create_seq_data(bond_dev->name, 0444,
+				bn->proc_dir, &bond_info_seq_ops, bond);
 		if (bond->proc_entry == NULL)
 			netdev_warn(bond_dev, "Cannot create /proc/net/%s/%s\n",
 				    DRV_NAME, bond_dev->name);
-- 
2.17.0
