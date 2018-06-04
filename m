Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeFDHS1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751913AbeFDHDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:03:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        KT Liao <kt.liao@emc.com.tw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.16 17/47] Input: elan_i2c_smbus - fix corrupted stack
Date: Mon,  4 Jun 2018 08:58:29 +0200
Message-Id: <20180604065550.204396440@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
References: <20180604065549.468488465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

commit 40f7090bb1b4ec327ea1e1402ff5783af5b35195 upstream.

New ICs (like the one on the Lenovo T480s) answer to
ETP_SMBUS_IAP_VERSION_CMD 4 bytes instead of 3. This corrupts the stack
as i2c_smbus_read_block_data() uses the values returned by the i2c
device to know how many data it need to return.

i2c_smbus_read_block_data() can read up to 32 bytes (I2C_SMBUS_BLOCK_MAX)
and there is no safeguard on how many bytes are provided in the return
value. Ensure we always have enough space for any future firmware.
Also 0-initialize the values to prevent any access to uninitialized memory.

Cc: <stable@vger.kernel.org> # v4.4.x, v4.9.x, v4.14.x, v4.15.x, v4.16.x
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Acked-by: KT Liao <kt.liao@emc.com.tw>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_smbus.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/input/mouse/elan_i2c_smbus.c
+++ b/drivers/input/mouse/elan_i2c_smbus.c
@@ -130,7 +130,7 @@ static int elan_smbus_get_baseline_data(
 					bool max_baseline, u8 *value)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  max_baseline ?
@@ -149,7 +149,7 @@ static int elan_smbus_get_version(struct
 				  bool iap, u8 *version)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  iap ? ETP_SMBUS_IAP_VERSION_CMD :
@@ -170,7 +170,7 @@ static int elan_smbus_get_sm_version(str
 				     u8 *clickpad)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  ETP_SMBUS_SM_VERSION_CMD, val);
@@ -188,7 +188,7 @@ static int elan_smbus_get_sm_version(str
 static int elan_smbus_get_product_id(struct i2c_client *client, u16 *id)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  ETP_SMBUS_UNIQUEID_CMD, val);
@@ -205,7 +205,7 @@ static int elan_smbus_get_checksum(struc
 				   bool iap, u16 *csum)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  iap ? ETP_SMBUS_FW_CHECKSUM_CMD :
@@ -226,7 +226,7 @@ static int elan_smbus_get_max(struct i2c
 {
 	int ret;
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	ret = i2c_smbus_read_block_data(client, ETP_SMBUS_RANGE_CMD, val);
 	if (ret != 3) {
@@ -246,7 +246,7 @@ static int elan_smbus_get_resolution(str
 {
 	int ret;
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	ret = i2c_smbus_read_block_data(client, ETP_SMBUS_RESOLUTION_CMD, val);
 	if (ret != 3) {
@@ -267,7 +267,7 @@ static int elan_smbus_get_num_traces(str
 {
 	int ret;
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	ret = i2c_smbus_read_block_data(client, ETP_SMBUS_XY_TRACENUM_CMD, val);
 	if (ret != 3) {
@@ -294,7 +294,7 @@ static int elan_smbus_iap_get_mode(struc
 {
 	int error;
 	u16 constant;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client, ETP_SMBUS_IAP_CTRL_CMD, val);
 	if (error < 0) {
@@ -345,7 +345,7 @@ static int elan_smbus_prepare_fw_update(
 	int len;
 	int error;
 	enum tp_mode mode;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 	u8 cmd[4] = {0x0F, 0x78, 0x00, 0x06};
 	u16 password;
 
@@ -419,7 +419,7 @@ static int elan_smbus_write_fw_block(str
 	struct device *dev = &client->dev;
 	int error;
 	u16 result;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	/*
 	 * Due to the limitation of smbus protocol limiting
