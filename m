Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174C7C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34F521529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34F521529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387768AbeITS3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:29:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:3374 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387453AbeITS3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:29:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 05:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="87820873"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Sep 2018 05:46:17 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [QUEUED v20180920 05/16] stm class: Add a helper for writing data packets
Date:   Thu, 20 Sep 2018 15:45:42 +0300
Message-Id: <20180920124553.56978-6-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to write a sequence of bytes as STP data packets. This
is used by protocol drivers to output their metadata, as well as the
actual data payload.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/core.c | 50 ++++++++++++++++++++++++++----------
 drivers/hwtracing/stm/stm.h  |  3 +++
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index c869a30661ac..9ed2f06deb47 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -564,27 +564,51 @@ stm_assign_first_policy(struct stm_device *stm, struct stm_output *output,
 	return err;
 }
 
-static ssize_t notrace stm_write(struct stm_data *data, unsigned int master,
-			  unsigned int channel, const char *buf, size_t count)
+/**
+ * stm_data_write() - send the given payload as data packets
+ * @data:	stm driver's data
+ * @m:		STP master
+ * @c:		STP channel
+ * @ts_first:	timestamp the first packet
+ * @buf:	data payload buffer
+ * @count:	data payload size
+ */
+ssize_t notrace stm_data_write(struct stm_data *data, unsigned int m,
+			       unsigned int c, bool ts_first, const void *buf,
+			       size_t count)
 {
-	unsigned int flags = STP_PACKET_TIMESTAMPED;
-	const unsigned char *p = buf, nil = 0;
-	size_t pos;
+	unsigned int flags = ts_first ? STP_PACKET_TIMESTAMPED : 0;
 	ssize_t sz;
+	size_t pos;
 
-	for (pos = 0, p = buf; count > pos; pos += sz, p += sz) {
+	for (pos = 0, sz = 0; pos < count; pos += sz) {
 		sz = min_t(unsigned int, count - pos, 8);
-		sz = data->packet(data, master, channel, STP_PACKET_DATA, flags,
-				  sz, p);
-		flags = 0;
-
-		if (sz < 0)
+		sz = data->packet(data, m, c, STP_PACKET_DATA, flags, sz,
+				  &((u8 *)buf)[pos]);
+		if (sz <= 0)
 			break;
+
+		if (ts_first) {
+			flags = 0;
+			ts_first = false;
+		}
 	}
 
-	data->packet(data, master, channel, STP_PACKET_FLAG, 0, 0, &nil);
+	return sz < 0 ? sz : pos;
+}
+EXPORT_SYMBOL_GPL(stm_data_write);
+
+static ssize_t notrace stm_write(struct stm_data *data, unsigned int master,
+			  unsigned int channel, const char *buf, size_t count)
+{
+	ssize_t sz;
+
+	sz = stm_data_write(data, master, channel, true, buf, count);
+	if (sz > 0)
+		data->packet(data, master, channel, STP_PACKET_FLAG, 0, 0,
+			     buf);
 
-	return pos;
+	return sz;
 }
 
 static ssize_t stm_char_write(struct file *file, const char __user *buf,
diff --git a/drivers/hwtracing/stm/stm.h b/drivers/hwtracing/stm/stm.h
index 921ebd9fd3bd..753d83acb7ae 100644
--- a/drivers/hwtracing/stm/stm.h
+++ b/drivers/hwtracing/stm/stm.h
@@ -111,5 +111,8 @@ int stm_lookup_protocol(const char *name,
 			const struct stm_protocol_driver **pdrv,
 			const struct config_item_type **type);
 void stm_put_protocol(const struct stm_protocol_driver *pdrv);
+ssize_t stm_data_write(struct stm_data *data, unsigned int m,
+		       unsigned int c, bool ts_first, const void *buf,
+		       size_t count);
 
 #endif /* _STM_STM_H_ */
-- 
2.18.0

