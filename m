Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx4+uiUy+NtwMVbBwGAcSiv2koOOD2WtCP99TBNVDJqFl4d9OEjLR8c6BaGDljPgOnXcjRjqB
ARC-Seal: i=1; a=rsa-sha256; t=1524141787; cv=none;
        d=google.com; s=arc-20160816;
        b=eoxd4Ef5Cm9S04GGBKdCIhsGb5cRlEVB5ktnv9kIazxieaWLNOuKp2pp42qKIEMCZE
         WNiAG2Vrw4kPtQLJA4xRNM0UpLp3VsHhoGSCQwFegVjIRUFsc/DrMsONLp+wqldyP2oW
         PK8S+/KgDmFj5X36U9ig0BSq81nWeseJH8abEZFtfGqlQvgyi4w4d9hp16JqqJbq64o6
         S6AwgrN/jPswBfY1gBDeicJgqmDlzQ1MdOAcokwakDEjCKlOJtXMrocrnQrJPSxwTy2l
         ZdJAGGFE2cRrK44/tkMZPRks0N8jAaLh7dxPiXUA7AGsY8r+qq5onkkPUM/RNNMKlE08
         OiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=ECA2CSGSEhAH8vQLcByGR0V9OF7u8Xt7NEwNmuSYeWw=;
        b=S4w8OWElcZzWk1x23jPaHyJLsgaXtuZQcvuXeguLbdrqQ8CnZkuh4RVMF4MU6Nc+99
         SoBomp8tDjoNKOCZ4aHV/evDX4iwNt1kFGWQVH1h5hGsPN5sdvpqXo7rj5FIPwGhOk1y
         fFL98hVWpi+YTOV4AMqzAqeOi8gpiqCeL6ZegNJ69AZL5NLWuojhinGIgqifkf2jDxLY
         XlCUbjk7qhjXwGG7v7F4c7E70SpsujtugFnLXcUD2Ncq2VKQ2R2H8yYaZ04E0w2JCIfK
         kid3SyYTGtaJ8jiRC1hkeJZGjhZN8ElJHMWKNCkMDrMgvFbmP2a2SiEBjlkNAAPI87Lf
         aylA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=VCnISZxY;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=VCnISZxY;
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
Subject: [PATCH 24/39] resource: switch to proc_create_seq_data
Date: Thu, 19 Apr 2018 14:41:25 +0200
Message-Id: <20180419124140.9309-25-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178498433911637?=
X-GMAIL-MSGID: =?utf-8?q?1598178498433911637?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

And use the root resource directly from the proc private data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/resource.c | 43 +++++--------------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 2af6c03858b9..b589dda910b3 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -87,7 +87,7 @@ enum { MAX_IORES_LEVEL = 5 };
 static void *r_start(struct seq_file *m, loff_t *pos)
 	__acquires(resource_lock)
 {
-	struct resource *p = m->private;
+	struct resource *p = PDE_DATA(file_inode(m->file));
 	loff_t l = 0;
 	read_lock(&resource_lock);
 	for (p = p->child; p && l < *pos; p = r_next(m, p, &l))
@@ -103,7 +103,7 @@ static void r_stop(struct seq_file *m, void *v)
 
 static int r_show(struct seq_file *m, void *v)
 {
-	struct resource *root = m->private;
+	struct resource *root = PDE_DATA(file_inode(m->file));
 	struct resource *r = v, *p;
 	unsigned long long start, end;
 	int width = root->end < 0x10000 ? 4 : 8;
@@ -135,44 +135,11 @@ static const struct seq_operations resource_op = {
 	.show	= r_show,
 };
 
-static int ioports_open(struct inode *inode, struct file *file)
-{
-	int res = seq_open(file, &resource_op);
-	if (!res) {
-		struct seq_file *m = file->private_data;
-		m->private = &ioport_resource;
-	}
-	return res;
-}
-
-static int iomem_open(struct inode *inode, struct file *file)
-{
-	int res = seq_open(file, &resource_op);
-	if (!res) {
-		struct seq_file *m = file->private_data;
-		m->private = &iomem_resource;
-	}
-	return res;
-}
-
-static const struct file_operations proc_ioports_operations = {
-	.open		= ioports_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-static const struct file_operations proc_iomem_operations = {
-	.open		= iomem_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
 static int __init ioresources_init(void)
 {
-	proc_create("ioports", 0, NULL, &proc_ioports_operations);
-	proc_create("iomem", 0, NULL, &proc_iomem_operations);
+	proc_create_seq_data("ioports", 0, NULL, &resource_op,
+			&ioport_resource);
+	proc_create_seq_data("iomem", 0, NULL, &resource_op, &iomem_resource);
 	return 0;
 }
 __initcall(ioresources_init);
-- 
2.17.0
