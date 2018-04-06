Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeDFXXT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 19:23:19 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45297 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752398AbeDFXXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 19:23:17 -0400
X-Google-Smtp-Source: AIpwx49gZE9CTP5wgyT68bgc5rjT2udtWw+U2Z3fhE0QWVgEP8trZKqZJhWBJzezFl/7Z6XdqzCOzw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180406151356.7818-2-ilina@codeaurora.org>
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
References: <20180406151356.7818-1-ilina@codeaurora.org>
 <20180406151356.7818-2-ilina@codeaurora.org>
Message-ID: <152305699547.94378.15462587304123828477@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 [RESEND] 1/2] drivers: qcom: add command DB driver
Date: Fri, 06 Apr 2018 16:23:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w36NNPkT008750

Quoting Lina Iyer (2018-04-06 08:13:55)
> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> 
> Command DB is a simple database in the shared memory of QCOM SoCs, that
> provides information regarding shared resources. Some shared resources
> in the SoC have properties that are probed dynamically at boot by the
> remote processor. The information pertaining to the SoC and the platform
> are made available in the shared memory. Drivers can query this
> information using predefined strings.
> 
> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

I have this patch on top to fix the endian stuff. Care to test it out
and see if it still works?

From: Stephen Boyd <swboyd@chromium.org>
Subject: soc: qcom: cmd-db: Make endian-agnostic
    
This driver deals with memory that is stored in little-endian format.
Update the structures with the proper little-endian types and then
do the proper conversions when reading the fields. Note that we compare
the ids with a memcmp() because we already pad out the string 'id' field
to exactly 8 bytes with the strncpy() onto the stack.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index b5172049f608..a56dc9edab82 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -13,18 +13,10 @@
 
 #define NUM_PRIORITY		2
 #define MAX_SLV_ID		8
-#define CMD_DB_MAGIC		0x0C0330DBUL
+static const char CMD_DB_MAGIC[] = { 0xdb, 0x33, 0x03, 0x0c };
 #define SLAVE_ID_MASK		0x7
 #define SLAVE_ID_SHIFT		16
 
-#define ENTRY_HEADER(hdr)	((void *)cmd_db_header +	\
-				sizeof(*cmd_db_header) +	\
-				hdr->header_offset)
-
-#define RSC_OFFSET(hdr, ent)	((void *)cmd_db_header +	\
-				sizeof(*cmd_db_header) +	\
-				hdr.data_offset + ent.offset)
-
 /**
  * struct entry_header: header for each entry in cmddb
  *
@@ -35,11 +27,11 @@
  * @offset: offset from :@data_offset, start of the data
  */
 struct entry_header {
-	u64 id;
-	u32 priority[NUM_PRIORITY];
-	u32 addr;
-	u16 len;
-	u16 offset;
+	u8 id[8];
+	__le32 priority[NUM_PRIORITY];
+	__le32 addr;
+	__le16 len;
+	__le16 offset;
 };
 
 /**
@@ -53,12 +45,12 @@ struct entry_header {
  * @reserved: reserved for future use.
  */
 struct rsc_hdr {
-	u16 slv_id;
-	u16 header_offset;
-	u16 data_offset;
-	u16 cnt;
-	u16 version;
-	u16 reserved[3];
+	__le16 slv_id;
+	__le16 header_offset;
+	__le16 data_offset;
+	__le16 cnt;
+	__le16 version;
+	__le16 reserved[3];
 };
 
 /**
@@ -72,11 +64,11 @@ struct rsc_hdr {
  * @data: driver specific data
  */
 struct cmd_db_header {
-	u32 version;
-	u32 magic_num;
+	__le32 version;
+	__le32 magic_num;
 	struct rsc_hdr header[MAX_SLV_ID];
-	u32 checksum;
-	u32 reserved;
+	__le32 checksum;
+	__le32 reserved;
 	u8 data[];
 };
 
@@ -101,6 +93,22 @@ struct cmd_db_header {
 
 static struct cmd_db_header *cmd_db_header;
 
+static inline void *rsc_to_entry_header(struct rsc_hdr *hdr)
+{
+	u16 offset = le16_to_cpu(hdr->header_offset);
+
+	return cmd_db_header->data + offset;
+}
+
+static inline void *
+rsc_offset(struct rsc_hdr *hdr, struct entry_header *ent)
+{
+	u16 offset = le16_to_cpu(hdr->header_offset);
+	u16 loffset = le16_to_cpu(ent->offset);
+
+	return cmd_db_header->data + offset +  loffset;
+}
+
 /**
  * cmd_db_ready - Indicates if command DB is available
  *
@@ -110,29 +118,20 @@ int cmd_db_ready(void)
 {
 	if (cmd_db_header == NULL)
 		return -EPROBE_DEFER;
-	else if (cmd_db_header->magic_num != CMD_DB_MAGIC)
+	else if (memcmp(&cmd_db_header->magic_num, CMD_DB_MAGIC, sizeof(CMD_DB_MAGIC)))
 		return -EINVAL;
 
 	return 0;
 }
 EXPORT_SYMBOL(cmd_db_ready);
 
-static u64 cmd_db_get_u64_id(const char *id)
-{
-	u64 rsc_id = 0;
-	u8 *ch = (u8 *)&rsc_id;
-
-	strncpy(ch, id, min(strlen(id), sizeof(rsc_id)));
-
-	return rsc_id;
-}
-
-static int cmd_db_get_header(u64 query, struct entry_header *eh,
+static int cmd_db_get_header(const char *id, struct entry_header *eh,
 			     struct rsc_hdr *rh)
 {
 	struct rsc_hdr *rsc_hdr;
 	struct entry_header *ent;
 	int ret, i, j;
+	char query[8];
 
 	ret = cmd_db_ready();
 	if (ret)
@@ -141,18 +140,21 @@ static int cmd_db_get_header(u64 query, struct entry_header *eh,
 	if (!eh || !rh)
 		return -EINVAL;
 
+	/* Pad out query string to same length as in DB */
+	strncpy(query, id, sizeof(query));
+
 	for (i = 0; i < MAX_SLV_ID; i++) {
 		rsc_hdr = &cmd_db_header->header[i];
 		if (!rsc_hdr->slv_id)
 			break;
 
-		ent = ENTRY_HEADER(rsc_hdr);
-		for (j = 0; j < rsc_hdr->cnt; j++, ent++) {
-			if (ent->id == query)
+		ent = rsc_to_entry_header(rsc_hdr);
+		for (j = 0; j < le16_to_cpu(rsc_hdr->cnt); j++, ent++) {
+			if (memcmp(ent->id, query, sizeof(ent->id)))
 				break;
 		}
 
-		if (j < rsc_hdr->cnt) {
+		if (j < le16_to_cpu(rsc_hdr->cnt)) {
 			memcpy(eh, ent, sizeof(*ent));
 			memcpy(rh, rsc_hdr, sizeof(*rh));
 			return 0;
@@ -166,9 +168,7 @@ static int cmd_db_get_header_by_rsc_id(const char *id,
 				       struct entry_header *ent_hdr,
 				       struct rsc_hdr *rsc_hdr)
 {
-	u64 rsc_id = cmd_db_get_u64_id(id);
-
-	return cmd_db_get_header(rsc_id, ent_hdr, rsc_hdr);
+	return cmd_db_get_header(id, ent_hdr, rsc_hdr);
 }
 
 /**
@@ -189,7 +189,7 @@ u32 cmd_db_read_addr(const char *id)
 
 	ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);
 
-	return ret < 0 ? 0 : ent.addr;
+	return ret < 0 ? 0 : le32_to_cpu(ent.addr);
 }
 EXPORT_SYMBOL(cmd_db_read_addr);
 
@@ -207,6 +207,7 @@ int cmd_db_read_aux_data(const char *id, u8 *data, size_t len)
 	int ret;
 	struct entry_header ent;
 	struct rsc_hdr rsc_hdr;
+	u16 ent_len;
 
 	if (!data)
 		return -EINVAL;
@@ -215,11 +216,12 @@ int cmd_db_read_aux_data(const char *id, u8 *data, size_t len)
 	if (ret)
 		return ret;
 
-	if (len < ent.len)
+	ent_len = le16_to_cpu(ent.len);
+	if (len < ent_len)
 		return -EINVAL;
 
-	len = min_t(u16, ent.len, len);
-	memcpy(data, RSC_OFFSET(rsc_hdr, ent), len);
+	len = min_t(u16, ent_len, len);
+	memcpy(data, rsc_offset(&rsc_hdr, &ent), len);
 
 	return len;
 }
@@ -240,7 +242,7 @@ size_t cmd_db_read_aux_data_len(const char *id)
 
 	ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);
 
-	return ret < 0 ? 0 : ent.len;
+	return ret < 0 ? 0 : le16_to_cpu(ent.len);
 }
 EXPORT_SYMBOL(cmd_db_read_aux_data_len);
 
@@ -256,11 +258,14 @@ enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
 	int ret;
 	struct entry_header ent;
 	struct rsc_hdr rsc_hdr;
+	u32 addr;
 
 	ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);
+	if (ret < 0)
+		return CMD_DB_HW_INVALID;
 
-	return ret < 0 ? CMD_DB_HW_INVALID :
-		       (ent.addr >> SLAVE_ID_SHIFT) & SLAVE_ID_MASK;
+	addr = le32_to_cpu(ent.addr);
+	return (addr >> SLAVE_ID_SHIFT) & SLAVE_ID_MASK;
 }
 EXPORT_SYMBOL(cmd_db_read_slave_id);
 
@@ -282,7 +287,7 @@ static int cmd_db_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (cmd_db_header->magic_num != CMD_DB_MAGIC) {
+	if (memcmp(&cmd_db_header->magic_num, CMD_DB_MAGIC, sizeof(CMD_DB_MAGIC))) {
 		dev_err(&pdev->dev, "Invalid Command DB Magic\n");
 		return -EINVAL;
 	}
