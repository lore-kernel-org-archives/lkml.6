Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDD8C46463
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90658208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90658208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbeGaIQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:16:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:59929 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeGaIQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:16:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 23:37:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,426,1526367600"; 
   d="scan'208";a="61154173"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2018 23:37:23 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 02/12] mei: hbm: define dma ring setup protocol
Date:   Tue, 31 Jul 2018 09:35:34 +0300
Message-Id: <20180731063544.25540-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180731063544.25540-1-tomas.winkler@intel.com>
References: <20180731063544.25540-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The protocol defines how to setup an I/O ring on top of host
memory to utilize the device DMA engine for faster transport.

Three memory buffers are allocated.
A Host circular buffer for from the Host to Device communication.
A Device circular buffer for from Device to the Host communication.
And finally a Control block where the pointers for the both
circular buffers are managed.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/hw.h | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index 3b325d955fbe..76fb502e6f71 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -122,6 +122,9 @@
 #define MEI_HBM_NOTIFY_RES_CMD              0x90
 #define MEI_HBM_NOTIFICATION_CMD            0x11
 
+#define MEI_HBM_DMA_SETUP_REQ_CMD           0x12
+#define MEI_HBM_DMA_SETUP_RES_CMD           0x92
+
 /*
  * MEI Stop Reason
  * used by hbm_host_stop_request.reason
@@ -449,4 +452,50 @@ struct hbm_notification {
 	u8 reserved[1];
 } __packed;
 
+/**
+ * struct hbm_dma_mem_dscr - dma ring
+ *
+ * @addr_hi: the high 32bits of 64 bit address
+ * @addr_lo: the low  32bits of 64 bit address
+ * @size   : size in bytes (must be power of 2)
+ */
+struct hbm_dma_mem_dscr {
+	u32 addr_hi;
+	u32 addr_lo;
+	u32 size;
+} __packed;
+
+enum {
+	DMA_DSCR_HOST = 0,
+	DMA_DSCR_DEVICE = 1,
+	DMA_DSCR_CTRL = 2,
+	DMA_DSCR_NUM,
+};
+
+/**
+ * struct hbm_dma_setup_request - dma setup request
+ *
+ * @hbm_cmd: bus message command header
+ * @reserved: reserved for alignment
+ * @dma_dscr: dma descriptor for HOST, DEVICE, and CTRL
+ */
+struct hbm_dma_setup_request {
+	u8 hbm_cmd;
+	u8 reserved[3];
+	struct hbm_dma_mem_dscr dma_dscr[DMA_DSCR_NUM];
+} __packed;
+
+/**
+ * struct hbm_dma_setup_response - dma setup response
+ *
+ * @hbm_cmd: bus message command header
+ * @status: 0 on success; otherwise DMA setup failed.
+ * @reserved: reserved for alignment
+ */
+struct hbm_dma_setup_response {
+	u8 hbm_cmd;
+	u8 status;
+	u8 reserved[2];
+} __packed;
+
 #endif
-- 
2.14.4

