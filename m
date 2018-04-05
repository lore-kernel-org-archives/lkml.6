Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeDEN1y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:27:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751298AbeDENZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:25:50 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/8] input: elan_i2c_smbus - fix corrupted stack
Date: Thu,  5 Apr 2018 15:25:31 +0200
Message-Id: <20180405132537.3218-3-benjamin.tissoires@redhat.com>
In-Reply-To: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
References: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New ICs (like the one on the Lenovo T480s) answer to
ETP_SMBUS_IAP_VERSION_CMD 4 bytes instead of 3. This corrupts the stack
as i2c_smbus_read_block_data() uses the values returned by the i2c
device to know how many data it need to return.

i2c_smbus_read_block_data() can read up to 32 bytes (I2C_SMBUS_BLOCK_MAX)
and there is no safeguard on how many bytes are provided in the return
value. Ensure we always have enough space for any future firmware.
Also 0-initialize the values to prevent any access to uninitialized memory.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elan_i2c_smbus.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse/elan_i2c_smbus.c
index 29f99529b187..cfcb32559925 100644
--- a/drivers/input/mouse/elan_i2c_smbus.c
+++ b/drivers/input/mouse/elan_i2c_smbus.c
@@ -130,7 +130,7 @@ static int elan_smbus_get_baseline_data(struct i2c_client *client,
 					bool max_baseline, u8 *value)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  max_baseline ?
@@ -149,7 +149,7 @@ static int elan_smbus_get_version(struct i2c_client *client,
 				  bool iap, u8 *version)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  iap ? ETP_SMBUS_IAP_VERSION_CMD :
@@ -170,7 +170,7 @@ static int elan_smbus_get_sm_version(struct i2c_client *client,
 				     u8 *clickpad)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  ETP_SMBUS_SM_VERSION_CMD, val);
@@ -188,7 +188,7 @@ static int elan_smbus_get_sm_version(struct i2c_client *client,
 static int elan_smbus_get_product_id(struct i2c_client *client, u16 *id)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  ETP_SMBUS_UNIQUEID_CMD, val);
@@ -205,7 +205,7 @@ static int elan_smbus_get_checksum(struct i2c_client *client,
 				   bool iap, u16 *csum)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  iap ? ETP_SMBUS_FW_CHECKSUM_CMD :
@@ -226,7 +226,7 @@ static int elan_smbus_get_max(struct i2c_client *client,
 {
 	int ret;
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	ret = i2c_smbus_read_block_data(client, ETP_SMBUS_RANGE_CMD, val);
 	if (ret != 3) {
@@ -246,7 +246,7 @@ static int elan_smbus_get_resolution(struct i2c_client *client,
 {
 	int ret;
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	ret = i2c_smbus_read_block_data(client, ETP_SMBUS_RESOLUTION_CMD, val);
 	if (ret != 3) {
@@ -267,7 +267,7 @@ static int elan_smbus_get_num_traces(struct i2c_client *client,
 {
 	int ret;
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	ret = i2c_smbus_read_block_data(client, ETP_SMBUS_XY_TRACENUM_CMD, val);
 	if (ret != 3) {
@@ -294,7 +294,7 @@ static int elan_smbus_iap_get_mode(struct i2c_client *client,
 {
 	int error;
 	u16 constant;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client, ETP_SMBUS_IAP_CTRL_CMD, val);
 	if (error < 0) {
@@ -345,7 +345,7 @@ static int elan_smbus_prepare_fw_update(struct i2c_client *client)
 	int len;
 	int error;
 	enum tp_mode mode;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 	u8 cmd[4] = {0x0F, 0x78, 0x00, 0x06};
 	u16 password;
 
@@ -419,7 +419,7 @@ static int elan_smbus_write_fw_block(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	int error;
 	u16 result;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	/*
 	 * Due to the limitation of smbus protocol limiting
-- 
2.14.3
