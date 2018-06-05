Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeFEREH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751842AbeFEREE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:04:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        KT Liao <kt.liao@emc.com.tw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 07/37] Input: elan_i2c_smbus - fix corrupted stack
Date: Tue,  5 Jun 2018 19:01:12 +0200
Message-Id: <20180605170109.327128892@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170108.884872354@linuxfoundation.org>
References: <20180605170108.884872354@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -169,7 +169,7 @@ static int elan_smbus_get_sm_version(str
 				     u8 *ic_type, u8 *version)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  ETP_SMBUS_SM_VERSION_CMD, val);
@@ -186,7 +186,7 @@ static int elan_smbus_get_sm_version(str
 static int elan_smbus_get_product_id(struct i2c_client *client, u16 *id)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  ETP_SMBUS_UNIQUEID_CMD, val);
@@ -203,7 +203,7 @@ static int elan_smbus_get_checksum(struc
 				   bool iap, u16 *csum)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  iap ? ETP_SMBUS_FW_CHECKSUM_CMD :
@@ -223,7 +223,7 @@ static int elan_smbus_get_max(struct i2c
 			      unsigned int *max_x, unsigned int *max_y)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client, ETP_SMBUS_RANGE_CMD, val);
 	if (error) {
@@ -241,7 +241,7 @@ static int elan_smbus_get_resolution(str
 				     u8 *hw_res_x, u8 *hw_res_y)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  ETP_SMBUS_RESOLUTION_CMD, val);
@@ -261,7 +261,7 @@ static int elan_smbus_get_num_traces(str
 				     unsigned int *y_traces)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  ETP_SMBUS_XY_TRACENUM_CMD, val);
@@ -288,7 +288,7 @@ static int elan_smbus_iap_get_mode(struc
 {
 	int error;
 	u16 constant;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client, ETP_SMBUS_IAP_CTRL_CMD, val);
 	if (error < 0) {
@@ -339,7 +339,7 @@ static int elan_smbus_prepare_fw_update(
 	int len;
 	int error;
 	enum tp_mode mode;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 	u8 cmd[4] = {0x0F, 0x78, 0x00, 0x06};
 	u16 password;
 
@@ -413,7 +413,7 @@ static int elan_smbus_write_fw_block(str
 	struct device *dev = &client->dev;
 	int error;
 	u16 result;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	/*
 	 * Due to the limitation of smbus protocol limiting
