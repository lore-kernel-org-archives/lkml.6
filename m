Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71766C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409EE20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409EE20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeKHPYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:24:33 -0500
Received: from mail5.windriver.com ([192.103.53.11]:56864 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbeKHPYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:24:33 -0500
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wA85noAS023656
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 7 Nov 2018 21:50:01 -0800
Received: from pek-lpggp4.wrs.com (128.224.153.77) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.408.0; Wed, 7 Nov 2018
 21:49:33 -0800
From:   Zumeng Chen <zumeng.chen@gmail.com>
To:     <linux-bluetooth@vger.kernel.org>
CC:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <linux-kernel@vger.kernel.org>, Zumeng Chen <zumeng.chen@gmail.com>
Subject: [PATCH 1/1] Bluetooth: make the balance of judgement condition to fix a false report
Date:   Thu, 8 Nov 2018 13:47:45 +0800
Message-ID: <1541656065-111693-1-git-send-email-zumeng.chen@gmail.com>
X-Mailer: git-send-email 2.7.4
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

Hi expert,

This issue existed whether or not T_DBG had been changed into bt_dev_err, which
just shows the issue explicitly. I noticed actually that opcode doesn't match
ev->opcode either at the same time. And there might be some logic issue about
HCI_EV_CMD_COMPLETE between protocol and drivers. I'm not familar with the whole
bluetooth protocol, and not gonna to dig more, so all yours guys~

Cheers,
Zumeng

 net/bluetooth/hci_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 235b5aa..d848663 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5217,7 +5217,8 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 		return true;
 	}
 
-	if (hdr->evt != HCI_EV_CMD_COMPLETE) {
+	if (!((hdr->evt == HCI_EV_CMD_COMPLETE) ||
+		(hdr->evt == HCI_EV_CMD_STATUS))) {
 		bt_dev_err(hdev, "last event is not cmd complete (0x%2.2x)",
 			   hdr->evt);
 		return false;
-- 
2.7.4

