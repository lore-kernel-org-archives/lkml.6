Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C26C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD42720879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YMpisxR2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hUoSSPez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbeL1Lsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 06:48:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49490 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732204AbeL1Lsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 06:48:41 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3F36B6090F; Fri, 28 Dec 2018 11:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545997720;
        bh=rnu8okox5XvhBmPI7ntxGTYhG719Crq47GRi3axFzJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMpisxR2hWLPBwQj/ZkgEccso0rDDVzy8rPkHxWbkZl7zoWoU/DWWF6eES86BFLBZ
         dQ1VwMt8+zaXaQnfByZCXqcVqyaT6f2ADCReEJwmPlFmRbccmxbxeecYCI1w19PKYG
         iKX7bnVijeRpRm2lPPxYviDsex5vfZp+b/LIozmI=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59CD060722;
        Fri, 28 Dec 2018 11:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545997719;
        bh=rnu8okox5XvhBmPI7ntxGTYhG719Crq47GRi3axFzJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hUoSSPezmy3wPmVsrWsWrlQUijePhEiafmXL+nbY+6mhjM86zlnfJhJe3BGzQDaaD
         tzcJI9udRoXqFaeIlqVM1+s5mMGsFIET2fLserp5FfNxGDOVsXxABPVuBuzbCE48jj
         a0TM8zNq6lSMBPZ00yPyN2APZKU+e4SbP7jnBNdI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59CD060722
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v7 4/4] Bluetooth: btqca: inject command complete event during fw download
Date:   Fri, 28 Dec 2018 17:18:19 +0530
Message-Id: <20181228114819.17479-5-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181228114819.17479-1-bgodavar@codeaurora.org>
References: <20181228114819.17479-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latest qualcomm chips are not sending an command complete event for
every firmware packet sent to chip. They only respond with a vendor
specific event for the last firmware packet. This optimization will
decrease the BT ON time. Due to this we are seeing a timeout error
message logs on the console during firmware download. Now we are
injecting a command complete event once we receive an vendor specific
event for the last RAM firmware packet.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/btqca.c | 39 ++++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btqca.h |  3 +++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index ec9e03a6b778..0b533f65f652 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -144,6 +144,7 @@ static void qca_tlv_check_data(struct rome_config *config,
 		 * In case VSE is skipped, only the last segment is acked.
 		 */
 		config->dnld_mode = tlv_patch->download_mode;
+		config->dnld_type = config->dnld_mode;
 
 		BT_DBG("Total Length           : %d bytes",
 		       le32_to_cpu(tlv_patch->total_size));
@@ -264,6 +265,31 @@ static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 	return err;
 }
 
+static int qca_inject_cmd_complete_event(struct hci_dev *hdev)
+{
+	struct hci_event_hdr *hdr;
+	struct hci_ev_cmd_complete *evt;
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = skb_put(skb, sizeof(*hdr));
+	hdr->evt = HCI_EV_CMD_COMPLETE;
+	hdr->plen = sizeof(*evt) + 1;
+
+	evt = skb_put(skb, sizeof(*evt));
+	evt->ncmd = 1;
+	evt->opcode = HCI_OP_NOP;
+
+	skb_put_u8(skb, QCA_HCI_CC_SUCCESS);
+
+	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
+
+	return hci_recv_frame(hdev, skb);
+}
+
 static int qca_download_firmware(struct hci_dev *hdev,
 				  struct rome_config *config)
 {
@@ -297,11 +323,22 @@ static int qca_download_firmware(struct hci_dev *hdev,
 		ret = qca_tlv_send_segment(hdev, segsize, segment,
 					    config->dnld_mode);
 		if (ret)
-			break;
+			goto out;
 
 		segment += segsize;
 	}
 
+	/* Latest qualcomm chipsets are not sending a command complete event
+	 * for every fw packet sent. They only respond with a vendor specific
+	 * event for the last packet. This optimization in the chip will
+	 * decrease the BT in initialization time. Here we will inject a command
+	 * complete event to avoid a command timeout error message.
+	 */
+	if ((config->dnld_type == ROME_SKIP_EVT_VSE_CC ||
+	    config->dnld_type == ROME_SKIP_EVT_VSE))
+		return qca_inject_cmd_complete_event(hdev);
+
+out:
 	release_firmware(fw);
 
 	return ret;
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 0c01f375fe83..5c8fc54133e3 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -40,6 +40,8 @@
 #define QCA_WCN3990_POWERON_PULSE	0xFC
 #define QCA_WCN3990_POWEROFF_PULSE	0xC0
 
+#define QCA_HCI_CC_SUCCESS		0x00
+
 enum qca_bardrate {
 	QCA_BAUDRATE_115200 	= 0,
 	QCA_BAUDRATE_57600,
@@ -81,6 +83,7 @@ struct rome_config {
 	char fwname[64];
 	uint8_t user_baud_rate;
 	enum rome_tlv_dnld_mode dnld_mode;
+	enum rome_tlv_dnld_mode dnld_type;
 };
 
 struct edl_event_hdr {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

