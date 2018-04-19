Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx48s1wdxYeSV5Ez/sRgtbymgMfv7saPTKXEo0JvR+iWIsngZfOr9v5hbsPIXytFIT+yt4We6
ARC-Seal: i=1; a=rsa-sha256; t=1524141767; cv=none;
        d=google.com; s=arc-20160816;
        b=aIJCyrj9Dx3oUsQzw4HvqzmNtxw17q2/MfK3gYNFpdSosYUEglzDXYZZvJe1ovje4/
         RWsXlhSKX5P442iGWLjaFOaNBSPMrVXU8Bpw1DGVtmz6veWOh04zI0wDWg/DQWSHNxYE
         vRpFdpxa/B3jw3Gst4/zr/ygA0153BKA2Pjmdihr6xry8tZU8Zg1OurPCbhWtw/heiwG
         hkaKJ+I11/R8UUo/ylDonwR7KEc+I3W9Q5kODxaR4kHv+Nyzyv/bq1BUqZWp6WJckCjh
         c1df/dcntUOb/c1xT1WPSF7LD8H/RZSUKbwMA4AFq8ntY249BWVrPu0E/rrtaqzHW0E5
         Be5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=FC6AdaTYFfC5lM/VhmciPyt2KY4sPbVwfDSlnsbJ6GM=;
        b=faMBNm2T9EbV8hNIt5tU9VDk/X66x3yR/V8cw5Q6YoTjqeyzI/L11zecknrQTPx9Y6
         6j2hc9H3iGv5rsg2Q4VZg/skKdlZlsXMJYMJoG91nRCV8IyrimRH7F7OEX6WLCppQW0O
         0mN4P/7xmP9bPyv56Q/iGFfRJUxOeyokdPFN5CsOnYS4axovDtzVvFckKc4woaD54qO1
         fhXuJVWyIPSAlrypOEtXUi4ZvvBRbH4j1MSdG5Ab7cuaAKM3l+Ub/Jzj3U0GB3DG+fVo
         Vn7EkJHa5KuSlImIbwLCBmvLF//IdrXIcZS4v6xPL980/Y+HsBVCPQV65201IJmftr5e
         2j0A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=IjCWpdNd;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=IjCWpdNd;
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
Subject: [PATCH 18/39] megaraid: simplify procfs code
Date: Thu, 19 Apr 2018 14:41:19 +0200
Message-Id: <20180419124140.9309-19-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178478444481676?=
X-GMAIL-MSGID: =?utf-8?q?1598178478444481676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use remove_proc_subtree to remove the whole subtree on cleanup, and
unwind the registration loop into individual calls.  Switch to use
proc_create_single.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/megaraid.c | 140 +++++++++++-----------------------------
 drivers/scsi/megaraid.h |  12 ----
 2 files changed, 36 insertions(+), 116 deletions(-)

diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 7195cff51d4c..91f5e2c68dbc 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -2731,53 +2731,6 @@ proc_show_rdrv_40(struct seq_file *m, void *v)
 	return proc_show_rdrv(m, m->private, 30, 39);
 }
 
-
-/*
- * seq_file wrappers for procfile show routines.
- */
-static int mega_proc_open(struct inode *inode, struct file *file)
-{
-	adapter_t *adapter = proc_get_parent_data(inode);
-	int (*show)(struct seq_file *, void *) = PDE_DATA(inode);
-
-	return single_open(file, show, adapter);
-}
-
-static const struct file_operations mega_proc_fops = {
-	.open		= mega_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-/*
- * Table of proc files we need to create.
- */
-struct mega_proc_file {
-	const char *name;
-	unsigned short ptr_offset;
-	int (*show) (struct seq_file *m, void *v);
-};
-
-static const struct mega_proc_file mega_proc_files[] = {
-	{ "config",	      offsetof(adapter_t, proc_read), proc_show_config },
-	{ "stat",	      offsetof(adapter_t, proc_stat), proc_show_stat },
-	{ "mailbox",	      offsetof(adapter_t, proc_mbox), proc_show_mbox },
-#if MEGA_HAVE_ENH_PROC
-	{ "rebuild-rate",     offsetof(adapter_t, proc_rr), proc_show_rebuild_rate },
-	{ "battery-status",   offsetof(adapter_t, proc_battery), proc_show_battery },
-	{ "diskdrives-ch0",   offsetof(adapter_t, proc_pdrvstat[0]), proc_show_pdrv_ch0 },
-	{ "diskdrives-ch1",   offsetof(adapter_t, proc_pdrvstat[1]), proc_show_pdrv_ch1 },
-	{ "diskdrives-ch2",   offsetof(adapter_t, proc_pdrvstat[2]), proc_show_pdrv_ch2 },
-	{ "diskdrives-ch3",   offsetof(adapter_t, proc_pdrvstat[3]), proc_show_pdrv_ch3 },
-	{ "raiddrives-0-9",   offsetof(adapter_t, proc_rdrvstat[0]), proc_show_rdrv_10 },
-	{ "raiddrives-10-19", offsetof(adapter_t, proc_rdrvstat[1]), proc_show_rdrv_20 },
-	{ "raiddrives-20-29", offsetof(adapter_t, proc_rdrvstat[2]), proc_show_rdrv_30 },
-	{ "raiddrives-30-39", offsetof(adapter_t, proc_rdrvstat[3]), proc_show_rdrv_40 },
-#endif
-	{ NULL }
-};
-
 /**
  * mega_create_proc_entry()
  * @index - index in soft state array
@@ -2788,31 +2741,45 @@ static const struct mega_proc_file mega_proc_files[] = {
 static void
 mega_create_proc_entry(int index, struct proc_dir_entry *parent)
 {
-	const struct mega_proc_file *f;
-	adapter_t	*adapter = hba_soft_state[index];
-	struct proc_dir_entry	*dir, *de, **ppde;
-	u8		string[16];
+	adapter_t *adapter = hba_soft_state[index];
+	struct proc_dir_entry *dir;
+	u8 string[16];
 
 	sprintf(string, "hba%d", adapter->host->host_no);
-
-	dir = adapter->controller_proc_dir_entry =
-		proc_mkdir_data(string, 0, parent, adapter);
-	if(!dir) {
+	dir = proc_mkdir_data(string, 0, parent, adapter);
+	if (!dir) {
 		dev_warn(&adapter->dev->dev, "proc_mkdir failed\n");
 		return;
 	}
 
-	for (f = mega_proc_files; f->name; f++) {
-		de = proc_create_data(f->name, S_IRUSR, dir, &mega_proc_fops,
-				      f->show);
-		if (!de) {
-			dev_warn(&adapter->dev->dev, "proc_create failed\n");
-			return;
-		}
-
-		ppde = (void *)adapter + f->ptr_offset;
-		*ppde = de;
-	}
+	proc_create_single_data("config", S_IRUSR, dir,
+			proc_show_config, adapter);
+	proc_create_single_data("stat", S_IRUSR, dir,
+			proc_show_stat, adapter);
+	proc_create_single_data("mailbox", S_IRUSR, dir,
+			proc_show_mbox, adapter);
+#if MEGA_HAVE_ENH_PROC
+	proc_create_single_data("rebuild-rate", S_IRUSR, dir,
+			proc_show_rebuild_rate, adapter);
+	proc_create_single_data("battery-status", S_IRUSR, dir,
+			proc_show_battery, adapter);
+	proc_create_single_data("diskdrives-ch0", S_IRUSR, dir,
+			proc_show_pdrv_ch0, adapter);
+	proc_create_single_data("diskdrives-ch1", S_IRUSR, dir,
+			proc_show_pdrv_ch1, adapter);
+	proc_create_single_data("diskdrives-ch2", S_IRUSR, dir,
+			proc_show_pdrv_ch2, adapter);
+	proc_create_single_data("diskdrives-ch3", S_IRUSR, dir,
+			proc_show_pdrv_ch3, adapter);
+	proc_create_single_data("raiddrives-0-9", S_IRUSR, dir,
+			proc_show_rdrv_10, adapter);
+	proc_create_single_data("raiddrives-10-19", S_IRUSR, dir,
+			proc_show_rdrv_20, adapter);
+	proc_create_single_data("raiddrives-20-29", S_IRUSR, dir,
+			proc_show_rdrv_30, adapter);
+	proc_create_single_data("raiddrives-30-39", S_IRUSR, dir,
+			proc_show_rdrv_40, adapter);
+#endif
 }
 
 #else
@@ -4580,6 +4547,7 @@ megaraid_remove_one(struct pci_dev *pdev)
 {
 	struct Scsi_Host *host = pci_get_drvdata(pdev);
 	adapter_t *adapter = (adapter_t *)host->hostdata;
+	char buf[12] = { 0 };
 
 	scsi_remove_host(host);
 
@@ -4594,44 +4562,8 @@ megaraid_remove_one(struct pci_dev *pdev)
 
 	mega_free_sgl(adapter);
 
-#ifdef CONFIG_PROC_FS
-	if (adapter->controller_proc_dir_entry) {
-		remove_proc_entry("stat", adapter->controller_proc_dir_entry);
-		remove_proc_entry("config",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("mailbox",
-				adapter->controller_proc_dir_entry);
-#if MEGA_HAVE_ENH_PROC
-		remove_proc_entry("rebuild-rate",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("battery-status",
-				adapter->controller_proc_dir_entry);
-
-		remove_proc_entry("diskdrives-ch0",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("diskdrives-ch1",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("diskdrives-ch2",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("diskdrives-ch3",
-				adapter->controller_proc_dir_entry);
-
-		remove_proc_entry("raiddrives-0-9",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("raiddrives-10-19",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("raiddrives-20-29",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("raiddrives-30-39",
-				adapter->controller_proc_dir_entry);
-#endif
-		{
-			char	buf[12] = { 0 };
-			sprintf(buf, "hba%d", adapter->host->host_no);
-			remove_proc_entry(buf, mega_proc_dir_entry);
-		}
-	}
-#endif
+	sprintf(buf, "hba%d", adapter->host->host_no);
+	remove_proc_subtree(buf, mega_proc_dir_entry);
 
 	pci_free_consistent(adapter->dev, MEGA_BUFFER_SIZE,
 			adapter->mega_buffer, adapter->buf_dma_handle);
diff --git a/drivers/scsi/megaraid.h b/drivers/scsi/megaraid.h
index 21eba2fd465a..18e85d9267ff 100644
--- a/drivers/scsi/megaraid.h
+++ b/drivers/scsi/megaraid.h
@@ -814,18 +814,6 @@ typedef struct {
 
 #ifdef CONFIG_PROC_FS
 	struct proc_dir_entry	*controller_proc_dir_entry;
-	struct proc_dir_entry	*proc_read;
-	struct proc_dir_entry	*proc_stat;
-	struct proc_dir_entry	*proc_mbox;
-
-#if MEGA_HAVE_ENH_PROC
-	struct proc_dir_entry	*proc_rr;
-	struct proc_dir_entry	*proc_battery;
-#define MAX_PROC_CHANNELS	4
-	struct proc_dir_entry	*proc_pdrvstat[MAX_PROC_CHANNELS];
-	struct proc_dir_entry	*proc_rdrvstat[MAX_PROC_CHANNELS];
-#endif
-
 #endif
 
 	int	has_64bit_addr;		/* are we using 64-bit addressing */
-- 
2.17.0
