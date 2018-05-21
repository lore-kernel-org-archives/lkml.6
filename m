Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeEUNaw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:30:52 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36598 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbeEUN3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:29:13 -0400
X-Google-Smtp-Source: AB8JxZo9VzKH2Uf4gY2rk9QomL2Qm+HSZIOEEAQWbFQaNdVDlBUS0yoPLizlN+U3BHFN0XZIbw3rbw==
From: "=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?=" <vokac.m@gmail.com>
X-Google-Original-From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: netdev@vger.kernel.org, michal.vokac@ysoft.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        andrew@lunn.ch, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net
Subject: [PATCH net-next 4/7] net: dsa: qca8k: Force CPU port to its highest bandwidth
Date: Mon, 21 May 2018 15:28:10 +0200
Message-Id: <1526909293-56377-5-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526909293-56377-1-git-send-email-michal.vokac@ysoft.com>
References: <1526909293-56377-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default autonegotiation is enabled to configure MAC on all ports.
For the CPU port autonegotiation can not be used so we need to set
some sensible defaults manually.

This patch forces the default setting of the CPU port to 1000Mbps/full
duplex which is the chip maximum capability.

Also correct size of the bit field used to configure link speed.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 drivers/net/dsa/qca8k.c | 6 +++++-
 drivers/net/dsa/qca8k.h | 6 ++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/qca8k.c b/drivers/net/dsa/qca8k.c
index 0d224f3..14a108b38 100644
--- a/drivers/net/dsa/qca8k.c
+++ b/drivers/net/dsa/qca8k.c
@@ -537,6 +537,7 @@ qca8k_setup(struct dsa_switch *ds)
 {
 	struct qca8k_priv *priv = (struct qca8k_priv *)ds->priv;
 	int ret, i, phy_mode = -1;
+	u32 mask;
 
 	pr_debug("qca: setup\n");
 
@@ -564,7 +565,10 @@ qca8k_setup(struct dsa_switch *ds)
 	if (ret < 0)
 		return ret;
 
-	/* Enable CPU Port */
+	/* Enable CPU Port, force it to maximum bandwidth and full-duplex */
+	mask = QCA8K_PORT_STATUS_SPEED_1000 | QCA8K_PORT_STATUS_TXFLOW |
+	       QCA8K_PORT_STATUS_RXFLOW | QCA8K_PORT_STATUS_DUPLEX;
+	qca8k_write(priv, QCA8K_REG_PORT_STATUS(QCA8K_CPU_PORT), mask);
 	qca8k_reg_set(priv, QCA8K_REG_GLOBAL_FW_CTRL0,
 		      QCA8K_GLOBAL_FW_CTRL0_CPU_PORT_EN);
 	qca8k_port_set_status(priv, QCA8K_CPU_PORT, 1);
diff --git a/drivers/net/dsa/qca8k.h b/drivers/net/dsa/qca8k.h
index 1cf8a92..5bda165 100644
--- a/drivers/net/dsa/qca8k.h
+++ b/drivers/net/dsa/qca8k.h
@@ -51,8 +51,10 @@
 #define QCA8K_GOL_MAC_ADDR0				0x60
 #define QCA8K_GOL_MAC_ADDR1				0x64
 #define QCA8K_REG_PORT_STATUS(_i)			(0x07c + (_i) * 4)
-#define   QCA8K_PORT_STATUS_SPEED			GENMASK(2, 0)
-#define   QCA8K_PORT_STATUS_SPEED_S			0
+#define   QCA8K_PORT_STATUS_SPEED			GENMASK(1, 0)
+#define   QCA8K_PORT_STATUS_SPEED_10			0
+#define   QCA8K_PORT_STATUS_SPEED_100			0x1
+#define   QCA8K_PORT_STATUS_SPEED_1000			0x2
 #define   QCA8K_PORT_STATUS_TXMAC			BIT(2)
 #define   QCA8K_PORT_STATUS_RXMAC			BIT(3)
 #define   QCA8K_PORT_STATUS_TXFLOW			BIT(4)
-- 
2.1.4
