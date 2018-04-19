Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753714AbeDSUB0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 16:01:26 -0400
Received: from sauhun.de ([88.99.104.3]:48092 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753583AbeDSUBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 16:01:02 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/7] i2c: pnx: move header into the driver
Date: Thu, 19 Apr 2018 22:00:13 +0200
Message-Id: <20180419200015.15095-8-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419200015.15095-1-wsa@the-dreams.de>
References: <20180419200015.15095-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no platform_data users anymore. Move the structs into the
driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-pnx.c | 21 ++++++++++++++++++++-
 include/linux/i2c-pnx.h      | 38 --------------------------------------
 2 files changed, 20 insertions(+), 39 deletions(-)
 delete mode 100644 include/linux/i2c-pnx.h

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index a542041df0cd..6e0e546ef83f 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -18,7 +18,6 @@
 #include <linux/timer.h>
 #include <linux/completion.h>
 #include <linux/platform_device.h>
-#include <linux/i2c-pnx.h>
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -29,6 +28,26 @@
 #define I2C_PNX_SPEED_KHZ_DEFAULT	100
 #define I2C_PNX_REGION_SIZE		0x100
 
+struct i2c_pnx_mif {
+	int			ret;		/* Return value */
+	int			mode;		/* Interface mode */
+	struct completion	complete;	/* I/O completion */
+	struct timer_list	timer;		/* Timeout */
+	u8 *			buf;		/* Data buffer */
+	int			len;		/* Length of data buffer */
+	int			order;		/* RX Bytes to order via TX */
+};
+
+struct i2c_pnx_algo_data {
+	void __iomem		*ioaddr;
+	struct i2c_pnx_mif	mif;
+	int			last;
+	struct clk		*clk;
+	struct i2c_adapter	adapter;
+	int			irq;
+	u32			timeout;
+};
+
 enum {
 	mstatus_tdi = 0x00000001,
 	mstatus_afi = 0x00000002,
diff --git a/include/linux/i2c-pnx.h b/include/linux/i2c-pnx.h
deleted file mode 100644
index 5388326fbbff..000000000000
--- a/include/linux/i2c-pnx.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * Header file for I2C support on PNX010x/4008.
- *
- * Author: Dennis Kovalev <dkovalev@ru.mvista.com>
- *
- * 2004-2006 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#ifndef __I2C_PNX_H__
-#define __I2C_PNX_H__
-
-struct platform_device;
-struct clk;
-
-struct i2c_pnx_mif {
-	int			ret;		/* Return value */
-	int			mode;		/* Interface mode */
-	struct completion	complete;	/* I/O completion */
-	struct timer_list	timer;		/* Timeout */
-	u8 *			buf;		/* Data buffer */
-	int			len;		/* Length of data buffer */
-	int			order;		/* RX Bytes to order via TX */
-};
-
-struct i2c_pnx_algo_data {
-	void __iomem		*ioaddr;
-	struct i2c_pnx_mif	mif;
-	int			last;
-	struct clk		*clk;
-	struct i2c_adapter	adapter;
-	int			irq;
-	u32			timeout;
-};
-
-#endif /* __I2C_PNX_H__ */
-- 
2.11.0
