Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95CAC169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA9B2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SGfQBrjI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TnUPHp2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA9B2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJPWMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:12:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52274 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeJPWM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:12:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 554A56058E; Tue, 16 Oct 2018 14:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539699708;
        bh=/Cosd0wxpPMboZIsSE8NtnmKOUskNl/I+7z5CBIEChI=;
        h=From:To:Cc:Subject:Date:From;
        b=SGfQBrjIatTz95S6DjMS5vOfyKoKhCUep2hMOAhT9PtC68R0t+woIWDjEmwnu0R2I
         nt2Y5SaCRoELyduFBE5jcmQTZF8g0psRSVZqm+KZkkZgVcWk9iFyTVCU8tMr9kMr3D
         JHqi8jK5KuZyzu54PFWqhJmV4CTNCCU12LuXw+g0=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D06AF6058E;
        Tue, 16 Oct 2018 14:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539699707;
        bh=/Cosd0wxpPMboZIsSE8NtnmKOUskNl/I+7z5CBIEChI=;
        h=From:To:Cc:Subject:Date:From;
        b=TnUPHp2E2x52zPoyc7c39GuQagAROyP8UEc0cO1RQR60E2OKZQXrMvDbbHirR4URZ
         92JmWMgt6eEL4V2ytdh8z6oR7GWaSvkUN11/XLkD0LGnW1nJf9exDDt5KQ1JIcLmle
         sUn9ErABQfX+4KN/GYDgpvQADNTRhVb5cUfZ4U0Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D06AF6058E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, c-hbandi@codeaurora.orhg,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>
Subject: [PATCH v3] Bluetooth: hci_qca: Add support for controller debug logs.
Date:   Tue, 16 Oct 2018 19:51:35 +0530
Message-Id: <20181016142135.16480-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
v3:
  * used get_unaligned_le16() instead of checking individual bytes
v2: 
  * Addressed reviewer comments.
v1: 
  * initial patch
---
 drivers/bluetooth/hci_qca.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 9f1392fc7105..f036c8f98ea3 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -40,6 +40,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/serdev.h>
+#include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -63,6 +64,9 @@
 /* susclk rate */
 #define SUSCLK_RATE_32KHZ	32768
 
+/* Controller debug log header */
+#define QCA_DEBUG_HANDLE	0x2EDC
+
 /* HCI_IBS transmit side sleep protocol states */
 enum tx_ibs_states {
 	HCI_IBS_TX_ASLEEP,
@@ -849,6 +853,19 @@ static int qca_ibs_wake_ack(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	/* We receive debug logs from chip as an ACL packets.
+	 * Instead of sending the data to ACL to decode the
+	 * received data, we are pushing them to the above layers
+	 * as a diagnostic packet.
+	 */
+	if (get_unaligned_le16(skb->data) == QCA_DEBUG_HANDLE)
+		return hci_recv_diag(hdev, skb);
+
+	return hci_recv_frame(hdev, skb);
+}
+
 #define QCA_IBS_SLEEP_IND_EVENT \
 	.type = HCI_IBS_SLEEP_IND, \
 	.hlen = 0, \
@@ -871,7 +888,7 @@ static int qca_ibs_wake_ack(struct hci_dev *hdev, struct sk_buff *skb)
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

