Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FBEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4551120663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4551120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405527AbeKVVv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:51:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:39305 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394529AbeKVVuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:50:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 03:11:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,265,1539673200"; 
   d="scan'208";a="91290772"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga007.jf.intel.com with ESMTP; 22 Nov 2018 03:11:54 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v2 2/7] mei: hbm: setup dma ring
Date:   Thu, 22 Nov 2018 13:11:37 +0200
Message-Id: <20181122111142.18653-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181122111142.18653-1-tomas.winkler@intel.com>
References: <20181122111142.18653-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA ring is allocated upon HBM handshake and the ring parameters are set
via dedicated HBM_DMA_SETUP request command. The firmware will perform
its setup and respond with a status. On failure the DMA buffers are
released.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/hbm.c | 86 ++++++++++++++++++++++++++++++++++++++++--
 drivers/misc/mei/hbm.h |  2 +
 2 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index fe67381b34c3..b458c5612245 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -65,6 +65,7 @@ const char *mei_hbm_state_str(enum mei_hbm_state state)
 	MEI_HBM_STATE(IDLE);
 	MEI_HBM_STATE(STARTING);
 	MEI_HBM_STATE(STARTED);
+	MEI_HBM_STATE(DR_SETUP);
 	MEI_HBM_STATE(ENUM_CLIENTS);
 	MEI_HBM_STATE(CLIENT_PROPERTIES);
 	MEI_HBM_STATE(STOPPED);
@@ -295,6 +296,46 @@ int mei_hbm_start_req(struct mei_device *dev)
 	return 0;
 }
 
+/**
+ * mei_hbm_dma_setup_req() - setup DMA request
+ * @dev: the device structure
+ *
+ * Return: 0 on success and < 0 on failure
+ */
+static int mei_hbm_dma_setup_req(struct mei_device *dev)
+{
+	struct mei_msg_hdr mei_hdr;
+	struct hbm_dma_setup_request req;
+	const size_t len = sizeof(struct hbm_dma_setup_request);
+	unsigned int i;
+	int ret;
+
+	mei_hbm_hdr(&mei_hdr, len);
+
+	memset(&req, 0, len);
+	req.hbm_cmd = MEI_HBM_DMA_SETUP_REQ_CMD;
+	for (i = 0; i < DMA_DSCR_NUM; i++) {
+		phys_addr_t paddr;
+
+		paddr = dev->dr_dscr[i].daddr;
+		req.dma_dscr[i].addr_hi = upper_32_bits(paddr);
+		req.dma_dscr[i].addr_lo = lower_32_bits(paddr);
+		req.dma_dscr[i].size = dev->dr_dscr[i].size;
+	}
+
+	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
+	if (ret) {
+		dev_err(dev->dev, "dma setup request write failed: ret = %d.\n",
+			ret);
+		return ret;
+	}
+
+	dev->hbm_state = MEI_HBM_DR_SETUP;
+	dev->init_clients_timer = MEI_CLIENTS_INIT_TIMEOUT;
+	mei_schedule_stall_timer(dev);
+	return 0;
+}
+
 /**
  * mei_hbm_enum_clients_req - sends enumeration client request message.
  *
@@ -1044,6 +1085,7 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 	struct hbm_host_version_response *version_res;
 	struct hbm_props_response *props_res;
 	struct hbm_host_enum_response *enum_res;
+	struct hbm_dma_setup_response *dma_setup_res;
 	struct hbm_add_client_request *add_cl_req;
 	int ret;
 
@@ -1108,14 +1150,52 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 			return -EPROTO;
 		}
 
-		if (mei_hbm_enum_clients_req(dev)) {
-			dev_err(dev->dev, "hbm: start: failed to send enumeration request\n");
-			return -EIO;
+		if (dev->hbm_f_dr_supported) {
+			if (mei_dmam_ring_alloc(dev))
+				dev_info(dev->dev, "running w/o dma ring\n");
+			if (mei_dma_ring_is_allocated(dev)) {
+				if (mei_hbm_dma_setup_req(dev))
+					return -EIO;
+
+				wake_up(&dev->wait_hbm_start);
+				break;
+			}
 		}
 
+		dev->hbm_f_dr_supported = 0;
+		mei_dmam_ring_free(dev);
+
+		if (mei_hbm_enum_clients_req(dev))
+			return -EIO;
+
 		wake_up(&dev->wait_hbm_start);
 		break;
 
+	case MEI_HBM_DMA_SETUP_RES_CMD:
+		dev_dbg(dev->dev, "hbm: dma setup response: message received.\n");
+
+		dev->init_clients_timer = 0;
+
+		if (dev->hbm_state != MEI_HBM_DR_SETUP) {
+			dev_err(dev->dev, "hbm: dma setup response: state mismatch, [%d, %d]\n",
+				dev->dev_state, dev->hbm_state);
+			return -EPROTO;
+		}
+
+		dma_setup_res = (struct hbm_dma_setup_response *)mei_msg;
+
+		if (dma_setup_res->status) {
+			dev_info(dev->dev, "hbm: dma setup response: failure = %d %s\n",
+				 dma_setup_res->status,
+				 mei_hbm_status_str(dma_setup_res->status));
+			dev->hbm_f_dr_supported = 0;
+			mei_dmam_ring_free(dev);
+		}
+
+		if (mei_hbm_enum_clients_req(dev))
+			return -EIO;
+		break;
+
 	case CLIENT_CONNECT_RES_CMD:
 		dev_dbg(dev->dev, "hbm: client connect response: message received.\n");
 		mei_hbm_cl_res(dev, cl_cmd, MEI_FOP_CONNECT);
diff --git a/drivers/misc/mei/hbm.h b/drivers/misc/mei/hbm.h
index a2025a5083a3..0171a7e79bab 100644
--- a/drivers/misc/mei/hbm.h
+++ b/drivers/misc/mei/hbm.h
@@ -26,6 +26,7 @@ struct mei_cl;
  *
  * @MEI_HBM_IDLE : protocol not started
  * @MEI_HBM_STARTING : start request message was sent
+ * @MEI_HBM_DR_SETUP : dma ring setup request message was sent
  * @MEI_HBM_ENUM_CLIENTS : enumeration request was sent
  * @MEI_HBM_CLIENT_PROPERTIES : acquiring clients properties
  * @MEI_HBM_STARTED : enumeration was completed
@@ -34,6 +35,7 @@ struct mei_cl;
 enum mei_hbm_state {
 	MEI_HBM_IDLE = 0,
 	MEI_HBM_STARTING,
+	MEI_HBM_DR_SETUP,
 	MEI_HBM_ENUM_CLIENTS,
 	MEI_HBM_CLIENT_PROPERTIES,
 	MEI_HBM_STARTED,
-- 
2.17.2

