Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932657AbeCIWmL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 17:42:11 -0500
Received: from gateway30.websitewelcome.com ([192.185.144.21]:32089 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932327AbeCIWmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 17:42:10 -0500
Date: Fri, 9 Mar 2018 16:42:08 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] Input: stmpe-keypad - remove VLA usage
Message-ID: <20180309224208.GA7080@embeddedor.com>
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
X-Source-IP: 187.162.24.133
X-Source-L: No
X-Exim-ID: 1euQiH-003dHr-DY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-24-133.static.axtel.net (embeddedor) [187.162.24.133]:8929
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wvla, remove VLA and replace it
with a fixed-length array instead.

Fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/input/keyboard/stmpe-keypad.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/stmpe-keypad.c b/drivers/input/keyboard/stmpe-keypad.c
index 8c6c0b9..cfa1dbe 100644
--- a/drivers/input/keyboard/stmpe-keypad.c
+++ b/drivers/input/keyboard/stmpe-keypad.c
@@ -48,6 +48,8 @@
 #define STMPE_KEYPAD_KEYMAP_MAX_SIZE \
 	(STMPE_KEYPAD_MAX_ROWS * STMPE_KEYPAD_MAX_COLS)
 
+#define MAX_NUM_DATA			5
+
 /**
  * struct stmpe_keypad_variant - model-specific attributes
  * @auto_increment: whether the KPC_DATA_BYTE register address
@@ -74,7 +76,7 @@ struct stmpe_keypad_variant {
 static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
 	[STMPE1601] = {
 		.auto_increment		= true,
-		.num_data		= 5,
+		.num_data		= MAX_NUM_DATA,
 		.num_normal_data	= 3,
 		.max_cols		= 8,
 		.max_rows		= 8,
@@ -84,7 +86,7 @@ static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
 	[STMPE2401] = {
 		.auto_increment		= false,
 		.set_pullup		= true,
-		.num_data		= 3,
+		.num_data		= MAX_NUM_DATA - 2,
 		.num_normal_data	= 2,
 		.max_cols		= 8,
 		.max_rows		= 12,
@@ -94,7 +96,7 @@ static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
 	[STMPE2403] = {
 		.auto_increment		= true,
 		.set_pullup		= true,
-		.num_data		= 5,
+		.num_data		= MAX_NUM_DATA,
 		.num_normal_data	= 3,
 		.max_cols		= 8,
 		.max_rows		= 12,
@@ -156,7 +158,7 @@ static irqreturn_t stmpe_keypad_irq(int irq, void *dev)
 	struct stmpe_keypad *keypad = dev;
 	struct input_dev *input = keypad->input;
 	const struct stmpe_keypad_variant *variant = keypad->variant;
-	u8 fifo[variant->num_data];
+	u8 fifo[MAX_NUM_DATA];
 	int ret;
 	int i;
 
-- 
2.7.4
