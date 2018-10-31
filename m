Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB31BECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7368420821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCp2qZ+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7368420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeKAIGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbeKAIGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB3AD20843;
        Wed, 31 Oct 2018 23:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027179;
        bh=VJIveXiCnAmoabm4oI36g6Ps2qFbn500SMnUQfuGQ00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aCp2qZ+/GTQYS1ibw7zQBbXTD+iD3AvJ7vEGqisfHE6SAPjEIlcF3diERchqMrbE0
         zs6PDqmUFzZNZPMd9Utx2NBdebUhT46JRABeDyOAvpJsr5STkPsZPy6MMz8YWd83r6
         VsLXBf1v9gemtYi9bBr4NzGHxn1fQqkLIXhbaljA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 041/146] ath10k: fix tx status flag setting for management frames
Date:   Wed, 31 Oct 2018 19:03:56 -0400
Message-Id: <20181031230541.28822-41-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rakesh Pillai <pillair@codeaurora.org>

[ Upstream commit 058a7eab9d9ee12f57282eb0b606668dada70d7a ]

The tx_status for management frames is being filled
incorrectly in the flags of skb_cb. This incorrect
flag setting causes the upper layers to consider that
the particular frame was not transmitted properly,
leading to improper behavior.

Set the IEEE80211_TX_STAT_ACK flag in the info flags
of skb_cb, to indicate the successful transmission of
the management frame.

Tested HW: WCN3990
Tested FW: WLAN.HL.2.0-01188-QCAHLSWMTPLZ-1

Fixes: dc405152bb64d4ae01c9ac669de25b2d1fb6fc2d
Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index fd612d2905b0..1dced0dae9cd 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -2336,7 +2336,12 @@ static int wmi_process_mgmt_tx_comp(struct ath10k *ar, u32 desc_id,
 	dma_unmap_single(ar->dev, pkt_addr->paddr,
 			 msdu->len, DMA_FROM_DEVICE);
 	info = IEEE80211_SKB_CB(msdu);
-	info->flags |= status;
+
+	if (status)
+		info->flags &= ~IEEE80211_TX_STAT_ACK;
+	else
+		info->flags |= IEEE80211_TX_STAT_ACK;
+
 	ieee80211_tx_status_irqsafe(ar->hw, msdu);
 
 	ret = 0;
-- 
2.17.1

