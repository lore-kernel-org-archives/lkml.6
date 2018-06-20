Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D4C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A44520874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A44520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeFTMVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:21:22 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12667 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754069AbeFTMVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:21:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b2a46a60000>; Wed, 20 Jun 2018 05:20:54 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 Jun 2018 05:21:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 Jun 2018 05:21:17 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 20 Jun
 2018 12:21:16 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Wed, 20 Jun 2018 12:21:16 +0000
Received: from mperttunen-lnx.Nvidia.com (Not Verified[10.21.26.144]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b2a46b90000>; Wed, 20 Jun 2018 05:21:15 -0700
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jassisinghbrar@gmail.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 4/8] mailbox: tegra-hsp: Refactor in preparation of mailboxes
Date:   Wed, 20 Jun 2018 15:20:38 +0300
Message-ID: <20180620122042.10950-5-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180620122042.10950-1-mperttunen@nvidia.com>
References: <20180620122042.10950-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HSP driver is currently in many places written with the assumption
of only supporting doorbells. Prepare for the addition of shared
mailbox support by removing these assumptions and cleaning up the code.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---

Notes:
    v2:
    - Moved fixes for some style and other issues from the next patch
      here, where they belong.

 drivers/mailbox/tegra-hsp.c | 123 +++++++++++++++++++++++++++++---------------
 1 file changed, 81 insertions(+), 42 deletions(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 0cde356c11ab..5dc21a6d01bb 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -42,6 +42,7 @@ struct tegra_hsp_channel;
 struct tegra_hsp;
 
 struct tegra_hsp_channel {
+	unsigned int type;
 	struct tegra_hsp *hsp;
 	struct mbox_chan *chan;
 	void __iomem *regs;
@@ -55,6 +56,12 @@ struct tegra_hsp_doorbell {
 	unsigned int index;
 };
 
+static inline struct tegra_hsp_doorbell *
+channel_to_doorbell(struct tegra_hsp_channel *channel)
+{
+	return container_of(channel, struct tegra_hsp_doorbell, channel);
+}
+
 struct tegra_hsp_db_map {
 	const char *name;
 	unsigned int master;
@@ -69,7 +76,7 @@ struct tegra_hsp {
 	const struct tegra_hsp_soc *soc;
 	struct mbox_controller mbox;
 	void __iomem *regs;
-	unsigned int irq;
+	unsigned int doorbell_irq;
 	unsigned int num_sm;
 	unsigned int num_as;
 	unsigned int num_ss;
@@ -194,7 +201,7 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
 	if (!db)
 		return ERR_PTR(-ENOMEM);
 
-	offset = (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) << 16;
+	offset = (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) * SZ_64K;
 	offset += index * 0x100;
 
 	db->channel.regs = hsp->regs + offset;
@@ -218,18 +225,8 @@ static void __tegra_hsp_doorbell_destroy(struct tegra_hsp_doorbell *db)
 	kfree(db);
 }
 
-static int tegra_hsp_doorbell_send_data(struct mbox_chan *chan, void *data)
-{
-	struct tegra_hsp_doorbell *db = chan->con_priv;
-
-	tegra_hsp_channel_writel(&db->channel, 1, HSP_DB_TRIGGER);
-
-	return 0;
-}
-
-static int tegra_hsp_doorbell_startup(struct mbox_chan *chan)
+static int tegra_hsp_doorbell_startup(struct tegra_hsp_doorbell *db)
 {
-	struct tegra_hsp_doorbell *db = chan->con_priv;
 	struct tegra_hsp *hsp = db->channel.hsp;
 	struct tegra_hsp_doorbell *ccplex;
 	unsigned long flags;
@@ -260,9 +257,8 @@ static int tegra_hsp_doorbell_startup(struct mbox_chan *chan)
 	return 0;
 }
 
-static void tegra_hsp_doorbell_shutdown(struct mbox_chan *chan)
+static void tegra_hsp_doorbell_shutdown(struct tegra_hsp_doorbell *db)
 {
-	struct tegra_hsp_doorbell *db = chan->con_priv;
 	struct tegra_hsp *hsp = db->channel.hsp;
 	struct tegra_hsp_doorbell *ccplex;
 	unsigned long flags;
@@ -281,35 +277,60 @@ static void tegra_hsp_doorbell_shutdown(struct mbox_chan *chan)
 	spin_unlock_irqrestore(&hsp->lock, flags);
 }
 
-static const struct mbox_chan_ops tegra_hsp_doorbell_ops = {
-	.send_data = tegra_hsp_doorbell_send_data,
-	.startup = tegra_hsp_doorbell_startup,
-	.shutdown = tegra_hsp_doorbell_shutdown,
+static int tegra_hsp_send_data(struct mbox_chan *chan, void *data)
+{
+	struct tegra_hsp_channel *channel = chan->con_priv;
+
+	switch (channel->type) {
+	case TEGRA_HSP_MBOX_TYPE_DB:
+		tegra_hsp_channel_writel(channel, 1, HSP_DB_TRIGGER);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int tegra_hsp_startup(struct mbox_chan *chan)
+{
+	struct tegra_hsp_channel *channel = chan->con_priv;
+
+	switch (channel->type) {
+	case TEGRA_HSP_MBOX_TYPE_DB:
+		return tegra_hsp_doorbell_startup(channel_to_doorbell(channel));
+	}
+
+	return -EINVAL;
+}
+
+static void tegra_hsp_shutdown(struct mbox_chan *chan)
+{
+	struct tegra_hsp_channel *channel = chan->con_priv;
+
+	switch (channel->type) {
+	case TEGRA_HSP_MBOX_TYPE_DB:
+		tegra_hsp_doorbell_shutdown(channel_to_doorbell(channel));
+		break;
+	}
+}
+
+static const struct mbox_chan_ops tegra_hsp_ops = {
+	.send_data = tegra_hsp_send_data,
+	.startup = tegra_hsp_startup,
+	.shutdown = tegra_hsp_shutdown,
 };
 
-static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox,
-					    const struct of_phandle_args *args)
+static struct mbox_chan *tegra_hsp_doorbell_xlate(struct tegra_hsp *hsp,
+						  unsigned int master)
 {
 	struct tegra_hsp_channel *channel = ERR_PTR(-ENODEV);
-	struct tegra_hsp *hsp = to_tegra_hsp(mbox);
-	unsigned int type = args->args[0];
-	unsigned int master = args->args[1];
 	struct tegra_hsp_doorbell *db;
 	struct mbox_chan *chan;
 	unsigned long flags;
 	unsigned int i;
 
-	switch (type) {
-	case TEGRA_HSP_MBOX_TYPE_DB:
-		db = tegra_hsp_doorbell_get(hsp, master);
-		if (db)
-			channel = &db->channel;
-
-		break;
-
-	default:
-		break;
-	}
+	db = tegra_hsp_doorbell_get(hsp, master);
+	if (db)
+		channel = &db->channel;
 
 	if (IS_ERR(channel))
 		return ERR_CAST(channel);
@@ -321,6 +342,7 @@ static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox,
 		if (!chan->con_priv) {
 			chan->con_priv = channel;
 			channel->chan = chan;
+			channel->type = TEGRA_HSP_MBOX_TYPE_DB;
 			break;
 		}
 
@@ -332,6 +354,22 @@ static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox,
 	return chan ?: ERR_PTR(-EBUSY);
 }
 
+static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox,
+					    const struct of_phandle_args *args)
+{
+	struct tegra_hsp *hsp = to_tegra_hsp(mbox);
+	unsigned int type = args->args[0];
+	unsigned int param = args->args[1];
+
+	switch (type) {
+	case TEGRA_HSP_MBOX_TYPE_DB:
+		return tegra_hsp_doorbell_xlate(hsp, param);
+
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+}
+
 static void tegra_hsp_remove_doorbells(struct tegra_hsp *hsp)
 {
 	struct tegra_hsp_doorbell *db, *tmp;
@@ -397,14 +435,14 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	hsp->irq = err;
+	hsp->doorbell_irq = err;
 
 	hsp->mbox.of_xlate = of_tegra_hsp_xlate;
 	hsp->mbox.num_chans = 32;
 	hsp->mbox.dev = &pdev->dev;
 	hsp->mbox.txdone_irq = false;
 	hsp->mbox.txdone_poll = false;
-	hsp->mbox.ops = &tegra_hsp_doorbell_ops;
+	hsp->mbox.ops = &tegra_hsp_ops;
 
 	hsp->mbox.chans = devm_kcalloc(&pdev->dev, hsp->mbox.num_chans,
 					sizeof(*hsp->mbox.chans),
@@ -427,11 +465,12 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = devm_request_irq(&pdev->dev, hsp->irq, tegra_hsp_doorbell_irq,
-			       IRQF_NO_SUSPEND, dev_name(&pdev->dev), hsp);
+	err = devm_request_irq(&pdev->dev, hsp->doorbell_irq,
+			       tegra_hsp_doorbell_irq, IRQF_NO_SUSPEND,
+			       dev_name(&pdev->dev), hsp);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n",
-			hsp->irq, err);
+		dev_err(&pdev->dev, "failed to request doorbell IRQ#%u: %d\n",
+			hsp->doorbell_irq, err);
 		return err;
 	}
 
-- 
2.16.1

