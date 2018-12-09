Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57AAC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 16:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958A920865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 16:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBVNHmvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958A920865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbeLIQ1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 11:27:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42413 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeLIQ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 11:27:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so3830927pga.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 08:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wANQ268hlc/LiTGW5pnZDhus9Y8mQ1vFLq6oOONiVlg=;
        b=hBVNHmvAPvgXT8GM5E7AHXlToCsS/80RXmVg8A881HAJ6cJOrw+mwRkZeA66ypTEK4
         aPb/Q1qwfv56zjEHsEkl+PjJZX+Oi4k12smR3xJEhKSJ2ZdvQ1tr9p3WWWLYI3UsbWRa
         nInutOIM2/FA+kNb9Jj2wSuW7LVee1mLzKIqbuyDrd9KMtkn6lAMv3yz7kzeQ44KdRCk
         YV36w4VpbzbyS9XtA+0uOmWXuqOwd2mZQ09dRQAz6ylJcswRCtJ2CFT0xLjjbpgDDSVs
         cZXP9BJP6+pJa8Lhk2CgOFemPtdWS0JY4gTEiW0XkKahGTcYMz5+WxmAyPBbkAgK2W7B
         vmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wANQ268hlc/LiTGW5pnZDhus9Y8mQ1vFLq6oOONiVlg=;
        b=soDrS818rEptblUSG6IWebQCswGIvu4/Bsv7c0ej3dJOSLGHldvUgBbh+svstod0gd
         pyL36aOLSMIS6rPNiC9bzzopaBnB5zEThetGUjh7juUsVvKDGDNWdjJgKNTym0zwXn97
         KP6UGT2Rsep77JYi1BkkK5J2AmqNVyQOIxEgxB+p82YU/aE9/yspM5ZWSFNAlm9TDa3z
         4BS9dK1ffVha7dsHl0wMIImHdCwQpuaK6TxE/K6eMNFGlMqctaR0B+7wzJ3AIL9hT7d7
         iNh2H3UUquR4XeyeH4XbQLjTvIm8XzTPcYs85QX9jz9wRKGHO/5vxCSfMgYjccE1ELIY
         I8fQ==
X-Gm-Message-State: AA+aEWZO9a963eXIuuCK9oMclUVheaqxXffDlkKGP4v637Tp+MXUUiWn
        6ikt+kK0d6o6UrXCRfyT4mQ=
X-Google-Smtp-Source: AFSGD/V/20qAjVRGEW2fVRo/BKucPqIAGQwX9SmiXnQl83F27T10lrBPUvqtNFytt0a/8m5WYcHRhQ==
X-Received: by 2002:a63:62c3:: with SMTP id w186mr8175411pgb.345.1544372866624;
        Sun, 09 Dec 2018 08:27:46 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id s2sm15726358pfa.167.2018.12.09.08.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 08:27:45 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     gregkh@linuxfoundation.org, pure.logic@nexus-software.ie,
        johan@kernel.org, elder@kernel.org, david.kershner@unisys.com,
        eric@anholt.net, stefan.wahren@i2se.com, viro@zeniv.linux.org.uk,
        kernelpatch@126.com, natechancellor@gmail.com,
        keescook@chromium.org, colin.king@canonical.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, sparmaintainer@unisys.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] staging: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sun,  9 Dec 2018 11:27:42 -0500
Message-Id: <20181209162742.19767-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/staging/fwserial/fwserial.c           | 32 +++----------------
 drivers/staging/greybus/loopback.c            | 16 ++--------
 drivers/staging/rtlwifi/debug.c               | 23 ++++---------
 .../staging/unisys/visorhba/visorhba_main.c   | 14 +-------
 .../interface/vchiq_arm/vchiq_debugfs.c       | 14 +-------
 5 files changed, 14 insertions(+), 85 deletions(-)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index 173f451b86b7..3e416f5bbcba 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1458,7 +1458,7 @@ static int fwtty_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int fwtty_debugfs_stats_show(struct seq_file *m, void *v)
+static int fwtty_stats_show(struct seq_file *m, void *v)
 {
 	struct fw_serial *serial = m->private;
 	struct fwtty_port *port;
@@ -1476,8 +1476,9 @@ static int fwtty_debugfs_stats_show(struct seq_file *m, void *v)
 	}
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(fwtty_stats);
 
-static int fwtty_debugfs_peers_show(struct seq_file *m, void *v)
+static int fwtty_peers_show(struct seq_file *m, void *v)
 {
 	struct fw_serial *serial = m->private;
 	struct fwtty_peer *peer;
@@ -1491,32 +1492,7 @@ static int fwtty_debugfs_peers_show(struct seq_file *m, void *v)
 	rcu_read_unlock();
 	return 0;
 }
-
-static int fwtty_stats_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, fwtty_debugfs_stats_show, inode->i_private);
-}
-
-static int fwtty_peers_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, fwtty_debugfs_peers_show, inode->i_private);
-}
-
-static const struct file_operations fwtty_stats_fops = {
-	.owner =	THIS_MODULE,
-	.open =		fwtty_stats_open,
-	.read =		seq_read,
-	.llseek =	seq_lseek,
-	.release =	single_release,
-};
-
-static const struct file_operations fwtty_peers_fops = {
-	.owner =	THIS_MODULE,
-	.open =		fwtty_peers_open,
-	.read =		seq_read,
-	.llseek =	seq_lseek,
-	.release =	single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(fwtty_peers);
 
 static const struct tty_port_operations fwtty_port_ops = {
 	.dtr_rts =		fwtty_port_dtr_rts,
diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 7080294f705c..33cda7527714 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -973,19 +973,7 @@ static int gb_loopback_dbgfs_latency_show(struct seq_file *s, void *unused)
 	return gb_loopback_dbgfs_latency_show_common(s, &gb->kfifo_lat,
 						     &gb->mutex);
 }
-
-static int gb_loopback_latency_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, gb_loopback_dbgfs_latency_show,
-			   inode->i_private);
-}
-
-static const struct file_operations gb_loopback_debugfs_latency_ops = {
-	.open		= gb_loopback_latency_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(gb_loopback_dbgfs_latency);
 
 static int gb_loopback_bus_id_compare(void *priv, struct list_head *lha,
 				      struct list_head *lhb)
@@ -1076,7 +1064,7 @@ static int gb_loopback_probe(struct gb_bundle *bundle,
 	snprintf(name, sizeof(name), "raw_latency_%s",
 		 dev_name(&connection->bundle->dev));
 	gb->file = debugfs_create_file(name, S_IFREG | 0444, gb_dev.root, gb,
-				       &gb_loopback_debugfs_latency_ops);
+				       &gb_loopback_dbgfs_latency_fops);
 
 	gb->id = ida_simple_get(&loopback_ida, 0, 0, GFP_KERNEL);
 	if (gb->id < 0) {
diff --git a/drivers/staging/rtlwifi/debug.c b/drivers/staging/rtlwifi/debug.c
index 8999feda29b4..543889923864 100644
--- a/drivers/staging/rtlwifi/debug.c
+++ b/drivers/staging/rtlwifi/debug.c
@@ -79,24 +79,13 @@ struct rtl_debugfs_priv {
 
 static struct dentry *debugfs_topdir;
 
-static int rtl_debug_get_common(struct seq_file *m, void *v)
+static int common_show(struct seq_file *m, void *v)
 {
 	struct rtl_debugfs_priv *debugfs_priv = m->private;
 
 	return debugfs_priv->cb_read(m, v);
 }
-
-static int dl_debug_open_common(struct inode *inode, struct file *file)
-{
-	return single_open(file, rtl_debug_get_common, inode->i_private);
-}
-
-static const struct file_operations file_ops_common = {
-	.open = dl_debug_open_common,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(common);
 
 static int rtl_debug_get_mac_page(struct seq_file *m, void *v)
 {
@@ -439,7 +428,7 @@ static ssize_t rtl_debugfs_common_write(struct file *filp,
 	return debugfs_priv->cb_write(filp, buffer, count, loff);
 }
 
-static const struct file_operations file_ops_common_write = {
+static const struct file_operations common_write_fops = {
 	.owner = THIS_MODULE,
 	.write = rtl_debugfs_common_write,
 	.open = simple_open,
@@ -488,7 +477,7 @@ static int rtl_debugfs_open_rw(struct inode *inode, struct file *filp)
 	int ret = 0;
 
 	if (filp->f_mode & FMODE_READ)
-		ret = single_open(filp, rtl_debug_get_common, inode->i_private);
+		ret = single_open(filp, common_show, inode->i_private);
 	else
 		filp->private_data = inode->i_private;
 
@@ -509,7 +498,7 @@ static struct rtl_debugfs_priv rtl_debug_priv_phydm_cmd = {
 	.cb_data = 0,
 };
 
-static const struct file_operations file_ops_common_rw = {
+static const struct file_operations common_rw_fops = {
 	.owner = THIS_MODULE,
 	.open = rtl_debugfs_open_rw,
 	.release = rtl_debugfs_close_rw,
@@ -523,7 +512,7 @@ static const struct file_operations file_ops_common_rw = {
 		rtl_debug_priv_ ##name.rtlpriv = rtlpriv;		   \
 		debugfs_create_file(#name, mode, parent,		   \
 				    &rtl_debug_priv_ ##name,		   \
-				    &file_ops_ ##fopname);		   \
+				    &fopname ##fops);		   	   \
 	} while (0)
 
 #define RTL_DEBUGFS_ADD(name)						   \
diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
index 4fc521c51c0e..d0fed63c13a2 100644
--- a/drivers/staging/unisys/visorhba/visorhba_main.c
+++ b/drivers/staging/unisys/visorhba/visorhba_main.c
@@ -681,19 +681,7 @@ static int info_debugfs_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
-
-static int info_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, info_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations info_debugfs_fops = {
-	.owner = THIS_MODULE,
-	.open = info_debugfs_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(info_debugfs);
 
 /*
  * complete_taskmgmt_command - Complete task management
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index 6a9e71a61142..46ba21967820 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -153,19 +153,7 @@ static int debugfs_usecount_show(struct seq_file *f, void *offset)
 
 	return 0;
 }
-
-static int debugfs_usecount_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, debugfs_usecount_show, inode->i_private);
-}
-
-static const struct file_operations debugfs_usecount_fops = {
-	.owner		= THIS_MODULE,
-	.open		= debugfs_usecount_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(debugfs_usecount);
 
 static int debugfs_trace_show(struct seq_file *f, void *offset)
 {
-- 
2.17.0

