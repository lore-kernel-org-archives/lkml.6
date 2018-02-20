Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeBTMAT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:00:19 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11230 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751996AbeBTMAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:00:15 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Feb 2018 04:00:14 -0800
From: Mikko Perttunen <mperttunen@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <talho@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pombredanne@nexb.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v4 1/7] firmware: tegra: Simplify channel management
Date: Tue, 20 Feb 2018 13:58:06 +0200
Message-ID: <20180220115812.24108-2-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220115812.24108-1-mperttunen@nvidia.com>
References: <20180220115812.24108-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra194 BPMP only implements 5 channels (4 to BPMP, 1 to CCPLEX),
and they are not placed contiguously in memory. The current channel
management in the BPMP driver does not support this.

Simplify and refactor the channel management such that only one atomic
transmit channel and one receive channel are supported, and channels
are not required to be placed contiguously in memory. The same
configuration also works on T186 so we end up with less code.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/firmware/tegra/bpmp.c | 142 +++++++++++++++++++-----------------------
 include/soc/tegra/bpmp.h      |   4 +-
 2 files changed, 66 insertions(+), 80 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index a7f461f2e650..81bc2dce8626 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -70,57 +70,20 @@ void tegra_bpmp_put(struct tegra_bpmp *bpmp)
 }
 EXPORT_SYMBOL_GPL(tegra_bpmp_put);
 
-static int tegra_bpmp_channel_get_index(struct tegra_bpmp_channel *channel)
-{
-	return channel - channel->bpmp->channels;
-}
-
 static int
 tegra_bpmp_channel_get_thread_index(struct tegra_bpmp_channel *channel)
 {
 	struct tegra_bpmp *bpmp = channel->bpmp;
-	unsigned int offset, count;
+	unsigned int count;
 	int index;
 
-	offset = bpmp->soc->channels.thread.offset;
 	count = bpmp->soc->channels.thread.count;
 
-	index = tegra_bpmp_channel_get_index(channel);
-	if (index < 0)
-		return index;
-
-	if (index < offset || index >= offset + count)
+	index = channel - channel->bpmp->threaded_channels;
+	if (index < 0 || index >= count)
 		return -EINVAL;
 
-	return index - offset;
-}
-
-static struct tegra_bpmp_channel *
-tegra_bpmp_channel_get_thread(struct tegra_bpmp *bpmp, unsigned int index)
-{
-	unsigned int offset = bpmp->soc->channels.thread.offset;
-	unsigned int count = bpmp->soc->channels.thread.count;
-
-	if (index >= count)
-		return NULL;
-
-	return &bpmp->channels[offset + index];
-}
-
-static struct tegra_bpmp_channel *
-tegra_bpmp_channel_get_tx(struct tegra_bpmp *bpmp)
-{
-	unsigned int offset = bpmp->soc->channels.cpu_tx.offset;
-
-	return &bpmp->channels[offset + smp_processor_id()];
-}
-
-static struct tegra_bpmp_channel *
-tegra_bpmp_channel_get_rx(struct tegra_bpmp *bpmp)
-{
-	unsigned int offset = bpmp->soc->channels.cpu_rx.offset;
-
-	return &bpmp->channels[offset];
+	return index;
 }
 
 static bool tegra_bpmp_message_valid(const struct tegra_bpmp_message *msg)
@@ -271,11 +234,7 @@ tegra_bpmp_write_threaded(struct tegra_bpmp *bpmp, unsigned int mrq,
 		goto unlock;
 	}
 
-	channel = tegra_bpmp_channel_get_thread(bpmp, index);
-	if (!channel) {
-		err = -EINVAL;
-		goto unlock;
-	}
+	channel = &bpmp->threaded_channels[index];
 
 	if (!tegra_bpmp_master_free(channel)) {
 		err = -EBUSY;
@@ -328,12 +287,18 @@ int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
 	if (!tegra_bpmp_message_valid(msg))
 		return -EINVAL;
 
-	channel = tegra_bpmp_channel_get_tx(bpmp);
+	channel = bpmp->tx_channel;
+
+	spin_lock(&bpmp->atomic_tx_lock);
 
 	err = tegra_bpmp_channel_write(channel, msg->mrq, MSG_ACK,
 				       msg->tx.data, msg->tx.size);
-	if (err < 0)
+	if (err < 0) {
+		spin_unlock(&bpmp->atomic_tx_lock);
 		return err;
+	}
+
+	spin_unlock(&bpmp->atomic_tx_lock);
 
 	err = mbox_send_message(bpmp->mbox.channel, NULL);
 	if (err < 0)
@@ -607,7 +572,7 @@ static void tegra_bpmp_handle_rx(struct mbox_client *client, void *data)
 	unsigned int i, count;
 	unsigned long *busy;
 
-	channel = tegra_bpmp_channel_get_rx(bpmp);
+	channel = bpmp->rx_channel;
 	count = bpmp->soc->channels.thread.count;
 	busy = bpmp->threaded.busy;
 
@@ -619,9 +584,7 @@ static void tegra_bpmp_handle_rx(struct mbox_client *client, void *data)
 	for_each_set_bit(i, busy, count) {
 		struct tegra_bpmp_channel *channel;
 
-		channel = tegra_bpmp_channel_get_thread(bpmp, i);
-		if (!channel)
-			continue;
+		channel = &bpmp->threaded_channels[i];
 
 		if (tegra_bpmp_master_acked(channel)) {
 			tegra_bpmp_channel_signal(channel);
@@ -698,7 +661,6 @@ static void tegra_bpmp_channel_cleanup(struct tegra_bpmp_channel *channel)
 
 static int tegra_bpmp_probe(struct platform_device *pdev)
 {
-	struct tegra_bpmp_channel *channel;
 	struct tegra_bpmp *bpmp;
 	unsigned int i;
 	char tag[32];
@@ -758,24 +720,45 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
 		goto free_rx;
 	}
 
-	bpmp->num_channels = bpmp->soc->channels.cpu_tx.count +
-			     bpmp->soc->channels.thread.count +
-			     bpmp->soc->channels.cpu_rx.count;
+	spin_lock_init(&bpmp->atomic_tx_lock);
+	bpmp->tx_channel = devm_kzalloc(&pdev->dev, sizeof(*bpmp->tx_channel),
+					GFP_KERNEL);
+	if (!bpmp->tx_channel) {
+		err = -ENOMEM;
+		goto free_rx;
+	}
 
-	bpmp->channels = devm_kcalloc(&pdev->dev, bpmp->num_channels,
-				      sizeof(*channel), GFP_KERNEL);
-	if (!bpmp->channels) {
+	bpmp->rx_channel = devm_kzalloc(&pdev->dev, sizeof(*bpmp->rx_channel),
+	                                GFP_KERNEL);
+	if (!bpmp->rx_channel) {
 		err = -ENOMEM;
 		goto free_rx;
 	}
 
-	/* message channel initialization */
-	for (i = 0; i < bpmp->num_channels; i++) {
-		struct tegra_bpmp_channel *channel = &bpmp->channels[i];
+	bpmp->threaded_channels = devm_kcalloc(&pdev->dev, bpmp->threaded.count,
+					       sizeof(*bpmp->threaded_channels),
+					       GFP_KERNEL);
+	if (!bpmp->threaded_channels) {
+		err = -ENOMEM;
+		goto free_rx;
+	}
 
-		err = tegra_bpmp_channel_init(channel, bpmp, i);
+	err = tegra_bpmp_channel_init(bpmp->tx_channel, bpmp,
+				      bpmp->soc->channels.cpu_tx.offset);
+	if (err < 0)
+		goto free_rx;
+
+	err = tegra_bpmp_channel_init(bpmp->rx_channel, bpmp,
+				      bpmp->soc->channels.cpu_rx.offset);
+	if (err < 0)
+		goto cleanup_tx_channel;
+
+	for (i = 0; i < bpmp->threaded.count; i++) {
+		err = tegra_bpmp_channel_init(
+			&bpmp->threaded_channels[i], bpmp,
+			bpmp->soc->channels.thread.offset + i);
 		if (err < 0)
-			goto cleanup_channels;
+			goto cleanup_threaded_channels;
 	}
 
 	/* mbox registration */
@@ -788,15 +771,14 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
 	if (IS_ERR(bpmp->mbox.channel)) {
 		err = PTR_ERR(bpmp->mbox.channel);
 		dev_err(&pdev->dev, "failed to get HSP mailbox: %d\n", err);
-		goto cleanup_channels;
+		goto cleanup_threaded_channels;
 	}
 
 	/* reset message channels */
-	for (i = 0; i < bpmp->num_channels; i++) {
-		struct tegra_bpmp_channel *channel = &bpmp->channels[i];
-
-		tegra_bpmp_channel_reset(channel);
-	}
+	tegra_bpmp_channel_reset(bpmp->tx_channel);
+	tegra_bpmp_channel_reset(bpmp->rx_channel);
+	for (i = 0; i < bpmp->threaded.count; i++)
+		tegra_bpmp_channel_reset(&bpmp->threaded_channels[i]);
 
 	err = tegra_bpmp_request_mrq(bpmp, MRQ_PING,
 				     tegra_bpmp_mrq_handle_ping, bpmp);
@@ -845,9 +827,15 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
 	tegra_bpmp_free_mrq(bpmp, MRQ_PING, bpmp);
 free_mbox:
 	mbox_free_channel(bpmp->mbox.channel);
-cleanup_channels:
-	while (i--)
-		tegra_bpmp_channel_cleanup(&bpmp->channels[i]);
+cleanup_threaded_channels:
+	for (i = 0; i < bpmp->threaded.count; i++) {
+		if (bpmp->threaded_channels[i].bpmp)
+			tegra_bpmp_channel_cleanup(&bpmp->threaded_channels[i]);
+	}
+
+	tegra_bpmp_channel_cleanup(bpmp->rx_channel);
+cleanup_tx_channel:
+	tegra_bpmp_channel_cleanup(bpmp->tx_channel);
 free_rx:
 	gen_pool_free(bpmp->rx.pool, (unsigned long)bpmp->rx.virt, 4096);
 free_tx:
@@ -858,18 +846,16 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
 static const struct tegra_bpmp_soc tegra186_soc = {
 	.channels = {
 		.cpu_tx = {
-			.offset = 0,
-			.count = 6,
+			.offset = 3,
 			.timeout = 60 * USEC_PER_SEC,
 		},
 		.thread = {
-			.offset = 6,
-			.count = 7,
+			.offset = 0,
+			.count = 3,
 			.timeout = 600 * USEC_PER_SEC,
 		},
 		.cpu_rx = {
 			.offset = 13,
-			.count = 1,
 			.timeout = 0,
 		},
 	},
diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
index aeae4466dd25..e69e4c4d80ae 100644
--- a/include/soc/tegra/bpmp.h
+++ b/include/soc/tegra/bpmp.h
@@ -75,8 +75,8 @@ struct tegra_bpmp {
 		struct mbox_chan *channel;
 	} mbox;
 
-	struct tegra_bpmp_channel *channels;
-	unsigned int num_channels;
+	spinlock_t atomic_tx_lock;
+	struct tegra_bpmp_channel *tx_channel, *rx_channel, *threaded_channels;
 
 	struct {
 		unsigned long *allocated;
-- 
2.16.1
