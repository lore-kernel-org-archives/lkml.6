Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx48wNFGZwXAA8Qex2h40jrSgBD+ybf7gxI0sFZNoQCOdoiK6B1moH0OcbFQUa3BT753WOKdg
ARC-Seal: i=1; a=rsa-sha256; t=1524141804; cv=none;
        d=google.com; s=arc-20160816;
        b=FqO0QjgELXv0cQRY1kwcFLYjCVvAxl4N72kpv+FbjwN9q65GYUsF8Nw0PSoPBg6+Y6
         yOT2Yu7/fy+R0ygz72BYThFSLsRVsYg3pamWZuuDpc/mnbXHYQRrZGRsi1b59xr86R10
         ffVg8ZimPWGHkSi+FRi5ONw/HMNhMRdfQ7GtmilFTxXXmBqLIfb5odzBMzYCBOFJVVKK
         wASbqjD+bvhLPkw9uwzQ69SJdOH8Oi+P7iQXbl0Vm5uMSnHjzcHjUjnYYujGEukjAm2a
         cpH3+u+dfaMb3U+dHy4w/eyy4bwaEP2bIpGVVRWXpgvbjVVoWz9wDb/nFxqyjK+R0C66
         ExXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=MbtsGIS/v4TIK6vVngbWuMqRPMCpaHUfKjALqlNPio8=;
        b=n4rSWaES5QfHDM20KyyiZuvj8yEO+Q8++Iv2BJQ6TFnilq3qXAr2cBNzkQQfOl7zxy
         cBouWMsWZSfum5Zl+fD364boOMMV8S7+zolbogw9QMJQzhflhZq6JnEX9jN4kJyelQ/M
         er4wwNckcodcl6fGda0ftjSH7lUV4/V8mhEROz8lflqkuhwVdipLd9i0pDdQHbBfj5Qw
         FjeOAJ2TnJIQg64MHNMa0G068dhRmBbD8E+WgC748AIDVLFzgVTtymmV2YPkajkKOWPv
         hoFJh8sC2RIbl/97GYQ7wW3svdXgyfRTOZXYh3oLwoW84nG04uLTEi+ZWNZAI46R7lri
         zlIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=u+QUBujk;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=u+QUBujk;
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
Subject: [PATCH 28/39] hostap: switch to proc_create_{seq,single}_data
Date: Thu, 19 Apr 2018 14:41:29 +0200
Message-Id: <20180419124140.9309-29-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178516853802201?=
X-GMAIL-MSGID: =?utf-8?q?1598178516853802201?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

And use proc private data directly instead of doing a detour
through seq->private.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../net/wireless/intersil/hostap/hostap_ap.c  |  70 ++-------
 .../net/wireless/intersil/hostap/hostap_hw.c  |  17 +--
 .../wireless/intersil/hostap/hostap_proc.c    | 143 +++---------------
 3 files changed, 39 insertions(+), 191 deletions(-)

diff --git a/drivers/net/wireless/intersil/hostap/hostap_ap.c b/drivers/net/wireless/intersil/hostap/hostap_ap.c
index 4f76f81dd3af..d1884b8913e7 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_ap.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_ap.c
@@ -69,7 +69,7 @@ static void prism2_send_mgmt(struct net_device *dev,
 #ifndef PRISM2_NO_PROCFS_DEBUG
 static int ap_debug_proc_show(struct seq_file *m, void *v)
 {
-	struct ap_data *ap = m->private;
+	struct ap_data *ap = PDE_DATA(file_inode(m->file));
 
 	seq_printf(m, "BridgedUnicastFrames=%u\n", ap->bridged_unicast);
 	seq_printf(m, "BridgedMulticastFrames=%u\n", ap->bridged_multicast);
@@ -81,18 +81,6 @@ static int ap_debug_proc_show(struct seq_file *m, void *v)
 	seq_printf(m, "tx_drop_nonassoc=%u\n", ap->tx_drop_nonassoc);
 	return 0;
 }
-
-static int ap_debug_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ap_debug_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations ap_debug_proc_fops = {
-	.open		= ap_debug_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
 #endif /* PRISM2_NO_PROCFS_DEBUG */
 
 
@@ -333,7 +321,7 @@ void hostap_deauth_all_stas(struct net_device *dev, struct ap_data *ap,
 
 static int ap_control_proc_show(struct seq_file *m, void *v)
 {
-	struct ap_data *ap = m->private;
+	struct ap_data *ap = PDE_DATA(file_inode(m->file));
 	char *policy_txt;
 	struct mac_entry *entry;
 
@@ -365,20 +353,20 @@ static int ap_control_proc_show(struct seq_file *m, void *v)
 
 static void *ap_control_proc_start(struct seq_file *m, loff_t *_pos)
 {
-	struct ap_data *ap = m->private;
+	struct ap_data *ap = PDE_DATA(file_inode(m->file));
 	spin_lock_bh(&ap->mac_restrictions.lock);
 	return seq_list_start_head(&ap->mac_restrictions.mac_list, *_pos);
 }
 
 static void *ap_control_proc_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	struct ap_data *ap = m->private;
+	struct ap_data *ap = PDE_DATA(file_inode(m->file));
 	return seq_list_next(v, &ap->mac_restrictions.mac_list, _pos);
 }
 
 static void ap_control_proc_stop(struct seq_file *m, void *v)
 {
-	struct ap_data *ap = m->private;
+	struct ap_data *ap = PDE_DATA(file_inode(m->file));
 	spin_unlock_bh(&ap->mac_restrictions.lock);
 }
 
@@ -389,24 +377,6 @@ static const struct seq_operations ap_control_proc_seqops = {
 	.show	= ap_control_proc_show,
 };
 
-static int ap_control_proc_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &ap_control_proc_seqops);
-	if (ret == 0) {
-		struct seq_file *m = file->private_data;
-		m->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static const struct file_operations ap_control_proc_fops = {
-	.open		= ap_control_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-
 int ap_control_add_mac(struct mac_restrictions *mac_restrictions, u8 *mac)
 {
 	struct mac_entry *entry;
@@ -585,20 +555,20 @@ static int prism2_ap_proc_show(struct seq_file *m, void *v)
 
 static void *prism2_ap_proc_start(struct seq_file *m, loff_t *_pos)
 {
-	struct ap_data *ap = m->private;
+	struct ap_data *ap = PDE_DATA(file_inode(m->file));
 	spin_lock_bh(&ap->sta_table_lock);
 	return seq_list_start_head(&ap->sta_list, *_pos);
 }
 
 static void *prism2_ap_proc_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	struct ap_data *ap = m->private;
+	struct ap_data *ap = PDE_DATA(file_inode(m->file));
 	return seq_list_next(v, &ap->sta_list, _pos);
 }
 
 static void prism2_ap_proc_stop(struct seq_file *m, void *v)
 {
-	struct ap_data *ap = m->private;
+	struct ap_data *ap = PDE_DATA(file_inode(m->file));
 	spin_unlock_bh(&ap->sta_table_lock);
 }
 
@@ -608,23 +578,6 @@ static const struct seq_operations prism2_ap_proc_seqops = {
 	.stop	= prism2_ap_proc_stop,
 	.show	= prism2_ap_proc_show,
 };
-
-static int prism2_ap_proc_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &prism2_ap_proc_seqops);
-	if (ret == 0) {
-		struct seq_file *m = file->private_data;
-		m->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static const struct file_operations prism2_ap_proc_fops = {
-	.open		= prism2_ap_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
 #endif /* PRISM2_NO_KERNEL_IEEE80211_MGMT */
 
 
@@ -896,12 +849,13 @@ void hostap_init_ap_proc(local_info_t *local)
 		return;
 
 #ifndef PRISM2_NO_PROCFS_DEBUG
-	proc_create_data("ap_debug", 0, ap->proc, &ap_debug_proc_fops, ap);
+	proc_create_single_data("ap_debug", 0, ap->proc, ap_debug_proc_show, ap);
 #endif /* PRISM2_NO_PROCFS_DEBUG */
 
 #ifndef PRISM2_NO_KERNEL_IEEE80211_MGMT
-	proc_create_data("ap_control", 0, ap->proc, &ap_control_proc_fops, ap);
-	proc_create_data("ap", 0, ap->proc, &prism2_ap_proc_fops, ap);
+	proc_create_seq_data("ap_control", 0, ap->proc, &ap_control_proc_seqops,
+			ap);
+	proc_create_seq_data("ap", 0, ap->proc, &prism2_ap_proc_seqops, ap);
 #endif /* PRISM2_NO_KERNEL_IEEE80211_MGMT */
 
 }
diff --git a/drivers/net/wireless/intersil/hostap/hostap_hw.c b/drivers/net/wireless/intersil/hostap/hostap_hw.c
index 5c4a17a18968..2720aa39f530 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_hw.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_hw.c
@@ -2951,19 +2951,6 @@ static int prism2_registers_proc_show(struct seq_file *m, void *v)
 
 	return 0;
 }
-
-static int prism2_registers_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, prism2_registers_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations prism2_registers_proc_fops = {
-	.open		= prism2_registers_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 #endif /* PRISM2_NO_PROCFS_DEBUG */
 
 
@@ -3279,8 +3266,8 @@ static int hostap_hw_ready(struct net_device *dev)
 		}
 		hostap_init_proc(local);
 #ifndef PRISM2_NO_PROCFS_DEBUG
-		proc_create_data("registers", 0, local->proc,
-				 &prism2_registers_proc_fops, local);
+		proc_create_single_data("registers", 0, local->proc,
+				 prism2_registers_proc_show, local);
 #endif /* PRISM2_NO_PROCFS_DEBUG */
 		hostap_init_ap_proc(local);
 		return 0;
diff --git a/drivers/net/wireless/intersil/hostap/hostap_proc.c b/drivers/net/wireless/intersil/hostap/hostap_proc.c
index d234231bf532..5b33ccab9188 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_proc.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_proc.c
@@ -43,18 +43,6 @@ static int prism2_debug_proc_show(struct seq_file *m, void *v)
 
 	return 0;
 }
-
-static int prism2_debug_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, prism2_debug_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations prism2_debug_proc_fops = {
-	.open		= prism2_debug_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
 #endif /* PRISM2_NO_PROCFS_DEBUG */
 
 
@@ -95,19 +83,6 @@ static int prism2_stats_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int prism2_stats_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, prism2_stats_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations prism2_stats_proc_fops = {
-	.open		= prism2_stats_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-
 static int prism2_wds_proc_show(struct seq_file *m, void *v)
 {
 	struct list_head *ptr = v;
@@ -122,20 +97,20 @@ static int prism2_wds_proc_show(struct seq_file *m, void *v)
 
 static void *prism2_wds_proc_start(struct seq_file *m, loff_t *_pos)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	read_lock_bh(&local->iface_lock);
 	return seq_list_start(&local->hostap_interfaces, *_pos);
 }
 
 static void *prism2_wds_proc_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	return seq_list_next(v, &local->hostap_interfaces, _pos);
 }
 
 static void prism2_wds_proc_stop(struct seq_file *m, void *v)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	read_unlock_bh(&local->iface_lock);
 }
 
@@ -146,27 +121,9 @@ static const struct seq_operations prism2_wds_proc_seqops = {
 	.show	= prism2_wds_proc_show,
 };
 
-static int prism2_wds_proc_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &prism2_wds_proc_seqops);
-	if (ret == 0) {
-		struct seq_file *m = file->private_data;
-		m->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static const struct file_operations prism2_wds_proc_fops = {
-	.open		= prism2_wds_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-
 static int prism2_bss_list_proc_show(struct seq_file *m, void *v)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	struct list_head *ptr = v;
 	struct hostap_bss_info *bss;
 
@@ -193,20 +150,20 @@ static int prism2_bss_list_proc_show(struct seq_file *m, void *v)
 
 static void *prism2_bss_list_proc_start(struct seq_file *m, loff_t *_pos)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	spin_lock_bh(&local->lock);
 	return seq_list_start_head(&local->bss_list, *_pos);
 }
 
 static void *prism2_bss_list_proc_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	return seq_list_next(v, &local->bss_list, _pos);
 }
 
 static void prism2_bss_list_proc_stop(struct seq_file *m, void *v)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	spin_unlock_bh(&local->lock);
 }
 
@@ -217,24 +174,6 @@ static const struct seq_operations prism2_bss_list_proc_seqops = {
 	.show	= prism2_bss_list_proc_show,
 };
 
-static int prism2_bss_list_proc_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &prism2_bss_list_proc_seqops);
-	if (ret == 0) {
-		struct seq_file *m = file->private_data;
-		m->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static const struct file_operations prism2_bss_list_proc_fops = {
-	.open		= prism2_bss_list_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-
 static int prism2_crypt_proc_show(struct seq_file *m, void *v)
 {
 	local_info_t *local = m->private;
@@ -252,19 +191,6 @@ static int prism2_crypt_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int prism2_crypt_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, prism2_crypt_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations prism2_crypt_proc_fops = {
-	.open		= prism2_crypt_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-
 static ssize_t prism2_pda_proc_read(struct file *file, char __user *buf,
 				    size_t count, loff_t *_pos)
 {
@@ -342,7 +268,7 @@ static int prism2_io_debug_proc_read(char *page, char **start, off_t off,
 #ifndef PRISM2_NO_STATION_MODES
 static int prism2_scan_results_proc_show(struct seq_file *m, void *v)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	unsigned long entry;
 	int i, len;
 	struct hfa384x_hostscan_result *scanres;
@@ -392,7 +318,7 @@ static int prism2_scan_results_proc_show(struct seq_file *m, void *v)
 
 static void *prism2_scan_results_proc_start(struct seq_file *m, loff_t *_pos)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	spin_lock_bh(&local->lock);
 
 	/* We have a header (pos 0) + N results to show (pos 1...N) */
@@ -403,7 +329,7 @@ static void *prism2_scan_results_proc_start(struct seq_file *m, loff_t *_pos)
 
 static void *prism2_scan_results_proc_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 
 	++*_pos;
 	if (*_pos > local->last_scan_results_count)
@@ -413,7 +339,7 @@ static void *prism2_scan_results_proc_next(struct seq_file *m, void *v, loff_t *
 
 static void prism2_scan_results_proc_stop(struct seq_file *m, void *v)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	spin_unlock_bh(&local->lock);
 }
 
@@ -423,25 +349,6 @@ static const struct seq_operations prism2_scan_results_proc_seqops = {
 	.stop	= prism2_scan_results_proc_stop,
 	.show	= prism2_scan_results_proc_show,
 };
-
-static int prism2_scan_results_proc_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &prism2_scan_results_proc_seqops);
-	if (ret == 0) {
-		struct seq_file *m = file->private_data;
-		m->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static const struct file_operations prism2_scan_results_proc_fops = {
-	.open		= prism2_scan_results_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-
 #endif /* PRISM2_NO_STATION_MODES */
 
 
@@ -463,29 +370,29 @@ void hostap_init_proc(local_info_t *local)
 	}
 
 #ifndef PRISM2_NO_PROCFS_DEBUG
-	proc_create_data("debug", 0, local->proc,
-			 &prism2_debug_proc_fops, local);
+	proc_create_single_data("debug", 0, local->proc,
+			prism2_debug_proc_show, local);
 #endif /* PRISM2_NO_PROCFS_DEBUG */
-	proc_create_data("stats", 0, local->proc,
-			 &prism2_stats_proc_fops, local);
-	proc_create_data("wds", 0, local->proc,
-			 &prism2_wds_proc_fops, local);
+	proc_create_single_data("stats", 0, local->proc, prism2_stats_proc_show,
+			local);
+	proc_create_seq_data("wds", 0, local->proc,
+			&prism2_wds_proc_seqops, local);
 	proc_create_data("pda", 0, local->proc,
 			 &prism2_pda_proc_fops, local);
 	proc_create_data("aux_dump", 0, local->proc,
 			 local->func->read_aux_fops ?: &prism2_aux_dump_proc_fops,
 			 local);
-	proc_create_data("bss_list", 0, local->proc,
-			 &prism2_bss_list_proc_fops, local);
-	proc_create_data("crypt", 0, local->proc,
-			 &prism2_crypt_proc_fops, local);
+	proc_create_seq_data("bss_list", 0, local->proc,
+			&prism2_bss_list_proc_seqops, local);
+	proc_create_single_data("crypt", 0, local->proc, prism2_crypt_proc_show,
+		local);
 #ifdef PRISM2_IO_DEBUG
-	proc_create_data("io_debug", 0, local->proc,
-			 &prism2_io_debug_proc_fops, local);
+	proc_create_single_data("io_debug", 0, local->proc,
+			prism2_debug_proc_show, local);
 #endif /* PRISM2_IO_DEBUG */
 #ifndef PRISM2_NO_STATION_MODES
-	proc_create_data("scan_results", 0, local->proc,
-			 &prism2_scan_results_proc_fops, local);
+	proc_create_seq_data("scan_results", 0, local->proc,
+			&prism2_scan_results_proc_seqops, local);
 #endif /* PRISM2_NO_STATION_MODES */
 }
 
-- 
2.17.0
