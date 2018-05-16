Return-Path: <BATV+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AB8JxZoUwo+6HYZc7kBfegG8qAMvSlY+QYH4QCkjro6xcFN0wZSHqHqTLpoDI2QCXpENF1/ywvYN
ARC-Seal: i=1; a=rsa-sha256; t=1526463851; cv=none;
        d=google.com; s=arc-20160816;
        b=gmPhawAwuyC73vTiJ4ZUj7FUcIUFpX3gkmRZ+xhW8VO7YTWIvQscQP7LmTp/Q5dEeY
         uzaJrxgu5ebkaXB4VgjFwfsCueES2s+6OZxIusEpRKoix2Y3FVKu7Xaza2UOUkiJ/1Bk
         UW3iU1kyzhOkqAKuLX26GWGbdwh+WA3yYbPq7+zZSJZ8mrj5QfMOIDXkYwzhWAw3FAZd
         nFTcFyQkxuxl4LPU2CwOZ/zLJb3SV99zBD0LXp5tAG5b9XdbmCiyyJ1CskGenWOENFTo
         aqLOyQ6ffQtI5wCeaKtqbjYpurUPL8Ipnf/Cc3Z+F4vAIucevK0wwVO+waLJTjQFn49W
         T3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=jjtc+BylkCQRbUezIax8ZwcWkqWdXi49U0dtgSfXUiE=;
        b=mz0wejemv/drO/43DQ+5IMGFjbKZgX/nfPDQB+wXsTA9Nw13tpYVXTUR5+PXw1K/6U
         ZCoMTI9Veozvap7s7z5cUsF2/h+7/7dFSD9VCvfwA7Yjk38KQXBEzSxza1cWBXC0fmzu
         zyqwqCUKxqYKJvhQJRqcvvZ+Xm7DUojyWyZnQAhY0RJJ9X2UTQ2HBG4QK9JL8LdKzrqy
         jMcRogitPpqAaCo9QKoAwwQE6H5qOItBoMdl+5MtOgSvU7AVbxCRpdQESAiR2FfwFLO2
         ckKeUwDiLIgjZrCzkyLYYdw932sIWdHxaj3OG8vSuPQHENh2AKLXXv0xZkMWsmPDYi38
         9jKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=tdE2ofw3;
       spf=pass (google.com: best guess record for domain of batv+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=tdE2ofw3;
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
Subject: [PATCH 05/42] proc: add a proc_create_reg helper
Date: Wed, 16 May 2018 11:43:09 +0200
Message-Id: <20180516094346.20506-6-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600613360088187898?=
X-GMAIL-MSGID: =?utf-8?q?1600613360088187898?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Common code for creating a regular file.  Factor out of proc_create_data, to
be reused by other functions soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/generic.c  | 44 +++++++++++++++++++++++++-------------------
 fs/proc/internal.h |  2 ++
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index bd8480ff0d35..ab6a321076b8 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -511,33 +511,39 @@ struct proc_dir_entry *proc_create_mount_point(const char *name)
 }
 EXPORT_SYMBOL(proc_create_mount_point);
 
-struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
-					struct proc_dir_entry *parent,
-					const struct file_operations *proc_fops,
-					void *data)
+struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
+		struct proc_dir_entry **parent, void *data)
 {
-	struct proc_dir_entry *pde;
+	struct proc_dir_entry *p;
+
 	if ((mode & S_IFMT) == 0)
 		mode |= S_IFREG;
-
-	if (!S_ISREG(mode)) {
-		WARN_ON(1);	/* use proc_mkdir() */
+	if ((mode & S_IALLUGO) == 0)
+		mode |= S_IRUGO;
+	if (WARN_ON_ONCE(!S_ISREG(mode)))
 		return NULL;
+
+	p = __proc_create(parent, name, mode, 1);
+	if (p) {
+		p->proc_iops = &proc_file_inode_operations;
+		p->data = data;
 	}
+	return p;
+}
+
+struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
+		struct proc_dir_entry *parent,
+		const struct file_operations *proc_fops, void *data)
+{
+	struct proc_dir_entry *p;
 
 	BUG_ON(proc_fops == NULL);
 
-	if ((mode & S_IALLUGO) == 0)
-		mode |= S_IRUGO;
-	pde = __proc_create(&parent, name, mode, 1);
-	if (!pde)
-		goto out;
-	pde->proc_fops = proc_fops;
-	pde->data = data;
-	pde->proc_iops = &proc_file_inode_operations;
-	return proc_register(parent, pde);
-out:
-	return NULL;
+	p = proc_create_reg(name, mode, &parent, data);
+	if (!p)
+		return NULL;
+	p->proc_fops = proc_fops;
+	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_data);
  
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 488e67490312..dd1e11400b97 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -162,6 +162,8 @@ extern bool proc_fill_cache(struct file *, struct dir_context *, const char *, i
 /*
  * generic.c
  */
+struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
+		struct proc_dir_entry **parent, void *data);
 struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 		struct proc_dir_entry *dp);
 extern struct dentry *proc_lookup(struct inode *, struct dentry *, unsigned int);
-- 
2.17.0
