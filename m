Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4B1C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3242098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mhWxwB+S";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Iq8P/l3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3242098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeJCWAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:00:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49594 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCWAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:00:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 10D5360C62; Wed,  3 Oct 2018 15:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538579520;
        bh=B/DQRInxvzQEV0zSqs2tQ0Ce60mkR6UkqlN+ceAIcHE=;
        h=From:To:Cc:Subject:Date:From;
        b=mhWxwB+Su47H4CtBxKdS1lVsbKEKOeVYWBWdtu4PNSSMgRr7UKyr4SFqCEGbjg2Ms
         tKyi3XIQsSho71y4t8QYUEbAog4UDFcfbo/op8HSCti14JOy41gdhVie6d5OjDnlFA
         P4qMW8LyjHO+rSc63hGG/iLFKM+HuARUWWFfUVFo=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06C1360A9B;
        Wed,  3 Oct 2018 15:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538579519;
        bh=B/DQRInxvzQEV0zSqs2tQ0Ce60mkR6UkqlN+ceAIcHE=;
        h=From:To:Cc:Subject:Date:From;
        b=Iq8P/l3i8fvKxraZtBx+UjixiFW1oOB3ljhGq/uroCtZjoHR1yubFfy/7dMKyKLXd
         U2ekDQuqTcy6qRzg2t5M/Lc1MfueOp4E3WdcLA5BvT4Efg8j91P8v9bDGLEMisVmQ/
         m2BKp8cf4AsJDkaXt+m1b4KSwUTCniqaKTzCSs0U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06C1360A9B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>
Subject: [PATCH v2] Bluetooth: hci_qca: Add support for controller debug logs.
Date:   Wed,  3 Oct 2018 20:41:44 +0530
Message-Id: <20181003151144.10537-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will prevent error messages splashing on console.

[   78.426697] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL packet for unknown connection handle 3804
[   78.436682] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL packet for unknown connection handle 3804
[   78.446639] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL packet for unknown connection handle 3804
[   78.456596] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL packet for unknown connection handle 3804

QCA wcn3990 will send the debug logs in the form of ACL packets.
While decoding packet in qca_recv(), marking the received debug log
packet as diagnostic packet.

Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
v2: 
  * Addressed reviewer comments.
v1: 
  * initial patch
---
 drivers/bluetooth/hci_qca.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index d98ed0442201..63ac3c6b4149 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -63,6 +63,10 @@
 /* susclk rate */
 #define SUSCLK_RATE_32KHZ	32768
 
+/* Controller debug log header */
+#define QCA_DEBUG_HDR_MSB	0xDC
+#define QCA_DEBUG_HDR_LSB	0x2E
+
 /* HCI_IBS transmit side sleep protocol states */
 enum tx_ibs_states {
 	HCI_IBS_TX_ASLEEP,
@@ -849,6 +853,20 @@ static int qca_ibs_wake_ack(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	/* We receive debug logs from chip as an ACL packets.
+	 * Instead of sending the data to ACL to decode the
+	 * received data, we are pushing them to the above layers
+	 * as a diagnostic packet.
+	 */
+	if ((skb->len > 2) && (skb->data[0] == QCA_DEBUG_HDR_MSB) &&
+	    (skb->data[1] == QCA_DEBUG_HDR_LSB))
+		return hci_recv_diag(hdev, skb);
+
+	return hci_recv_frame(hdev, skb);
+}
+
 #define QCA_IBS_SLEEP_IND_EVENT \
 	.type = HCI_IBS_SLEEP_IND, \
 	.hlen = 0, \
@@ -871,7 +889,7 @@ static int qca_ibs_wake_ack(struct hci_dev *hdev, struct sk_buff *skb)
 	.maxlen = HCI_MAX_IBS_SIZE
 
 static const struct h4_recv_pkt qca_recv_pkts[] = {
-	{ H4_RECV_ACL,             .recv = hci_recv_frame    },
+	{ H4_RECV_ACL,             .recv = qca_recv_acl_data },
 	{ H4_RECV_SCO,             .recv = hci_recv_frame    },
 	{ H4_RECV_EVENT,           .recv = hci_recv_frame    },
 	{ QCA_IBS_WAKE_IND_EVENT,  .recv = qca_ibs_wake_ind  },
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

