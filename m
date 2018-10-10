Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3E9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48472087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48472087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeJJWAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:00:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52313 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJJWAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:00:02 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gAFcC-00018m-2O; Wed, 10 Oct 2018 14:37:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove redundant check on status
Date:   Wed, 10 Oct 2018 15:37:31 +0100
Message-Id: <20181010143731.16451-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check on statis is redundant as a status has to be zero at
the point it is being checked because of a previous check and return
path via label 'unlock'.  Remove the redundant check and the deadcode
that can never be reached.

Detected by CoverityScan, CID#1471710 ("Logically dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/bluetooth/hci_event.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f47f8fad757a..ef9928d7b4fb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4937,31 +4937,27 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	hci_debugfs_create_conn(conn);
 	hci_conn_add_sysfs(conn);
 
-	if (!status) {
-		/* The remote features procedure is defined for master
-		 * role only. So only in case of an initiated connection
-		 * request the remote features.
-		 *
-		 * If the local controller supports slave-initiated features
-		 * exchange, then requesting the remote features in slave
-		 * role is possible. Otherwise just transition into the
-		 * connected state without requesting the remote features.
-		 */
-		if (conn->out ||
-		    (hdev->le_features[0] & HCI_LE_SLAVE_FEATURES)) {
-			struct hci_cp_le_read_remote_features cp;
+	/* The remote features procedure is defined for master
+	 * role only. So only in case of an initiated connection
+	 * request the remote features.
+	 *
+	 * If the local controller supports slave-initiated features
+	 * exchange, then requesting the remote features in slave
+	 * role is possible. Otherwise just transition into the
+	 * connected state without requesting the remote features.
+	 */
+	if (conn->out ||
+	    (hdev->le_features[0] & HCI_LE_SLAVE_FEATURES)) {
+		struct hci_cp_le_read_remote_features cp;
 
-			cp.handle = __cpu_to_le16(conn->handle);
+		cp.handle = __cpu_to_le16(conn->handle);
 
-			hci_send_cmd(hdev, HCI_OP_LE_READ_REMOTE_FEATURES,
-				     sizeof(cp), &cp);
+		hci_send_cmd(hdev, HCI_OP_LE_READ_REMOTE_FEATURES,
+			     sizeof(cp), &cp);
 
-			hci_conn_hold(conn);
-		} else {
-			conn->state = BT_CONNECTED;
-			hci_connect_cfm(conn, status);
-		}
+		hci_conn_hold(conn);
 	} else {
+		conn->state = BT_CONNECTED;
 		hci_connect_cfm(conn, status);
 	}
 
-- 
2.17.1

