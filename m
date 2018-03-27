Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeC0MFR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:05:17 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:32811 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751241AbeC0MFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:05:13 -0400
From: michaelsh@mellanox.com
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Shych <michaelsh@mellanox.com>
Subject: [PATCH v1 - resent 1/5] i2c: busses: Add support for extended transaction length for i2c-mlxcpld
Date: Tue, 27 Mar 2018 14:01:22 +0000
Message-Id: <1522159286-41779-2-git-send-email-michaelsh@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
References: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Shych <michaelsh@mellanox.com>

It adds support for extended length of read and write transactions.
New CPLD logic allows double size of the read and write transactions
length. This feature is verified through capability register, which is
renamed from unclear LPF_REG to CPBLTY_REG. Two bits 5 and 6 of these
register are used for length capability detection, while only 01
combination indicates support of extended transaction length.
Others mean lack of such support.

Signed-off-by: Michael Shych <michaelsh@mellanox.com>
---
 drivers/i2c/busses/i2c-mlxcpld.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mlxcpld.c b/drivers/i2c/busses/i2c-mlxcpld.c
index 4c28fa2..6434f8c 100644
--- a/drivers/i2c/busses/i2c-mlxcpld.c
+++ b/drivers/i2c/busses/i2c-mlxcpld.c
@@ -45,13 +45,15 @@
 #define MLXCPLD_I2C_VALID_FLAG		(I2C_M_RECV_LEN | I2C_M_RD)
 #define MLXCPLD_I2C_BUS_NUM		1
 #define MLXCPLD_I2C_DATA_REG_SZ		36
+#define MLXCPLD_I2C_DATA_SZ_BIT		BIT(5)
+#define MLXCPLD_I2C_DATA_SZ_MASK	GENMASK(6, 5)
 #define MLXCPLD_I2C_MAX_ADDR_LEN	4
 #define MLXCPLD_I2C_RETR_NUM		2
 #define MLXCPLD_I2C_XFER_TO		500000 /* usec */
 #define MLXCPLD_I2C_POLL_TIME		2000   /* usec */
 
 /* LPC I2C registers */
-#define MLXCPLD_LPCI2C_LPF_REG		0x0
+#define MLXCPLD_LPCI2C_CPBLTY_REG	0x0
 #define MLXCPLD_LPCI2C_CTRL_REG		0x1
 #define MLXCPLD_LPCI2C_HALF_CYC_REG	0x4
 #define MLXCPLD_LPCI2C_I2C_HOLD_REG	0x5
@@ -230,7 +232,7 @@ static void mlxcpld_i2c_set_transf_data(struct mlxcpld_i2c_priv *priv,
 	 * All upper layers currently are never use transfer with more than
 	 * 2 messages. Actually, it's also not so relevant in Mellanox systems
 	 * because of HW limitation. Max size of transfer is not more than 32
-	 * bytes in the current x86 LPCI2C bridge.
+	 * or 68 bytes in the current x86 LPCI2C bridge.
 	 */
 	priv->xfer.cmd = msgs[num - 1].flags & I2C_M_RD;
 
@@ -440,6 +442,13 @@ static const struct i2c_adapter_quirks mlxcpld_i2c_quirks = {
 	.max_comb_1st_msg_len = 4,
 };
 
+static const struct i2c_adapter_quirks mlxcpld_i2c_quirks_ext = {
+	.flags = I2C_AQ_COMB_WRITE_THEN_READ,
+	.max_read_len = MLXCPLD_I2C_DATA_REG_SZ * 2 - MLXCPLD_I2C_MAX_ADDR_LEN,
+	.max_write_len = MLXCPLD_I2C_DATA_REG_SZ * 2,
+	.max_comb_1st_msg_len = 4,
+};
+
 static struct i2c_adapter mlxcpld_i2c_adapter = {
 	.owner          = THIS_MODULE,
 	.name           = "i2c-mlxcpld",
@@ -454,6 +463,7 @@ static int mlxcpld_i2c_probe(struct platform_device *pdev)
 {
 	struct mlxcpld_i2c_priv *priv;
 	int err;
+	u8 val;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -466,6 +476,11 @@ static int mlxcpld_i2c_probe(struct platform_device *pdev)
 
 	/* Register with i2c layer */
 	mlxcpld_i2c_adapter.timeout = usecs_to_jiffies(MLXCPLD_I2C_XFER_TO);
+	/* Read capability register */
+	mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_CPBLTY_REG, &val, 1);
+	/* Check support for extended transaction length */
+	if ((val & MLXCPLD_I2C_DATA_SZ_MASK) == MLXCPLD_I2C_DATA_SZ_BIT)
+		mlxcpld_i2c_adapter.quirks = &mlxcpld_i2c_quirks_ext;
 	priv->adap = mlxcpld_i2c_adapter;
 	priv->adap.dev.parent = &pdev->dev;
 	priv->base_addr = MLXPLAT_CPLD_LPC_I2C_BASE_ADDR;
-- 
2.1.4
