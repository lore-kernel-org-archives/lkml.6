Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbeC0MFO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:05:14 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:32819 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752159AbeC0MFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:05:12 -0400
From: michaelsh@mellanox.com
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Shych <michaelsh@mellanox.com>
Subject: [PATCH v1 - resent 2/5] i2c: busses: Add support for smbus block read transaction
Date: Tue, 27 Mar 2018 14:01:23 +0000
Message-Id: <1522159286-41779-3-git-send-email-michaelsh@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
References: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Shych <michaelsh@mellanox.com>

It adds support for smbus block read transaction. CPLD smbus block read bit
of capability register is verified during driver initialization, and driver
data is updated if such capability is available. In case an upper layer
requests a read transaction of length one and expects that length will be
the first received byte, driver will notify CPLD about SMBus block read
transaction flavor, so CPLD will know to execute such kind of transaction.

Signed-off-by: Michael Shych <michaelsh@mellanox.com>
---
 drivers/i2c/busses/i2c-mlxcpld.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mlxcpld.c b/drivers/i2c/busses/i2c-mlxcpld.c
index 6434f8c..4d8efe0 100644
--- a/drivers/i2c/busses/i2c-mlxcpld.c
+++ b/drivers/i2c/busses/i2c-mlxcpld.c
@@ -47,6 +47,7 @@
 #define MLXCPLD_I2C_DATA_REG_SZ		36
 #define MLXCPLD_I2C_DATA_SZ_BIT		BIT(5)
 #define MLXCPLD_I2C_DATA_SZ_MASK	GENMASK(6, 5)
+#define MLXCPLD_I2C_SMBUS_BLK_BIT	BIT(7)
 #define MLXCPLD_I2C_MAX_ADDR_LEN	4
 #define MLXCPLD_I2C_RETR_NUM		2
 #define MLXCPLD_I2C_XFER_TO		500000 /* usec */
@@ -85,6 +86,7 @@ struct mlxcpld_i2c_priv {
 	struct mutex lock;
 	struct  mlxcpld_i2c_curr_xfer xfer;
 	struct device *dev;
+	bool smbus_block;
 };
 
 static void mlxcpld_i2c_lpc_write_buf(u8 *data, u8 len, u32 addr)
@@ -297,7 +299,7 @@ static int mlxcpld_i2c_wait_for_free(struct mlxcpld_i2c_priv *priv)
 static int mlxcpld_i2c_wait_for_tc(struct mlxcpld_i2c_priv *priv)
 {
 	int status, i, timeout = 0;
-	u8 datalen;
+	u8 datalen, val;
 
 	do {
 		usleep_range(MLXCPLD_I2C_POLL_TIME / 2, MLXCPLD_I2C_POLL_TIME);
@@ -326,9 +328,22 @@ static int mlxcpld_i2c_wait_for_tc(struct mlxcpld_i2c_priv *priv)
 		 * Actual read data len will be always the same as
 		 * requested len. 0xff (line pull-up) will be returned
 		 * if slave has no data to return. Thus don't read
-		 * MLXCPLD_LPCI2C_NUM_DAT_REG reg from CPLD.
+		 * MLXCPLD_LPCI2C_NUM_DAT_REG reg from CPLD.  Only in case of
+		 * SMBus block read transaction data len can be different,
+		 * check this case.
 		 */
-		datalen = priv->xfer.data_len;
+		mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_NUM_ADDR_REG, &val,
+				      1);
+		if (priv->smbus_block && (val & MLXCPLD_I2C_SMBUS_BLK_BIT)) {
+			mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_NUM_DAT_REG,
+					      &datalen, 1);
+			if (unlikely(datalen > (I2C_SMBUS_BLOCK_MAX + 1))) {
+				dev_err(priv->dev, "Incorrect smbus block read message len\n");
+				return -E2BIG;
+			}
+		} else {
+			datalen = priv->xfer.data_len;
+		}
 
 		mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_DATA_REG,
 				      priv->xfer.msg[i].buf, datalen);
@@ -346,12 +361,20 @@ static int mlxcpld_i2c_wait_for_tc(struct mlxcpld_i2c_priv *priv)
 static void mlxcpld_i2c_xfer_msg(struct mlxcpld_i2c_priv *priv)
 {
 	int i, len = 0;
-	u8 cmd;
+	u8 cmd, val;
 
 	mlxcpld_i2c_write_comm(priv, MLXCPLD_LPCI2C_NUM_DAT_REG,
 			       &priv->xfer.data_len, 1);
-	mlxcpld_i2c_write_comm(priv, MLXCPLD_LPCI2C_NUM_ADDR_REG,
-			       &priv->xfer.addr_width, 1);
+
+	val = priv->xfer.addr_width;
+	/* Notify HW about SMBus block read transaction */
+	if (priv->smbus_block && priv->xfer.msg_num >= 2 &&
+	    priv->xfer.msg[1].len == 1 &&
+	    (priv->xfer.msg[1].flags & I2C_M_RECV_LEN) &&
+	    (priv->xfer.msg[1].flags & I2C_M_RD))
+		val |= MLXCPLD_I2C_SMBUS_BLK_BIT;
+
+	mlxcpld_i2c_write_comm(priv, MLXCPLD_LPCI2C_NUM_ADDR_REG, &val, 1);
 
 	for (i = 0; i < priv->xfer.msg_num; i++) {
 		if ((priv->xfer.msg[i].flags & I2C_M_RD) != I2C_M_RD) {
@@ -481,6 +504,9 @@ static int mlxcpld_i2c_probe(struct platform_device *pdev)
 	/* Check support for extended transaction length */
 	if ((val & MLXCPLD_I2C_DATA_SZ_MASK) == MLXCPLD_I2C_DATA_SZ_BIT)
 		mlxcpld_i2c_adapter.quirks = &mlxcpld_i2c_quirks_ext;
+	/* Check support for smbus block transaction */
+	if (val & MLXCPLD_I2C_SMBUS_BLK_BIT)
+		priv->smbus_block = true;
 	priv->adap = mlxcpld_i2c_adapter;
 	priv->adap.dev.parent = &pdev->dev;
 	priv->base_addr = MLXPLAT_CPLD_LPC_I2C_BASE_ADDR;
-- 
2.1.4
