Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B844C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100D0206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100D0206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeJETl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:41:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:8943 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeJETl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:41:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 05:43:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,344,1534834800"; 
   d="scan'208";a="97687789"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Oct 2018 05:43:21 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 05/16] stm class: Add a helper for writing data packets
Date:   Fri,  5 Oct 2018 15:42:55 +0300
Message-Id: <20181005124306.54870-6-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005124306.54870-1-alexander.shishkin@linux.intel.com>
References: <20181005124306.54870-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to write a sequence of bytes as STP data packets. This
is used by protocol drivers to output their metadata, as well as the
actual data payload.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/stm/core.c | 51 +++++++++++++++++++++++++++---------
 drivers/hwtracing/stm/stm.h  |  3 +++
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 915af2541dcd..b789a5f0688e 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -569,27 +569,52 @@ stm_assign_first_policy(struct stm_device *stm, struct stm_output *output,
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
+	const unsigned char nil = 0;
+	ssize_t sz;
+
+	sz = stm_data_write(data, master, channel, true, buf, count);
+	if (sz > 0)
+		data->packet(data, master, channel, STP_PACKET_FLAG, 0, 0,
+			     &nil);
 
-	return pos;
+	return sz;
 }
 
 static ssize_t stm_char_write(struct file *file, const char __user *buf,
diff --git a/drivers/hwtracing/stm/stm.h b/drivers/hwtracing/stm/stm.h
index ed7f3d07fa47..3569439d53bb 100644
--- a/drivers/hwtracing/stm/stm.h
+++ b/drivers/hwtracing/stm/stm.h
@@ -110,5 +110,8 @@ int stm_lookup_protocol(const char *name,
 			const struct stm_protocol_driver **pdrv,
 			const struct config_item_type **type);
 void stm_put_protocol(const struct stm_protocol_driver *pdrv);
+ssize_t stm_data_write(struct stm_data *data, unsigned int m,
+		       unsigned int c, bool ts_first, const void *buf,
+		       size_t count);
 
 #endif /* _STM_STM_H_ */
-- 
2.19.0

