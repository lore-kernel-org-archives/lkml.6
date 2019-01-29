Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE3BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EEF20880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763086;
	bh=K9CHrK75K+vu+zwWC9e/HtWa4ETNyBuTIXpXOhDCGwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dx9CooMIrovQ0QGnLZrtOTuLSiL68Il7zKnmKvPFJmUtOmd6voAPw+aceapDnVUQb
	 q1CN5w2x322p4352PlQ1owkqOp9f0yHk6RwRKcLPD28VnMd7V4uzuUYq5TCMIhaDt5
	 vk7wrTKS2s2V0JMoYhXiVcD+NVcXshT/ETs7wkqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfA2L6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:58:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731329AbfA2Lsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:48:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 009FD2083B;
        Tue, 29 Jan 2019 11:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762509;
        bh=K9CHrK75K+vu+zwWC9e/HtWa4ETNyBuTIXpXOhDCGwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZuVExmG1DdSOLkublhD8No4sOR/EFRjzfLVUs+Ztrt7QHA2LBOGc/iEUsH+BuhMhq
         lGChR0S5Mbc3IebfoDJs/T3tlawo11HVp1Imv9nyFiPK2Z/n6xbDT7/qjDm0TJFNF0
         QaS2H+U8QkwzuKEBiQNWepHIqZ9nibC9ew3bokf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 29/68] Drivers: hv: vmbus: Check for ring when getting debug info
Date:   Tue, 29 Jan 2019 12:35:51 +0100
Message-Id: <20190129113134.038996767@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit ba50bf1ce9a51fc97db58b96d01306aa70bc3979 upstream.

fc96df16a1ce is good and can already fix the "return stack garbage" issue,
but let's also improve hv_ringbuffer_get_debuginfo(), which would silently
return stack garbage, if people forget to check channel->state or
ring_info->ring_buffer, when using the function in the future.

Having an error check in the function would eliminate the potential risk.

Add a Fixes tag to indicate the patch depdendency.

Fixes: fc96df16a1ce ("Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened channels")
Cc: stable@vger.kernel.org
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hv/ring_buffer.c |   29 +++++++-------
 drivers/hv/vmbus_drv.c   |   91 +++++++++++++++++++++++++++++++----------------
 include/linux/hyperv.h   |    5 +-
 3 files changed, 78 insertions(+), 47 deletions(-)

--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -141,26 +141,25 @@ static u32 hv_copyto_ringbuffer(
 }
 
 /* Get various debug metrics for the specified ring buffer. */
-void hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info *ring_info,
-				 struct hv_ring_buffer_debug_info *debug_info)
+int hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info *ring_info,
+				struct hv_ring_buffer_debug_info *debug_info)
 {
 	u32 bytes_avail_towrite;
 	u32 bytes_avail_toread;
 
-	if (ring_info->ring_buffer) {
-		hv_get_ringbuffer_availbytes(ring_info,
-					&bytes_avail_toread,
-					&bytes_avail_towrite);
+	if (!ring_info->ring_buffer)
+		return -EINVAL;
 
-		debug_info->bytes_avail_toread = bytes_avail_toread;
-		debug_info->bytes_avail_towrite = bytes_avail_towrite;
-		debug_info->current_read_index =
-			ring_info->ring_buffer->read_index;
-		debug_info->current_write_index =
-			ring_info->ring_buffer->write_index;
-		debug_info->current_interrupt_mask =
-			ring_info->ring_buffer->interrupt_mask;
-	}
+	hv_get_ringbuffer_availbytes(ring_info,
+				     &bytes_avail_toread,
+				     &bytes_avail_towrite);
+	debug_info->bytes_avail_toread = bytes_avail_toread;
+	debug_info->bytes_avail_towrite = bytes_avail_towrite;
+	debug_info->current_read_index = ring_info->ring_buffer->read_index;
+	debug_info->current_write_index = ring_info->ring_buffer->write_index;
+	debug_info->current_interrupt_mask
+		= ring_info->ring_buffer->interrupt_mask;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(hv_ringbuffer_get_debuginfo);
 
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -297,12 +297,16 @@ static ssize_t out_intr_mask_show(struct
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", outbound.current_interrupt_mask);
 }
 static DEVICE_ATTR_RO(out_intr_mask);
@@ -312,12 +316,15 @@ static ssize_t out_read_index_show(struc
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
 	return sprintf(buf, "%d\n", outbound.current_read_index);
 }
 static DEVICE_ATTR_RO(out_read_index);
@@ -328,12 +335,15 @@ static ssize_t out_write_index_show(stru
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
 	return sprintf(buf, "%d\n", outbound.current_write_index);
 }
 static DEVICE_ATTR_RO(out_write_index);
@@ -344,12 +354,15 @@ static ssize_t out_read_bytes_avail_show
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
 	return sprintf(buf, "%d\n", outbound.bytes_avail_toread);
 }
 static DEVICE_ATTR_RO(out_read_bytes_avail);
@@ -360,12 +373,15 @@ static ssize_t out_write_bytes_avail_sho
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
 	return sprintf(buf, "%d\n", outbound.bytes_avail_towrite);
 }
 static DEVICE_ATTR_RO(out_write_bytes_avail);
@@ -375,12 +391,15 @@ static ssize_t in_intr_mask_show(struct
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.current_interrupt_mask);
 }
 static DEVICE_ATTR_RO(in_intr_mask);
@@ -390,12 +409,15 @@ static ssize_t in_read_index_show(struct
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.current_read_index);
 }
 static DEVICE_ATTR_RO(in_read_index);
@@ -405,12 +427,15 @@ static ssize_t in_write_index_show(struc
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.current_write_index);
 }
 static DEVICE_ATTR_RO(in_write_index);
@@ -421,12 +446,15 @@ static ssize_t in_read_bytes_avail_show(
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.bytes_avail_toread);
 }
 static DEVICE_ATTR_RO(in_read_bytes_avail);
@@ -437,12 +465,15 @@ static ssize_t in_write_bytes_avail_show
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.bytes_avail_towrite);
 }
 static DEVICE_ATTR_RO(in_write_bytes_avail);
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1130,8 +1130,9 @@ struct hv_ring_buffer_debug_info {
 	u32 bytes_avail_towrite;
 };
 
-void hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info *ring_info,
-			    struct hv_ring_buffer_debug_info *debug_info);
+
+int hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info *ring_info,
+				struct hv_ring_buffer_debug_info *debug_info);
 
 /* Vmbus interface */
 #define vmbus_driver_register(driver)	\


