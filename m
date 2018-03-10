Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932772AbeCJD61 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 22:58:27 -0500
Received: from gateway23.websitewelcome.com ([192.185.49.179]:12357 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932299AbeCJD60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 22:58:26 -0500
Date: Fri, 9 Mar 2018 21:36:12 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2] Input: stmpe-keypad - remove VLA usage
Message-ID: <20180310033612.GA8010@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1euVIr-003LvZ-6U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:39616
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wvla, remove VLA and replace it
with a fixed-length array instead.

Fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Update the code based on Dmitry Torokhov comments. Thanks Dmitry.

 drivers/input/keyboard/stmpe-keypad.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/stmpe-keypad.c b/drivers/input/keyboard/stmpe-keypad.c
index 8c6c0b9..d69e631 100644
--- a/drivers/input/keyboard/stmpe-keypad.c
+++ b/drivers/input/keyboard/stmpe-keypad.c
@@ -48,6 +48,14 @@
 #define STMPE_KEYPAD_KEYMAP_MAX_SIZE \
 	(STMPE_KEYPAD_MAX_ROWS * STMPE_KEYPAD_MAX_COLS)
 
+
+#define STMPE1601_NUM_DATA	5
+#define STMPE2401_NUM_DATA	3
+#define STMPE2403_NUM_DATA	5
+
+/* Make sure it covers all cases above */
+#define MAX_NUM_DATA		5
+
 /**
  * struct stmpe_keypad_variant - model-specific attributes
  * @auto_increment: whether the KPC_DATA_BYTE register address
@@ -74,7 +82,7 @@ struct stmpe_keypad_variant {
 static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
 	[STMPE1601] = {
 		.auto_increment		= true,
-		.num_data		= 5,
+		.num_data		= STMPE1601_NUM_DATA,
 		.num_normal_data	= 3,
 		.max_cols		= 8,
 		.max_rows		= 8,
@@ -84,7 +92,7 @@ static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
 	[STMPE2401] = {
 		.auto_increment		= false,
 		.set_pullup		= true,
-		.num_data		= 3,
+		.num_data		= STMPE2401_NUM_DATA,
 		.num_normal_data	= 2,
 		.max_cols		= 8,
 		.max_rows		= 12,
@@ -94,7 +102,7 @@ static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
 	[STMPE2403] = {
 		.auto_increment		= true,
 		.set_pullup		= true,
-		.num_data		= 5,
+		.num_data		= STMPE2403_NUM_DATA,
 		.num_normal_data	= 3,
 		.max_cols		= 8,
 		.max_rows		= 12,
@@ -156,7 +164,7 @@ static irqreturn_t stmpe_keypad_irq(int irq, void *dev)
 	struct stmpe_keypad *keypad = dev;
 	struct input_dev *input = keypad->input;
 	const struct stmpe_keypad_variant *variant = keypad->variant;
-	u8 fifo[variant->num_data];
+	u8 fifo[MAX_NUM_DATA];
 	int ret;
 	int i;
 
-- 
2.7.4
