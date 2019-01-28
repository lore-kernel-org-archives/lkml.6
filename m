Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3975AC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B7F20844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694701;
	bh=DQ1LNdVUw8f7ERxptaREjtWpFFb6/7QqPCR209Ai0IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PqoWBhOeX3nywkk+fcn9eK8fC75nI0Bqi6xOIh9Ajd82twAa/dfVnjOWl0U7WWclE
	 oCRaBqSYmA7DCojF7iTE42kEL0U84q2JfOFLtzDKGcv5lNZ6TtmymZnEHt4Ln4ABSv
	 sM0FtEL8twInSNjs+m8M/DtJFDNRc7VFhjMTZDpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388971AbfA1Q6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:58:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388094AbfA1QRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:17:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 403E32086C;
        Mon, 28 Jan 2019 16:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692220;
        bh=DQ1LNdVUw8f7ERxptaREjtWpFFb6/7QqPCR209Ai0IE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1rSzTwv+rgikjRXC0aEq3AcAGU8ySuEbKANuQ7QQikzByHXO8tfKN47ewwDOftWoU
         4fVzuaIF3LWiR3RaSlKCx3hPOUqMhfcMsY5lYnbkb2RsDndUQgDrOUskJDgR/msl5O
         vZ4ybiIsBDSoKdoKcO49nFAzDeAI2OdpuMdGPJuc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Hedberg <johan.hedberg@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 116/170] Bluetooth: Fix unnecessary error message for HCI request completion
Date:   Mon, 28 Jan 2019 11:11:06 -0500
Message-Id: <20190128161200.55107-116-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hedberg <johan.hedberg@intel.com>

[ Upstream commit 1629db9c75342325868243d6bca5853017d91cf8 ]

In case a command which completes in Command Status was sent using the
hci_cmd_send-family of APIs there would be a misleading error in the
hci_get_cmd_complete function, since the code would be trying to fetch
the Command Complete parameters when there are none.

Avoid the misleading error and silently bail out from the function in
case the received event is a command status.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 01f211e31f47..363dc85bbc5c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5212,6 +5212,12 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 		return true;
 	}
 
+	/* Check if request ended in Command Status - no way to retreive
+	 * any extra parameters in this case.
+	 */
+	if (hdr->evt == HCI_EV_CMD_STATUS)
+		return false;
+
 	if (hdr->evt != HCI_EV_CMD_COMPLETE) {
 		BT_DBG("Last event is not cmd complete (0x%2.2x)", hdr->evt);
 		return false;
-- 
2.19.1

