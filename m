Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45011C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023AE2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbfACHqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 02:46:13 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:34108 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730219AbfACHqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 02:46:12 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03312;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.DgqvJY-_1546501546;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.DgqvJY-_1546501546)
          by smtp.aliyun-inc.com(10.147.43.230);
          Thu, 03 Jan 2019 15:45:56 +0800
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: [RFC v4 3/3] pstore/rom: support pmsg for pstore_rom
Date:   Thu,  3 Jan 2019 15:45:33 +0800
Message-Id: <1546501533-1855-4-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546501533-1855-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1546501533-1855-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable pmsg, just set pmsg_size when block device register romzone.
The pmsg have a single-boot lifetime, which means that zone of pmsg gets
wiped after its contents get copied out after boot.

Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
---
 fs/pstore/romzone.c        | 194 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/pstore_rom.h |   1 +
 2 files changed, 187 insertions(+), 8 deletions(-)

diff --git a/fs/pstore/romzone.c b/fs/pstore/romzone.c
index 76a2648..d035694 100644
--- a/fs/pstore/romzone.c
+++ b/fs/pstore/romzone.c
@@ -31,12 +31,14 @@
  *
  * @sig: signature to indicate header (ROM_SIG xor ROMZONE-type value)
  * @datalen: length of data in @data
+ * @start: offset into @data where the beginning of the stored bytes begin
  * @data: zone data.
  */
 struct romz_buffer {
 #define ROM_SIG (0x43474244) /* DBGC */
 	uint32_t sig;
 	atomic_t datalen;
+	atomic_t start;
 	uint8_t data[0];
 };
 
@@ -69,6 +71,10 @@ struct romz_dmesg_header {
  *	frontent name for this zone
  * @buffer:
  *	pointer to data buffer managed by this zone
+ * @oldbuf:
+ *	pointer to old data buffer. It is used for zone who have a single-boot
+ *	lifetime, which means that this zone gets wiped after its contents get
+ *	copied out after boot.
  * @buffer_size:
  *	bytes in @buffer->data
  * @should_recover:
@@ -82,6 +88,7 @@ struct romz_zone {
 	enum pstore_type_id type;
 
 	struct romz_buffer *buffer;
+	struct romz_buffer *oldbuf;
 	size_t buffer_size;
 	bool should_recover;
 	atomic_t dirty;
@@ -89,8 +96,10 @@ struct romz_zone {
 
 struct romoops_context {
 	struct romz_zone **drzs;	/* Oops dump zones */
+	struct romz_zone *prz;		/* Pmsg dump zones */
 	unsigned int dmesg_max_cnt;
 	unsigned int dmesg_read_cnt;
+	unsigned int pmsg_read_cnt;
 	unsigned int dmesg_write_cnt;
 	/**
 	 * the counter should be recovered when do recovery
@@ -124,6 +133,11 @@ static inline int buffer_datalen(struct romz_zone *zone)
 	return atomic_read(&zone->buffer->datalen);
 }
 
+static inline int buffer_start(struct romz_zone *zone)
+{
+	return atomic_read(&zone->buffer->start);
+}
+
 static inline bool is_on_panic(void)
 {
 	struct romoops_context *cxt = &romz_cxt;
@@ -398,6 +412,65 @@ static int romz_recover_dmesg(struct romoops_context *cxt)
 	return ret;
 }
 
+static int romz_recover_pmsg(struct romoops_context *cxt)
+{
+	struct romz_info *info = cxt->rzinfo;
+	struct romz_buffer *oldbuf;
+	struct romz_zone *zone = NULL;
+	ssize_t (*readop)(char *buf, size_t bytes, loff_t pos);
+	int ret = 0;
+	ssize_t rcnt, len;
+
+	zone = cxt->prz;
+	if (!zone)
+		return -EINVAL;
+
+	if (zone->oldbuf)
+		return 0;
+
+	readop = info->read;
+	if (is_on_panic())
+		readop = info->panic_read;
+	if (!readop)
+		return -EINVAL;
+
+	len = zone->buffer_size + sizeof(*oldbuf);
+	oldbuf = kzalloc(len, GFP_KERNEL);
+	if (!oldbuf)
+		return -ENOMEM;
+
+	rcnt = readop((char *)oldbuf, len, zone->off);
+	if (rcnt != len) {
+		pr_debug("recovery pmsg failed\n");
+		ret = -EIO;
+		goto free_oldbuf;
+	}
+
+	if (oldbuf->sig != zone->buffer->sig) {
+		pr_debug("no valid data in zone %s\n", zone->name);
+		goto free_oldbuf;
+	}
+
+	if (zone->buffer_size < atomic_read(&oldbuf->datalen) ||
+		zone->buffer_size < atomic_read(&oldbuf->start)) {
+		pr_info("found overtop zone: %s: off %lu, size %zu\n",
+				zone->name, zone->off, zone->buffer_size);
+		goto free_oldbuf;
+	}
+
+	if (atomic_read(&zone->dirty))
+		romz_zone_write(zone, FLUSH_ALL, NULL, buffer_datalen(zone), 0);
+	else
+		romz_zone_write(zone, FLUSH_META, NULL, 0, 0);
+
+	zone->oldbuf = oldbuf;
+	return 0;
+
+free_oldbuf:
+	kfree(oldbuf);
+	return ret;
+}
+
 static inline int romz_recovery(struct romoops_context *cxt)
 {
 	int ret = -EBUSY;
@@ -412,6 +485,10 @@ static inline int romz_recovery(struct romoops_context *cxt)
 	if (ret)
 		goto recover_fail;
 
+	ret = romz_recover_pmsg(cxt);
+	if (ret)
+		goto recover_fail;
+
 	atomic_set(&cxt->recovery, 1);
 	pr_debug("recover end!\n");
 	return 0;
@@ -520,6 +597,55 @@ static int notrace romz_dmesg_write(struct romoops_context *cxt,
 	return 0;
 }
 
+static int notrace romz_pmsg_write(struct romoops_context *cxt,
+		struct pstore_record *record)
+{
+	struct romz_zone *zone;
+	size_t start, rem;
+	int cnt = record->size;
+	bool is_full_data = false;
+	char *buf = record->buf;
+
+	zone = cxt->prz;
+	if (!zone)
+		return -ENOSPC;
+
+	if (atomic_read(&zone->buffer->datalen) >= zone->buffer_size)
+		is_full_data = true;
+
+	if (unlikely(cnt > zone->buffer_size)) {
+		buf += cnt - zone->buffer_size;
+		cnt = zone->buffer_size;
+	}
+
+	start = buffer_start(zone);
+	rem = zone->buffer_size - start;
+	if (unlikely(rem < cnt)) {
+		romz_zone_write(zone, FLUSH_PART, buf, rem, start);
+		buf += rem;
+		cnt -= rem;
+		start = 0;
+		is_full_data = true;
+	}
+
+	atomic_set(&zone->buffer->start, cnt + start);
+	romz_zone_write(zone, FLUSH_PART, buf, cnt, start);
+
+	/**
+	 * romz_zone_write will set datalen as start + cnt.
+	 * It work if actual data length lesser than buffer size.
+	 * If data length greater than buffer size, pmsg will rewrite to
+	 * beginning of zone, which make buffer->datalen wrongly.
+	 * So we should reset datalen as buffer size once actual data length
+	 * greater than buffer size.
+	 */
+	if (is_full_data) {
+		atomic_set(&zone->buffer->datalen, zone->buffer_size);
+		romz_zone_write(zone, FLUSH_META, NULL, 0, 0);
+	}
+	return 0;
+}
+
 static int notrace romoops_pstore_write(struct pstore_record *record)
 {
 	struct romoops_context *cxt = record->psi->data;
@@ -537,6 +663,8 @@ static int notrace romoops_pstore_write(struct pstore_record *record)
 	switch (record->type) {
 	case PSTORE_TYPE_DMESG:
 		return romz_dmesg_write(cxt, record);
+	case PSTORE_TYPE_PMSG:
+		return romz_pmsg_write(cxt, record);
 	default:
 		return -EINVAL;
 	}
@@ -544,9 +672,11 @@ static int notrace romoops_pstore_write(struct pstore_record *record)
 
 static inline bool romz_ok(struct romz_zone *zone)
 {
-	if (!zone || !zone->buffer || !buffer_datalen(zone))
-		return false;
-	return true;
+	if (zone && zone->oldbuf && atomic_read(&zone->oldbuf->datalen))
+		return true;
+	if (zone && zone->buffer && buffer_datalen(zone))
+		return true;
+	return false;
 }
 
 #define READ_NEXT_ZONE ((ssize_t)(-1024))
@@ -560,6 +690,13 @@ static struct romz_zone *romz_read_next_zone(struct romoops_context *cxt)
 			return zone;
 	}
 
+	if (cxt->pmsg_read_cnt == 0) {
+		cxt->pmsg_read_cnt++;
+		zone = cxt->prz;
+		if (romz_ok(zone))
+			return zone;
+	}
+
 	return NULL;
 }
 
@@ -620,6 +757,29 @@ static ssize_t romz_dmesg_read(struct romz_zone *zone,
 	return size + hlen;
 }
 
+static ssize_t romz_pmsg_read(struct romz_zone *zone,
+		struct pstore_record *record)
+{
+	size_t size, start;
+	struct romz_buffer *buf;
+
+	buf = (struct romz_buffer *)zone->oldbuf;
+	if (!buf)
+		return READ_NEXT_ZONE;
+
+	size = atomic_read(&buf->datalen);
+	start = atomic_read(&buf->start);
+
+	record->buf = kmalloc(size, GFP_KERNEL);
+	if (!record->buf)
+		return -ENOMEM;
+
+	memcpy(record->buf, buf->data + start, size - start);
+	memcpy(record->buf + size - start, buf->data, start);
+
+	return size;
+}
+
 static ssize_t romoops_pstore_read(struct pstore_record *record)
 {
 	struct romoops_context *cxt = record->psi->data;
@@ -651,6 +811,9 @@ static ssize_t romoops_pstore_read(struct pstore_record *record)
 		romz_read = romz_dmesg_read;
 		record->id = cxt->dmesg_read_cnt - 1;
 		break;
+	case PSTORE_TYPE_PMSG:
+		romz_read = romz_pmsg_read;
+		break;
 	default:
 		goto next_zone;
 	}
@@ -757,8 +920,10 @@ static struct romz_zone *romz_init_zone(enum pstore_type_id type,
 	zone->type = type;
 	zone->buffer_size = size - sizeof(struct romz_buffer);
 	zone->buffer->sig = type ^ ROM_SIG;
+	zone->oldbuf = NULL;
 	atomic_set(&zone->dirty, 0);
 	atomic_set(&zone->buffer->datalen, 0);
+	atomic_set(&zone->buffer->start, 0);
 
 	*off += size;
 
@@ -840,7 +1005,7 @@ static int romz_cut_zones(struct romoops_context *cxt)
 	int err;
 	size_t size;
 
-	size = info->part_size;
+	size = info->part_size - info->pmsg_size;
 	cxt->drzs = romz_init_zones(PSTORE_TYPE_DMESG, &off, size,
 			info->dmesg_size, &cxt->dmesg_max_cnt);
 	if (IS_ERR(cxt->drzs)) {
@@ -848,7 +1013,16 @@ static int romz_cut_zones(struct romoops_context *cxt)
 		goto fail_out;
 	}
 
+	size = info->pmsg_size;
+	cxt->prz = romz_init_zone(PSTORE_TYPE_PMSG, &off, size);
+	if (IS_ERR(cxt->prz)) {
+		err = PTR_ERR(cxt->prz);
+		goto free_dmesg_zones;
+	}
+
 	return 0;
+free_dmesg_zones:
+	romz_free_zones(&cxt->drzs, &cxt->dmesg_max_cnt);
 fail_out:
 	return err;
 }
@@ -859,7 +1033,7 @@ int romz_register(struct romz_info *info)
 	struct romoops_context *cxt = &romz_cxt;
 	struct module *owner = info->owner;
 
-	if (!info->part_size || !info->dmesg_size) {
+	if (!info->part_size || (!info->dmesg_size && !info->pmsg_size)) {
 		pr_warn("The memory size and the dmesg size must be non-zero\n");
 		return -EINVAL;
 	}
@@ -879,6 +1053,7 @@ int romz_register(struct romz_info *info)
 
 	check_size(part_size, 4096 - 1);
 	check_size(dmesg_size, SECTOR_SIZE - 1);
+	check_size(pmsg_size, SECTOR_SIZE - 1);
 
 #undef check_size
 
@@ -915,6 +1090,8 @@ int romz_register(struct romz_info *info)
 	}
 	cxt->pstore.data = cxt;
 	cxt->pstore.flags = PSTORE_FLAGS_DMESG;
+	if (info->pmsg_size)
+		cxt->pstore.flags |= PSTORE_FLAGS_PMSG;
 
 	err = pstore_register(&cxt->pstore);
 	if (err) {
@@ -922,9 +1099,10 @@ int romz_register(struct romz_info *info)
 		goto free_pstore_buf;
 	}
 
-	pr_info("Registered %s as romzone backend for %s%s\n", info->name,
+	pr_info("Registered %s as romzone backend for %s%s%s\n", info->name,
 			cxt->drzs && cxt->rzinfo->dump_oops ? "Oops " : "",
-			cxt->drzs ? "Panic " : "");
+			cxt->drzs ? "Panic " : "",
+			cxt->prz ? "Pmsg" : "");
 
 	module_put(owner);
 	return 0;
@@ -952,7 +1130,7 @@ void romz_unregister(struct romz_info *info)
 	spin_unlock(&cxt->rzinfo_lock);
 
 	romz_free_zones(&cxt->drzs, &cxt->dmesg_max_cnt);
-
+	romz_free_zone(&cxt->prz);
 }
 EXPORT_SYMBOL_GPL(romz_unregister);
 
diff --git a/include/linux/pstore_rom.h b/include/linux/pstore_rom.h
index 45b95df..7141af8 100644
--- a/include/linux/pstore_rom.h
+++ b/include/linux/pstore_rom.h
@@ -48,6 +48,7 @@ struct romz_info {
 	const char *part_path;
 	unsigned long part_size;
 	unsigned long dmesg_size;
+	unsigned long pmsg_size;
 	int dump_oops;
 	ssize_t (*read)(char *buf, size_t bytes, loff_t pos);
 	ssize_t (*write)(const char *buf, size_t bytes, loff_t pos);
-- 
1.9.1

