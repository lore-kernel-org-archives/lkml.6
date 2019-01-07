Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E92C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025372147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfAGMCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:02:02 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:48162 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726535AbfAGMB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:01:59 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03309;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.DibxlYK_1546862495;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.DibxlYK_1546862495)
          by smtp.aliyun-inc.com(10.147.40.200);
          Mon, 07 Jan 2019 20:01:49 +0800
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: [RFC v5 3/4] pstore/blk: support pmsg for pstore block
Date:   Mon,  7 Jan 2019 20:01:01 +0800
Message-Id: <1546862462-19640-4-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546862462-19640-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1546862462-19640-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable pmsg, just set pmsg_size when block device register blkzone.

Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
---
 fs/pstore/blkzone.c        | 254 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/pstore_blk.h |   1 +
 2 files changed, 233 insertions(+), 22 deletions(-)

diff --git a/fs/pstore/blkzone.c b/fs/pstore/blkzone.c
index e1b7f26..157f1cfd 100644
--- a/fs/pstore/blkzone.c
+++ b/fs/pstore/blkzone.c
@@ -32,12 +32,14 @@
  *
  * @sig: signature to indicate header (BLK_SIG xor BLKZONE-type value)
  * @datalen: length of data in @data
+ * @start: offset into @data where the beginning of the stored bytes begin
  * @data: zone data.
  */
 struct blkz_buffer {
 #define BLK_SIG (0x43474244) /* DBGC */
 	uint32_t sig;
 	atomic_t datalen;
+	atomic_t start;
 	uint8_t data[0];
 };
 
@@ -70,6 +72,9 @@ struct blkz_dmesg_header {
  *	frontent name for this zone
  * @buffer:
  *	pointer to data buffer managed by this zone
+ * @oldbuf:
+ *	pointer to old data buffer. It is used for single zone such as pmsg,
+ *	saving the old buffer.
  * @buffer_size:
  *	bytes in @buffer->data
  * @should_recover:
@@ -83,6 +88,7 @@ struct blkz_zone {
 	enum pstore_type_id type;
 
 	struct blkz_buffer *buffer;
+	struct blkz_buffer *oldbuf;
 	size_t buffer_size;
 	bool should_recover;
 	atomic_t dirty;
@@ -90,8 +96,10 @@ struct blkz_zone {
 
 struct blkoops_context {
 	struct blkz_zone **dbzs;	/* dmesg block zones */
+	struct blkz_zone *pbz;		/* Pmsg block zone */
 	unsigned int dmesg_max_cnt;
 	unsigned int dmesg_read_cnt;
+	unsigned int pmsg_read_cnt;
 	unsigned int dmesg_write_cnt;
 	/**
 	 * the counter should be recovered when do recovery
@@ -125,6 +133,11 @@ static inline int buffer_datalen(struct blkz_zone *zone)
 	return atomic_read(&zone->buffer->datalen);
 }
 
+static inline int buffer_start(struct blkz_zone *zone)
+{
+	return atomic_read(&zone->buffer->start);
+}
+
 static inline bool is_on_panic(void)
 {
 	struct blkoops_context *cxt = &blkz_cxt;
@@ -394,6 +407,72 @@ static int blkz_recover_dmesg(struct blkoops_context *cxt)
 	return ret;
 }
 
+static int blkz_recover_pmsg(struct blkoops_context *cxt)
+{
+	struct blkz_info *info = cxt->bzinfo;
+	struct blkz_buffer *oldbuf;
+	struct blkz_zone *zone = NULL;
+	ssize_t (*readop)(char *buf, size_t bytes, loff_t pos);
+	int ret = 0;
+	ssize_t rcnt, len;
+
+	zone = cxt->pbz;
+	if (!zone || zone->oldbuf)
+		return 0;
+
+	if (is_on_panic())
+		goto out;
+
+	readop = info->read;
+	if (unlikely(!readop))
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
+		ret = (int)rcnt < 0 ? (int)rcnt : -EIO;
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
+	if (!atomic_read(&oldbuf->datalen)) {
+		pr_debug("found erased zone: %s: id 0, off %lu, size %zu, datalen %d\n",
+				zone->name, zone->off, zone->buffer_size,
+				atomic_read(&oldbuf->datalen));
+		kfree(oldbuf);
+		goto out;
+	}
+
+	pr_debug("found nice zone: %s: id 0, off %lu, size %zu, datalen %d\n",
+			zone->name, zone->off, zone->buffer_size,
+			atomic_read(&oldbuf->datalen));
+	zone->oldbuf = oldbuf;
+out:
+	if (atomic_read(&zone->dirty))
+		blkz_zone_write(zone, FLUSH_ALL, NULL, buffer_datalen(zone), 0);
+	return 0;
+
+free_oldbuf:
+	kfree(oldbuf);
+	return ret;
+}
+
 static inline int blkz_recovery(struct blkoops_context *cxt)
 {
 	int ret = -EBUSY;
@@ -408,6 +487,10 @@ static inline int blkz_recovery(struct blkoops_context *cxt)
 	if (ret)
 		goto recover_fail;
 
+	ret = blkz_recover_pmsg(cxt);
+	if (ret)
+		goto recover_fail;
+
 	atomic_set(&cxt->recovery, 1);
 	pr_debug("recover end!\n");
 	return 0;
@@ -425,11 +508,18 @@ static int blkoops_pstore_open(struct pstore_info *psi)
 	return 0;
 }
 
+static inline bool blkz_old_ok(struct blkz_zone *zone)
+{
+	if (zone && zone->oldbuf && atomic_read(&zone->oldbuf->datalen))
+		return true;
+	return false;
+}
+
 static inline bool blkz_ok(struct blkz_zone *zone)
 {
-	if (!zone || !zone->buffer || !buffer_datalen(zone))
-		return false;
-	return true;
+	if (zone && zone->buffer && buffer_datalen(zone))
+		return true;
+	return false;
 }
 
 static int blkoops_pstore_erase(struct pstore_record *record)
@@ -443,13 +533,29 @@ static int blkoops_pstore_erase(struct pstore_record *record)
 	 */
 	blkz_recovery(cxt);
 
-	if (record->type == PSTORE_TYPE_DMESG)
+	if (record->type == PSTORE_TYPE_DMESG) {
 		zone = cxt->dbzs[record->id];
-	if (!blkz_ok(zone))
-		return 0;
+		if (unlikely(!blkz_ok(zone)))
+			return 0;
 
-	atomic_set(&zone->buffer->datalen, 0);
-	return blkz_zone_write(zone, FLUSH_META, NULL, 0, 0);
+		atomic_set(&zone->buffer->datalen, 0);
+		return blkz_zone_write(zone, FLUSH_META, NULL, 0, 0);
+	} else if (record->type == PSTORE_TYPE_PMSG) {
+		zone = cxt->pbz;
+		if (unlikely(!blkz_old_ok(zone)))
+			return 0;
+
+		kfree(zone->oldbuf);
+		zone->oldbuf = NULL;
+		/**
+		 * if there is new data in zone buffer, there is no need to
+		 * flush 0 (erase) to block device
+		 */
+		if (buffer_datalen(zone))
+			return 0;
+		return blkz_zone_write(zone, FLUSH_META, NULL, 0, 0);
+	}
+	return -EINVAL;
 }
 
 static void blkoops_write_kmsg_hdr(struct blkz_zone *zone,
@@ -467,8 +573,10 @@ static void blkoops_write_kmsg_hdr(struct blkz_zone *zone,
 	hdr->reason = record->reason;
 	if (hdr->reason == KMSG_DUMP_OOPS)
 		hdr->counter = ++cxt->oops_counter;
-	else
+	else if (hdr->reason == KMSG_DUMP_PANIC)
 		hdr->counter = ++cxt->panic_counter;
+	else
+		hdr->counter = 0;
 }
 
 static int notrace blkz_dmesg_write(struct blkoops_context *cxt,
@@ -518,6 +626,55 @@ static int notrace blkz_dmesg_write(struct blkoops_context *cxt,
 	return 0;
 }
 
+static int notrace blkz_pmsg_write(struct blkoops_context *cxt,
+		struct pstore_record *record)
+{
+	struct blkz_zone *zone;
+	size_t start, rem;
+	int cnt = record->size;
+	bool is_full_data = false;
+	char *buf = record->buf;
+
+	zone = cxt->pbz;
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
+		blkz_zone_write(zone, FLUSH_PART, buf, rem, start);
+		buf += rem;
+		cnt -= rem;
+		start = 0;
+		is_full_data = true;
+	}
+
+	atomic_set(&zone->buffer->start, cnt + start);
+	blkz_zone_write(zone, FLUSH_PART, buf, cnt, start);
+
+	/**
+	 * blkz_zone_write will set datalen as start + cnt.
+	 * It work if actual data length lesser than buffer size.
+	 * If data length greater than buffer size, pmsg will rewrite to
+	 * beginning of zone, which make buffer->datalen wrongly.
+	 * So we should reset datalen as buffer size once actual data length
+	 * greater than buffer size.
+	 */
+	if (is_full_data) {
+		atomic_set(&zone->buffer->datalen, zone->buffer_size);
+		blkz_zone_write(zone, FLUSH_META, NULL, 0, 0);
+	}
+	return 0;
+}
+
 static int notrace blkoops_pstore_write(struct pstore_record *record)
 {
 	struct blkoops_context *cxt = record->psi->data;
@@ -535,6 +692,8 @@ static int notrace blkoops_pstore_write(struct pstore_record *record)
 	switch (record->type) {
 	case PSTORE_TYPE_DMESG:
 		return blkz_dmesg_write(cxt, record);
+	case PSTORE_TYPE_PMSG:
+		return blkz_pmsg_write(cxt, record);
 	default:
 		return -EINVAL;
 	}
@@ -551,6 +710,13 @@ static struct blkz_zone *blkz_read_next_zone(struct blkoops_context *cxt)
 			return zone;
 	}
 
+	if (cxt->pmsg_read_cnt == 0) {
+		cxt->pmsg_read_cnt++;
+		zone = cxt->pbz;
+		if (blkz_old_ok(zone))
+			return zone;
+	}
+
 	return NULL;
 }
 
@@ -589,7 +755,8 @@ static ssize_t blkz_dmesg_read(struct blkz_zone *zone,
 		char *buf = kasprintf(GFP_KERNEL,
 				"blkoops: %s: Total %d times\n",
 				record->reason == KMSG_DUMP_OOPS ? "Oops" :
-				"Panic", record->count);
+				record->reason == KMSG_DUMP_PANIC ? "Panic" :
+				"Unknown", record->count);
 		hlen = strlen(buf);
 		record->buf = krealloc(buf, hlen + size, GFP_KERNEL);
 		if (!record->buf) {
@@ -611,6 +778,29 @@ static ssize_t blkz_dmesg_read(struct blkz_zone *zone,
 	return size + hlen;
 }
 
+static ssize_t blkz_pmsg_read(struct blkz_zone *zone,
+		struct pstore_record *record)
+{
+	size_t size, start;
+	struct blkz_buffer *buf;
+
+	buf = (struct blkz_buffer *)zone->oldbuf;
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
 static ssize_t blkoops_pstore_read(struct pstore_record *record)
 {
 	struct blkoops_context *cxt = record->psi->data;
@@ -642,6 +832,9 @@ static ssize_t blkoops_pstore_read(struct pstore_record *record)
 		blkz_read = blkz_dmesg_read;
 		record->id = cxt->dmesg_read_cnt - 1;
 		break;
+	case PSTORE_TYPE_PMSG:
+		blkz_read = blkz_pmsg_read;
+		break;
 	default:
 		goto next_zone;
 	}
@@ -754,8 +947,10 @@ static struct blkz_zone *blkz_init_zone(enum pstore_type_id type,
 	zone->type = type;
 	zone->buffer_size = size - sizeof(struct blkz_buffer);
 	zone->buffer->sig = type ^ BLK_SIG;
+	zone->oldbuf = NULL;
 	atomic_set(&zone->dirty, 0);
 	atomic_set(&zone->buffer->datalen, 0);
+	atomic_set(&zone->buffer->start, 0);
 
 	*off += size;
 
@@ -837,7 +1032,7 @@ static int blkz_cut_zones(struct blkoops_context *cxt)
 	int err;
 	size_t size;
 
-	size = info->part_size;
+	size = info->part_size - info->pmsg_size;
 	cxt->dbzs = blkz_init_zones(PSTORE_TYPE_DMESG, &off, size,
 			info->dmesg_size, &cxt->dmesg_max_cnt);
 	if (IS_ERR(cxt->dbzs)) {
@@ -845,7 +1040,16 @@ static int blkz_cut_zones(struct blkoops_context *cxt)
 		goto fail_out;
 	}
 
+	size = info->pmsg_size;
+	cxt->pbz = blkz_init_zone(PSTORE_TYPE_PMSG, &off, size);
+	if (IS_ERR(cxt->pbz)) {
+		err = PTR_ERR(cxt->pbz);
+		goto free_dmesg_zones;
+	}
+
 	return 0;
+free_dmesg_zones:
+	blkz_free_zones(&cxt->dbzs, &cxt->dmesg_max_cnt);
 fail_out:
 	return err;
 }
@@ -856,7 +1060,7 @@ int blkz_register(struct blkz_info *info)
 	struct blkoops_context *cxt = &blkz_cxt;
 	struct module *owner = info->owner;
 
-	if (!info->part_size || !info->dmesg_size) {
+	if (!info->part_size || (!info->dmesg_size && !info->pmsg_size)) {
 		pr_warn("The memory size and the dmesg size must be non-zero\n");
 		return -EINVAL;
 	}
@@ -876,6 +1080,7 @@ int blkz_register(struct blkz_info *info)
 
 	check_size(part_size, 4096 - 1);
 	check_size(dmesg_size, SECTOR_SIZE - 1);
+	check_size(pmsg_size, SECTOR_SIZE - 1);
 
 #undef check_size
 
@@ -902,16 +1107,20 @@ int blkz_register(struct blkz_info *info)
 		goto fail_out;
 	}
 
-	cxt->pstore.bufsize = cxt->dbzs[0]->buffer_size -
+	if (info->dmesg_size) {
+		cxt->pstore.bufsize = cxt->dbzs[0]->buffer_size -
 			sizeof(struct blkz_dmesg_header);
-	cxt->pstore.buf = kzalloc(cxt->pstore.bufsize, GFP_KERNEL);
-	if (!cxt->pstore.buf) {
-		pr_err("cannot allocate pstore crash dump buffer\n");
-		err = -ENOMEM;
-		goto fail_out;
+		cxt->pstore.buf = kzalloc(cxt->pstore.bufsize, GFP_KERNEL);
+		if (!cxt->pstore.buf) {
+			err = -ENOMEM;
+			goto fail_out;
+		}
 	}
 	cxt->pstore.data = cxt;
-	cxt->pstore.flags = PSTORE_FLAGS_DMESG;
+	if (info->dmesg_size)
+		cxt->pstore.flags |= PSTORE_FLAGS_DMESG;
+	if (info->pmsg_size)
+		cxt->pstore.flags |= PSTORE_FLAGS_PMSG;
 
 	err = pstore_register(&cxt->pstore);
 	if (err) {
@@ -919,9 +1128,10 @@ int blkz_register(struct blkz_info *info)
 		goto free_pstore_buf;
 	}
 
-	pr_info("Registered %s as blkzone backend for %s%s\n", info->name,
+	pr_info("Registered %s as blkzone backend for %s%s%s\n", info->name,
 			cxt->dbzs && cxt->bzinfo->dump_oops ? "Oops " : "",
-			cxt->dbzs && cxt->bzinfo->panic_write ? "Panic " : "");
+			cxt->dbzs && cxt->bzinfo->panic_write ? "Panic " : "",
+			cxt->pbz ? "Pmsg" : "");
 
 	module_put(owner);
 	return 0;
@@ -949,7 +1159,7 @@ void blkz_unregister(struct blkz_info *info)
 	spin_unlock(&cxt->bzinfo_lock);
 
 	blkz_free_zones(&cxt->dbzs, &cxt->dmesg_max_cnt);
-
+	blkz_free_zone(&cxt->pbz);
 }
 EXPORT_SYMBOL_GPL(blkz_unregister);
 
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 426cae4..6c6b4eb 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -48,6 +48,7 @@ struct blkz_info {
 	const char *part_path;
 	unsigned long part_size;
 	unsigned long dmesg_size;
+	unsigned long pmsg_size;
 	int dump_oops;
 	ssize_t (*read)(char *buf, size_t bytes, loff_t pos);
 	ssize_t (*write)(const char *buf, size_t bytes, loff_t pos);
-- 
1.9.1

