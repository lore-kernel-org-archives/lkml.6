Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FF5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04272089C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04272089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbeGMHQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:16:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36327 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726917AbeGMHQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:16:54 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9BF216DC46516;
        Fri, 13 Jul 2018 15:03:33 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 15:03:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <j@w1.fi>, <kvalo@codeaurora.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <davem@davemloft.net>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] hostap: hide unused procfs helpers
Date:   Fri, 13 Jul 2018 15:03:17 +0800
Message-ID: <20180713070317.6724-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PROC_FS isn't set, gcc warning this:

drivers/net/wireless/intersil/hostap/hostap_hw.c:2901:12: warning: ‘prism2_registers_proc_show’ defined but not used [-Wunused-function]
 static int prism2_registers_proc_show(struct seq_file *m, void *v)

drivers/net/wireless/intersil/hostap/hostap_proc.c:16:12: warning: ‘prism2_debug_proc_show’ defined but not used [-Wunused-function]
 static int prism2_debug_proc_show(struct seq_file *m, void *v)
            ^
drivers/net/wireless/intersil/hostap/hostap_proc.c:49:12: warning: ‘prism2_stats_proc_show’ defined but not used [-Wunused-function]
 static int prism2_stats_proc_show(struct seq_file *m, void *v)
            ^
drivers/net/wireless/intersil/hostap/hostap_proc.c:177:12: warning: ‘prism2_crypt_proc_show’ defined but not used [-Wunused-function]
 static int prism2_crypt_proc_show(struct seq_file *m, void *v)
            ^

fix this by adding #ifdef around them.
hfa384x_read_reg is only used by prism2_registers_proc_show,so move it
into #ifdef.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/wireless/intersil/hostap/hostap_ap.c   |  8 ++++----
 drivers/net/wireless/intersil/hostap/hostap_hw.c   | 17 +++++++----------
 drivers/net/wireless/intersil/hostap/hostap_proc.c | 10 ++++++----
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intersil/hostap/hostap_ap.c b/drivers/net/wireless/intersil/hostap/hostap_ap.c
index d1884b8..0094b1d 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_ap.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_ap.c
@@ -66,7 +66,7 @@ static void prism2_send_mgmt(struct net_device *dev,
 #endif /* PRISM2_NO_KERNEL_IEEE80211_MGMT */
 
 
-#ifndef PRISM2_NO_PROCFS_DEBUG
+#if !defined(PRISM2_NO_PROCFS_DEBUG) && defined(CONFIG_PROC_FS)
 static int ap_debug_proc_show(struct seq_file *m, void *v)
 {
 	struct ap_data *ap = PDE_DATA(file_inode(m->file));
@@ -81,8 +81,7 @@ static int ap_debug_proc_show(struct seq_file *m, void *v)
 	seq_printf(m, "tx_drop_nonassoc=%u\n", ap->tx_drop_nonassoc);
 	return 0;
 }
-#endif /* PRISM2_NO_PROCFS_DEBUG */
-
+#endif
 
 static void ap_sta_hash_add(struct ap_data *ap, struct sta_info *sta)
 {
@@ -990,7 +989,7 @@ static void prism2_send_mgmt(struct net_device *dev,
 }
 #endif /* PRISM2_NO_KERNEL_IEEE80211_MGMT */
 
-
+#ifdef CONFIG_PROC_FS
 static int prism2_sta_proc_show(struct seq_file *m, void *v)
 {
 	struct sta_info *sta = m->private;
@@ -1059,6 +1058,7 @@ static int prism2_sta_proc_show(struct seq_file *m, void *v)
 
 	return 0;
 }
+#endif
 
 static void handle_add_proc_queue(struct work_struct *work)
 {
diff --git a/drivers/net/wireless/intersil/hostap/hostap_hw.c b/drivers/net/wireless/intersil/hostap/hostap_hw.c
index 2720aa3..ad1aa65 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_hw.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_hw.c
@@ -151,13 +151,6 @@ static int prism2_get_ram_size(local_info_t *local);
 #define HFA384X_MAGIC 0x8A32
 #endif
 
-
-static u16 hfa384x_read_reg(struct net_device *dev, u16 reg)
-{
-	return HFA384X_INW(reg);
-}
-
-
 static void hfa384x_read_regs(struct net_device *dev,
 			      struct hfa384x_regs *regs)
 {
@@ -2897,7 +2890,12 @@ static void hostap_tick_timer(struct timer_list *t)
 }
 
 
-#ifndef PRISM2_NO_PROCFS_DEBUG
+#if !defined(PRISM2_NO_PROCFS_DEBUG) && defined(CONFIG_PROC_FS)
+static u16 hfa384x_read_reg(struct net_device *dev, u16 reg)
+{
+	return HFA384X_INW(reg);
+}
+
 static int prism2_registers_proc_show(struct seq_file *m, void *v)
 {
 	local_info_t *local = m->private;
@@ -2951,8 +2949,7 @@ static int prism2_registers_proc_show(struct seq_file *m, void *v)
 
 	return 0;
 }
-#endif /* PRISM2_NO_PROCFS_DEBUG */
-
+#endif
 
 struct set_tim_data {
 	struct list_head list;
diff --git a/drivers/net/wireless/intersil/hostap/hostap_proc.c b/drivers/net/wireless/intersil/hostap/hostap_proc.c
index 5b33cca..703d74c 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_proc.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_proc.c
@@ -11,8 +11,7 @@
 
 #define PROC_LIMIT (PAGE_SIZE - 80)
 
-
-#ifndef PRISM2_NO_PROCFS_DEBUG
+#if !defined(PRISM2_NO_PROCFS_DEBUG) && defined(CONFIG_PROC_FS)
 static int prism2_debug_proc_show(struct seq_file *m, void *v)
 {
 	local_info_t *local = m->private;
@@ -43,9 +42,9 @@ static int prism2_debug_proc_show(struct seq_file *m, void *v)
 
 	return 0;
 }
-#endif /* PRISM2_NO_PROCFS_DEBUG */
-
+#endif
 
+#ifdef CONFIG_PROC_FS
 static int prism2_stats_proc_show(struct seq_file *m, void *v)
 {
 	local_info_t *local = m->private;
@@ -82,6 +81,7 @@ static int prism2_stats_proc_show(struct seq_file *m, void *v)
 
 	return 0;
 }
+#endif
 
 static int prism2_wds_proc_show(struct seq_file *m, void *v)
 {
@@ -174,6 +174,7 @@ static const struct seq_operations prism2_bss_list_proc_seqops = {
 	.show	= prism2_bss_list_proc_show,
 };
 
+#ifdef CONFIG_PROC_FS
 static int prism2_crypt_proc_show(struct seq_file *m, void *v)
 {
 	local_info_t *local = m->private;
@@ -190,6 +191,7 @@ static int prism2_crypt_proc_show(struct seq_file *m, void *v)
 	}
 	return 0;
 }
+#endif
 
 static ssize_t prism2_pda_proc_read(struct file *file, char __user *buf,
 				    size_t count, loff_t *_pos)
-- 
2.7.0


