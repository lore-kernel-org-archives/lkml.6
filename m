Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeC0MFW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:05:22 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:32847 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752315AbeC0MFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:05:18 -0400
From: michaelsh@mellanox.com
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Shych <michaelsh@mellanox.com>
Subject: [PATCH v1 - resent 3/5] i2c: busses: Fix adapter functionality support callback
Date: Tue, 27 Mar 2018 14:01:24 +0000
Message-Id: <1522159286-41779-4-git-send-email-michaelsh@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
References: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Shych <michaelsh@mellanox.com>

It fixes report about supported functionality.
Functionality can be different up to CPLD capability.

Fixes: 6bec23bff9149 (i2c: mlxcpld: add master driver for mellanox systems)
Signed-off-by: Michael Shych <michaelsh@mellanox.com>
---
 drivers/i2c/busses/i2c-mlxcpld.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mlxcpld.c b/drivers/i2c/busses/i2c-mlxcpld.c
index 4d8efe0..7341cee9 100644
--- a/drivers/i2c/busses/i2c-mlxcpld.c
+++ b/drivers/i2c/busses/i2c-mlxcpld.c
@@ -450,7 +450,14 @@ static int mlxcpld_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 
 static u32 mlxcpld_i2c_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;
+	struct mlxcpld_i2c_priv *priv = i2c_get_adapdata(adap);
+
+	if (priv->smbus_block)
+		return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
+			I2C_FUNC_SMBUS_I2C_BLOCK | I2C_FUNC_SMBUS_BLOCK_DATA;
+	else
+		return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
+			I2C_FUNC_SMBUS_I2C_BLOCK;
 }
 
 static const struct i2c_algorithm mlxcpld_i2c_algo = {
-- 
2.1.4
