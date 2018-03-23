Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeCWTrn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:47:43 -0400
Received: from avasout06.plus.net ([212.159.14.18]:35882 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeCWTrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:47:41 -0400
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fL8XI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10 a=beXlt2xKAAAA:8 a=cm27Pg_UAAAA:8
 a=Bbkv9igl7JydgJVAOtQA:9 a=rgO6oxR7olbCNuXR:21 a=EAOtJm5Lt8WzkJvp:21
 a=CjuIK1q_8ugA:10 a=gcY2M4Ci8LIz02MwfSIM:22 a=xmb-EsYY8bH0VWELuYED:22
Date: Fri, 23 Mar 2018 19:47:36 +0000
From: Nick Dyer <nick@shmanahar.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Nandor Han <nandor.han@ge.com>
Subject: Re: [PATCHv1] Input: atmel_mxt_ts - fix the firmware update
Message-ID: <20180323194736.7fhgb6qjkwbivsvx@hairyalien>
References: <20180322164330.24809-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322164330.24809-1-sebastian.reichel@collabora.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
X-CMAE-Envelope: MS4wfGfjHPQH267X+/WuZl+kEY0/SPCCWuulYxj/c/uGiZeN0SLAw41qyy+egHfvdQQN0ReTbtrmzZdf2M1HZcBte/TeKnIQBAgVUN1MW0q5V1SNY40J7D/t
 MbdOtPx7XXyNNbFPfN55fx2Zeasnd8RG48hp6CLkzm9uVgVVUeTdFVjy
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 05:43:30PM +0100, Sebastian Reichel wrote:
> The automatic update mechanism will trigger an update if the
> info block CRCs are different between maxtouch configuration
> file (maxtouch.cfg) and chip.
> 
> The driver compared the CRCs without retrieving the chip CRC,
> resulting always in a failure and firmware flashing action
> triggered. The patch will fix this issue by retrieving the
> chip info block CRC before the check.

Thanks for raising this, I agree it's definitely something we want to
fix.

However, I'm not convinced you're solving the problem in the best way.
You've attached it to the read_t9_resolution() code path, whereas the
info block is common between T9 and T100 and works in the same way.

Would you mind trying the below patch? I've dusted it off from some
work that I did back in 2012 and it should solve your issue.

It also has the benefit that by reading the information block and the
object table into a contiguous region of memory, we can verify the
checksum at probe time. This means we make sure that we are indeed
talking to a chip that supports object protocol correctly.

Signed-off-by: Nick Dyer <nick.dyer@shmanahar.org>
Acked-by: Benson Leung <bleung@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 193 +++++++++++++++++++------------
 1 file changed, 117 insertions(+), 76 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 7659bc48f1db..8a60d91d49a6 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -275,7 +275,8 @@ struct mxt_data {
 	char phys[64];		/* device physical location */
 	const struct mxt_platform_data *pdata;
 	struct mxt_object *object_table;
-	struct mxt_info info;
+	struct mxt_info *info;
+	void *raw_info_block;
 	unsigned int irq;
 	unsigned int max_x;
 	unsigned int max_y;
@@ -450,12 +451,13 @@ static int mxt_lookup_bootloader_address(struct mxt_data *data, bool retry)
 {
 	u8 appmode = data->client->addr;
 	u8 bootloader;
+	u8 family_id = data->info ? data->info->family_id : 0;
 
 	switch (appmode) {
 	case 0x4a:
 	case 0x4b:
 		/* Chips after 1664S use different scheme */
-		if (retry || data->info.family_id >= 0xa2) {
+		if (retry || family_id >= 0xa2) {
 			bootloader = appmode - 0x24;
 			break;
 		}
@@ -682,7 +684,7 @@ mxt_get_object(struct mxt_data *data, u8 type)
 	struct mxt_object *object;
 	int i;
 
-	for (i = 0; i < data->info.object_num; i++) {
+	for (i = 0; i < data->info->object_num; i++) {
 		object = data->object_table + i;
 		if (object->type == type)
 			return object;
@@ -1453,12 +1455,12 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
 		data_pos += offset;
 	}
 
-	if (cfg_info.family_id != data->info.family_id) {
+	if (cfg_info.family_id != data->info->family_id) {
 		dev_err(dev, "Family ID mismatch!\n");
 		return -EINVAL;
 	}
 
-	if (cfg_info.variant_id != data->info.variant_id) {
+	if (cfg_info.variant_id != data->info->variant_id) {
 		dev_err(dev, "Variant ID mismatch!\n");
 		return -EINVAL;
 	}
@@ -1503,7 +1505,7 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
 
 	/* Malloc memory to store configuration */
 	cfg_start_ofs = MXT_OBJECT_START +
-			data->info.object_num * sizeof(struct mxt_object) +
+			data->info->object_num * sizeof(struct mxt_object) +
 			MXT_INFO_CHECKSUM_SIZE;
 	config_mem_size = data->mem_size - cfg_start_ofs;
 	config_mem = kzalloc(config_mem_size, GFP_KERNEL);
@@ -1554,20 +1556,6 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
 	return ret;
 }
 
-static int mxt_get_info(struct mxt_data *data)
-{
-	struct i2c_client *client = data->client;
-	struct mxt_info *info = &data->info;
-	int error;
-
-	/* Read 7-byte info block starting at address 0 */
-	error = __mxt_read_reg(client, 0, sizeof(*info), info);
-	if (error)
-		return error;
-
-	return 0;
-}
-
 static void mxt_free_input_device(struct mxt_data *data)
 {
 	if (data->input_dev) {
@@ -1582,9 +1570,10 @@ static void mxt_free_object_table(struct mxt_data *data)
 	video_unregister_device(&data->dbg.vdev);
 	v4l2_device_unregister(&data->dbg.v4l2);
 #endif
-
-	kfree(data->object_table);
 	data->object_table = NULL;
+	data->info = NULL;
+	kfree(data->raw_info_block);
+	data->raw_info_block = NULL;
 	kfree(data->msg_buf);
 	data->msg_buf = NULL;
 	data->T5_address = 0;
@@ -1600,34 +1589,18 @@ static void mxt_free_object_table(struct mxt_data *data)
 	data->max_reportid = 0;
 }
 
-static int mxt_get_object_table(struct mxt_data *data)
+static int mxt_parse_object_table(struct mxt_data *data,
+				  struct mxt_object *object_table)
 {
 	struct i2c_client *client = data->client;
-	size_t table_size;
-	struct mxt_object *object_table;
-	int error;
 	int i;
 	u8 reportid;
 	u16 end_address;
 
-	table_size = data->info.object_num * sizeof(struct mxt_object);
-	object_table = kzalloc(table_size, GFP_KERNEL);
-	if (!object_table) {
-		dev_err(&data->client->dev, "Failed to allocate memory\n");
-		return -ENOMEM;
-	}
-
-	error = __mxt_read_reg(client, MXT_OBJECT_START, table_size,
-			object_table);
-	if (error) {
-		kfree(object_table);
-		return error;
-	}
-
 	/* Valid Report IDs start counting from 1 */
 	reportid = 1;
 	data->mem_size = 0;
-	for (i = 0; i < data->info.object_num; i++) {
+	for (i = 0; i < data->info->object_num; i++) {
 		struct mxt_object *object = object_table + i;
 		u8 min_id, max_id;
 
@@ -1651,8 +1624,8 @@ static int mxt_get_object_table(struct mxt_data *data)
 
 		switch (object->type) {
 		case MXT_GEN_MESSAGE_T5:
-			if (data->info.family_id == 0x80 &&
-			    data->info.version < 0x20) {
+			if (data->info->family_id == 0x80 &&
+			    data->info->version < 0x20) {
 				/*
 				 * On mXT224 firmware versions prior to V2.0
 				 * read and discard unused CRC byte otherwise
@@ -1707,24 +1680,108 @@ static int mxt_get_object_table(struct mxt_data *data)
 	/* If T44 exists, T5 position has to be directly after */
 	if (data->T44_address && (data->T5_address != data->T44_address + 1)) {
 		dev_err(&client->dev, "Invalid T44 position\n");
-		error = -EINVAL;
-		goto free_object_table;
+		return -EINVAL;
 	}
 
 	data->msg_buf = kcalloc(data->max_reportid,
 				data->T5_msg_size, GFP_KERNEL);
 	if (!data->msg_buf) {
 		dev_err(&client->dev, "Failed to allocate message buffer\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int mxt_read_info_block(struct mxt_data *data)
+{
+	struct i2c_client *client = data->client;
+	int error;
+	size_t size;
+	void *id_buf, *buf;
+	uint8_t num_objects;
+	u32 calculated_crc;
+	u8 *crc_ptr;
+
+	/* If info block already allocated, free it */
+	if (data->raw_info_block != NULL)
+		mxt_free_object_table(data);
+
+	/* Read 7-byte ID information block starting at address 0 */
+	size = sizeof(struct mxt_info);
+	id_buf = kzalloc(size, GFP_KERNEL);
+	if (!id_buf) {
+		dev_err(&client->dev, "Failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	error = __mxt_read_reg(client, 0, size, id_buf);
+	if (error) {
+		kfree(id_buf);
+		return error;
+	}
+
+	/* Resize buffer to give space for rest of info block */
+	num_objects = ((struct mxt_info *)id_buf)->object_num;
+	size += (num_objects * sizeof(struct mxt_object))
+		+ MXT_INFO_CHECKSUM_SIZE;
+
+	buf = krealloc(id_buf, size, GFP_KERNEL);
+	if (!buf) {
+		dev_err(&client->dev, "Failed to allocate memory\n");
 		error = -ENOMEM;
-		goto free_object_table;
+		goto err_free_mem;
+	}
+
+	/* Read rest of info block */
+	error = __mxt_read_reg(client, MXT_OBJECT_START,
+			       size - MXT_OBJECT_START,
+			       buf + MXT_OBJECT_START);
+	if (error)
+		goto err_free_mem;
+
+	/* Extract & calculate checksum */
+	crc_ptr = buf + size - MXT_INFO_CHECKSUM_SIZE;
+	data->info_crc = crc_ptr[0] | (crc_ptr[1] << 8) | (crc_ptr[2] << 16);
+
+	calculated_crc = mxt_calculate_crc(buf, 0,
+					   size - MXT_INFO_CHECKSUM_SIZE);
+
+	/*
+	 * CRC mismatch can be caused by data corruption due to I2C comms
+	 * issue or else device is not using Object Based Protocol (eg i2c-hid)
+	 */
+	if ((data->info_crc == 0) || (data->info_crc != calculated_crc)) {
+		dev_err(&client->dev,
+			"Info Block CRC error calculated=0x%06X read=0x%06X\n",
+			calculated_crc, data->info_crc);
+		error = -EIO;
+		goto err_free_mem;
 	}
 
-	data->object_table = object_table;
+	data->raw_info_block = buf;
+	data->info = (struct mxt_info *)buf;
+
+	dev_info(&client->dev,
+		 "Family: %u Variant: %u Firmware V%u.%u.%02X Objects: %u\n",
+		 data->info->family_id, data->info->variant_id,
+		 data->info->version >> 4, data->info->version & 0xf,
+		 data->info->build, data->info->object_num);
+
+	/* Parse object table information */
+	error = mxt_parse_object_table(data, buf + MXT_OBJECT_START);
+	if (error) {
+		dev_err(&client->dev, "Error %d parsing object table\n", error);
+		mxt_free_object_table(data);
+		return error;
+	}
+
+	data->object_table = (struct mxt_object *)(buf + MXT_OBJECT_START);
 
 	return 0;
 
-free_object_table:
-	mxt_free_object_table(data);
+err_free_mem:
+	kfree(buf);
 	return error;
 }
 
@@ -2039,7 +2096,7 @@ static int mxt_initialize(struct mxt_data *data)
 	int error;
 
 	while (1) {
-		error = mxt_get_info(data);
+		error = mxt_read_info_block(data);
 		if (!error)
 			break;
 
@@ -2070,13 +2127,6 @@ static int mxt_initialize(struct mxt_data *data)
 		msleep(MXT_FW_RESET_TIME);
 	}
 
-	/* Get object table information */
-	error = mxt_get_object_table(data);
-	if (error) {
-		dev_err(&client->dev, "Error %d reading object table\n", error);
-		return error;
-	}
-
 	error = mxt_acquire_irq(data);
 	if (error)
 		goto err_free_object_table;
@@ -2155,25 +2205,24 @@ static int mxt_init_t7_power_cfg(struct mxt_data *data)
 static u16 mxt_get_debug_value(struct mxt_data *data, unsigned int x,
 			       unsigned int y)
 {
-	struct mxt_info *info = &data->info;
 	struct mxt_dbg *dbg = &data->dbg;
 	unsigned int ofs, page;
 	unsigned int col = 0;
 	unsigned int col_width;
 
-	if (info->family_id == MXT_FAMILY_1386) {
-		col_width = info->matrix_ysize / MXT1386_COLUMNS;
+	if (data->info->family_id == MXT_FAMILY_1386) {
+		col_width = data->info->matrix_ysize / MXT1386_COLUMNS;
 		col = y / col_width;
 		y = y % col_width;
 	} else {
-		col_width = info->matrix_ysize;
+		col_width = data->info->matrix_ysize;
 	}
 
 	ofs = (y + (x * col_width)) * sizeof(u16);
 	page = ofs / MXT_DIAGNOSTIC_SIZE;
 	ofs %= MXT_DIAGNOSTIC_SIZE;
 
-	if (info->family_id == MXT_FAMILY_1386)
+	if (data->info->family_id == MXT_FAMILY_1386)
 		page += col * MXT1386_PAGES_PER_COLUMN;
 
 	return get_unaligned_le16(&dbg->t37_buf[page].data[ofs]);
@@ -2483,7 +2532,6 @@ static const struct video_device mxt_video_device = {
 
 static void mxt_debug_init(struct mxt_data *data)
 {
-	struct mxt_info *info = &data->info;
 	struct mxt_dbg *dbg = &data->dbg;
 	struct mxt_object *object;
 	int error;
@@ -2508,11 +2556,11 @@ static void mxt_debug_init(struct mxt_data *data)
 	/* Calculate size of data and allocate buffer */
 	dbg->t37_nodes = data->xsize * data->ysize;
 
-	if (info->family_id == MXT_FAMILY_1386)
+	if (data->info->family_id == MXT_FAMILY_1386)
 		dbg->t37_pages = MXT1386_COLUMNS * MXT1386_PAGES_PER_COLUMN;
 	else
 		dbg->t37_pages = DIV_ROUND_UP(data->xsize *
-					      info->matrix_ysize *
+					      data->info->matrix_ysize *
 					      sizeof(u16),
 					      sizeof(dbg->t37_buf->data));
 
@@ -2569,7 +2617,6 @@ static int mxt_configure_objects(struct mxt_data *data,
 				 const struct firmware *cfg)
 {
 	struct device *dev = &data->client->dev;
-	struct mxt_info *info = &data->info;
 	int error;
 
 	error = mxt_init_t7_power_cfg(data);
@@ -2594,11 +2641,6 @@ static int mxt_configure_objects(struct mxt_data *data,
 
 	mxt_debug_init(data);
 
-	dev_info(dev,
-		 "Family: %u Variant: %u Firmware V%u.%u.%02X Objects: %u\n",
-		 info->family_id, info->variant_id, info->version >> 4,
-		 info->version & 0xf, info->build, info->object_num);
-
 	return 0;
 }
 
@@ -2607,9 +2649,9 @@ static ssize_t mxt_fw_version_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct mxt_data *data = dev_get_drvdata(dev);
-	struct mxt_info *info = &data->info;
 	return scnprintf(buf, PAGE_SIZE, "%u.%u.%02X\n",
-			 info->version >> 4, info->version & 0xf, info->build);
+			 data->info->version >> 4, data->info->version & 0xf,
+			 data->info->build);
 }
 
 /* Hardware Version is returned as FamilyID.VariantID */
@@ -2617,9 +2659,8 @@ static ssize_t mxt_hw_version_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct mxt_data *data = dev_get_drvdata(dev);
-	struct mxt_info *info = &data->info;
 	return scnprintf(buf, PAGE_SIZE, "%u.%u\n",
-			 info->family_id, info->variant_id);
+			data->info->family_id, data->info->variant_id);
 }
 
 static ssize_t mxt_show_instance(char *buf, int count,
@@ -2656,7 +2697,7 @@ static ssize_t mxt_object_show(struct device *dev,
 		return -ENOMEM;
 
 	error = 0;
-	for (i = 0; i < data->info.object_num; i++) {
+	for (i = 0; i < data->info->object_num; i++) {
 		object = data->object_table + i;
 
 		if (!mxt_object_readable(object->type))
-- 
2.14.1
