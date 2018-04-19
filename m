Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx489kFDFTbI93BRdJ9SDosWP2D0zSLZKkQ2mXo0P8SIfYCQGjLigPxQlPw/uz+BRtzaZJ/Q5
ARC-Seal: i=1; a=rsa-sha256; t=1524141765; cv=none;
        d=google.com; s=arc-20160816;
        b=C2SHjNNkK4redVwRiDAzeml6WHejSnCsUcbrxAZApscVcYnIsKXQPs4bGXzOOBtmKl
         GcrlGdozxqqb5HZ28ytXhE+3IlQMMyiwDhMRb1g5Jy6tPLVrIoBEE1PBsWEKT3YQgts1
         sdr4LB29H23/Y2T+4wZvgg2uLjs/eXWzxn2JrNXKTv5LQVHs6OXb37qHx4mmBL9Wcmb/
         oHHe3u7oxJxHc2rWlomd7v3iU930fE5S+LEP6sMKVa2jcA2J9ZTcG39PwNJI0cdJdy1e
         YXocxK8sjUTezpoukPVV2IjzhcBkAtvl7KfUWH3OOUio5jiJkWI2tfj1eb3z3RCsrhq0
         WGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=/7M9BV2gSqZxArf2tpJ6MueHLbUBS7SR4pWC8vWn63Q=;
        b=A106SVq6ozmrGRfOu9s3lnp+3IlQ+GqDdagZEjYnaVc0X/+yFxbuPUeLsO51oqUYf5
         jzMZKvLSLoGUVDikhTpGFQ/4BXsT4F8fqE3guNe7YRec8ZtSMb34SKpPr8qyB3cOkYBk
         fgpnyTPbfqIk0p65Yz+37Auh5y6iZmxFaqO52r2r8K4utm+XAs+TX1ohdtXihqwb9vUw
         2cgCvKrOZaKqE624TVgGAoT1rjsCor6IenaLR6KGv5kDLxgyTDs1apHgV7OMDLsZmu8p
         6BathXHxzynT8pXRDq63y81grb8g38glT2bWWsVhqlKvxvb2nUEyt2y977I+Q3vxzv+b
         +cBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=klrAqWtd;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=klrAqWtd;
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
Subject: [PATCH 17/39] sgi-gru: simplify procfs code
Date: Thu, 19 Apr 2018 14:41:18 +0200
Message-Id: <20180419124140.9309-18-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178475312611048?=
X-GMAIL-MSGID: =?utf-8?q?1598178475312611048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use remove_proc_subtree to remove the whole subtree on cleanup, and
unwind the registration loop into individual calls.  Switch to use
proc_create_seq where applicable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/misc/sgi-gru/gruprocfs.c | 81 ++++++--------------------------
 1 file changed, 14 insertions(+), 67 deletions(-)

diff --git a/drivers/misc/sgi-gru/gruprocfs.c b/drivers/misc/sgi-gru/gruprocfs.c
index 4f7635922394..42ea2eccaee9 100644
--- a/drivers/misc/sgi-gru/gruprocfs.c
+++ b/drivers/misc/sgi-gru/gruprocfs.c
@@ -270,16 +270,6 @@ static int options_open(struct inode *inode, struct file *file)
 	return single_open(file, options_show, NULL);
 }
 
-static int cch_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &cch_seq_ops);
-}
-
-static int gru_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &gru_seq_ops);
-}
-
 /* *INDENT-OFF* */
 static const struct file_operations statistics_fops = {
 	.open 		= statistics_open,
@@ -305,73 +295,30 @@ static const struct file_operations options_fops = {
 	.release 	= single_release,
 };
 
-static const struct file_operations cch_fops = {
-	.open 		= cch_open,
-	.read 		= seq_read,
-	.llseek 	= seq_lseek,
-	.release 	= seq_release,
-};
-static const struct file_operations gru_fops = {
-	.open 		= gru_open,
-	.read 		= seq_read,
-	.llseek 	= seq_lseek,
-	.release 	= seq_release,
-};
-
-static struct proc_entry {
-	char *name;
-	umode_t mode;
-	const struct file_operations *fops;
-	struct proc_dir_entry *entry;
-} proc_files[] = {
-	{"statistics", 0644, &statistics_fops},
-	{"mcs_statistics", 0644, &mcs_statistics_fops},
-	{"debug_options", 0644, &options_fops},
-	{"cch_status", 0444, &cch_fops},
-	{"gru_status", 0444, &gru_fops},
-	{NULL}
-};
-/* *INDENT-ON* */
-
 static struct proc_dir_entry *proc_gru __read_mostly;
 
-static int create_proc_file(struct proc_entry *p)
-{
-	p->entry = proc_create(p->name, p->mode, proc_gru, p->fops);
-	if (!p->entry)
-		return -1;
-	return 0;
-}
-
-static void delete_proc_files(void)
-{
-	struct proc_entry *p;
-
-	if (proc_gru) {
-		for (p = proc_files; p->name; p++)
-			if (p->entry)
-				remove_proc_entry(p->name, proc_gru);
-		proc_remove(proc_gru);
-	}
-}
-
 int gru_proc_init(void)
 {
-	struct proc_entry *p;
-
 	proc_gru = proc_mkdir("sgi_uv/gru", NULL);
-
-	for (p = proc_files; p->name; p++)
-		if (create_proc_file(p))
-			goto err;
+	if (!proc_gru)
+		return -1;
+	if (!proc_create("statistics", 0644, proc_gru, &statistics_fops))
+		goto err;
+	if (!proc_create("mcs_statistics", 0644, proc_gru, &mcs_statistics_fops))
+		goto err;
+	if (!proc_create("debug_options", 0644, proc_gru, &options_fops))
+		goto err;
+	if (!proc_create_seq("cch_status", 0444, proc_gru, &cch_seq_ops))
+		goto err;
+	if (!proc_create_seq("gru_status", 0444, proc_gru, &gru_seq_ops))
+		goto err;
 	return 0;
-
 err:
-	delete_proc_files();
+	remove_proc_subtree("sgi_uv/gru", NULL);
 	return -1;
 }
 
 void gru_proc_exit(void)
 {
-	delete_proc_files();
+	remove_proc_subtree("sgi_uv/gru", NULL);
 }
-- 
2.17.0
