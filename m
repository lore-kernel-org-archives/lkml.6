Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D51ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172BF2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172BF2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387712AbeGMQ3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:29:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38798 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729622AbeGMQ3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:29:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DDF0520737; Fri, 13 Jul 2018 18:14:04 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 832952074F;
        Fri, 13 Jul 2018 18:13:54 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 2/5] net: mvpp2: add a debugfs interface for the Header Parser
Date:   Fri, 13 Jul 2018 18:13:41 +0200
Message-Id: <20180713161344.19872-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180713161344.19872-1-maxime.chevallier@bootlin.com>
References: <20180713161344.19872-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell PPv2 Packer Header Parser has a TCAM based filter, that is not
trivial to configure and debug. Being able to dump TCAM entries from
userspace can be really helpful to help development of new features
and debug existing ones.

This commit adds a basic debugfs interface for the PPv2 driver, focusing
on TCAM related features.

<mnt>/mvpp2/ --- f2000000.ethernet
              \- f4000000.ethernet --- parser --- 000 ...
                                    |          \- 001
                                    |          \- ...
                                    |          \- 255 --- ai
                                    |                  \- header_data
                                    |                  \- lookup_id
                                    |                  \- sram
                                    |                  \- valid
                                    \- eth1 ...
                                    \- eth2 --- mac_filter
                                             \- parser_entries
                                             \- vid_filter

There's one directory per PPv2 instance, named after pdev->name to make
sure names are uniques. In each of these directories, there's :

 - one directory per interface on the controller, each containing :

   - "mac_filter", which lists all filtered addresses for this port
     (based on TCAM, not on the kernel's uc / mc lists)

   - "parser_entries", which lists the indices of all valid TCAM
      entries that have this port in their port map

   - "vid_filter", which lists the vids allowed on this port, based on
     TCAM

 - one "parser" directory (the parser is common to all ports), containing :

   - one directory per TCAM entry (256 of them, from 0 to 255), each
     containing :

     - "ai" : Contains the 1 byte Additional Info field from TCAM, and

     - "header_data" : Contains the 8 bytes Header Data extracted from
       the packet

     - "lookup_id" : Contains the 4 bits LU_ID

     - "sram" : contains the raw SRAM data, which is the result of the TCAM
		lookup. This readonly at the moment.

     - "valid" : Indicates if the entry is valid of not.

All entries are read-only, and everything is output in hex form.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/Makefile        |   2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h         |   7 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c | 344 +++++++++++++++++++++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   4 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c     |  12 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h     |   9 +
 6 files changed, 371 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c

diff --git a/drivers/net/ethernet/marvell/mvpp2/Makefile b/drivers/net/ethernet/marvell/mvpp2/Makefile
index 4d11dd9e3246..51f65a202c6e 100644
--- a/drivers/net/ethernet/marvell/mvpp2/Makefile
+++ b/drivers/net/ethernet/marvell/mvpp2/Makefile
@@ -4,4 +4,4 @@
 #
 obj-$(CONFIG_MVPP2) := mvpp2.o
 
-mvpp2-objs := mvpp2_main.o mvpp2_prs.o mvpp2_cls.o
+mvpp2-objs := mvpp2_main.o mvpp2_prs.o mvpp2_cls.o mvpp2_debugfs.o
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 3e470d6fcf64..439f14192b08 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -746,6 +746,9 @@ struct mvpp2 {
 	/* Workqueue to gather hardware statistics */
 	char queue_name[30];
 	struct workqueue_struct *stats_queue;
+
+	/* Debugfs root entry */
+	struct dentry *dbgfs_dir;
 };
 
 struct mvpp2_pcpu_stats {
@@ -1089,4 +1092,8 @@ u32 mvpp2_percpu_read(struct mvpp2 *priv, int cpu, u32 offset);
 void mvpp2_percpu_write_relaxed(struct mvpp2 *priv, int cpu, u32 offset,
 				u32 data);
 
+void mvpp2_dbgfs_init(struct mvpp2 *priv, const char *name);
+
+void mvpp2_dbgfs_cleanup(struct mvpp2 *priv);
+
 #endif
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
new file mode 100644
index 000000000000..e8a242b56519
--- /dev/null
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Marvell PPv2 network controller for Armada 375 SoC.
+ *
+ * Copyright (C) 2018 Marvell
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/debugfs.h>
+
+#include "mvpp2.h"
+#include "mvpp2_prs.h"
+
+struct mvpp2_dbgfs_prs_entry {
+	int tid;
+	struct mvpp2 *priv;
+};
+
+static int mvpp2_dbgfs_port_vid_show(struct seq_file *s, void *unused)
+{
+	struct mvpp2_port *port = s->private;
+	unsigned char byte[2], enable[2];
+	struct mvpp2 *priv = port->priv;
+	struct mvpp2_prs_entry pe;
+	unsigned long pmap;
+	u16 rvid;
+	int tid;
+
+	for (tid = MVPP2_PRS_VID_PORT_FIRST(port->id);
+	     tid <= MVPP2_PRS_VID_PORT_LAST(port->id); tid++) {
+		mvpp2_prs_init_from_hw(priv, &pe, tid);
+
+		pmap = mvpp2_prs_tcam_port_map_get(&pe);
+
+		if (!priv->prs_shadow[tid].valid)
+			continue;
+
+		if (!test_bit(port->id, &pmap))
+			continue;
+
+		mvpp2_prs_tcam_data_byte_get(&pe, 2, &byte[0], &enable[0]);
+		mvpp2_prs_tcam_data_byte_get(&pe, 3, &byte[1], &enable[1]);
+
+		rvid = ((byte[0] & 0xf) << 8) + byte[1];
+
+		seq_printf(s, "%u\n", rvid);
+	}
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_port_vid);
+
+static int mvpp2_dbgfs_port_parser_show(struct seq_file *s, void *unused)
+{
+	struct mvpp2_port *port = s->private;
+	struct mvpp2 *priv = port->priv;
+	struct mvpp2_prs_entry pe;
+	unsigned long pmap;
+	int i;
+
+	for (i = 0; i < MVPP2_PRS_TCAM_SRAM_SIZE; i++) {
+		mvpp2_prs_init_from_hw(port->priv, &pe, i);
+
+		pmap = mvpp2_prs_tcam_port_map_get(&pe);
+		if (priv->prs_shadow[i].valid && test_bit(port->id, &pmap))
+			seq_printf(s, "%03d\n", i);
+	}
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_port_parser);
+
+static int mvpp2_dbgfs_filter_show(struct seq_file *s, void *unused)
+{
+	struct mvpp2_port *port = s->private;
+	struct mvpp2 *priv = port->priv;
+	struct mvpp2_prs_entry pe;
+	unsigned long pmap;
+	int index, tid;
+
+	for (tid = MVPP2_PE_MAC_RANGE_START;
+	     tid <= MVPP2_PE_MAC_RANGE_END; tid++) {
+		unsigned char da[ETH_ALEN], da_mask[ETH_ALEN];
+
+		if (!priv->prs_shadow[tid].valid ||
+		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_MAC ||
+		    priv->prs_shadow[tid].udf != MVPP2_PRS_UDF_MAC_DEF)
+			continue;
+
+		mvpp2_prs_init_from_hw(priv, &pe, tid);
+
+		pmap = mvpp2_prs_tcam_port_map_get(&pe);
+
+		/* We only want entries active on this port */
+		if (!test_bit(port->id, &pmap))
+			continue;
+
+		/* Read mac addr from entry */
+		for (index = 0; index < ETH_ALEN; index++)
+			mvpp2_prs_tcam_data_byte_get(&pe, index, &da[index],
+						     &da_mask[index]);
+
+		seq_printf(s, "%pM\n", da);
+	}
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_filter);
+
+static int mvpp2_dbgfs_prs_lu_show(struct seq_file *s, void *unused)
+{
+	struct mvpp2_dbgfs_prs_entry *entry = s->private;
+	struct mvpp2 *priv = entry->priv;
+
+	seq_printf(s, "%x\n", priv->prs_shadow[entry->tid].lu);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_prs_lu);
+
+static int mvpp2_dbgfs_prs_pmap_show(struct seq_file *s, void *unused)
+{
+	struct mvpp2_dbgfs_prs_entry *entry = s->private;
+	struct mvpp2_prs_entry pe;
+	unsigned int pmap;
+
+	mvpp2_prs_init_from_hw(entry->priv, &pe, entry->tid);
+
+	pmap = mvpp2_prs_tcam_port_map_get(&pe);
+	pmap &= MVPP2_PRS_PORT_MASK;
+
+	seq_printf(s, "%02x\n", pmap);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_prs_pmap);
+
+static int mvpp2_dbgfs_prs_ai_show(struct seq_file *s, void *unused)
+{
+	struct mvpp2_dbgfs_prs_entry *entry = s->private;
+	struct mvpp2_prs_entry pe;
+	unsigned char ai, ai_mask;
+
+	mvpp2_prs_init_from_hw(entry->priv, &pe, entry->tid);
+
+	ai = pe.tcam[MVPP2_PRS_TCAM_AI_WORD] & MVPP2_PRS_AI_MASK;
+	ai_mask = (pe.tcam[MVPP2_PRS_TCAM_AI_WORD] >> 16) & MVPP2_PRS_AI_MASK;
+
+	seq_printf(s, "%02x %02x\n", ai, ai_mask);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_prs_ai);
+
+static int mvpp2_dbgfs_prs_hdata_show(struct seq_file *s, void *unused)
+{
+	struct mvpp2_dbgfs_prs_entry *entry = s->private;
+	struct mvpp2_prs_entry pe;
+	unsigned char data[8], mask[8];
+	int i;
+
+	mvpp2_prs_init_from_hw(entry->priv, &pe, entry->tid);
+
+	for (i = 0; i < 8; i++)
+		mvpp2_prs_tcam_data_byte_get(&pe, i, &data[i], &mask[i]);
+
+	seq_printf(s, "%*phN %*phN\n", 8, data, 8, mask);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_prs_hdata);
+
+static int mvpp2_dbgfs_prs_sram_show(struct seq_file *s, void *unused)
+{
+	struct mvpp2_dbgfs_prs_entry *entry = s->private;
+	struct mvpp2_prs_entry pe;
+
+	mvpp2_prs_init_from_hw(entry->priv, &pe, entry->tid);
+
+	seq_printf(s, "%*phN\n", 14, pe.sram);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_prs_sram);
+
+static int mvpp2_dbgfs_prs_valid_show(struct seq_file *s, void *unused)
+{
+	struct mvpp2_dbgfs_prs_entry *entry = s->private;
+	struct mvpp2 *priv = entry->priv;
+	int tid = entry->tid;
+
+	seq_printf(s, "%d\n", priv->prs_shadow[tid].valid ? 1 : 0);
+
+	return 0;
+}
+
+static int mvpp2_dbgfs_prs_valid_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mvpp2_dbgfs_prs_valid_show, inode->i_private);
+}
+
+static int mvpp2_dbgfs_prs_valid_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+	struct mvpp2_dbgfs_prs_entry *entry = seq->private;
+
+	kfree(entry);
+	return single_release(inode, file);
+}
+
+static const struct file_operations mvpp2_dbgfs_prs_valid_fops = {
+	.open = mvpp2_dbgfs_prs_valid_open,
+	.read = seq_read,
+	.release = mvpp2_dbgfs_prs_valid_release,
+};
+
+static int mvpp2_dbgfs_prs_entry_init(struct dentry *parent,
+				      struct mvpp2 *priv, int tid)
+{
+	struct mvpp2_dbgfs_prs_entry *entry;
+	struct dentry *prs_entry_dir;
+	char prs_entry_name[10];
+
+	if (tid >= MVPP2_PRS_TCAM_SRAM_SIZE)
+		return -EINVAL;
+
+	sprintf(prs_entry_name, "%03d", tid);
+
+	prs_entry_dir = debugfs_create_dir(prs_entry_name, parent);
+	if (!prs_entry_dir)
+		return -ENOMEM;
+
+	/* The 'valid' entry's ops will free that */
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->tid = tid;
+	entry->priv = priv;
+
+	/* Create each attr */
+	debugfs_create_file("sram", 0444, prs_entry_dir, entry,
+			    &mvpp2_dbgfs_prs_sram_fops);
+
+	debugfs_create_file("valid", 0644, prs_entry_dir, entry,
+			    &mvpp2_dbgfs_prs_valid_fops);
+
+	debugfs_create_file("lookup_id", 0644, prs_entry_dir, entry,
+			    &mvpp2_dbgfs_prs_lu_fops);
+
+	debugfs_create_file("ai", 0644, prs_entry_dir, entry,
+			    &mvpp2_dbgfs_prs_ai_fops);
+
+	debugfs_create_file("header_data", 0644, prs_entry_dir, entry,
+			    &mvpp2_dbgfs_prs_hdata_fops);
+
+	return 0;
+}
+
+static int mvpp2_dbgfs_prs_init(struct dentry *parent, struct mvpp2 *priv)
+{
+	struct dentry *prs_dir;
+	int i, ret;
+
+	prs_dir = debugfs_create_dir("parser", parent);
+	if (!prs_dir)
+		return -ENOMEM;
+
+	for (i = 0; i < MVPP2_PRS_TCAM_SRAM_SIZE; i++) {
+		ret = mvpp2_dbgfs_prs_entry_init(prs_dir, priv, i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int mvpp2_dbgfs_port_init(struct dentry *parent,
+				 struct mvpp2_port *port)
+{
+	struct dentry *port_dir;
+
+	port_dir = debugfs_create_dir(port->dev->name, parent);
+	if (IS_ERR(port_dir))
+		return PTR_ERR(port_dir);
+
+	debugfs_create_file("parser_entries", 0444, port_dir, port,
+			    &mvpp2_dbgfs_port_parser_fops);
+
+	debugfs_create_file("mac_filter", 0444, port_dir, port,
+			    &mvpp2_dbgfs_filter_fops);
+
+	debugfs_create_file("vid_filter", 0444, port_dir, port,
+			    &mvpp2_dbgfs_port_vid_fops);
+
+	return 0;
+}
+
+void mvpp2_dbgfs_cleanup(struct mvpp2 *priv)
+{
+	debugfs_remove_recursive(priv->dbgfs_dir);
+}
+
+void mvpp2_dbgfs_init(struct mvpp2 *priv, const char *name)
+{
+	struct dentry *mvpp2_dir, *mvpp2_root;
+	int ret, i;
+
+	mvpp2_root = debugfs_lookup(MVPP2_DRIVER_NAME, NULL);
+	if (!mvpp2_root) {
+		mvpp2_root = debugfs_create_dir(MVPP2_DRIVER_NAME, NULL);
+		if (IS_ERR(mvpp2_root))
+			return;
+	}
+
+	mvpp2_dir = debugfs_create_dir(name, mvpp2_root);
+	if (IS_ERR(mvpp2_dir))
+		return;
+
+	priv->dbgfs_dir = mvpp2_dir;
+
+	ret = mvpp2_dbgfs_prs_init(mvpp2_dir, priv);
+	if (ret)
+		goto err;
+
+	for (i = 0; i < priv->port_count; i++) {
+		ret = mvpp2_dbgfs_port_init(mvpp2_dir, priv->port_list[i]);
+		if (ret)
+			goto err;
+	}
+
+	return;
+err:
+	mvpp2_dbgfs_cleanup(priv);
+}
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 2d690b082b89..32d785b616e1 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5289,6 +5289,8 @@ static int mvpp2_probe(struct platform_device *pdev)
 		goto err_port_probe;
 	}
 
+	mvpp2_dbgfs_init(priv, pdev->name);
+
 	platform_set_drvdata(pdev, priv);
 	return 0;
 
@@ -5322,6 +5324,8 @@ static int mvpp2_remove(struct platform_device *pdev)
 	struct fwnode_handle *port_fwnode;
 	int i = 0;
 
+	mvpp2_dbgfs_cleanup(priv);
+
 	flush_workqueue(priv->stats_queue);
 	destroy_workqueue(priv->stats_queue);
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
index 2a8d25139a8f..f133d820f0fa 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
@@ -43,8 +43,8 @@ static int mvpp2_prs_hw_write(struct mvpp2 *priv, struct mvpp2_prs_entry *pe)
 }
 
 /* Initialize tcam entry from hw */
-static int mvpp2_prs_init_from_hw(struct mvpp2 *priv,
-				  struct mvpp2_prs_entry *pe, int tid)
+int mvpp2_prs_init_from_hw(struct mvpp2 *priv, struct mvpp2_prs_entry *pe,
+			   int tid)
 {
 	int i;
 
@@ -126,7 +126,7 @@ static void mvpp2_prs_tcam_port_map_set(struct mvpp2_prs_entry *pe,
 }
 
 /* Obtain port map from tcam sw entry */
-static unsigned int mvpp2_prs_tcam_port_map_get(struct mvpp2_prs_entry *pe)
+unsigned int mvpp2_prs_tcam_port_map_get(struct mvpp2_prs_entry *pe)
 {
 	return (~pe->tcam[MVPP2_PRS_TCAM_PORT_WORD] >> 24) & MVPP2_PRS_PORT_MASK;
 }
@@ -145,9 +145,9 @@ static void mvpp2_prs_tcam_data_byte_set(struct mvpp2_prs_entry *pe,
 }
 
 /* Get byte of data and its enable bits from tcam sw entry */
-static void mvpp2_prs_tcam_data_byte_get(struct mvpp2_prs_entry *pe,
-					 unsigned int offs, unsigned char *byte,
-					 unsigned char *enable)
+void mvpp2_prs_tcam_data_byte_get(struct mvpp2_prs_entry *pe,
+				  unsigned int offs, unsigned char *byte,
+				  unsigned char *enable)
 {
 	int pos = MVPP2_PRS_BYTE_IN_WORD(offs) * BITS_PER_BYTE;
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h
index eb81db1a301f..67b67ccb387d 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h
@@ -294,6 +294,15 @@ struct mvpp2_prs_shadow {
 
 int mvpp2_prs_default_init(struct platform_device *pdev, struct mvpp2 *priv);
 
+int mvpp2_prs_init_from_hw(struct mvpp2 *priv, struct mvpp2_prs_entry *pe,
+			   int tid);
+
+unsigned int mvpp2_prs_tcam_port_map_get(struct mvpp2_prs_entry *pe);
+
+void mvpp2_prs_tcam_data_byte_get(struct mvpp2_prs_entry *pe,
+				  unsigned int offs, unsigned char *byte,
+				  unsigned char *enable);
+
 int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da, bool add);
 
 int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type);
-- 
2.11.0

