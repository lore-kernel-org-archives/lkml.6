Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF0DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBEA21B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898462;
	bh=3bJN6QpnGn9cYj7XiRUQJfw1M2zhPIUD740j1H9kFbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Ss7lsaHfvoEBMJrsx89N68I4fcK9CV6fuGlXYOSQmEi/Mf9IxcEQ5wTbQzMMKMJN
	 qOem4NdeWJXR8cMhaaxyKKBorYj79ylVcQCOzU+VzJXRFJq0U7Nl2yxeEucwVGrQS6
	 qiSefBMmIE6YdkKSLMMGdoC0lu+lWaaQKlusG4ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404070AbfBKPVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:21:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390865AbfBKPEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:04:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7825D222AD;
        Mon, 11 Feb 2019 15:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897487;
        bh=3bJN6QpnGn9cYj7XiRUQJfw1M2zhPIUD740j1H9kFbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1yYuP8nUoQLdPURK/HE1Tc7KfgYtLclvw4i7RsBZiDrnyJDDyRz8jVTsBlSgMWFmI
         yBHsXs/yHMTt4nIEFwYB8syL8BwVfHv/eQlgnzOZ1PDW3O5+/NL0WclFqWDoQ/8heN
         ADStxhj7qlD80Iu1J/7Pn8f0j2UkRq9ccKun+UhU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 005/137] ath9k: dynack: use authentication messages for late ack
Date:   Mon, 11 Feb 2019 15:18:06 +0100
Message-Id: <20190211141812.442216608@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3831a2a0010c72e3956020cbf1057a1701a2e469 ]

In order to properly support dynack in ad-hoc mode running
wpa_supplicant, take into account authentication frames for
'late ack' detection. This patch has been tested on devices
mounted on offshore high-voltage stations connected through
~24Km link

Reported-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
Tested-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/dynack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/dynack.c b/drivers/net/wireless/ath/ath9k/dynack.c
index 7334c9b09e82..cc0dc966c512 100644
--- a/drivers/net/wireless/ath/ath9k/dynack.c
+++ b/drivers/net/wireless/ath/ath9k/dynack.c
@@ -187,7 +187,8 @@ void ath_dynack_sample_tx_ts(struct ath_hw *ah, struct sk_buff *skb,
 	/* late ACK */
 	if (ts->ts_status & ATH9K_TXERR_XRETRY) {
 		if (ieee80211_is_assoc_req(hdr->frame_control) ||
-		    ieee80211_is_assoc_resp(hdr->frame_control)) {
+		    ieee80211_is_assoc_resp(hdr->frame_control) ||
+		    ieee80211_is_auth(hdr->frame_control)) {
 			ath_dbg(common, DYNACK, "late ack\n");
 			ath9k_hw_setslottime(ah, (LATEACK_TO - 3) / 2);
 			ath9k_hw_set_ack_timeout(ah, LATEACK_TO);
-- 
2.19.1



