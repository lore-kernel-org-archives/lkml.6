Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755404AbeEAJNX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:13:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44330 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755068AbeEAJML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:12:11 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 25/27] coresight: etr_buf: Add helper for padding an area of trace data
Date: Tue,  1 May 2018 10:10:55 +0100
Message-Id: <1525165857-11096-26-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a helper to insert barrier packets for a given
size (aligned to packet size) at given offset in an etr_buf. This
will be used later for perf mode when we try to start in the
middle of an SG buffer.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 53 ++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 7551272..8159e84 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1083,18 +1083,59 @@ static ssize_t tmc_etr_buf_get_data(struct etr_buf *etr_buf,
 	return etr_buf->ops->get_data(etr_buf, (u64)offset, len, bufpp);
 }
 
+/*
+ * tmc_etr_buf_insert_barrier_packets : Insert barrier packets at @offset upto
+ * @size of bytes in the given buffer. @size should be aligned to the barrier
+ * packet size.
+ *
+ * Returns the new @offset after filling the barriers on success. Otherwise
+ * returns error.
+ */
 static inline s64
-tmc_etr_buf_insert_barrier_packet(struct etr_buf *etr_buf, u64 offset)
+tmc_etr_buf_insert_barrier_packets(struct etr_buf *etr_buf,
+				   u64 offset, u64 size)
 {
 	ssize_t len;
 	char *bufp;
 
-	len = tmc_etr_buf_get_data(etr_buf, offset,
-				   CORESIGHT_BARRIER_PKT_SIZE, &bufp);
-	if (WARN_ON(len <= CORESIGHT_BARRIER_PKT_SIZE))
+	if (size < CORESIGHT_BARRIER_PKT_SIZE)
 		return -EINVAL;
-	coresight_insert_barrier_packet(bufp);
-	return offset + CORESIGHT_BARRIER_PKT_SIZE;
+	/*
+	 * Normally the size should be aligned to the frame size
+	 * of the ETR. Even if it isn't, the decoder looks for a
+	 * barrier packet at a frame size aligned offset. So align
+	 * the buffer to frame size first and then fill barrier
+	 * packets.
+	 */
+	do {
+		len = tmc_etr_buf_get_data(etr_buf, offset, size, &bufp);
+		if (WARN_ON(len <= 0))
+			return -EINVAL;
+		/*
+		 * We are guaranteed that @bufp will point to a linear range
+		 * of @len bytes, where @len <= @size.
+		 */
+		size -= len;
+		offset += len;
+		while (len >= CORESIGHT_BARRIER_PKT_SIZE) {
+			coresight_insert_barrier_packet(bufp);
+			bufp += CORESIGHT_BARRIER_PKT_SIZE;
+			len -= CORESIGHT_BARRIER_PKT_SIZE;
+		}
+
+		/* If we reached the end of the buffer, wrap around */
+		if (offset == etr_buf->size)
+			offset -= etr_buf->size;
+	} while (size);
+
+	return offset;
+}
+
+static inline s64
+tmc_etr_buf_insert_barrier_packet(struct etr_buf *etr_buf, u64 offset)
+{
+	return tmc_etr_buf_insert_barrier_packets(etr_buf, offset,
+					  CORESIGHT_BARRIER_PKT_SIZE);
 }
 
 /*
-- 
2.7.4
