Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B66AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39CA208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39CA208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbeGaIQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:16:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:59929 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeGaIQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:16:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 23:37:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,426,1526367600"; 
   d="scan'208";a="61154186"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2018 23:37:25 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 03/12] mei: hbm: introduce dma bit in the message header
Date:   Tue, 31 Jul 2018 09:35:35 +0300
Message-Id: <20180731063544.25540-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180731063544.25540-1-tomas.winkler@intel.com>
References: <20180731063544.25540-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma_ring bit in the mei message header for conveying
that the message data itself are on the dma ring.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/client.c  |  1 +
 drivers/misc/mei/hbm.c     |  1 +
 drivers/misc/mei/hw.h      | 16 ++++++++++++----
 drivers/misc/mei/mei_dev.h |  4 ++--
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 0a9173827461..4ab6251d418e 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1551,6 +1551,7 @@ static void mei_msg_hdr_init(struct mei_msg_hdr *mei_hdr, struct mei_cl_cb *cb)
 	mei_hdr->length = 0;
 	mei_hdr->reserved = 0;
 	mei_hdr->msg_complete = 0;
+	mei_hdr->dma_ring = 0;
 	mei_hdr->internal = cb->internal;
 }
 
diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index 8b3fd9ff6566..b0086c4aefe4 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -145,6 +145,7 @@ static inline void mei_hbm_hdr(struct mei_msg_hdr *hdr, size_t length)
 	hdr->me_addr = 0;
 	hdr->length = length;
 	hdr->msg_complete = 1;
+	hdr->dma_ring = 0;
 	hdr->reserved = 0;
 	hdr->internal = 0;
 }
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index 76fb502e6f71..5fb8844a6db5 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -190,19 +190,27 @@ enum  mei_cl_disconnect_status {
 	MEI_CL_DISCONN_SUCCESS = MEI_HBMS_SUCCESS
 };
 
-/*
- *  MEI BUS Interface Section
+/**
+ * struct mei_msg_hdr - MEI BUS Interface Section
+ *
+ * @me_addr: device address
+ * @host_addr: host address
+ * @length: message length
+ * @reserved: reserved
+ * @dma_ring: message is on dma ring
+ * @internal: message is internal
+ * @msg_complete: last packet of the message
  */
 struct mei_msg_hdr {
 	u32 me_addr:8;
 	u32 host_addr:8;
 	u32 length:9;
-	u32 reserved:5;
+	u32 reserved:4;
+	u32 dma_ring:1;
 	u32 internal:1;
 	u32 msg_complete:1;
 } __packed;
 
-
 struct mei_bus_message {
 	u8 hbm_cmd;
 	u8 data[0];
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 06fb5fc67fe9..975afaa38a66 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -714,10 +714,10 @@ static inline void mei_dbgfs_deregister(struct mei_device *dev) {}
 int mei_register(struct mei_device *dev, struct device *parent);
 void mei_deregister(struct mei_device *dev);
 
-#define MEI_HDR_FMT "hdr:host=%02d me=%02d len=%d internal=%1d comp=%1d"
+#define MEI_HDR_FMT "hdr:host=%02d me=%02d len=%d dma=%1d internal=%1d comp=%1d"
 #define MEI_HDR_PRM(hdr)                  \
 	(hdr)->host_addr, (hdr)->me_addr, \
-	(hdr)->length, (hdr)->internal, (hdr)->msg_complete
+	(hdr)->length, (hdr)->dma_ring, (hdr)->internal, (hdr)->msg_complete
 
 ssize_t mei_fw_status2str(struct mei_fw_status *fw_sts, char *buf, size_t len);
 /**
-- 
2.14.4

