Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25950C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 07:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFDD2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 07:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUvb2bAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbeLOH7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 02:59:36 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35064 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeLOH7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 02:59:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so3937854pfi.2;
        Fri, 14 Dec 2018 23:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YNR7EgnUa9hdsPpHoWIBT4AT3jyNyDczR6mlAZoKqJU=;
        b=JUvb2bAcjS3jRaCTJtbkONkM4c+EFsFVe6WPvow92/BstdoNpnFjA1gATl2tLJkxQy
         /8v4z4BqUgTJnj+3oOGtiFN9rKnFoT6Jxs8bGYz8CiJq2fGfeNk92cQAkhpvFzeVadJR
         57vBrBosO3wzWQLUFyYlo8V8jUN0HjyigZlv1dX0qmXCb1hG9wEtaWFl+67xHR4P0eJ2
         Xaa54/RKd9JXJI2evT6vt7iB1NAkxfqHdNdhxTjh/WL6gRewf+UJ5j71DlIruIACZRJX
         Zbluzy6JTJeIXlF4c8RHihRQfAlytqggDQMXjLeUjSltBjWp3nvxsQsi+IFpS3K1bHFb
         Aiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YNR7EgnUa9hdsPpHoWIBT4AT3jyNyDczR6mlAZoKqJU=;
        b=KQ+3jIbSwy5hOKst3iKs0RIqwJAgP53CGeI4yLfrGpcewBLXVdKIi+xYvcMguKWh3q
         7VKP2QQVNFGw7hBjaHmR9riZnCXNDK6B1us7VORoQ90MNPGqvA4AhfDaLFCuCgzMDxn/
         +bvUohXt/4De/QrUbQbMixCAaqkBk9nLLrgiyrOHid5lLf852SdMeZzq0kwmhgKdq/62
         EpE4syV25a8lBAGjkJ1fftHPotXgXC0PP4wfxkpH0oozf+L2ritKz0JeAboIe1Um484T
         ZOKeLI40Tn90PnxxYUfEtV70j/s1CX0GsMH6lhPWnP86W/XK4yhJpPsMtk7XowtAPkyE
         YODg==
X-Gm-Message-State: AA+aEWYlStcLGOZww+iaBY45sHqrB7d2TGG9qvLu6ZUlPNbcyHzhEVZc
        syrxbpNDPM/fVGBI4yG4Fp7bwStYzUE=
X-Google-Smtp-Source: AFSGD/WcARk0CYK5jK04bj2YZCycqNL5w16Bes86DpVK12bNwIb86l2VFCeWUyfYbofc2dkvBMOiGA==
X-Received: by 2002:a62:2fc3:: with SMTP id v186mr5721119pfv.82.1544860773664;
        Fri, 14 Dec 2018 23:59:33 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id p7sm10348888pfa.22.2018.12.14.23.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 23:59:32 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ganeshgr@chelsio.com, davem@davemloft.net, leedom@chelsio.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cxgb4: remove DEFINE_SIMPLE_DEBUGFS_FILE()
Date:   Sat, 15 Dec 2018 02:59:30 -0500
Message-Id: <20181215075930.26316-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have the DEFINE_SHOW_ATTRIBUTE. There is no need to define
such a macro, so remove DEFINE_SIMPLE_DEBUGFS_FILE. Also use the
DEFINE_SHOW_ATTRIBUTE macro to simplify some code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../ethernet/chelsio/cxgb4/cxgb4_debugfs.c    | 113 ++++--------------
 .../ethernet/chelsio/cxgb4/cxgb4_debugfs.h    |  13 --
 .../ethernet/chelsio/cxgb4vf/cxgb4vf_main.c   |  16 +--
 3 files changed, 25 insertions(+), 117 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
index cab492ec8f59..b0ff9fa183f4 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
@@ -378,19 +378,7 @@ static int cim_qcfg_show(struct seq_file *seq, void *v)
 			   QUEREMFLITS_G(p[2]) * 16);
 	return 0;
 }
-
-static int cim_qcfg_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, cim_qcfg_show, inode->i_private);
-}
-
-static const struct file_operations cim_qcfg_fops = {
-	.owner   = THIS_MODULE,
-	.open    = cim_qcfg_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(cim_qcfg);
 
 static int cimq_show(struct seq_file *seq, void *v, int idx)
 {
@@ -860,8 +848,7 @@ static int tx_rate_show(struct seq_file *seq, void *v)
 	}
 	return 0;
 }
-
-DEFINE_SIMPLE_DEBUGFS_FILE(tx_rate);
+DEFINE_SHOW_ATTRIBUTE(tx_rate);
 
 static int cctrl_tbl_show(struct seq_file *seq, void *v)
 {
@@ -893,8 +880,7 @@ static int cctrl_tbl_show(struct seq_file *seq, void *v)
 	kfree(incr);
 	return 0;
 }
-
-DEFINE_SIMPLE_DEBUGFS_FILE(cctrl_tbl);
+DEFINE_SHOW_ATTRIBUTE(cctrl_tbl);
 
 /* Format a value in a unit that differs from the value's native unit by the
  * given factor.
@@ -955,8 +941,7 @@ static int clk_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
-
-DEFINE_SIMPLE_DEBUGFS_FILE(clk);
+DEFINE_SHOW_ATTRIBUTE(clk);
 
 /* Firmware Device Log dump. */
 static const char * const devlog_level_strings[] = {
@@ -1990,22 +1975,10 @@ static int sensors_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
-
-DEFINE_SIMPLE_DEBUGFS_FILE(sensors);
+DEFINE_SHOW_ATTRIBUTE(sensors);
 
 #if IS_ENABLED(CONFIG_IPV6)
-static int clip_tbl_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, clip_tbl_show, inode->i_private);
-}
-
-static const struct file_operations clip_tbl_debugfs_fops = {
-	.owner   = THIS_MODULE,
-	.open    = clip_tbl_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release
-};
+DEFINE_SHOW_ATTRIBUTE(clip_tbl);
 #endif
 
 /*RSS Table.
@@ -2208,8 +2181,7 @@ static int rss_config_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
-
-DEFINE_SIMPLE_DEBUGFS_FILE(rss_config);
+DEFINE_SHOW_ATTRIBUTE(rss_config);
 
 /* RSS Secret Key.
  */
@@ -2628,19 +2600,7 @@ static int resources_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
-
-static int resources_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, resources_show, inode->i_private);
-}
-
-static const struct file_operations resources_debugfs_fops = {
-	.owner   = THIS_MODULE,
-	.open    = resources_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
-};
+DEFINE_SHOW_ATTRIBUTE(resources);
 
 /**
  * ethqset2pinfo - return port_info of an Ethernet Queue Set
@@ -3233,8 +3193,7 @@ static int tid_info_show(struct seq_file *seq, void *v)
 			   t4_read_reg(adap, LE_DB_ACT_CNT_IPV6_A));
 	return 0;
 }
-
-DEFINE_SIMPLE_DEBUGFS_FILE(tid_info);
+DEFINE_SHOW_ATTRIBUTE(tid_info);
 
 static void add_debugfs_mem(struct adapter *adap, const char *name,
 			    unsigned int idx, unsigned int size_mb)
@@ -3364,21 +3323,9 @@ static int meminfo_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(meminfo);
 
-static int meminfo_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, meminfo_show, inode->i_private);
-}
-
-static const struct file_operations meminfo_fops = {
-	.owner   = THIS_MODULE,
-	.open    = meminfo_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-};
-
-static int chcr_show(struct seq_file *seq, void *v)
+static int chcr_stats_show(struct seq_file *seq, void *v)
 {
 	struct adapter *adap = seq->private;
 
@@ -3399,20 +3346,7 @@ static int chcr_show(struct seq_file *seq, void *v)
 		   atomic_read(&adap->chcr_stats.ipsec_cnt));
 	return 0;
 }
-
-
-static int chcr_stats_open(struct inode *inode, struct file *file)
-{
-        return single_open(file, chcr_show, inode->i_private);
-}
-
-static const struct file_operations chcr_stats_debugfs_fops = {
-        .owner   = THIS_MODULE,
-        .open    = chcr_stats_open,
-        .read    = seq_read,
-        .llseek  = seq_lseek,
-        .release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(chcr_stats);
 
 #define PRINT_ADAP_STATS(string, value) \
 	seq_printf(seq, "%-25s %-20llu\n", (string), \
@@ -3573,8 +3507,7 @@ static int tp_stats_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
-
-DEFINE_SIMPLE_DEBUGFS_FILE(tp_stats);
+DEFINE_SHOW_ATTRIBUTE(tp_stats);
 
 /* Add an array of Debug FS files.
  */
@@ -3603,7 +3536,7 @@ int t4_setup_debugfs(struct adapter *adap)
 		{ "cim_pif_la", &cim_pif_la_fops, 0400, 0 },
 		{ "cim_ma_la", &cim_ma_la_fops, 0400, 0 },
 		{ "cim_qcfg", &cim_qcfg_fops, 0400, 0 },
-		{ "clk", &clk_debugfs_fops, 0400, 0 },
+		{ "clk", &clk_fops, 0400, 0 },
 		{ "devlog", &devlog_fops, 0400, 0 },
 		{ "mboxlog", &mboxlog_fops, 0400, 0 },
 		{ "mbox0", &mbox_debugfs_fops, 0600, 0 },
@@ -3621,11 +3554,11 @@ int t4_setup_debugfs(struct adapter *adap)
 		{ "l2t", &t4_l2t_fops, 0400, 0},
 		{ "mps_tcam", &mps_tcam_debugfs_fops, 0400, 0 },
 		{ "rss", &rss_debugfs_fops, 0400, 0 },
-		{ "rss_config", &rss_config_debugfs_fops, 0400, 0 },
+		{ "rss_config", &rss_config_fops, 0400, 0 },
 		{ "rss_key", &rss_key_debugfs_fops, 0400, 0 },
 		{ "rss_pf_config", &rss_pf_config_debugfs_fops, 0400, 0 },
 		{ "rss_vf_config", &rss_vf_config_debugfs_fops, 0400, 0 },
-		{ "resources", &resources_debugfs_fops, 0400, 0 },
+		{ "resources", &resources_fops, 0400, 0 },
 #ifdef CONFIG_CHELSIO_T4_DCB
 		{ "dcb_info", &dcb_info_debugfs_fops, 0400, 0 },
 #endif
@@ -3644,18 +3577,18 @@ int t4_setup_debugfs(struct adapter *adap)
 		{ "obq_ncsi", &cim_obq_fops, 0400, 5 },
 		{ "tp_la", &tp_la_fops, 0400, 0 },
 		{ "ulprx_la", &ulprx_la_fops, 0400, 0 },
-		{ "sensors", &sensors_debugfs_fops, 0400, 0 },
+		{ "sensors", &sensors_fops, 0400, 0 },
 		{ "pm_stats", &pm_stats_debugfs_fops, 0400, 0 },
-		{ "tx_rate", &tx_rate_debugfs_fops, 0400, 0 },
-		{ "cctrl", &cctrl_tbl_debugfs_fops, 0400, 0 },
+		{ "tx_rate", &tx_rate_fops, 0400, 0 },
+		{ "cctrl", &cctrl_tbl_fops, 0400, 0 },
 #if IS_ENABLED(CONFIG_IPV6)
-		{ "clip_tbl", &clip_tbl_debugfs_fops, 0400, 0 },
+		{ "clip_tbl", &clip_tbl_fops, 0400, 0 },
 #endif
-		{ "tids", &tid_info_debugfs_fops, 0400, 0},
+		{ "tids", &tid_info_fops, 0400, 0},
 		{ "blocked_fl", &blocked_fl_fops, 0600, 0 },
 		{ "meminfo", &meminfo_fops, 0400, 0 },
-		{ "crypto", &chcr_stats_debugfs_fops, 0400, 0 },
-		{ "tp_stats", &tp_stats_debugfs_fops, 0400, 0 },
+		{ "crypto", &chcr_stats_fops, 0400, 0 },
+		{ "tp_stats", &tp_stats_fops, 0400, 0 },
 	};
 
 	/* Debug FS nodes common to all T5 and later adapters.
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.h
index 23f43a0f8950..ba95e13d52da 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.h
@@ -37,19 +37,6 @@
 
 #include <linux/export.h>
 
-#define DEFINE_SIMPLE_DEBUGFS_FILE(name) \
-static int name##_open(struct inode *inode, struct file *file) \
-{ \
-	return single_open(file, name##_show, inode->i_private); \
-} \
-static const struct file_operations name##_debugfs_fops = { \
-	.owner   = THIS_MODULE, \
-	.open    = name##_open, \
-	.read    = seq_read, \
-	.llseek  = seq_lseek, \
-	.release = single_release \
-}
-
 struct t4_debugfs_entry {
 	const char *name;
 	const struct file_operations *ops;
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index ff84791a0ff8..c31bbf0f6189 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -2324,19 +2324,7 @@ static int resources_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
-
-static int resources_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, resources_show, inode->i_private);
-}
-
-static const struct file_operations resources_proc_fops = {
-	.owner   = THIS_MODULE,
-	.open    = resources_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(resources);
 
 /*
  * Show Virtual Interfaces.
@@ -2420,7 +2408,7 @@ static struct cxgb4vf_debugfs_entry debugfs_files[] = {
 	{ "mboxlog",    0444, &mboxlog_fops },
 	{ "sge_qinfo",  0444, &sge_qinfo_debugfs_fops },
 	{ "sge_qstats", 0444, &sge_qstats_proc_fops },
-	{ "resources",  0444, &resources_proc_fops },
+	{ "resources",  0444, &resources_fops },
 	{ "interfaces", 0444, &interfaces_proc_fops },
 };
 
-- 
2.17.0

