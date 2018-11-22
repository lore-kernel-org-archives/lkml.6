Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FC6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F76520663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F76520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394556AbeKVVuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:50:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:39305 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387933AbeKVVux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:50:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 03:11:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,265,1539673200"; 
   d="scan'208";a="91290777"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga007.jf.intel.com with ESMTP; 22 Nov 2018 03:11:56 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v2 3/7] mei: hw: add dma ring control block
Date:   Thu, 22 Nov 2018 13:11:38 +0200
Message-Id: <20181122111142.18653-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181122111142.18653-1-tomas.winkler@intel.com>
References: <20181122111142.18653-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA ring control block contains write and read
indices for host and device circular buffers.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/dma-ring.c | 20 ++++++++++++++++++++
 drivers/misc/mei/hbm.c      |  2 ++
 drivers/misc/mei/hw.h       | 23 +++++++++++++++++++++++
 drivers/misc/mei/mei_dev.h  |  1 +
 4 files changed, 46 insertions(+)

diff --git a/drivers/misc/mei/dma-ring.c b/drivers/misc/mei/dma-ring.c
index 56f4c0882a20..b73d5ab54070 100644
--- a/drivers/misc/mei/dma-ring.c
+++ b/drivers/misc/mei/dma-ring.c
@@ -97,3 +97,23 @@ bool mei_dma_ring_is_allocated(struct mei_device *dev)
 {
 	return !!dev->dr_dscr[DMA_DSCR_HOST].vaddr;
 }
+
+static inline
+struct hbm_dma_ring_ctrl *mei_dma_ring_ctrl(struct mei_device *dev)
+{
+	return (struct hbm_dma_ring_ctrl *)dev->dr_dscr[DMA_DSCR_CTRL].vaddr;
+}
+
+/**
+ * mei_dma_ring_reset() - reset the dma control block
+ * @dev: mei device
+ */
+void mei_dma_ring_reset(struct mei_device *dev)
+{
+	struct hbm_dma_ring_ctrl *ctrl = mei_dma_ring_ctrl(dev);
+
+	if (!ctrl)
+		return;
+
+	memset(ctrl, 0, sizeof(*ctrl));
+}
diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index b458c5612245..78c26cebf5d4 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -323,6 +323,8 @@ static int mei_hbm_dma_setup_req(struct mei_device *dev)
 		req.dma_dscr[i].size = dev->dr_dscr[i].size;
 	}
 
+	mei_dma_ring_reset(dev);
+
 	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret) {
 		dev_err(dev->dev, "dma setup request write failed: ret = %d.\n",
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index 65655925791a..4f09bbcdbc2a 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -512,4 +512,27 @@ struct hbm_dma_setup_response {
 	u8 reserved[2];
 } __packed;
 
+/**
+ * struct mei_dma_ring_ctrl - dma ring control block
+ *
+ * @hbuf_wr_idx: host circular buffer write index in slots
+ * @reserved1: reserved for alignment
+ * @hbuf_rd_idx: host circular buffer read index in slots
+ * @reserved2: reserved for alignment
+ * @dbuf_wr_idx: device circular buffer write index in slots
+ * @reserved3: reserved for alignment
+ * @dbuf_rd_idx: device circular buffer read index in slots
+ * @reserved4: reserved for alignment
+ */
+struct hbm_dma_ring_ctrl {
+	u32 hbuf_wr_idx;
+	u32 reserved1;
+	u32 hbuf_rd_idx;
+	u32 reserved2;
+	u32 dbuf_wr_idx;
+	u32 reserved3;
+	u32 dbuf_rd_idx;
+	u32 reserved4;
+} __packed;
+
 #endif
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index a6796e3f712b..033b5eff8e59 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -597,6 +597,7 @@ void mei_cancel_work(struct mei_device *dev);
 int mei_dmam_ring_alloc(struct mei_device *dev);
 void mei_dmam_ring_free(struct mei_device *dev);
 bool mei_dma_ring_is_allocated(struct mei_device *dev);
+void mei_dma_ring_reset(struct mei_device *dev);
 
 /*
  *  MEI interrupt functions prototype
-- 
2.17.2

