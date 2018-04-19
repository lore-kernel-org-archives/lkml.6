Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx4+GEKg1UTFss+EcUi9yehBaKlm/AQU8OQ4s04cqz0RVDL+7WEeeuG10foSy8T1vrgQWIwrl
ARC-Seal: i=1; a=rsa-sha256; t=1524141822; cv=none;
        d=google.com; s=arc-20160816;
        b=MDhrYUyj8qZU1oQJz6Eiph7POGWVcekcGfTHAa8crt4KEc0wHY1GPHpvrLNmavitoe
         QMunRohU9BxtFxw95LRdRPVlaOG3AcdFCJE4TeEXrPf7oVZloOQ75mmG/lA+HsMuh991
         tePVyyhhmUx1jbRZB/9i9hCtulJ23z7Wr+Ksy75/6s3SBaZ3H6lsWFc5WgwK0JmJOJ4G
         OxfYSjnT5jx17teTeQcjB5uGOS9b1hTViF/Vm+jV+oFk1vWIPg7Hg/POeDgykK8xYDKg
         WXcQy6hfSp1iiURiDuFCABqdRalCGiPdbNl5BZhU403KwLbhX4AqeBNLHL+A2jUZCyUd
         2X1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=fAB4gRwSdq5zuTnoC0rEeqoedUShfgWSxeh6EMTtVOg=;
        b=VZJcqSy01PSRbYkFco0xk4rbdiU/vfzNO3sYpNasHTTqMtes5BDjI2oyIC/ibYi+pg
         9MCCl41ONiUJYponL1E4mv0i5IYO4nn/bV8fKkGD3lBl/e0fe70AAAq8W637PQW6wsl7
         ZB+tU6OebccvQtx4kyBPlWlP5vZSBv7gSWGy47tKaaJXpv4ZMpTTUkQIlt+CFcVHUzC2
         RT23Z5G6wk1iD3Mcpwt8hSuXQaciBAFwgA/Qqi/wDJ+/j9UQhWdcaB+wJfgsnyDcm7CJ
         78NGkSdScV3iHvq4ma6RAmJNZYrAm1ISDgSLcVb/xuc0/QcOTqPt4rWEZO1DuXsvt7Ni
         8/ww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qg+UdNik;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qg+UdNik;
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
Subject: [PATCH 33/39] atm: simplify procfs code
Date: Thu, 19 Apr 2018 14:41:34 +0200
Message-Id: <20180419124140.9309-34-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178535741512929?=
X-GMAIL-MSGID: =?utf-8?q?1598178535741512929?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use remove_proc_subtree to remove the whole subtree on cleanup, and
unwind the registration loop into individual calls.  Switch to use
proc_create_seq where applicable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/atm/proc.c | 65 ++++++--------------------------------------------
 1 file changed, 7 insertions(+), 58 deletions(-)

diff --git a/net/atm/proc.c b/net/atm/proc.c
index 55410c00c7e2..f272b0f59d82 100644
--- a/net/atm/proc.c
+++ b/net/atm/proc.c
@@ -257,18 +257,6 @@ static const struct seq_operations atm_dev_seq_ops = {
 	.show	= atm_dev_seq_show,
 };
 
-static int atm_dev_seq_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &atm_dev_seq_ops);
-}
-
-static const struct file_operations devices_seq_fops = {
-	.open		= atm_dev_seq_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
 static int pvc_seq_show(struct seq_file *seq, void *v)
 {
 	static char atm_pvc_banner[] =
@@ -440,58 +428,19 @@ void atm_proc_dev_deregister(struct atm_dev *dev)
 	kfree(dev->proc_name);
 }
 
-static struct atm_proc_entry {
-	char *name;
-	const struct file_operations *proc_fops;
-	struct proc_dir_entry *dirent;
-} atm_proc_ents[] = {
-	{ .name = "devices",	.proc_fops = &devices_seq_fops },
-	{ .name = "pvc",	.proc_fops = &pvc_seq_fops },
-	{ .name = "svc",	.proc_fops = &svc_seq_fops },
-	{ .name = "vc",		.proc_fops = &vcc_seq_fops },
-	{ .name = NULL,		.proc_fops = NULL }
-};
-
-static void atm_proc_dirs_remove(void)
-{
-	static struct atm_proc_entry *e;
-
-	for (e = atm_proc_ents; e->name; e++) {
-		if (e->dirent)
-			remove_proc_entry(e->name, atm_proc_root);
-	}
-	remove_proc_entry("atm", init_net.proc_net);
-}
-
 int __init atm_proc_init(void)
 {
-	static struct atm_proc_entry *e;
-	int ret;
-
 	atm_proc_root = proc_net_mkdir(&init_net, "atm", init_net.proc_net);
 	if (!atm_proc_root)
-		goto err_out;
-	for (e = atm_proc_ents; e->name; e++) {
-		struct proc_dir_entry *dirent;
-
-		dirent = proc_create(e->name, 0444,
-				     atm_proc_root, e->proc_fops);
-		if (!dirent)
-			goto err_out_remove;
-		e->dirent = dirent;
-	}
-	ret = 0;
-out:
-	return ret;
-
-err_out_remove:
-	atm_proc_dirs_remove();
-err_out:
-	ret = -ENOMEM;
-	goto out;
+		return -ENOMEM;
+	proc_create_seq("devices", 0444, atm_proc_root, &atm_dev_seq_ops);
+	proc_create("pvc", 0444, atm_proc_root, &pvc_seq_fops);
+	proc_create("svc", 0444, atm_proc_root, &svc_seq_fops);
+	proc_create("vc", 0444, atm_proc_root, &vcc_seq_fops);
+	return 0;
 }
 
 void atm_proc_exit(void)
 {
-	atm_proc_dirs_remove();
+	remove_proc_subtree("atm", init_net.proc_net);
 }
-- 
2.17.0
