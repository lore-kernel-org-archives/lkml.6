Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA52CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994AF2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895421;
	bh=ejmSe/8NqA10huS4TsCJLWKtHcDJGmb31xrVEMwle84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MVU7Y3bKtjLK8wKpMIvsLDT8r50CFCptqwghNoAt6EEj4RZRSEjouT7bpuEgr/jl8
	 6+9lLUFHGlr6ZFFCexuaj5GEiVP64OHlLdTGRhXI1MfKZxAfFfAs4IgB8AezW1YoC0
	 Qd8eZejVn1C5DZVR3iUnKcC5sYYWgBdrLK4QEtuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfBKOaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:30:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729552AbfBKOaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:30:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D940D20675;
        Mon, 11 Feb 2019 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895412;
        bh=ejmSe/8NqA10huS4TsCJLWKtHcDJGmb31xrVEMwle84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aLniGRnwzQWieFJHUFxTilsIuXz+gSMUcv6Q9lW4Bvy299Tdp1AaVQ4/2BLG6V0hI
         7XmV8EiaSL3lIJTT1gzylQNCBaU8pDTQmYguEhCMnm1XCio3CR2lVmu9R41R+FfRCD
         5FeT9xB0dcr4jv8QrZYtVD9EQw1aLh4Mhp7IpCa0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 196/352] mac80211: Properly handle SKB with radiotap only
Date:   Mon, 11 Feb 2019 15:17:03 +0100
Message-Id: <20190211141859.608082806@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8020919a9b99d6c990dc6a50e8215e291fbbe5a6 ]

The monitor interface Rx handling of SKBs that contain only
radiotap information was buggy as it tried to access the
SKB assuming it contains a frame.

To fix this, check the RX_FLAG_NO_PSDU flag in the Rx status
(indicting that the SKB contains only radiotap information),
and do not perform data path specific processing when the flag
is set.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rx.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 428f7ad5f9b5..77d996a60f12 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -753,6 +753,7 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
 	struct ieee80211_sub_if_data *monitor_sdata =
 		rcu_dereference(local->monitor_sdata);
 	bool only_monitor = false;
+	unsigned int min_head_len;
 
 	if (status->flag & RX_FLAG_RADIOTAP_HE)
 		rtap_space += sizeof(struct ieee80211_radiotap_he);
@@ -766,6 +767,8 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
 		rtap_space += sizeof(*rtap) + rtap->len + rtap->pad;
 	}
 
+	min_head_len = rtap_space;
+
 	/*
 	 * First, we may need to make a copy of the skb because
 	 *  (1) we need to modify it for radiotap (if not present), and
@@ -775,18 +778,23 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
 	 * the SKB because it has a bad FCS/PLCP checksum.
 	 */
 
-	if (ieee80211_hw_check(&local->hw, RX_INCLUDES_FCS)) {
-		if (unlikely(origskb->len <= FCS_LEN)) {
-			/* driver bug */
-			WARN_ON(1);
-			dev_kfree_skb(origskb);
-			return NULL;
+	if (!(status->flag & RX_FLAG_NO_PSDU)) {
+		if (ieee80211_hw_check(&local->hw, RX_INCLUDES_FCS)) {
+			if (unlikely(origskb->len <= FCS_LEN + rtap_space)) {
+				/* driver bug */
+				WARN_ON(1);
+				dev_kfree_skb(origskb);
+				return NULL;
+			}
+			present_fcs_len = FCS_LEN;
 		}
-		present_fcs_len = FCS_LEN;
+
+		/* also consider the hdr->frame_control */
+		min_head_len += 2;
 	}
 
-	/* ensure hdr->frame_control and vendor radiotap data are in skb head */
-	if (!pskb_may_pull(origskb, 2 + rtap_space)) {
+	/* ensure that the expected data elements are in skb head */
+	if (!pskb_may_pull(origskb, min_head_len)) {
 		dev_kfree_skb(origskb);
 		return NULL;
 	}
-- 
2.19.1



