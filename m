Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx4+qVn2kd67mHFHpFgx8/+BPpp6YkCQYg8po9nbuWdTMZEA/Zl/fYD5VduKFOBs8oReIyDWd
ARC-Seal: i=1; a=rsa-sha256; t=1524141834; cv=none;
        d=google.com; s=arc-20160816;
        b=TL818IppYIsJPrVz3ALl7Lnl80Vv1OGRFHrMxGwptA2XdcvcoY7JShkWjJxDqw4kaq
         Fin4RJ5iNUcNSnZ58tId2OpXTWT22It8Tlpl/upEL2DyWoBezU3NCNU7mueMR/1OQrbu
         IXgzC7bHDPeOq8LU75qoV9EmBNA1yAe4YE1vJ0EhHlJP9ALB+2NbfiQ5q9y+0cfUBxsJ
         tF/AwoVjk3iUn4v1/697Zg2uowyDRWQ0jLKTedK9OyRviYGGyBZoG/uPp7KEigrD7Sty
         VwR6R1q81rYMUrkFi0ke80S0C5olSWKIGsIxFXphoIynva1VJCgepKtNSulD0TVLwiLP
         +Z1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Unq0mxf27aZXbnCpwBc9AYmtS5GZ52gENh7T0Mh080Q=;
        b=ZGnUruZfzjeBj4QJwnDV5r6k6hOmwXqdfO5dCNk3krDlI5hYbBh7FRCpyqPEhgXydZ
         Vb3+vFLs/Cgc0O1jJP5/43PFyPvY3+psWm61L1juiEFlfbss7v6bbxacvOx6HtuIHC+L
         IYi6UVdsZhi7d8fn4IMe3Gfe0/tae0FPHUuUpDrUOvri1iL/74OUdjI73L5kG4VR8a+7
         dn7Vqx61DLDrwcUBAf9vlbhUB9Iw+Ha0OYU8NUrIyVUZ/m5dWJaoee06CjM+ossgupWG
         2UozYbrS6hbtEiaD0TWz4JJraO+9TA3M1O0eTkNempcCqb8i2Ek+PWc0heRLpEeDrm0j
         U7xw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=QPjQOY2s;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=QPjQOY2s;
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
Subject: [PATCH 36/39] proc: don't detour through seq->private to get the inode
Date: Thu, 19 Apr 2018 14:41:37 +0200
Message-Id: <20180419124140.9309-37-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178548960699426?=
X-GMAIL-MSGID: =?utf-8?q?1598178548960699426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/array.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index ae2c807fd719..b34796b562ef 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -677,7 +677,7 @@ get_children_pid(struct inode *inode, struct pid *pid_prev, loff_t pos)
 
 static int children_seq_show(struct seq_file *seq, void *v)
 {
-	struct inode *inode = seq->private;
+	struct inode *inode = file_inode(seq->file);
 	pid_t pid;
 
 	pid = pid_nr_ns(v, inode->i_sb->s_fs_info);
@@ -688,14 +688,14 @@ static int children_seq_show(struct seq_file *seq, void *v)
 
 static void *children_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	return get_children_pid(seq->private, NULL, *pos);
+	return get_children_pid(file_inode(seq->file), NULL, *pos);
 }
 
 static void *children_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct pid *pid;
 
-	pid = get_children_pid(seq->private, v, *pos + 1);
+	pid = get_children_pid(file_inode(seq->file), v, *pos + 1);
 	put_pid(v);
 
 	++*pos;
@@ -716,17 +716,7 @@ static const struct seq_operations children_seq_ops = {
 
 static int children_seq_open(struct inode *inode, struct file *file)
 {
-	struct seq_file *m;
-	int ret;
-
-	ret = seq_open(file, &children_seq_ops);
-	if (ret)
-		return ret;
-
-	m = file->private_data;
-	m->private = inode;
-
-	return ret;
+	return seq_open(file, &children_seq_ops);
 }
 
 const struct file_operations proc_tid_children_operations = {
-- 
2.17.0
