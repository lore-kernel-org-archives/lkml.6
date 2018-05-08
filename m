Return-Path: <mperttunen@nvidia.com>
X-Google-Smtp-Source: AB8JxZor/R9kZgf3wjBHkrUE82hKT+Nk8lgomV6sU1KOnC+go9W9evT6Q2LMqsh14jFNHRKf1d5Q
ARC-Seal: i=1; a=rsa-sha256; t=1525780177; cv=none;
        d=google.com; s=arc-20160816;
        b=GsyUTwCdtrAhMLYM6aqNzvnSWlFKG2kvvcIX9DIJ91RLKyF1d/CvsvW/gZxBJuOHfQ
         HcSsfOJvLCRF3V+1+CKV8QvivZPXTrebb7tg3SKJ1CifZdRWigSYU5Y1wTyEqBuTFUgC
         dw+0+Hq1TqL0TAl7ZSPFwxaJT1aNDLjLnOw+VYVkSIUKoyufLIsIwOMjFDjef/OTOYON
         5my2Uyh2k/4BGXrwMPaieNWdS9et5bsFpG5aNQm6yDC7VePYpTaYtKPl/ngwdgbAaF/H
         qsaxkAq0oW1fW/vg5yoUuvdI+MM2D7N7J/85/ESILBRystu9Ets/8w6+VOWGvZIc3d8x
         cVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=eBXAnSD+2bXMyAWHMiNHczD3808RZGv0EZ3FgTEYyjI=;
        b=WN02sQoKXCNpY5xFsLWONpOKgztBI0Det7X5kp9FFNcAE0ueOqpFU4yOSrktun0gQX
         kj3fwPuf2i736ULG+x+4ZreTRhwc6dzOlHxdje37YwkUor4BqBPYC9RLEPYt3DOlK3Q4
         bEAZd4+PB5A/KZKOqNmVR2jmsprcRqGuCxTazHCKw+hyGrtLrIfJrO90XDpeMWDPlI6T
         3mKus/Fj/jhBSKTzDEnoJCnKgb5vl05FCCKn3oEmgqZV0pv5omjzb5a/+5zSP/j+caU1
         K5bISdNTJ0OkkEP78Xrk7SZrtBd8LuQdH/ktoYVjTeLaVd6xjiol2S23fIDRTvnY/rUv
         6LOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mperttunen@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=mperttunen@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mperttunen@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=mperttunen@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate102.nvidia.com on Tue, 08 May 2018 04:49:31 -0700
From: Mikko Perttunen <mperttunen@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
	<gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>
CC: <araza@nvidia.com>, <devicetree@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Mikko Perttunen" <mperttunen@nvidia.com>
Subject: [PATCH 5/8] mailbox: tegra-hsp: Add support for shared mailboxes
Date: Tue, 8 May 2018 14:44:00 +0300
Message-ID: <20180508114403.14499-6-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180508114403.14499-1-mperttunen@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599896475595898000?=
X-GMAIL-MSGID: =?utf-8?q?1599896475595898000?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Tegra HSP block supports 'shared mailboxes' that are simple 32-bit
registers consisting of a FULL bit in MSB position and 31 bits of data.
The hardware can be configured to trigger interrupts when a mailbox
is empty or full. Add support for these shared mailboxes to the HSP
driver.

The initial use for the mailboxes is the Tegra Combined UART. For this
purpose, we use interrupts to receive data, and spinning to wait for
the transmit mailbox to be emptied to minimize unnecessary overhead.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/mailbox/tegra-hsp.c | 216 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 193 insertions(+), 23 deletions(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 16eb970f2c9f..77bc8ed7ef15 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -21,6 +21,11 @@
 
 #include <dt-bindings/mailbox/tegra186-hsp.h>
 
+#include "mailbox.h"
+
+#define HSP_INT0_IE		0x100
+#define HSP_INT_IR		0x304
+
 #define HSP_INT_DIMENSIONING	0x380
 #define HSP_nSM_SHIFT		0
 #define HSP_nSS_SHIFT		4
@@ -34,6 +39,8 @@
 #define HSP_DB_RAW	0x8
 #define HSP_DB_PENDING	0xc
 
+#define HSP_SM_SHRD_MBOX	0x0
+
 #define HSP_DB_CCPLEX		1
 #define HSP_DB_BPMP		3
 #define HSP_DB_MAX		7
@@ -68,6 +75,18 @@ struct tegra_hsp_db_map {
 	unsigned int index;
 };
 
+struct tegra_hsp_mailbox {
+	struct tegra_hsp_channel channel;
+	unsigned int index;
+	bool sending;
+};
+
+static inline struct tegra_hsp_mailbox *
+channel_to_mailbox(struct tegra_hsp_channel *channel)
+{
+	return container_of(channel, struct tegra_hsp_mailbox, channel);
+}
+
 struct tegra_hsp_soc {
 	const struct tegra_hsp_db_map *map;
 };
@@ -77,6 +96,7 @@ struct tegra_hsp {
 	struct mbox_controller mbox;
 	void __iomem *regs;
 	unsigned int doorbell_irq;
+	unsigned int shared_irq;
 	unsigned int num_sm;
 	unsigned int num_as;
 	unsigned int num_ss;
@@ -85,6 +105,7 @@ struct tegra_hsp {
 	spinlock_t lock;
 
 	struct list_head doorbells;
+	struct tegra_hsp_mailbox *mailboxes;
 };
 
 static inline struct tegra_hsp *
@@ -189,6 +210,35 @@ static irqreturn_t tegra_hsp_doorbell_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t tegra_hsp_shared_irq(int irq, void *data)
+{
+	struct tegra_hsp_mailbox *mb;
+	struct tegra_hsp *hsp = data;
+	unsigned long bit, mask;
+	u32 value;
+
+	mask = tegra_hsp_readl(hsp, HSP_INT_IR);
+	/* Only interested in FULL interrupts */
+	mask &= 0xff << 8;
+
+	for_each_set_bit(bit, &mask, 16) {
+		unsigned int mb_i = bit % 8;
+
+		mb = &hsp->mailboxes[mb_i];
+
+		if (!mb->sending) {
+			value = tegra_hsp_channel_readl(&mb->channel,
+							HSP_SM_SHRD_MBOX);
+			value &= ~BIT(31);
+			mbox_chan_received_data(mb->channel.chan, &value);
+			tegra_hsp_channel_writel(&mb->channel, value,
+						 HSP_SM_SHRD_MBOX);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
 static struct tegra_hsp_channel *
 tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
 			  unsigned int master, unsigned int index)
@@ -277,15 +327,58 @@ static void tegra_hsp_doorbell_shutdown(struct tegra_hsp_doorbell *db)
 	spin_unlock_irqrestore(&hsp->lock, flags);
 }
 
+static int tegra_hsp_mailbox_startup(struct tegra_hsp_mailbox *mb)
+{
+	struct tegra_hsp *hsp = mb->channel.hsp;
+	u32 value;
+
+	mb->channel.chan->txdone_method = TXDONE_BY_BLOCK;
+
+	/* Route FULL interrupt to external IRQ 0 */
+	value = tegra_hsp_readl(hsp, HSP_INT0_IE);
+	value |= BIT(mb->index + 8);
+	tegra_hsp_writel(hsp, value, HSP_INT0_IE);
+
+	return 0;
+}
+
+static int tegra_hsp_mailbox_shutdown(struct tegra_hsp_mailbox *mb)
+{
+	struct tegra_hsp *hsp = mb->channel.hsp;
+	u32 value;
+
+	value = tegra_hsp_readl(hsp, HSP_INT0_IE);
+	value &= ~BIT(mb->index + 8);
+	tegra_hsp_writel(hsp, value, HSP_INT0_IE);
+
+	return 0;
+}
+
 static int tegra_hsp_send_data(struct mbox_chan *chan, void *data)
 {
 	struct tegra_hsp_channel *channel = chan->con_priv;
-	struct tegra_hsp_doorbell *db;
+	struct tegra_hsp_mailbox *mailbox;
+	uint32_t value;
 
 	switch (channel->type) {
 	case TEGRA_HSP_MBOX_TYPE_DB:
-		db = channel_to_doorbell(channel);
-		tegra_hsp_channel_writel(&db->channel, 1, HSP_DB_TRIGGER);
+		tegra_hsp_channel_writel(channel, 1, HSP_DB_TRIGGER);
+		return 0;
+	case TEGRA_HSP_MBOX_TYPE_SM:
+		mailbox = channel_to_mailbox(channel);
+		mailbox->sending = true;
+
+		value = *(uint32_t *)data;
+		/* Mark mailbox full */
+		value |= BIT(31);
+
+		tegra_hsp_channel_writel(channel, value, HSP_SM_SHRD_MBOX);
+
+		while (tegra_hsp_channel_readl(channel, HSP_SM_SHRD_MBOX)
+		               & BIT(31))
+			cpu_relax();
+
+		return 0;
 	}
 
 	return -EINVAL;
@@ -298,6 +391,8 @@ static int tegra_hsp_startup(struct mbox_chan *chan)
 	switch (channel->type) {
 	case TEGRA_HSP_MBOX_TYPE_DB:
 		return tegra_hsp_doorbell_startup(channel_to_doorbell(channel));
+	case TEGRA_HSP_MBOX_TYPE_SM:
+		return tegra_hsp_mailbox_startup(channel_to_mailbox(channel));
 	}
 
 	return -EINVAL;
@@ -311,6 +406,9 @@ static void tegra_hsp_shutdown(struct mbox_chan *chan)
 	case TEGRA_HSP_MBOX_TYPE_DB:
 		tegra_hsp_doorbell_shutdown(channel_to_doorbell(channel));
 		break;
+	case TEGRA_HSP_MBOX_TYPE_SM:
+		tegra_hsp_mailbox_shutdown(channel_to_mailbox(channel));
+		break;
 	}
 }
 
@@ -364,7 +462,16 @@ static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox,
 
 	switch (type) {
 	case TEGRA_HSP_MBOX_TYPE_DB:
-		return tegra_hsp_doorbell_xlate(hsp, param);
+		if (hsp->doorbell_irq)
+			return tegra_hsp_doorbell_xlate(hsp, param);
+		else
+			return ERR_PTR(-EINVAL);
+
+	case TEGRA_HSP_MBOX_TYPE_SM:
+		if (hsp->shared_irq && param < hsp->num_sm)
+			return hsp->mailboxes[param].channel.chan;
+		else
+			return ERR_PTR(-EINVAL);
 
 	default:
 		return ERR_PTR(-EINVAL);
@@ -403,6 +510,31 @@ static int tegra_hsp_add_doorbells(struct tegra_hsp *hsp)
 	return 0;
 }
 
+static int tegra_hsp_add_mailboxes(struct tegra_hsp *hsp, struct device *dev)
+{
+	int i;
+
+	hsp->mailboxes = devm_kcalloc(dev, hsp->num_sm, sizeof(*hsp->mailboxes),
+				      GFP_KERNEL);
+	if (!hsp->mailboxes)
+		return -ENOMEM;
+
+	for (i = 0; i < hsp->num_sm; i++) {
+		struct tegra_hsp_mailbox *mb = &hsp->mailboxes[i];
+
+		mb->index = i;
+		mb->sending = false;
+
+		mb->channel.hsp = hsp;
+		mb->channel.type = TEGRA_HSP_MBOX_TYPE_SM;
+		mb->channel.regs = hsp->regs + SZ_64K + i * SZ_32K;
+		mb->channel.chan = &hsp->mbox.chans[i];
+		mb->channel.chan->con_priv = &mb->channel;
+	}
+
+	return 0;
+}
+
 static int tegra_hsp_probe(struct platform_device *pdev)
 {
 	struct tegra_hsp *hsp;
@@ -431,14 +563,19 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 	hsp->num_si = (value >> HSP_nSI_SHIFT) & HSP_nINT_MASK;
 
 	err = platform_get_irq_byname(pdev, "doorbell");
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get doorbell IRQ: %d\n", err);
-		return err;
-	}
+	if (err < 0)
+		hsp->doorbell_irq = 0;
+	else
+		hsp->doorbell_irq = err;
 
-	hsp->doorbell_irq = err;
+	err = platform_get_irq_byname(pdev, "shared0");
+	if (err < 0)
+		hsp->shared_irq = 0;
+	else
+		hsp->shared_irq = err;
 
 	hsp->mbox.of_xlate = of_tegra_hsp_xlate;
+	/* First nSM are reserved for mailboxes */
 	hsp->mbox.num_chans = 32;
 	hsp->mbox.dev = &pdev->dev;
 	hsp->mbox.txdone_irq = false;
@@ -451,10 +588,22 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 	if (!hsp->mbox.chans)
 		return -ENOMEM;
 
-	err = tegra_hsp_add_doorbells(hsp);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to add doorbells: %d\n", err);
-		return err;
+	if (hsp->doorbell_irq) {
+		err = tegra_hsp_add_doorbells(hsp);
+		if (err < 0) {
+			dev_err(&pdev->dev, "failed to add doorbells: %d\n",
+			        err);
+			return err;
+		}
+	}
+
+	if (hsp->shared_irq) {
+		err = tegra_hsp_add_mailboxes(hsp, &pdev->dev);
+		if (err < 0) {
+			dev_err(&pdev->dev, "failed to add mailboxes: %d\n",
+			        err);
+			goto remove_doorbells;
+		}
 	}
 
 	platform_set_drvdata(pdev, hsp);
@@ -462,20 +611,40 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 	err = mbox_controller_register(&hsp->mbox);
 	if (err) {
 		dev_err(&pdev->dev, "failed to register mailbox: %d\n", err);
-		tegra_hsp_remove_doorbells(hsp);
-		return err;
+		goto remove_doorbells;
 	}
 
-	err = devm_request_irq(&pdev->dev, hsp->doorbell_irq,
-			       tegra_hsp_doorbell_irq, IRQF_NO_SUSPEND,
-			       dev_name(&pdev->dev), hsp);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to request doorbell IRQ#%u: %d\n",
-			hsp->doorbell_irq, err);
-		return err;
+	if (hsp->doorbell_irq) {
+		err = devm_request_irq(&pdev->dev, hsp->doorbell_irq,
+				       tegra_hsp_doorbell_irq, IRQF_NO_SUSPEND,
+				       dev_name(&pdev->dev), hsp);
+		if (err < 0) {
+			dev_err(&pdev->dev,
+			        "failed to request doorbell IRQ#%u: %d\n",
+				hsp->doorbell_irq, err);
+			return err;
+		}
+	}
+
+	if (hsp->shared_irq) {
+		err = devm_request_irq(&pdev->dev, hsp->shared_irq,
+				       tegra_hsp_shared_irq, 0,
+				       dev_name(&pdev->dev), hsp);
+		if (err < 0) {
+			dev_err(&pdev->dev,
+				"failed to request shared0 IRQ%u: %d\n",
+				hsp->shared_irq, err);
+			return err;
+		}
 	}
 
 	return 0;
+
+remove_doorbells:
+	if (hsp->doorbell_irq)
+		tegra_hsp_remove_doorbells(hsp);
+
+	return err;
 }
 
 static int tegra_hsp_remove(struct platform_device *pdev)
@@ -483,7 +652,8 @@ static int tegra_hsp_remove(struct platform_device *pdev)
 	struct tegra_hsp *hsp = platform_get_drvdata(pdev);
 
 	mbox_controller_unregister(&hsp->mbox);
-	tegra_hsp_remove_doorbells(hsp);
+	if (hsp->doorbell_irq)
+		tegra_hsp_remove_doorbells(hsp);
 
 	return 0;
 }
-- 
2.16.1
