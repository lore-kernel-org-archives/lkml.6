Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7425ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4E720846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4E720846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388144AbeGWLXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:23:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:16833 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387872AbeGWLXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:23:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 03:23:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,393,1526367600"; 
   d="scan'208";a="248063993"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2018 03:23:11 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/3] mei: cleanup slots to data conversions
Date:   Mon, 23 Jul 2018 13:21:22 +0300
Message-Id: <20180723102124.27788-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup conversions between slots and data.
Define MEI_SLOT_SIZE instead of using 4 or sizeof(u32) across
the source code.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c  | 2 +-
 drivers/misc/mei/hw-me.c   | 8 ++++----
 drivers/misc/mei/hw-txe.c  | 8 ++++----
 drivers/misc/mei/mei_dev.h | 8 +++++---
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 5a673d09585f..79e200d71652 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1597,7 +1597,7 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 	/* Split the message only if we can write the whole host buffer */
 	} else if ((u32)slots == dev->hbuf_depth) {
 		msg_slots = slots;
-		len = (slots * sizeof(u32)) - sizeof(struct mei_msg_hdr);
+		len = mei_slots2data(slots) - sizeof(struct mei_msg_hdr);
 		mei_hdr.length = len;
 		mei_hdr.msg_complete = 0;
 	} else {
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 5bbea13ab171..016b7c956f18 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -511,7 +511,7 @@ static int mei_me_hbuf_empty_slots(struct mei_device *dev)
  */
 static size_t mei_me_hbuf_max_len(const struct mei_device *dev)
 {
-	return dev->hbuf_depth * sizeof(u32) - sizeof(struct mei_msg_hdr);
+	return mei_slots2data(dev->hbuf_depth) - sizeof(struct mei_msg_hdr);
 }
 
 
@@ -549,7 +549,7 @@ static int mei_me_hbuf_write(struct mei_device *dev,
 
 	mei_me_hcbww_write(dev, *((u32 *) header));
 
-	for (i = 0; i < length / 4; i++)
+	for (i = 0; i < length / MEI_SLOT_SIZE; i++)
 		mei_me_hcbww_write(dev, reg_buf[i]);
 
 	rem = length & 0x3;
@@ -604,11 +604,11 @@ static int mei_me_count_full_read_slots(struct mei_device *dev)
  * Return: always 0
  */
 static int mei_me_read_slots(struct mei_device *dev, unsigned char *buffer,
-		    unsigned long buffer_length)
+			     unsigned long buffer_length)
 {
 	u32 *reg_buf = (u32 *)buffer;
 
-	for (; buffer_length >= sizeof(u32); buffer_length -= sizeof(u32))
+	for (; buffer_length >= MEI_SLOT_SIZE; buffer_length -= MEI_SLOT_SIZE)
 		*reg_buf++ = mei_me_mecbrw_read(dev);
 
 	if (buffer_length > 0) {
diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c
index a5e551ffb2dd..0facd823634e 100644
--- a/drivers/misc/mei/hw-txe.c
+++ b/drivers/misc/mei/hw-txe.c
@@ -682,7 +682,7 @@ static void mei_txe_hw_config(struct mei_device *dev)
 	struct mei_txe_hw *hw = to_txe_hw(dev);
 
 	/* Doesn't change in runtime */
-	dev->hbuf_depth = PAYLOAD_SIZE / 4;
+	dev->hbuf_depth = PAYLOAD_SIZE / MEI_SLOT_SIZE;
 
 	hw->aliveness = mei_txe_aliveness_get(dev);
 	hw->readiness = mei_txe_readiness_get(dev);
@@ -766,7 +766,7 @@ static int mei_txe_write(struct mei_device *dev,
  *
  * @dev: the device structure
  *
- * Return: the PAYLOAD_SIZE - 4
+ * Return: the PAYLOAD_SIZE - header size
  */
 static size_t mei_txe_hbuf_max_len(const struct mei_device *dev)
 {
@@ -797,7 +797,7 @@ static int mei_txe_hbuf_empty_slots(struct mei_device *dev)
 static int mei_txe_count_full_read_slots(struct mei_device *dev)
 {
 	/* read buffers has static size */
-	return  PAYLOAD_SIZE / 4;
+	return  PAYLOAD_SIZE / MEI_SLOT_SIZE;
 }
 
 /**
@@ -839,7 +839,7 @@ static int mei_txe_read(struct mei_device *dev,
 	dev_dbg(dev->dev, "buffer-length = %lu buf[0]0x%08X\n",
 		len, mei_txe_out_data_read(dev, 0));
 
-	for (i = 0; i < len / 4; i++) {
+	for (i = 0; i < len / MEI_SLOT_SIZE; i++) {
 		/* skip header: index starts from 1 */
 		reg = mei_txe_out_data_read(dev, i + 1);
 		dev_dbg(dev->dev, "buf[%d] = 0x%08X\n", i, reg);
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index d522585b71b7..897126dca5d0 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -26,7 +26,9 @@
 #include "hw.h"
 #include "hbm.h"
 
-#define MEI_RD_MSG_BUF_SIZE           (128 * sizeof(u32))
+#define MEI_SLOT_SIZE             sizeof(u32)
+#define MEI_RD_MSG_BUF_SIZE       (128 * MEI_SLOT_SIZE)
+
 
 /*
  * Number of Maximum MEI Clients
@@ -540,7 +542,7 @@ static inline unsigned long mei_secs_to_jiffies(unsigned long sec)
  */
 static inline u32 mei_data2slots(size_t length)
 {
-	return DIV_ROUND_UP(sizeof(struct mei_msg_hdr) + length, 4);
+	return DIV_ROUND_UP(sizeof(struct mei_msg_hdr) + length, MEI_SLOT_SIZE);
 }
 
 /**
@@ -552,7 +554,7 @@ static inline u32 mei_data2slots(size_t length)
  */
 static inline u32 mei_slots2data(int slots)
 {
-	return slots * 4;
+	return slots * MEI_SLOT_SIZE;
 }
 
 /*
-- 
2.14.4

