Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6486CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA5E20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPXJ2Hx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA5E20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbeKLKDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:03:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730547AbeKLIRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:17 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91D96215EA;
        Sun, 11 Nov 2018 22:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975241;
        bh=KyZRNeQ712Sh8377stAvwRyPzCSm9XSW9PcEv5tlPzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KPXJ2Hx2uKVwPzT2b/afaqlO2HHyEKDanZNNsBqaT+IceMD/++QcXWnqrrEPV/dEv
         VAzouH5L8/LTl0rFI971UUR9nOcx66zgrGSxrYsBZbkW2maAqzvDIohwINp8tOSWs2
         2W4ATu66e4+v0o7He3ObC2+Fm7JO90RJr6mwRLsA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 086/361] ath10k: fix tx status flag setting for management frames
Date:   Sun, 11 Nov 2018 14:17:13 -0800
Message-Id: <20181111221631.937232624@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/wmi.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -2336,7 +2336,12 @@ static int wmi_process_mgmt_tx_comp(stru
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


