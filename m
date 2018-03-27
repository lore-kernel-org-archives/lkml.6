Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AG47ELuBWmCtjBdxGqN7kxmGEvfNLHWjywynQlnX4FsDQjMOa3lb2X4O4c6vMF9yE1tkh3stKABN
ARC-Seal: i=1; a=rsa-sha256; t=1522137956; cv=none;
        d=google.com; s=arc-20160816;
        b=WsO2Wu8flHvd8Qfp19P0b4jW2qtZ1X4Tydotm8BfgEh1rO/FIR8p6M5jVBaTz/yKU9
         4ILAQYo2+LyRqKEzTFgavFRq3nw388dOa6zOWtD7Di/25dMZmyyk+tdqbDWTRwaV3ZNW
         7Fm+krKPweKaIQerdPydZ2a0fNR6sqFNSJUJG2tFo7xAdrqWYzv6G5isJnKaoSZYrDQV
         5ohmn/S4B4TAcGNCn0CaCxP5xLAk8YXFTqPFEjTXGpDpWyPXp1+Ca2rsYikUsBFbKyvX
         xCU9pKACHETCuigrH4oNl4boxFJ2iHQ7uzuYPJ24QL8TIqXO1Xq/G0nC2BmwAllezWp9
         yagA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=nyGU9Ha9SuTZiUZxK4o/1aMD83A3qg9gFzIz8/bMPns=;
        b=NJZhW6H78G8GEpH/4FiTx0A5e2as0rnR7UhxLysT/JLj/mblMUJv3uKiRCcfsT7X5w
         4DJs/kXx4Mnyzt4vHnNvNt+0S37sy3p4BmJi2FtDFwRqUQo5bA9ex2JJFtmlrKXkBww/
         QfEYEHRRFvOL93LfAR+wMswfl7WeK/4bJjj84Xji5fjGErHgI72HGG+EkJUuAeNSR8TO
         fJzCf9EJgyfLZpUUxRoMxp/reCet0xZ2/imhtXOc8SzyxUcXwDX22uLjG+gtQy12yEeD
         WBH9SeMaFa1x3VQQY2C9Qls4UqPgMxCC/5U3f5Szm2Co1Z1lRImz9emiJg8Th092JrMC
         gZUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v1 3/7] platform/mellanox: mlxreg-hotplug: add extra cycle for hotplug work queue
Date: Tue, 27 Mar 2018 10:02:03 +0000
Message-Id: <1522144927-56512-4-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
References: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596077329932393819?=
X-GMAIL-MSGID: =?utf-8?q?1596077329932393819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It adds missed logic for signal acknowledge, by adding an extra run for
work queue in case a signal is received, but no specific signal assertion
is detected. Such case theoretically can happen for example in case
several units are removed or inserted at the same time. In this situation
acknowledge for some signal can be missed at signal top aggreagation
status level. The extra run will allow to handler to acknowledge the
missed signal.

The interrupt handling flow performs the next steps:
(1)
Enter mlxreg_hotplug_work_handler due to signal assertion.
Aggregation status register is changed for example from 0xff to 0xfd
(event signal group related to bit 1).
(2)
Mask aggregation interrupts, read aggregation status register and save it
(0xfd) in aggr_cache, then traverse down to handle signal from groups
related to the changed bit.
(3)
Read and mask group related signal.
Acknowledge and unmask group related signal (acknowledge should clear
aggregation status register from 0xfd back to 0xff).
(4)
Re-schedule work queue for the immediate execution.
(5)
Enter mlxreg_hotplug_work_handler due to re-scheduling.
Aggregation status is changed from previous 0xfd to 0xff.
Go over steps (2) - (5) and in case no new signal assertion
is detected - unmask aggregation interrupts.

The possible race could happen in case new signal from the same group is
asserted after step (3) and prior step (5). In such case aggregation
status will change back from 0xff to 0xfd and the value read from the
aggregation status register will be the same as a value saved in
aggr_cache. As a result the handler will not traverse down and signal
will stay unhandled.
The fix will enforce handler to traverse down in case the signal is
received, but signal assertion is not detected.

Fixes: 1f976f6978bf ("platform/x86: Move Mellanox platform hotplug driver to platform/mellanox")
Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/mellanox/mlxreg-hotplug.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index b56953a..ced81b7 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -55,6 +55,7 @@
 #define MLXREG_HOTPLUG_RST_CNTR		3
 
 #define MLXREG_HOTPLUG_ATTRS_MAX	24
+#define MLXREG_HOTPLUG_NOT_ASSERT	3
 
 /**
  * struct mlxreg_hotplug_priv_data - platform private data:
@@ -74,6 +75,7 @@
  * @mask: top aggregation interrupt common mask;
  * @aggr_cache: last value of aggregation register status;
  * @after_probe: flag indication probing completion;
+ * @not_asserted: number of entries in workqueue with no signal assertion;
  */
 struct mlxreg_hotplug_priv_data {
 	int irq;
@@ -93,6 +95,7 @@ struct mlxreg_hotplug_priv_data {
 	u32 mask;
 	u32 aggr_cache;
 	bool after_probe;
+	u8 not_asserted;
 };
 
 static int mlxreg_hotplug_device_create(struct mlxreg_hotplug_priv_data *priv,
@@ -410,6 +413,18 @@ static void mlxreg_hotplug_work_handler(struct work_struct *work)
 	aggr_asserted = priv->aggr_cache ^ regval;
 	priv->aggr_cache = regval;
 
+	/*
+	 * Handler is invoked, but no assertion is detected at top aggregation
+	 * status level. Set aggr_asserted to mask value to allow handler extra
+	 * run over all relevant signals to recover any missed signal.
+	 */
+	if (priv->not_asserted == MLXREG_HOTPLUG_NOT_ASSERT) {
+		priv->not_asserted = 0;
+		aggr_asserted = pdata->mask;
+	}
+	if (!aggr_asserted)
+		goto unmask_event;
+
 	/* Handle topology and health configuration changes. */
 	for (i = 0; i < pdata->counter; i++, item++) {
 		if (aggr_asserted & item->aggr_mask) {
@@ -441,6 +456,8 @@ static void mlxreg_hotplug_work_handler(struct work_struct *work)
 		return;
 	}
 
+unmask_event:
+	priv->not_asserted++;
 	/* Unmask aggregation event (no need acknowledge). */
 	ret = regmap_write(priv->regmap, pdata->cell +
 			   MLXREG_HOTPLUG_AGGR_MASK_OFF, pdata->mask);
-- 
2.1.4
