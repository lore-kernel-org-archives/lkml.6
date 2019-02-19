Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EBAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2082147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfBSLxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:53:34 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:55129 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726385AbfBSLxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:53:33 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712966|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.23774-0.162944-0.599316;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.E-W9w0Q_1550577197;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.E-W9w0Q_1550577197)
          by smtp.aliyun-inc.com(10.147.40.233);
          Tue, 19 Feb 2019 19:53:25 +0800
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC v9 1/5] pstore/blk: new support logger for block devices
Date:   Tue, 19 Feb 2019 19:52:46 +0800
Message-Id: <1550577170-18761-2-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550577170-18761-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1550577170-18761-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pstore_blk is similar to pstore_ram, but dump log to block devices
rather than persistent ram.

Why should we need pstore_blk?
1. Most embedded intelligent equipment have no persistent ram, which
increases costs. We perfer to cheaper solutions, like block devices.
In fact, there is already a sample for block device logger in driver
MTD (drivers/mtd/mtdoops.c).
2. Do not any equipment have battery, which means that it lost all data
on general ram if power failure. Pstore has little to do for these
equipments.

pstore_blk can only dump Oops/Panic log to block devices. It only
supports dmesg now. To make pstore_blk work, the block driver should
provide the block device and the read/write apis when on panic.

pstore_blk begins at 'blkz_register', by witch block device can register
a block device to pstore_blk. Then pstore_blk divide and manage the
block device as zones, which is similar to pstore_ram.

Recommend that, block driver register pstore_blk after block device is
ready.

pstore_blk works well on allwinner(sunxi) platform.

Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
---
 fs/pstore/Kconfig          |    8 +
 fs/pstore/Makefile         |    3 +
 fs/pstore/blkzone.c        | 1013 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pstore_blk.h |   80 ++++
 4 files changed, 1104 insertions(+)
 create mode 100644 fs/pstore/blkzone.c
 create mode 100644 include/linux/pstore_blk.h

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 8b3ba27..defcb75 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -152,3 +152,11 @@ config PSTORE_RAM
 	  "ramoops.ko".
 
 	  For more information, see Documentation/admin-guide/ramoops.rst.
+
+config PSTORE_BLK
+	tristate "Log panic/oops to a block device"
+	depends on PSTORE
+	depends on BLOCK
+	help
+	  This enables panic and oops message to be logged to a block dev
+	  where it can be read back at some later point.
diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
index 967b589..0ee2fc8 100644
--- a/fs/pstore/Makefile
+++ b/fs/pstore/Makefile
@@ -12,3 +12,6 @@ pstore-$(CONFIG_PSTORE_PMSG)	+= pmsg.o
 
 ramoops-objs += ram.o ram_core.o
 obj-$(CONFIG_PSTORE_RAM)	+= ramoops.o
+
+obj-$(CONFIG_PSTORE_BLK) += pstore_blk.o
+pstore_blk-y += blkzone.o
diff --git a/fs/pstore/blkzone.c b/fs/pstore/blkzone.c
new file mode 100644
index 0000000..83dd181
--- /dev/null
+++ b/fs/pstore/blkzone.c
@@ -0,0 +1,1013 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * blkzone.c: Block device Oops/Panic logger
+ *
+ * Copyright (C) 2019 liaoweixiong <liaoweixiong@gallwinnertech.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#define MODNAME "pstore-blk"
+#define pr_fmt(fmt) MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/blkdev.h>
+#include <linux/pstore.h>
+#include <linux/mount.h>
+#include <linux/printk.h>
+#include <linux/fs.h>
+#include <linux/pstore_blk.h>
+#include <linux/kdev_t.h>
+#include <linux/device.h>
+#include <linux/namei.h>
+#include <linux/fcntl.h>
+
+
+#define PSTORE_BLKDEV "/dev/pstore-blk"
+
+/**
+ * struct blkz_head - head of zone to flush to storage
+ *
+ * @sig: signature to indicate header (BLK_SIG xor BLKZONE-type value)
+ * @datalen: length of data in @data
+ * @data: zone data.
+ */
+struct blkz_buffer {
+#define BLK_SIG (0x43474244) /* DBGC */
+	uint32_t sig;
+	atomic_t datalen;
+	uint8_t data[];
+};
+
+/**
+ * struct blkz_dmesg_header: dmesg information
+ *
+ * @magic: magic num for dmesg header
+ * @time: trigger time
+ * @compressed: whether conpressed
+ * @count: oops/panic counter
+ * @reason: identify oops or panic
+ */
+struct blkz_dmesg_header {
+#define DMESG_HEADER_MAGIC 0x4dfc3ae5
+	uint32_t magic;
+	struct timespec64 time;
+	bool compressed;
+	uint32_t counter;
+	enum kmsg_dump_reason reason;
+	uint8_t data[0];
+};
+
+/**
+ * struct blkz_zone - zone information
+ * @off:
+ *	zone offset of block device
+ * @type:
+ *	frontent type for this zone
+ * @name:
+ *	frontent name for this zone
+ * @buffer:
+ *	pointer to data buffer managed by this zone
+ * @buffer_size:
+ *	bytes in @buffer->data
+ * @should_recover:
+ *	should recover from storage
+ * @dirty:
+ *	mark whether the data in @buffer are dirty (not flush to storage yet)
+ */
+struct blkz_zone {
+	unsigned long off;
+	const char *name;
+	enum pstore_type_id type;
+
+	struct blkz_buffer *buffer;
+	size_t buffer_size;
+	bool should_recover;
+	atomic_t dirty;
+};
+
+struct blkz_context {
+	struct blkz_zone **dbzs;	/* dmesg block zones */
+	unsigned int dmesg_max_cnt;
+	unsigned int dmesg_read_cnt;
+	unsigned int dmesg_write_cnt;
+	/*
+	 * the counter should be recovered when do recovery
+	 * It records the oops/panic times after burning rather than booting.
+	 */
+	unsigned int oops_counter;
+	unsigned int panic_counter;
+	atomic_t recovery;
+	atomic_t on_panic;
+
+	/*
+	 * bzinfo_lock just protects "bzinfo" during calls to
+	 * blkz_register/blkz_unregister
+	 */
+	spinlock_t bzinfo_lock;
+	struct blkz_info *bzinfo;
+	struct pstore_info pstore;
+};
+static struct blkz_context blkz_cxt;
+
+enum blkz_flush_mode {
+	FLUSH_NONE = 0,
+	FLUSH_PART,
+	FLUSH_META,
+	FLUSH_ALL,
+};
+
+static inline int buffer_datalen(struct blkz_zone *zone)
+{
+	return atomic_read(&zone->buffer->datalen);
+}
+
+static inline bool is_on_panic(void)
+{
+	struct blkz_context *cxt = &blkz_cxt;
+
+	return atomic_read(&cxt->on_panic);
+}
+
+static int blkz_zone_read(struct blkz_zone *zone, char *buf,
+		size_t len, unsigned long off)
+{
+	if (!buf || !zone->buffer)
+		return -EINVAL;
+	if (off > zone->buffer_size)
+		return -EINVAL;
+	len = min_t(size_t, len, zone->buffer_size - off);
+	memcpy(buf, zone->buffer->data + off, len);
+	return 0;
+}
+
+static int blkz_zone_write(struct blkz_zone *zone,
+		enum blkz_flush_mode flush_mode, const char *buf,
+		size_t len, unsigned long off)
+{
+	struct blkz_info *info = blkz_cxt.bzinfo;
+	ssize_t wcnt;
+	ssize_t (*writeop)(const char *buf, size_t bytes, loff_t pos);
+	size_t wlen;
+
+	if (off > zone->buffer_size)
+		return -EINVAL;
+	wlen = min_t(size_t, len, zone->buffer_size - off);
+	if (flush_mode != FLUSH_META && flush_mode != FLUSH_NONE) {
+		if (buf && zone->buffer)
+			memcpy(zone->buffer->data + off, buf, wlen);
+		atomic_set(&zone->buffer->datalen, wlen + off);
+	}
+
+	writeop = is_on_panic() ? info->panic_write : info->write;
+	if (!writeop)
+		return -EINVAL;
+
+	switch (flush_mode) {
+	case FLUSH_NONE:
+		return 0;
+	case FLUSH_PART:
+		wcnt = writeop((const char *)zone->buffer->data + off, wlen,
+				zone->off + sizeof(*zone->buffer) + off);
+		if (wcnt != wlen)
+			goto set_dirty;
+	case FLUSH_META:
+		wlen = sizeof(struct blkz_buffer);
+		wcnt = writeop((const char *)zone->buffer, wlen, zone->off);
+		if (wcnt != wlen)
+			goto set_dirty;
+		break;
+	case FLUSH_ALL:
+		wlen = buffer_datalen(zone) + sizeof(*zone->buffer);
+		wcnt = writeop((const char *)zone->buffer, wlen, zone->off);
+		if (wcnt != wlen)
+			goto set_dirty;
+		break;
+	}
+
+	return 0;
+set_dirty:
+	pr_err("write failed with %zd returned, set dirty\n", wcnt);
+	atomic_set(&zone->dirty, true);
+	return -EBUSY;
+}
+
+/*
+ * blkz_move_zone: move data from a old zone to a new zone
+ *
+ * @old: the old zone
+ * @new: the new zone
+ *
+ * NOTE:
+ *	Call blkz_zone_write to copy and flush data. If it failed, we
+ *	should reset new->dirty, because the new zone not really dirty.
+ */
+static int blkz_move_zone(struct blkz_zone *old, struct blkz_zone *new)
+{
+	const char *data = (const char *)old->buffer->data;
+	int ret;
+
+	ret = blkz_zone_write(new, FLUSH_ALL, data, buffer_datalen(old), 0);
+	if (ret) {
+		atomic_set(&new->buffer->datalen, 0);
+		atomic_set(&new->dirty, false);
+		return ret;
+	}
+	atomic_set(&old->buffer->datalen, 0);
+	return 0;
+}
+
+static int blkz_recover_dmesg_data(struct blkz_context *cxt)
+{
+	struct blkz_info *info = cxt->bzinfo;
+	struct blkz_zone *zone = NULL;
+	struct blkz_buffer *buf;
+	unsigned long i;
+	ssize_t (*readop)(char *buf, size_t bytes, loff_t pos);
+	ssize_t rcnt;
+
+	readop = is_on_panic() ? info->panic_read : info->read;
+	if (!readop)
+		return -EINVAL;
+
+	for (i = 0; i < cxt->dmesg_max_cnt; i++) {
+		zone = cxt->dbzs[i];
+		if (unlikely(!zone))
+			return -EINVAL;
+		if (atomic_read(&zone->dirty)) {
+			unsigned int wcnt = cxt->dmesg_write_cnt;
+			struct blkz_zone *new = cxt->dbzs[wcnt];
+			int ret;
+
+			ret = blkz_move_zone(zone, new);
+			if (ret) {
+				pr_err("move zone from %lu to %d failed\n",
+						i, wcnt);
+				return ret;
+			}
+			cxt->dmesg_write_cnt = (wcnt + 1) % cxt->dmesg_max_cnt;
+		}
+		if (!zone->should_recover)
+			continue;
+		buf = zone->buffer;
+		rcnt = readop((char *)buf, zone->buffer_size + sizeof(*buf),
+				zone->off);
+		if (rcnt != zone->buffer_size + sizeof(*buf))
+			return (int)rcnt < 0 ? (int)rcnt : -EIO;
+	}
+	return 0;
+}
+
+/**
+ * blkz_recover_dmesg_meta: recover metadata of dmesg
+ *
+ * Recover metadata as follow:
+ * @cxt->dmesg_write_cnt
+ * @cxt->oops_counter
+ * @cxt->panic_counter
+ */
+static int blkz_recover_dmesg_meta(struct blkz_context *cxt)
+{
+	struct blkz_info *info = cxt->bzinfo;
+	struct blkz_zone *zone;
+	size_t rcnt, len;
+	struct blkz_buffer *buf;
+	struct blkz_dmesg_header *hdr;
+	ssize_t (*readop)(char *buf, size_t bytes, loff_t pos);
+	struct timespec64 time = {0};
+	unsigned long i;
+	/*
+	 * Recover may on panic, we can't allocate any memory by kmalloc.
+	 * So, we use local array instead.
+	 */
+	char buffer_header[sizeof(*buf) + sizeof(*hdr)] = {0};
+
+	readop = is_on_panic() ? info->panic_read : info->read;
+	if (!readop)
+		return -EINVAL;
+
+	len = sizeof(*buf) + sizeof(*hdr);
+	buf = (struct blkz_buffer *)buffer_header;
+	for (i = 0; i < cxt->dmesg_max_cnt; i++) {
+		zone = cxt->dbzs[i];
+		if (unlikely(!zone))
+			return -EINVAL;
+
+		rcnt = readop((char *)buf, len, zone->off);
+		if (rcnt != len)
+			return (int)rcnt < 0 ? (int)rcnt : -EIO;
+
+		/*
+		 * If sig NOT match, it means this zone never used before,
+		 * because we write one by one, and we never modify sig even
+		 * when erase. So, we do not need to check next one.
+		 */
+		if (buf->sig != zone->buffer->sig) {
+			cxt->dmesg_write_cnt = i;
+			pr_debug("no valid data in dmesg zone %lu\n", i);
+			break;
+		}
+
+		if (zone->buffer_size < atomic_read(&buf->datalen)) {
+			pr_info("found overtop zone: %s: id %lu, off %lu, size %zu\n",
+					zone->name, i, zone->off,
+					zone->buffer_size);
+			continue;
+		}
+
+		hdr = (struct blkz_dmesg_header *)buf->data;
+		if (hdr->magic != DMESG_HEADER_MAGIC) {
+			pr_info("found invalid zone: %s: id %lu, off %lu, size %zu\n",
+					zone->name, i, zone->off,
+					zone->buffer_size);
+			continue;
+		}
+
+		/*
+		 * we get the newest zone, and the next one must be the oldest
+		 * or unused zone, because we do write one by one like a circle.
+		 */
+		if (hdr->time.tv_sec >= time.tv_sec) {
+			time.tv_sec = hdr->time.tv_sec;
+			cxt->dmesg_write_cnt = (i + 1) % cxt->dmesg_max_cnt;
+		}
+
+		if (hdr->reason == KMSG_DUMP_OOPS)
+			cxt->oops_counter =
+				max(cxt->oops_counter, hdr->counter);
+		else
+			cxt->panic_counter =
+				max(cxt->panic_counter, hdr->counter);
+
+		if (!atomic_read(&buf->datalen)) {
+			pr_debug("found erased zone: %s: id %ld, off %lu, size %zu, datalen %d\n",
+					zone->name, i, zone->off,
+					zone->buffer_size,
+					atomic_read(&buf->datalen));
+			continue;
+		}
+
+		if (!is_on_panic())
+			zone->should_recover = true;
+		pr_debug("found nice zone: %s: id %ld, off %lu, size %zu, datalen %d\n",
+				zone->name, i, zone->off,
+				zone->buffer_size, atomic_read(&buf->datalen));
+	}
+
+	return 0;
+}
+
+static int blkz_recover_dmesg(struct blkz_context *cxt)
+{
+	int ret;
+
+	if (!cxt->dbzs)
+		return 0;
+
+	ret = blkz_recover_dmesg_meta(cxt);
+	if (ret)
+		goto recover_fail;
+
+	ret = blkz_recover_dmesg_data(cxt);
+	if (ret)
+		goto recover_fail;
+
+	return 0;
+recover_fail:
+	pr_debug("recover dmesg failed\n");
+	return ret;
+}
+
+static inline int blkz_recovery(struct blkz_context *cxt)
+{
+	int ret = -EBUSY;
+
+	if (atomic_read(&cxt->recovery))
+		return 0;
+
+	ret = blkz_recover_dmesg(cxt);
+	if (ret)
+		goto recover_fail;
+
+	atomic_set(&cxt->recovery, 1);
+	pr_debug("recover end!\n");
+	return 0;
+
+recover_fail:
+	pr_debug("recovery failed, handle buffer\n");
+	return ret;
+}
+
+static int blkz_pstore_open(struct pstore_info *psi)
+{
+	struct blkz_context *cxt = psi->data;
+
+	cxt->dmesg_read_cnt = 0;
+	return 0;
+}
+
+static inline bool blkz_ok(struct blkz_zone *zone)
+{
+	if (!zone || !zone->buffer || !buffer_datalen(zone))
+		return false;
+	return true;
+}
+
+static int blkz_pstore_erase(struct pstore_record *record)
+{
+	struct blkz_context *cxt = record->psi->data;
+	struct blkz_zone *zone = NULL;
+
+	if (record->type == PSTORE_TYPE_DMESG)
+		zone = cxt->dbzs[record->id];
+	if (!blkz_ok(zone))
+		return 0;
+
+	atomic_set(&zone->buffer->datalen, 0);
+	return blkz_zone_write(zone, FLUSH_META, NULL, 0, 0);
+}
+
+static void blkz_write_kmsg_hdr(struct blkz_zone *zone,
+		struct pstore_record *record)
+{
+	struct blkz_context *cxt = record->psi->data;
+	struct blkz_buffer *buffer = zone->buffer;
+	struct blkz_dmesg_header *hdr =
+		(struct blkz_dmesg_header *)buffer->data;
+
+	hdr->magic = DMESG_HEADER_MAGIC;
+	hdr->compressed = record->compressed;
+	hdr->time.tv_sec = record->time.tv_sec;
+	hdr->time.tv_nsec = record->time.tv_nsec;
+	hdr->reason = record->reason;
+	if (hdr->reason == KMSG_DUMP_OOPS)
+		hdr->counter = ++cxt->oops_counter;
+	else
+		hdr->counter = ++cxt->panic_counter;
+}
+
+static int notrace blkz_dmesg_write(struct blkz_context *cxt,
+		struct pstore_record *record)
+{
+	struct blkz_info *info = cxt->bzinfo;
+	struct blkz_zone *zone;
+	size_t size, hlen;
+
+	/*
+	 * Out of the various dmesg dump types, pstore/blk is currently designed
+	 * to only store crash logs, rather than storing general kernel logs.
+	 */
+	if (record->reason != KMSG_DUMP_OOPS &&
+			record->reason != KMSG_DUMP_PANIC)
+		return -EINVAL;
+
+	/* Skip Oopes when configured to do so. */
+	if (record->reason == KMSG_DUMP_OOPS && !info->dump_oops)
+		return -EINVAL;
+
+	/*
+	 * Explicitly only take the first part of any new crash.
+	 * If our buffer is larger than kmsg_bytes, this can never happen,
+	 * and if our buffer is smaller than kmsg_bytes, we don't want the
+	 * report split across multiple records.
+	 */
+	if (record->part != 1)
+		return -ENOSPC;
+
+	if (!cxt->dbzs)
+		return -ENOSPC;
+
+	zone = cxt->dbzs[cxt->dmesg_write_cnt];
+	if (!zone)
+		return -ENOSPC;
+
+	blkz_write_kmsg_hdr(zone, record);
+	hlen = sizeof(struct blkz_dmesg_header);
+	size = record->size;
+	if (size + hlen > zone->buffer_size)
+		size = zone->buffer_size - hlen;
+	blkz_zone_write(zone, FLUSH_ALL, record->buf, size, hlen);
+
+	pr_debug("write %s to zone id %d\n", zone->name, cxt->dmesg_write_cnt);
+	cxt->dmesg_write_cnt = (cxt->dmesg_write_cnt + 1) % cxt->dmesg_max_cnt;
+	return 0;
+}
+
+static int notrace blkz_pstore_write(struct pstore_record *record)
+{
+	struct blkz_context *cxt = record->psi->data;
+
+	if (record->type == PSTORE_TYPE_DMESG &&
+			record->reason == KMSG_DUMP_PANIC)
+		atomic_set(&cxt->on_panic, 1);
+
+	/*
+	 * before write, we must recover from storage.
+	 * if recover failed, handle buffer
+	 */
+	blkz_recovery(cxt);
+
+	switch (record->type) {
+	case PSTORE_TYPE_DMESG:
+		return blkz_dmesg_write(cxt, record);
+	default:
+		return -EINVAL;
+	}
+}
+
+#define READ_NEXT_ZONE ((ssize_t)(-1024))
+static struct blkz_zone *blkz_read_next_zone(struct blkz_context *cxt)
+{
+	struct blkz_zone *zone = NULL;
+
+	while (cxt->dmesg_read_cnt < cxt->dmesg_max_cnt) {
+		zone = cxt->dbzs[cxt->dmesg_read_cnt++];
+		if (blkz_ok(zone))
+			return zone;
+	}
+
+	return NULL;
+}
+
+static int blkz_read_dmesg_hdr(struct blkz_zone *zone,
+		struct pstore_record *record)
+{
+	struct blkz_buffer *buffer = zone->buffer;
+	struct blkz_dmesg_header *hdr =
+		(struct blkz_dmesg_header *)buffer->data;
+
+	if (hdr->magic != DMESG_HEADER_MAGIC)
+		return -EINVAL;
+	record->compressed = hdr->compressed;
+	record->time.tv_sec = hdr->time.tv_sec;
+	record->time.tv_nsec = hdr->time.tv_nsec;
+	record->reason = hdr->reason;
+	record->count = hdr->counter;
+	return 0;
+}
+
+static ssize_t blkz_dmesg_read(struct blkz_zone *zone,
+		struct pstore_record *record)
+{
+	size_t size, hlen = 0;
+
+	size = buffer_datalen(zone);
+	/* Clear and skip this DMESG record if it has no valid header */
+	if (blkz_read_dmesg_hdr(zone, record)) {
+		atomic_set(&zone->buffer->datalen, 0);
+		atomic_set(&zone->dirty, 0);
+		return READ_NEXT_ZONE;
+	}
+	size -= sizeof(struct blkz_dmesg_header);
+
+	if (!record->compressed) {
+		char *buf = kasprintf(GFP_KERNEL,
+				"%s: Total %d times\n",
+				record->reason == KMSG_DUMP_OOPS ? "Oops" :
+				"Panic", record->count);
+		hlen = strlen(buf);
+		record->buf = krealloc(buf, hlen + size, GFP_KERNEL);
+		if (!record->buf) {
+			kfree(buf);
+			return -ENOMEM;
+		}
+	} else {
+		record->buf = kmalloc(size, GFP_KERNEL);
+		if (!record->buf)
+			return -ENOMEM;
+	}
+
+	if (unlikely(blkz_zone_read(zone, record->buf + hlen, size,
+				sizeof(struct blkz_dmesg_header)) < 0)) {
+		kfree(record->buf);
+		return READ_NEXT_ZONE;
+	}
+
+	return size + hlen;
+}
+
+static ssize_t blkz_pstore_read(struct pstore_record *record)
+{
+	struct blkz_context *cxt = record->psi->data;
+	ssize_t (*blkz_read)(struct blkz_zone *zone,
+			struct pstore_record *record);
+	struct blkz_zone *zone;
+	ssize_t ret;
+
+	/*
+	 * before read, we must recover from storage.
+	 * if recover failed, handle buffer
+	 */
+	blkz_recovery(cxt);
+
+next_zone:
+	zone = blkz_read_next_zone(cxt);
+	if (!zone)
+		return 0;
+
+	record->type = zone->type;
+	switch (record->type) {
+	case PSTORE_TYPE_DMESG:
+		blkz_read = blkz_dmesg_read;
+		record->id = cxt->dmesg_read_cnt - 1;
+		break;
+	default:
+		goto next_zone;
+	}
+
+	ret = blkz_read(zone, record);
+	if (ret == READ_NEXT_ZONE)
+		goto next_zone;
+	return ret;
+}
+
+static struct blkz_context blkz_cxt = {
+	.bzinfo_lock = __SPIN_LOCK_UNLOCKED(blkz_cxt.bzinfo_lock),
+	.recovery = ATOMIC_INIT(0),
+	.on_panic = ATOMIC_INIT(0),
+	.pstore = {
+		.owner = THIS_MODULE,
+		.name = MODNAME,
+		.open = blkz_pstore_open,
+		.read = blkz_pstore_read,
+		.write = blkz_pstore_write,
+		.erase = blkz_pstore_erase,
+	},
+};
+
+static long long blkz_blkdev_size(const char *path)
+{
+	long long size;
+	struct file *filp;
+	struct inode *inode;
+	struct hd_struct *part;
+
+	filp = filp_open(path, O_RDONLY, 0);
+	if (IS_ERR(filp))
+		return PTR_ERR(filp);
+	inode = filp->f_inode;
+	if (!S_ISBLK(inode->i_mode))
+		return -ENOTBLK;
+	part = inode->i_bdev->bd_part;
+	size = (long long)part_nr_sects_read(part) * SECTOR_SIZE;
+	filp_close(filp, NULL);
+
+	return size;
+}
+
+/**
+ * blkz_create_dev: create block device to PSTORE_BLKDEV
+ *
+ * It uses name_to_dev_t to get dev_t, so it accpet the following variants:
+ *	1) <hex_major><hex_minor> device number in hexadecimal represents itself
+ *	   no leading 0x, for example b302.
+ *	2) /dev/<disk_name> represents the device number of disk
+ *	3) /dev/<disk_name><decimal> represents the device number
+ *	   of partition - device number of disk plus the partition number
+ *	4) /dev/<disk_name>p<decimal> - same as the above, that form is
+ *	   used when disk name of partitioned disk ends on a digit.
+ *	5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
+ *	   unique id of a partition if the partition table provides it.
+ *	   The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
+ *	   partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
+ *	   filled hex representation of the 32-bit "NT disk signature", and PP
+ *	   is a zero-filled hex representation of the 1-based partition number.
+ *	6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation to
+ *	   a partition with a known unique id.
+ *	7) <major>:<minor> major and minor number of the device separated by
+ *	   a colon.
+ */
+static int blkz_create_dev(const char *bdev)
+{
+	int err;
+	dev_t devt;
+	struct path path;
+	struct dentry *dentry;
+
+	if (!bdev)
+		return -EINVAL;
+
+	devt = name_to_dev_t(bdev);
+	if (!devt) {
+		pr_err("not found dev_t from %s\n", bdev);
+		return -ENODEV;
+	}
+
+	dentry = kern_path_create(AT_FDCWD, PSTORE_BLKDEV, &path, 0);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+	err = vfs_mknod(path.dentry->d_inode, dentry, S_IFBLK | 0600, devt);
+	if (err < 0)
+		pr_err("failed to create %s: %d\n", PSTORE_BLKDEV, err);
+	done_path_create(&path, dentry);
+	return err;
+}
+
+static ssize_t blkz_default_general_read(char *buf, size_t bytes, loff_t pos)
+{
+	struct blkz_context *cxt = &blkz_cxt;
+	struct file *filp;
+	ssize_t ret;
+
+	if (!cxt->bzinfo->blkdev)
+		return -ENODEV;
+
+	filp = filp_open(PSTORE_BLKDEV, O_RDONLY, 0);
+	if (filp == ERR_PTR(-ENOENT) && !blkz_create_dev(cxt->bzinfo->blkdev))
+		filp = filp_open(PSTORE_BLKDEV, O_RDONLY, 0);
+	if (IS_ERR(filp)) {
+		pr_debug("open %s failed, maybe unready\n", PSTORE_BLKDEV);
+		return -EACCES;
+	}
+	ret = kernel_read(filp, buf, bytes, &pos);
+	filp_close(filp, NULL);
+
+	return ret;
+}
+
+static ssize_t blkz_default_general_write(const char *buf, size_t bytes,
+		loff_t pos)
+{
+	struct blkz_context *cxt = &blkz_cxt;
+	struct file *filp;
+	ssize_t ret;
+
+	if (!cxt->bzinfo->blkdev)
+		return -ENODEV;
+
+	filp = filp_open(PSTORE_BLKDEV, O_WRONLY, 0);
+	if (filp == ERR_PTR(-ENOENT) && !blkz_create_dev(cxt->bzinfo->blkdev))
+		filp = filp_open(PSTORE_BLKDEV, O_WRONLY, 0);
+	if (IS_ERR(filp)) {
+		pr_debug("open %s failed, maybe unready\n", PSTORE_BLKDEV);
+		return -EACCES;
+	}
+	ret = kernel_write(filp, buf, bytes, &pos);
+	vfs_fsync(filp, 0);
+	filp_close(filp, NULL);
+
+	return ret;
+}
+
+static struct blkz_zone *blkz_init_zone(enum pstore_type_id type,
+		unsigned long *off, size_t size)
+{
+	struct blkz_info *info = blkz_cxt.bzinfo;
+	struct blkz_zone *zone;
+	const char *name = pstore_type_to_name(type);
+
+	if (!size)
+		return NULL;
+
+	if (*off + size > info->total_size) {
+		pr_err("no room for %s (0x%zx@0x%lx over 0x%lx)\n",
+			name, size, *off, info->total_size);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	zone = kzalloc(sizeof(struct blkz_zone), GFP_KERNEL);
+	if (!zone)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * NOTE: allocate buffer for blk zones for two reasons:
+	 * 1. It can temporarily hold the data before
+	 *    blkz_default_general_read/write are useable.
+	 * 2. It makes pstore usable even if no persistent storage. Most
+	 *    events of pstore except panic are suitable!!
+	 */
+	zone->buffer = kmalloc(size, GFP_KERNEL);
+	if (!zone->buffer) {
+		kfree(zone);
+		return ERR_PTR(-ENOMEM);
+	}
+	memset(zone->buffer, 0xFF, size);
+	zone->off = *off;
+	zone->name = name;
+	zone->type = type;
+	zone->buffer_size = size - sizeof(struct blkz_buffer);
+	zone->buffer->sig = type ^ BLK_SIG;
+	atomic_set(&zone->dirty, 0);
+	atomic_set(&zone->buffer->datalen, 0);
+
+	*off += size;
+
+	pr_debug("blkzone %s: off 0x%lx, %zu header, %zu data\n", zone->name,
+			zone->off, sizeof(*zone->buffer), zone->buffer_size);
+	return zone;
+}
+
+static struct blkz_zone **blkz_init_zones(enum pstore_type_id type,
+	unsigned long *off, size_t total_size, ssize_t record_size,
+	unsigned int *cnt)
+{
+	struct blkz_info *info = blkz_cxt.bzinfo;
+	struct blkz_zone **zones, *zone;
+	const char *name = pstore_type_to_name(type);
+	int c, i;
+
+	if (!total_size || !record_size)
+		return NULL;
+
+	if (*off + total_size > info->total_size) {
+		pr_err("no room for zones %s (0x%zx@0x%lx over 0x%lx)\n",
+			name, total_size, *off, info->total_size);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	c = total_size / record_size;
+	zones = kcalloc(c, sizeof(*zones), GFP_KERNEL);
+	if (!zones) {
+		pr_err("allocate for zones %s failed\n", name);
+		return ERR_PTR(-ENOMEM);
+	}
+	memset(zones, 0, c * sizeof(*zones));
+
+	for (i = 0; i < c; i++) {
+		zone = blkz_init_zone(type, off, record_size);
+		if (!zone || IS_ERR(zone)) {
+			pr_err("initialize zones %s failed\n", name);
+			while (--i >= 0)
+				kfree(zones[i]);
+			kfree(zones);
+			return (void *)zone;
+		}
+		zones[i] = zone;
+	}
+
+	*cnt = c;
+	return zones;
+}
+
+static void blkz_free_zone(struct blkz_zone **blkzone)
+{
+	struct blkz_zone *zone = *blkzone;
+
+	if (!zone)
+		return;
+
+	kfree(zone->buffer);
+	kfree(zone);
+	*blkzone = NULL;
+}
+
+static void blkz_free_zones(struct blkz_zone ***blkzones, unsigned int *cnt)
+{
+	struct blkz_zone **zones = *blkzones;
+
+	while (*cnt > 0) {
+		blkz_free_zone(&zones[*cnt]);
+		(*cnt)--;
+	}
+	kfree(zones);
+	*blkzones = NULL;
+}
+
+static int blkz_cut_zones(struct blkz_context *cxt)
+{
+	struct blkz_info *info = cxt->bzinfo;
+	unsigned long off = 0;
+	int err;
+	size_t size;
+
+	size = info->total_size;
+	cxt->dbzs = blkz_init_zones(PSTORE_TYPE_DMESG, &off, size,
+			info->dmesg_size, &cxt->dmesg_max_cnt);
+	if (IS_ERR(cxt->dbzs)) {
+		err = PTR_ERR(cxt->dbzs);
+		goto fail_out;
+	}
+
+	return 0;
+fail_out:
+	return err;
+}
+
+int blkz_register(struct blkz_info *info)
+{
+	int err = -EINVAL;
+	struct blkz_context *cxt = &blkz_cxt;
+	struct module *owner = info->owner;
+
+	if (info->blkdev && !blkz_create_dev(info->blkdev)) {
+		long long size;
+
+		size = blkz_blkdev_size(PSTORE_BLKDEV);
+		if (size > 0 && (!info->total_size || info->total_size > size)) {
+			info->total_size = (unsigned long)size;
+			pr_info("total size %ld from block device %s\n",
+					info->total_size, info->blkdev);
+		}
+	}
+
+	if (!info->total_size || !info->dmesg_size) {
+		pr_warn("The total size and the dmesg size must be non-zero\n");
+		return -EINVAL;
+	}
+
+	if (info->total_size < 4096) {
+		pr_err("total size must be over 4096 bytes\n");
+		return -EINVAL;
+	}
+
+#define check_size(name, size) {					\
+		if (info->name & (size - 1)) {				\
+			pr_err(#name " must be a multiple of %d\n",	\
+					(size));			\
+			return -EINVAL;					\
+		}							\
+	}
+
+	check_size(total_size, 4096);
+	check_size(dmesg_size, SECTOR_SIZE);
+
+#undef check_size
+
+	if (!info->read)
+		info->read = blkz_default_general_read;
+	if (!info->write)
+		info->write = blkz_default_general_write;
+
+	if (owner && !try_module_get(owner))
+		return -EINVAL;
+
+	spin_lock(&cxt->bzinfo_lock);
+	if (cxt->bzinfo) {
+		pr_warn("blk '%s' already loaded: ignoring '%s'\n",
+				cxt->bzinfo->name, info->name);
+		spin_unlock(&cxt->bzinfo_lock);
+		return -EBUSY;
+	}
+	cxt->bzinfo = info;
+	spin_unlock(&cxt->bzinfo_lock);
+
+	if (blkz_cut_zones(cxt)) {
+		pr_err("cut zones fialed\n");
+		goto fail_out;
+	}
+
+	cxt->pstore.bufsize = cxt->dbzs[0]->buffer_size -
+			sizeof(struct blkz_dmesg_header);
+	cxt->pstore.buf = kzalloc(cxt->pstore.bufsize, GFP_KERNEL);
+	if (!cxt->pstore.buf) {
+		pr_err("cannot allocate pstore crash dump buffer\n");
+		err = -ENOMEM;
+		goto fail_out;
+	}
+	cxt->pstore.data = cxt;
+	cxt->pstore.flags = PSTORE_FLAGS_DMESG;
+
+	pr_info("Registered %s as blkzone backend for %s%s\n", info->name,
+			cxt->dbzs && cxt->bzinfo->dump_oops ? "Oops " : "",
+			cxt->dbzs && cxt->bzinfo->panic_write ? "Panic " : "");
+
+	err = pstore_register(&cxt->pstore);
+	if (err) {
+		pr_err("registering with pstore failed\n");
+		goto free_pstore_buf;
+	}
+
+	module_put(owner);
+	return 0;
+
+free_pstore_buf:
+	kfree(cxt->pstore.buf);
+fail_out:
+	spin_lock(&blkz_cxt.bzinfo_lock);
+	blkz_cxt.bzinfo = NULL;
+	spin_unlock(&blkz_cxt.bzinfo_lock);
+	return err;
+}
+EXPORT_SYMBOL_GPL(blkz_register);
+
+void blkz_unregister(struct blkz_info *info)
+{
+	struct blkz_context *cxt = &blkz_cxt;
+
+	pstore_unregister(&cxt->pstore);
+	kfree(cxt->pstore.buf);
+	cxt->pstore.bufsize = 0;
+
+	spin_lock(&cxt->bzinfo_lock);
+	blkz_cxt.bzinfo = NULL;
+	spin_unlock(&cxt->bzinfo_lock);
+
+	blkz_free_zones(&cxt->dbzs, &cxt->dmesg_max_cnt);
+
+}
+EXPORT_SYMBOL_GPL(blkz_unregister);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("liaoweixiong <liaoweixiong@allwinnertech.com>");
+MODULE_DESCRIPTION("Block device Oops/Panic logger");
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
new file mode 100644
index 0000000..4f239f0
--- /dev/null
+++ b/include/linux/pstore_blk.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PSTORE_BLK_H_
+#define __PSTORE_BLK_H_
+
+#include <linux/types.h>
+#include <linux/blkdev.h>
+
+#ifndef SECTOR_SIZE
+#define SECTOR_SIZE 512
+#endif
+
+/**
+ * struct blkz_info - backend blkzone driver structure
+ *
+ * @owner:
+ *	module which is responsible for this backend driver
+ * @name:
+ *	name of the backend driver
+ * @blkdev:
+ *	The block device to use. Most of the time, it is a partition of block
+ *	device. It's ok to keep it as NULL if you passing @read and @write
+ *	in blkz_info as @blkdev is used by blkz_default_general_read/write.
+ *	If both of @blkdev, @read and @write are NULL, no block device is
+ *	effective and the data will be saved in ddr buffer.
+ *	It accept the following variants:
+ *	1) <hex_major><hex_minor> device number in hexadecimal represents itself
+ *	   no leading 0x, for example b302.
+ *	2) /dev/<disk_name> represents the device number of disk
+ *	3) /dev/<disk_name><decimal> represents the device number
+ *	   of partition - device number of disk plus the partition number
+ *	4) /dev/<disk_name>p<decimal> - same as the above, that form is
+ *	   used when disk name of partitioned disk ends on a digit.
+ *	5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
+ *	   unique id of a partition if the partition table provides it.
+ *	   The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
+ *	   partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
+ *	   filled hex representation of the 32-bit "NT disk signature", and PP
+ *	   is a zero-filled hex representation of the 1-based partition number.
+ *	6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation to
+ *	   a partition with a known unique id.
+ *	7) <major>:<minor> major and minor number of the device separated by
+ *	   a colon.
+ * @total_size:
+ *	the total size in bytes pstore/blk can use. It must be less than or
+ *	equal to size of block device if @blkdev valid. If @total_size is zero
+ *	with @blkdev, @total_size will be set to equal to size of @blkdev.
+ * @dmesg_size:
+ *	the size of each zones for dmesg (oops & panic).
+ * @dump_oops:
+ *	dump oops and panic log or only panic.
+ * @read:
+ *	the general (not panic) read operation. If NULL, pstore/blk
+ *	replaced as blkz_default_general_read. See also @blkdev
+ * @write:
+ *	the general (not panic) write operation. If NULL, pstore/blk
+ *	replaced as blkz_default_general_write. See also @blkdev
+ * @panic_read:
+ *	the read operation only used for panic.
+ * @panic_write:
+ *	the write operation only used for panic.
+ */
+struct blkz_info {
+	struct module *owner;
+	const char *name;
+
+	const char *blkdev;
+	unsigned long total_size;
+	unsigned long dmesg_size;
+	int dump_oops;
+	ssize_t (*read)(char *buf, size_t bytes, loff_t pos);
+	ssize_t (*write)(const char *buf, size_t bytes, loff_t pos);
+	ssize_t (*panic_read)(char *buf, size_t bytes, loff_t pos);
+	ssize_t (*panic_write)(const char *buf, size_t bytes, loff_t pos);
+};
+
+extern int blkz_register(struct blkz_info *info);
+extern void blkz_unregister(struct blkz_info *info);
+
+#endif
-- 
1.9.1

