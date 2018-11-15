Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BDDC04EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D8B22419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D8B22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeKOLkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:40:03 -0500
Received: from mail1.windriver.com ([147.11.146.13]:51617 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOLkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 06:40:02 -0500
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wAF1Y7Hv027418
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 14 Nov 2018 17:34:07 -0800 (PST)
Received: from pek-lpggp4.wrs.com (128.224.153.77) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.408.0; Wed, 14 Nov 2018
 17:33:55 -0800
From:   Zumeng Chen <zumeng.chen@gmail.com>
To:     <marcel@holtmann.org>
CC:     <linux-bluetooth@vger.kernel.org>, <johan.hedberg@gmail.com>,
        <linux-kernel@vger.kernel.org>, Zumeng Chen <zumeng.chen@gmail.com>
Subject: [PATCH 1/1 v2] Bluetooth: make the balance of judgement condition to fix a false report
Date:   Thu, 15 Nov 2018 09:31:57 +0800
Message-ID: <1542245517-150977-1-git-send-email-zumeng.chen@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <5A23C871-B30F-44C4-898B-C138EFDB4893@holtmann.org>
References: <5A23C871-B30F-44C4-898B-C138EFDB4893@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to balance the condition scope between hci_get_cmd_complete and
hci_event_packet about orig_skb as follows:

        if (req_complete_skb || event == HCI_EV_CMD_STATUS ||
            event == HCI_EV_CMD_COMPLETE)
                orig_skb = skb_clone(skb, GFP_KERNEL);

And hci_get_cmd_complete will bt_dev_err out when HCI_EV_CMD_STATUS, so a lot
of asymmetric conditions are triggered. Since both of them are the entry into
hci_get_cmd_complete, we'd better get STATUS into judge the false out there.

Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
---

v2: remove redundant braces and adjust the indentation.

Cheers,
Zumeng

 net/bluetooth/hci_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 235b5aa..1d2a8fe 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5217,7 +5217,8 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 		return true;
 	}
 
-	if (hdr->evt != HCI_EV_CMD_COMPLETE) {
+	if (!(hdr->evt == HCI_EV_CMD_COMPLETE ||
+	      hdr->evt == HCI_EV_CMD_STATUS)) {
 		bt_dev_err(hdev, "last event is not cmd complete (0x%2.2x)",
 			   hdr->evt);
 		return false;
-- 
2.7.4

