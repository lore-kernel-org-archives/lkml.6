Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0B3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78232206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897171;
	bh=rJeAMNGzgPkoG+71rXsetXbE0pOTUPdXZrd4hUuP93o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DIFXVubTbrUQqlMegQZlFvuYM6TV6rFSbcA3mavYIjvoBceskfUJLDaDGbZgVqucR
	 q4WZwF6Q2ZUqT4445wMqo/3Jr1K3RJQDoXeeIH2ljwHjCai+Tt4y4A6RsEt8I0a61T
	 67bN9H75ypIpYl7WLYmQEA7HgGuN9Vs15RTgQFgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389805AbfBKO72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:59:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389791AbfBKO7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:59:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E351C21773;
        Mon, 11 Feb 2019 14:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897163;
        bh=rJeAMNGzgPkoG+71rXsetXbE0pOTUPdXZrd4hUuP93o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NV1JbxPmTXBxBR2ODLjZnRwi28MpZkOeBz9SJaUHmnCvI5pmynLI5neWflGHDsKyE
         oPShkNPE3vx62SBar4+bADnwc6CHlbPwhPDih8GD/+LyLiOfpCTia4WCAw7znmvYy4
         O3vXXCqpYm3w7e4UMKAIh7sPso21b2WCGfskjSaE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hedberg <johan.hedberg@intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 111/205] Bluetooth: Fix unnecessary error message for HCI request completion
Date:   Mon, 11 Feb 2019 15:18:29 +0100
Message-Id: <20190211141835.769833971@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



