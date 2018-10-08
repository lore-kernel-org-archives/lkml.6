Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921F2C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532D72087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzmiKFjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532D72087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbeJIB7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:59:33 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EC8E2064A;
        Mon,  8 Oct 2018 18:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024386;
        bh=SzZjW4v4APK2ERSAK82BrxhrFlqcSzkJj//BHf/yRng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DzmiKFjNO3CNrK9wFblHbGxchq2+CXHhYiMIcAsLhzEDe8Dd1o/T3UnyJXm4kiL75
         wObepHQO7/ZQ2EE+on9g2llKY/o3PYXxTWP+RnGi8gwGZM+6mnclRq7diBXw+sBmcP
         P2Sc2Ow1sXD+6QNfEcoGjBjin0Q4vHA2cb5md4pU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sara Sharon <sara.sharon@intel.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 024/168] mac80211: avoid kernel panic when building AMSDU from non-linear SKB
Date:   Mon,  8 Oct 2018 20:30:04 +0200
Message-Id: <20181008175620.961798766@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sara Sharon <sara.sharon@intel.com>

[ Upstream commit 166ac9d55b0ab70b644e429be1f217fe8393cbd7 ]

When building building AMSDU from non-linear SKB, we hit a
kernel panic when trying to push the padding to the tail.
Instead, put the padding at the head of the next subframe.
This also fixes the A-MSDU subframes to not have the padding
accounted in the length field and not have pad at all for
the last subframe, both required by the spec.

Fixes: 6e0456b54545 ("mac80211: add A-MSDU tx support")
Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Reviewed-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/tx.c |   38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3073,27 +3073,18 @@ void ieee80211_clear_fast_xmit(struct st
 }
 
 static bool ieee80211_amsdu_realloc_pad(struct ieee80211_local *local,
-					struct sk_buff *skb, int headroom,
-					int *subframe_len)
+					struct sk_buff *skb, int headroom)
 {
-	int amsdu_len = *subframe_len + sizeof(struct ethhdr);
-	int padding = (4 - amsdu_len) & 3;
-
-	if (skb_headroom(skb) < headroom || skb_tailroom(skb) < padding) {
+	if (skb_headroom(skb) < headroom) {
 		I802_DEBUG_INC(local->tx_expand_skb_head);
 
-		if (pskb_expand_head(skb, headroom, padding, GFP_ATOMIC)) {
+		if (pskb_expand_head(skb, headroom, 0, GFP_ATOMIC)) {
 			wiphy_debug(local->hw.wiphy,
 				    "failed to reallocate TX buffer\n");
 			return false;
 		}
 	}
 
-	if (padding) {
-		*subframe_len += padding;
-		skb_put_zero(skb, padding);
-	}
-
 	return true;
 }
 
@@ -3117,8 +3108,7 @@ static bool ieee80211_amsdu_prepare_head
 	if (info->control.flags & IEEE80211_TX_CTRL_AMSDU)
 		return true;
 
-	if (!ieee80211_amsdu_realloc_pad(local, skb, sizeof(*amsdu_hdr),
-					 &subframe_len))
+	if (!ieee80211_amsdu_realloc_pad(local, skb, sizeof(*amsdu_hdr)))
 		return false;
 
 	data = skb_push(skb, sizeof(*amsdu_hdr));
@@ -3184,7 +3174,8 @@ static bool ieee80211_amsdu_aggregate(st
 	void *data;
 	bool ret = false;
 	unsigned int orig_len;
-	int n = 1, nfrags;
+	int n = 1, nfrags, pad = 0;
+	u16 hdrlen;
 
 	if (!ieee80211_hw_check(&local->hw, TX_AMSDU))
 		return false;
@@ -3235,8 +3226,19 @@ static bool ieee80211_amsdu_aggregate(st
 	if (max_frags && nfrags > max_frags)
 		goto out;
 
-	if (!ieee80211_amsdu_realloc_pad(local, skb, sizeof(rfc1042_header) + 2,
-					 &subframe_len))
+	/*
+	 * Pad out the previous subframe to a multiple of 4 by adding the
+	 * padding to the next one, that's being added. Note that head->len
+	 * is the length of the full A-MSDU, but that works since each time
+	 * we add a new subframe we pad out the previous one to a multiple
+	 * of 4 and thus it no longer matters in the next round.
+	 */
+	hdrlen = fast_tx->hdr_len - sizeof(rfc1042_header);
+	if ((head->len - hdrlen) & 3)
+		pad = 4 - ((head->len - hdrlen) & 3);
+
+	if (!ieee80211_amsdu_realloc_pad(local, skb, sizeof(rfc1042_header) +
+						     2 + pad))
 		goto out;
 
 	ret = true;
@@ -3248,6 +3250,8 @@ static bool ieee80211_amsdu_aggregate(st
 	memcpy(data, &len, 2);
 	memcpy(data + 2, rfc1042_header, sizeof(rfc1042_header));
 
+	memset(skb_push(skb, pad), 0, pad);
+
 	head->len += skb->len;
 	head->data_len += skb->len;
 	*frag_tail = skb;


