Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB34CECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B5A2084A
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B5A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeGNLs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 07:48:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51863 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbeGNLsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 07:48:25 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 80213207C8; Sat, 14 Jul 2018 13:29:38 +0200 (CEST)
Received: from localhost.localdomain (ABordeaux-654-1-198-104.w90-55.abo.wanadoo.fr [90.55.201.104])
        by mail.bootlin.com (Postfix) with ESMTPSA id 27EFA203EC;
        Sat, 14 Jul 2018 13:29:38 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next v2 3/5] net: mvpp2: debugfs: add hit counter stats for Header Parser entries
Date:   Sat, 14 Jul 2018 13:29:26 +0200
Message-Id: <20180714112928.14246-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180714112928.14246-1-maxime.chevallier@bootlin.com>
References: <20180714112928.14246-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One helpful feature to help debug the Header Parser TCAM filter in PPv2
is to be able to see if the entries did match something when a packet
comes in. This can be done by using the built-in hit counter for TCAM
entries.

This commit implements reading the counter, and exposing its value on
debugfs for each filter entry.

The counter is a 16-bits clear-on-read value, located at:
 .../mvpp2/<controller>/parser/XXX/hits

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h         |  3 +++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c | 19 +++++++++++++++++++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c     | 16 ++++++++++++++++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h     |  2 ++
 4 files changed, 40 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 439f14192b08..70b3e9cd0d84 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -64,6 +64,9 @@
 #define MVPP2_PRS_SRAM_DATA_REG(idx)		(0x1204 + (idx) * 4)
 #define MVPP2_PRS_TCAM_CTRL_REG			0x1230
 #define     MVPP2_PRS_TCAM_EN_MASK		BIT(0)
+#define MVPP2_PRS_TCAM_HIT_IDX_REG		0x1240
+#define MVPP2_PRS_TCAM_HIT_CNT_REG		0x1244
+#define     MVPP2_PRS_TCAM_HIT_CNT_MASK		GENMASK(15, 0)
 
 /* RSS Registers */
 #define MVPP22_RSS_INDEX			0x1500
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
index e8a242b56519..af8fb93a8ae2 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
@@ -192,6 +192,22 @@ static int mvpp2_dbgfs_prs_sram_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_prs_sram);
 
+static int mvpp2_dbgfs_prs_hits_show(struct seq_file *s, void *unused)
+{
+	struct mvpp2_dbgfs_prs_entry *entry = s->private;
+	int val;
+
+	val = mvpp2_prs_hits(entry->priv, entry->tid);
+	if (val < 0)
+		return val;
+
+	seq_printf(s, "%d\n", val);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_prs_hits);
+
 static int mvpp2_dbgfs_prs_valid_show(struct seq_file *s, void *unused)
 {
 	struct mvpp2_dbgfs_prs_entry *entry = s->private;
@@ -263,6 +279,9 @@ static int mvpp2_dbgfs_prs_entry_init(struct dentry *parent,
 	debugfs_create_file("header_data", 0644, prs_entry_dir, entry,
 			    &mvpp2_dbgfs_prs_hdata_fops);
 
+	debugfs_create_file("hits", 0444, prs_entry_dir, entry,
+			    &mvpp2_dbgfs_prs_hits_fops);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
index f133d820f0fa..392fd895f278 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
@@ -2478,3 +2478,19 @@ int mvpp2_prs_def_flow(struct mvpp2_port *port)
 
 	return 0;
 }
+
+int mvpp2_prs_hits(struct mvpp2 *priv, int index)
+{
+	u32 val;
+
+	if (index > MVPP2_PRS_TCAM_SRAM_SIZE)
+		return -EINVAL;
+
+	mvpp2_write(priv, MVPP2_PRS_TCAM_HIT_IDX_REG, index);
+
+	val = mvpp2_read(priv, MVPP2_PRS_TCAM_HIT_CNT_REG);
+
+	val &= MVPP2_PRS_TCAM_HIT_CNT_MASK;
+
+	return val;
+}
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h
index 67b67ccb387d..e22f6c85d380 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h
@@ -328,4 +328,6 @@ void mvpp2_prs_mac_del_all(struct mvpp2_port *port);
 
 int mvpp2_prs_update_mac_da(struct net_device *dev, const u8 *da);
 
+int mvpp2_prs_hits(struct mvpp2 *priv, int index);
+
 #endif
-- 
2.11.0

