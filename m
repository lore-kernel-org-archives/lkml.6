Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754170AbeEWGWg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:22:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40478 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754031AbeEWGVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:21:19 -0400
X-Google-Smtp-Source: AB8JxZqsX/gh6816Z/i7x7khQO0lUtzAbRzgTJ/SSnGHW79tZh/weRUMSOdK9BeL61gkhvxnT4TG2Q==
From: "=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?=" <vokac.m@gmail.com>
X-Google-Original-From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        andrew@lunn.ch, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net, michal.vokac@ysoft.com
Subject: [PATCH net-next v3 5/7] net: dsa: qca8k: Allow overwriting CPU port setting
Date: Wed, 23 May 2018 08:20:22 +0200
Message-Id: <1527056424-14528-6-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527056424-14528-1-git-send-email-michal.vokac@ysoft.com>
References: <1527056424-14528-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement adjust_link function that allows to overwrite default CPU port
setting using fixed-link device tree subnode.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:
 - none

Changes in v2:
 - Add "Reviewed-by" tags from Andrew and Florian.

 drivers/net/dsa/qca8k.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/qca8k.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/dsa/qca8k.c b/drivers/net/dsa/qca8k.c
index 14a108b38..7eba987 100644
--- a/drivers/net/dsa/qca8k.c
+++ b/drivers/net/dsa/qca8k.c
@@ -636,6 +636,47 @@ qca8k_setup(struct dsa_switch *ds)
 	return 0;
 }
 
+static void
+qca8k_adjust_link(struct dsa_switch *ds, int port, struct phy_device *phy)
+{
+	struct qca8k_priv *priv = ds->priv;
+	u32 reg;
+
+	/* Force fixed-link setting for CPU port, skip others. */
+	if (!phy_is_pseudo_fixed_link(phy))
+		return;
+
+	/* Set port speed */
+	switch (phy->speed) {
+	case 10:
+		reg = QCA8K_PORT_STATUS_SPEED_10;
+		break;
+	case 100:
+		reg = QCA8K_PORT_STATUS_SPEED_100;
+		break;
+	case 1000:
+		reg = QCA8K_PORT_STATUS_SPEED_1000;
+		break;
+	default:
+		dev_dbg(priv->dev, "port%d link speed %dMbps not supported.\n",
+			port, phy->speed);
+		return;
+	}
+
+	/* Set duplex mode */
+	if (phy->duplex == DUPLEX_FULL)
+		reg |= QCA8K_PORT_STATUS_DUPLEX;
+
+	/* Force flow control */
+	if (dsa_is_cpu_port(ds, port))
+		reg |= QCA8K_PORT_STATUS_RXFLOW | QCA8K_PORT_STATUS_TXFLOW;
+
+	/* Force link down before changing MAC options */
+	qca8k_port_set_status(priv, port, 0);
+	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port), reg);
+	qca8k_port_set_status(priv, port, 1);
+}
+
 static int
 qca8k_phy_read(struct dsa_switch *ds, int phy, int regnum)
 {
@@ -909,6 +950,7 @@ qca8k_get_tag_protocol(struct dsa_switch *ds, int port)
 static const struct dsa_switch_ops qca8k_switch_ops = {
 	.get_tag_protocol	= qca8k_get_tag_protocol,
 	.setup			= qca8k_setup,
+	.adjust_link            = qca8k_adjust_link,
 	.get_strings		= qca8k_get_strings,
 	.phy_read		= qca8k_phy_read,
 	.phy_write		= qca8k_phy_write,
@@ -942,6 +984,7 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
 		return -ENOMEM;
 
 	priv->bus = mdiodev->bus;
+	priv->dev = &mdiodev->dev;
 
 	/* read the switches ID register */
 	id = qca8k_read(priv, QCA8K_REG_MASK_CTRL);
diff --git a/drivers/net/dsa/qca8k.h b/drivers/net/dsa/qca8k.h
index 5bda165..613fe5c5 100644
--- a/drivers/net/dsa/qca8k.h
+++ b/drivers/net/dsa/qca8k.h
@@ -167,6 +167,7 @@ struct qca8k_priv {
 	struct ar8xxx_port_status port_sts[QCA8K_NUM_PORTS];
 	struct dsa_switch *ds;
 	struct mutex reg_mutex;
+	struct device *dev;
 };
 
 struct qca8k_mib_desc {
-- 
2.7.4
