Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755930AbeDWQVA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:21:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45155 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755423AbeDWQU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:20:57 -0400
X-Google-Smtp-Source: AIpwx4+XAcZT3LemZrN3ZHXDkQv14OrYLs2TeWbNCvuga73OfxPStQTDc7DH/IkhFoZI5bfdYA00kA==
From: Stephen Boyd <swboyd@chromium.org>
To: Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH v3] soc: qcom: cmd-db: Make endian-agnostic
Date: Mon, 23 Apr 2018 09:20:54 -0700
Message-Id: <20180423162054.238544-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver deals with memory that is stored in little-endian format.
Update the structures with the proper little-endian types and then
do the proper conversions when reading the fields. Note that we compare
the ids with a memcmp() because we already pad out the string 'id' field
to exactly 8 bytes with the strncpy() onto the stack.

Cc: Mahesh Sivasubramanian <msivasub@codeaurora.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v2:
 * Fixed rsc_offset conversion to use data_offset instead of header_offset
   for finding first offset
 * Tested and confirmed slave ids and aux data for ARC regulators look
   the same as before
                                                                                                                                                               
Changes from v1:                                                                                                                                               
 * Fixed negation on probe time magic matches check to be correct                                                                                              
 * Fixed kernel doc and renamed magic_num to magic                                                                                                             
 * Killed cmd_db_get_header_by_rsc_id() entirely                                                                                                               
 * Changed chars to u8s for simplicity of thinking about signedness                                                                                            
 * Fixed cmd_db_get_header()'s memcmp to do the right thing by checking                                                                                        
   for a match instead of the opposite                                                                                                                         
 * Tested on real hardware           

 drivers/soc/qcom/cmd-db.c | 131 ++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 62 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index b5172049f608..a6f646295f06 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -13,18 +13,9 @@
 
 #define NUM_PRIORITY		2
 #define MAX_SLV_ID		8
-#define CMD_DB_MAGIC		0x0C0330DBUL
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
@@ -35,11 +26,11 @@
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
@@ -53,30 +44,30 @@ struct entry_header {
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
  * struct cmd_db_header: The DB header information
  *
  * @version: The cmd db version
- * @magic_number: constant expected in the database
+ * @magic: constant expected in the database
  * @header: array of resources
  * @checksum: checksum for the header. Unused.
  * @reserved: reserved memory
  * @data: driver specific data
  */
 struct cmd_db_header {
-	u32 version;
-	u32 magic_num;
+	__le32 version;
+	u8 magic[4];
 	struct rsc_hdr header[MAX_SLV_ID];
-	u32 checksum;
-	u32 reserved;
+	__le32 checksum;
+	__le32 reserved;
 	u8 data[];
 };
 
@@ -99,8 +90,34 @@ struct cmd_db_header {
  * h/w accelerator and request a resource state.
  */
 
+static const u8 CMD_DB_MAGIC[] = { 0xdb, 0x30, 0x03, 0x0c };
+
+static bool cmd_db_magic_matches(const struct cmd_db_header *header)
+{
+	const u8 *magic = header->magic;
+
+	return memcmp(magic, CMD_DB_MAGIC, ARRAY_SIZE(CMD_DB_MAGIC)) == 0;
+}
+
 static struct cmd_db_header *cmd_db_header;
 
+
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
+	u16 offset = le16_to_cpu(hdr->data_offset);
+	u16 loffset = le16_to_cpu(ent->offset);
+
+	return cmd_db_header->data + offset + loffset;
+}
+
 /**
  * cmd_db_ready - Indicates if command DB is available
  *
@@ -110,29 +127,20 @@ int cmd_db_ready(void)
 {
 	if (cmd_db_header == NULL)
 		return -EPROBE_DEFER;
-	else if (cmd_db_header->magic_num != CMD_DB_MAGIC)
+	else if (!cmd_db_magic_matches(cmd_db_header))
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
+	u8 query[8];
 
 	ret = cmd_db_ready();
 	if (ret)
@@ -141,18 +149,21 @@ static int cmd_db_get_header(u64 query, struct entry_header *eh,
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
+			if (memcmp(ent->id, query, sizeof(ent->id)) == 0)
 				break;
 		}
 
-		if (j < rsc_hdr->cnt) {
+		if (j < le16_to_cpu(rsc_hdr->cnt)) {
 			memcpy(eh, ent, sizeof(*ent));
 			memcpy(rh, rsc_hdr, sizeof(*rh));
 			return 0;
@@ -162,15 +173,6 @@ static int cmd_db_get_header(u64 query, struct entry_header *eh,
 	return -ENODEV;
 }
 
-static int cmd_db_get_header_by_rsc_id(const char *id,
-				       struct entry_header *ent_hdr,
-				       struct rsc_hdr *rsc_hdr)
-{
-	u64 rsc_id = cmd_db_get_u64_id(id);
-
-	return cmd_db_get_header(rsc_id, ent_hdr, rsc_hdr);
-}
-
 /**
  * cmd_db_read_addr() - Query command db for resource id address.
  *
@@ -187,9 +189,9 @@ u32 cmd_db_read_addr(const char *id)
 	struct entry_header ent;
 	struct rsc_hdr rsc_hdr;
 
-	ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);
+	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
 
-	return ret < 0 ? 0 : ent.addr;
+	return ret < 0 ? 0 : le32_to_cpu(ent.addr);
 }
 EXPORT_SYMBOL(cmd_db_read_addr);
 
@@ -207,19 +209,21 @@ int cmd_db_read_aux_data(const char *id, u8 *data, size_t len)
 	int ret;
 	struct entry_header ent;
 	struct rsc_hdr rsc_hdr;
+	u16 ent_len;
 
 	if (!data)
 		return -EINVAL;
 
-	ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);
+	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
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
@@ -238,9 +242,9 @@ size_t cmd_db_read_aux_data_len(const char *id)
 	struct entry_header ent;
 	struct rsc_hdr rsc_hdr;
 
-	ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);
+	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
 
-	return ret < 0 ? 0 : ent.len;
+	return ret < 0 ? 0 : le16_to_cpu(ent.len);
 }
 EXPORT_SYMBOL(cmd_db_read_aux_data_len);
 
@@ -256,11 +260,14 @@ enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
 	int ret;
 	struct entry_header ent;
 	struct rsc_hdr rsc_hdr;
+	u32 addr;
 
-	ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);
+	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
+	if (ret < 0)
+		return CMD_DB_HW_INVALID;
 
-	return ret < 0 ? CMD_DB_HW_INVALID :
-		       (ent.addr >> SLAVE_ID_SHIFT) & SLAVE_ID_MASK;
+	addr = le32_to_cpu(ent.addr);
+	return (addr >> SLAVE_ID_SHIFT) & SLAVE_ID_MASK;
 }
 EXPORT_SYMBOL(cmd_db_read_slave_id);
 
@@ -282,7 +289,7 @@ static int cmd_db_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (cmd_db_header->magic_num != CMD_DB_MAGIC) {
+	if (!cmd_db_magic_matches(cmd_db_header)) {
 		dev_err(&pdev->dev, "Invalid Command DB Magic\n");
 		return -EINVAL;
 	}
-- 
Sent by a computer through tubes
