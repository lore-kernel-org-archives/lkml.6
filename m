Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D419DC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A85E21A03
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A85E21A03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbeHFNSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:18:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10671 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbeHFNSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:18:08 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3D0CBCB928C7;
        Mon,  6 Aug 2018 19:09:29 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Mon, 6 Aug 2018
 19:09:23 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <davem@davemloft.net>, <linux-bluetooth@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] Bluetooth: remove redundant variables 'adv_set' and 'cp'
Date:   Mon, 6 Aug 2018 19:08:51 +0800
Message-ID: <20180806110851.8568-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables 'adv_set' and 'cp'  are being assigned but are never used hence
they are redundant and can be removed.

Cleans up clang warnings:
net/bluetooth/hci_event.c:1135:29: warning: variable 'adv_set' set but not used [-Wunused-but-set-variable]
net/bluetooth/mgmt.c:3359:39: warning: variable 'cp' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/bluetooth/hci_event.c | 3 ---
 net/bluetooth/mgmt.c      | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 754714c..8078587 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1132,7 +1132,6 @@ static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
 	struct hci_cp_le_set_ext_adv_enable *cp;
-	struct hci_cp_ext_adv_set *adv_set;
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
@@ -1144,8 +1143,6 @@ static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
 	if (!cp)
 		return;
 
-	adv_set = (void *) cp->data;
-
 	hci_dev_lock(hdev);
 
 	if (cp->enable) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 231602f7..3bdc8f3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3356,7 +3356,6 @@ int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *skip)
 static void set_default_phy_complete(struct hci_dev *hdev, u8 status,
 				     u16 opcode, struct sk_buff *skb)
 {
-	struct mgmt_cp_set_phy_confguration *cp;
 	struct mgmt_pending_cmd *cmd;
 
 	BT_DBG("status 0x%02x", status);
@@ -3367,8 +3366,6 @@ static void set_default_phy_complete(struct hci_dev *hdev, u8 status,
 	if (!cmd)
 		goto unlock;
 
-	cp = cmd->param;
-
 	if (status) {
 		mgmt_cmd_status(cmd->sk, hdev->id,
 				MGMT_OP_SET_PHY_CONFIGURATION,
-- 
2.7.0


