Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80CBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7969E206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dDqx49i4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393281AbfAPNog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:44:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36043 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733175AbfAPNof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:44:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so6997190wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 05:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=DM5tu/r8wrvirg6BCehjKky0y5iqI6RQJjvECDwO6gI=;
        b=dDqx49i4HCosKdYgHgLE/n5zLXUyu94ivuQbwtK/WBgLPmsY77Lg+3syv/TCwAlGnR
         xUKr45dwwNdErZ0wdKw+CUIqFPYnEU+XQZ0wiGZ4RNrfE6S7ty2OcqFWpob4SvEMqksK
         KPBJ9mBfOF9hyf15rrThQ0vrwrabBvH0GbjYx0+R/PC2NW00Srb/c5X1uWeIT3bSyguj
         RklPz8kqAjZ3d/A1HesCViSKZUiFbaSv33UYh2JfZpF/rvbBt4MefCwmmlfUJ9ED89Te
         gNG7o3NDX5YhVQS2dpsRM3SIxFOMXkZA/Pa/WLMkAQmUJidtVXr78FpUiOtCnMxFxNkM
         cUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DM5tu/r8wrvirg6BCehjKky0y5iqI6RQJjvECDwO6gI=;
        b=uQys6IdfcZkwUy/GqoTmcTBiaMNLK7kNZBU0FYRC/vprfpG85gsTIW1ySfbGUJdGtw
         E98Heblb9gxW5xim4LzaCzKVoeroSqobYOGQtfsvejiqlXjLZfmCdJdy+wcnyjp1ijP8
         FME5HIqeKgJNVKUR7ZjQoTeT2HC1llrGx0BM5Y8BH2CL7p6EjJeWOOV5MtNuONBvNcp7
         vZrWhfCU9GqB93cPKKLCt+06js/6gmKzEBy5oAbzc7JBAWplQXvyZ5vAQ7XtsjfloPb2
         skcYZ0Yf5xszDTpRnTEWEvTZ0SsbWanzW1qCMi1zEBm5y3AST43I/k1ZQwHwiWa5Uket
         etFA==
X-Gm-Message-State: AJcUukdE7gwor753SnOs8R6ZadV4SaPyZel+2m95VmSWptq5y4ZNG76J
        cS1GBUG47CJk7JCr3YPBTehSUtGz5g4=
X-Google-Smtp-Source: ALg8bN6W8lF0MoSyz38fb3CTkBMR2Wew8oSQp+BJq2ozI/be6CaFoqdlxPqPkCwYQF4plQ+lP36+UA==
X-Received: by 2002:adf:b190:: with SMTP id q16mr7649235wra.95.1547646273608;
        Wed, 16 Jan 2019 05:44:33 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id i13sm71014746wrw.32.2019.01.16.05.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 05:44:32 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] dma-debug: add dumping facility via debugfs
Date:   Wed, 16 Jan 2019 13:44:25 +0000
Message-Id: <1547646265-9414-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging a DMA mapping leak, I needed to access
debug_dma_dump_mappings() but easily from user space.

This patch adds a /sys/kernel/debug/dma-api/dump file which contain all
current DMA mapping.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 kernel/dma/debug.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 23cf5361bcf1..9253382f5729 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -144,6 +144,7 @@ static struct dentry *num_free_entries_dent __read_mostly;
 static struct dentry *min_free_entries_dent __read_mostly;
 static struct dentry *nr_total_entries_dent __read_mostly;
 static struct dentry *filter_dent           __read_mostly;
+static struct dentry *dump_dent             __read_mostly;
 
 /* per-driver filter related state */
 
@@ -840,6 +841,47 @@ static const struct file_operations filter_fops = {
 	.llseek = default_llseek,
 };
 
+static int dump_read(struct seq_file *seq, void *v)
+{
+	int idx;
+
+	for (idx = 0; idx < HASH_SIZE; idx++) {
+		struct hash_bucket *bucket = &dma_entry_hash[idx];
+		struct dma_debug_entry *entry;
+		unsigned long flags;
+
+		spin_lock_irqsave(&bucket->lock, flags);
+
+		list_for_each_entry(entry, &bucket->list, list) {
+			seq_printf(seq,
+				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx %s %s\n",
+				   dev_name(entry->dev),
+				   dev_driver_string(entry->dev),
+				   type2name[entry->type], idx,
+				   phys_addr(entry), entry->pfn,
+				   entry->dev_addr, entry->size,
+				   dir2name[entry->direction],
+				   maperr2str[entry->map_err_type]);
+		}
+
+		spin_unlock_irqrestore(&bucket->lock, flags);
+	}
+	return 0;
+}
+
+static int dump_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dump_read, inode->i_private);
+}
+
+static const struct file_operations dump_fops = {
+	.owner = THIS_MODULE,
+	.open = dump_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
 static int dma_debug_fs_init(void)
 {
 	dma_debug_dent = debugfs_create_dir("dma-api", NULL);
@@ -894,6 +936,11 @@ static int dma_debug_fs_init(void)
 	if (!filter_dent)
 		goto out_err;
 
+	dump_dent = debugfs_create_file("dump", 0444,
+					dma_debug_dent, NULL, &dump_fops);
+	if (!dump_dent)
+		goto out_err;
+
 	return 0;
 
 out_err:
-- 
2.19.2

