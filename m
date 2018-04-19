Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx4+gKAiS9XiDV+aimCofYJsfcwGB6GyLhKA1hXv8kaMt+Lf1fjQUmwjlzP+gxLUscoVAsdbY
ARC-Seal: i=1; a=rsa-sha256; t=1524141783; cv=none;
        d=google.com; s=arc-20160816;
        b=BhzpkzbmpIolibnd8cdtgpWpSK64SzTF1Fqgp7cCJ02JhGYXj1tdNczxgTvhNINHQL
         MGQrEWPcJNeahmplyQPB7GejyPXsXo4dyo0xcCgW9H4TKBYZOL3TiG/UmQHNaKWMKbkv
         0N8ZttlyMqx7mNAEqBu7OzxoGsbVssdmJs0FmyicFZ3mOcsPd5UkSciGWDjeE05ZgvFG
         BjQ3GcKCzNyIESEIqSPfkl896/B4seW6x5pZzSLOrK8hcxGepuaBNciTKdcCqZJCTUYx
         tVP6PzlNXEdB6XuK+W2Gv0pW6IQwjnOs5xvpFHQEAzdonsT6h6XoEVjDxPTY/GVLYgUf
         joyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=U8JoB7tOkLhoo+A4P9iVJ/CRgnOI57iSyPHBEiiqUJc=;
        b=hyAzyAkDdw/JiYnqSrz4fGC9/t+tOm6VQK9Gw1lLdpPD6/DIY9DmUQ1ha1pANorS75
         TANFfqng9K4SzWGCoZzVQKOldMhwbvPAClHDgPVRS4NUxrtQ/AD5fX1+chyL8er7YBWU
         P5NoyJ3UFNvOCXtRz51ENyFmfbHYYDBgtQ5T9CjdJ+xKcxHOxal5R6dJK/e+xZKurabR
         cV1TIVKqKlopiFLVcGpNOTNK97WNzyw9vIiwCmi7oY8ISBTDGtvzwIM1PVtECDbN4aTn
         UhFW/7W0QG5ZS8SgpSsAcw7dvyj2BB4TBnf7to8GBsLCQgWqjUCRFtI0jjUjeVh9BKe2
         t8xg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=S6a7H/ev;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=S6a7H/ev;
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
Subject: [PATCH 23/39] staging/rtl8192u: simplify procfs code
Date: Thu, 19 Apr 2018 14:41:24 +0200
Message-Id: <20180419124140.9309-24-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178495207766292?=
X-GMAIL-MSGID: =?utf-8?q?1598178495207766292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Unwind the registration loop into individual calls.  Switch to use
proc_create_single where applicable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/staging/rtl8192u/r8192U_core.c | 67 ++++++--------------------
 1 file changed, 14 insertions(+), 53 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index d607c59761cf..7a0dbc0fa18e 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -646,64 +646,25 @@ static void rtl8192_proc_module_init(void)
 	rtl8192_proc = proc_mkdir(RTL819xU_MODULE_NAME, init_net.proc_net);
 }
 
-/*
- * seq_file wrappers for procfile show routines.
- */
-static int rtl8192_proc_open(struct inode *inode, struct file *file)
-{
-	struct net_device *dev = proc_get_parent_data(inode);
-	int (*show)(struct seq_file *, void *) = PDE_DATA(inode);
-
-	return single_open(file, show, dev);
-}
-
-static const struct file_operations rtl8192_proc_fops = {
-	.open		= rtl8192_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-/*
- * Table of proc files we need to create.
- */
-struct rtl8192_proc_file {
-	char name[12];
-	int (*show)(struct seq_file *, void *);
-};
-
-static const struct rtl8192_proc_file rtl8192_proc_files[] = {
-	{ "stats-rx",	&proc_get_stats_rx },
-	{ "stats-tx",	&proc_get_stats_tx },
-	{ "stats-ap",	&proc_get_stats_ap },
-	{ "registers",	&proc_get_registers },
-	{ "" }
-};
-
 static void rtl8192_proc_init_one(struct net_device *dev)
 {
-	const struct rtl8192_proc_file *f;
 	struct proc_dir_entry *dir;
 
-	if (rtl8192_proc) {
-		dir = proc_mkdir_data(dev->name, 0, rtl8192_proc, dev);
-		if (!dir) {
-			RT_TRACE(COMP_ERR,
-				 "Unable to initialize /proc/net/rtl8192/%s\n",
-				 dev->name);
-			return;
-		}
+	if (!rtl8192_proc)
+		return;
 
-		for (f = rtl8192_proc_files; f->name[0]; f++) {
-			if (!proc_create_data(f->name, S_IFREG | S_IRUGO, dir,
-					      &rtl8192_proc_fops, f->show)) {
-				RT_TRACE(COMP_ERR,
-					 "Unable to initialize /proc/net/rtl8192/%s/%s\n",
-					 dev->name, f->name);
-				return;
-			}
-		}
-	}
+	dir = proc_mkdir_data(dev->name, 0, rtl8192_proc, dev);
+	if (!dir)
+		return;
+
+	proc_create_single("stats-rx", S_IFREG | S_IRUGO, dir,
+			proc_get_stats_rx);
+	proc_create_single("stats-tx", S_IFREG | S_IRUGO, dir,
+			proc_get_stats_tx);
+	proc_create_single("stats-ap", S_IFREG | S_IRUGO, dir,
+			proc_get_stats_ap);
+	proc_create_single("registers", S_IFREG | S_IRUGO, dir,
+			proc_get_registers);
 }
 
 static void rtl8192_proc_remove_one(struct net_device *dev)
-- 
2.17.0
