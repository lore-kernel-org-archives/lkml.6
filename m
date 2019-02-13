Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACDAC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219D9222D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083265;
	bh=S45H/ragH46HCUTqwdzVGmJA7OICKV+86xiv7XK2UYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0GM1JZQa90IgdahFuRi88sJEmmESDTlXOa9jxWH1kshufWGFYCEvKfeFllij01dYF
	 5g1o1kkqkfSE4TY1LAuXHdDMPLOVCu/KgEJbrzcln1k31oL6SWMHC8xuE+fvPsbGvx
	 J1Lksn3q06jzYUktRfxDltgHlQtBivGM5nSER+ME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393765AbfBMSlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:41:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387927AbfBMSlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:41:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76807222D5;
        Wed, 13 Feb 2019 18:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083261;
        bh=S45H/ragH46HCUTqwdzVGmJA7OICKV+86xiv7XK2UYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=df/o+MsHP/3IZvDa6DaC/jH5lrqKPx7hACDlftM/im68dH9828Naw6cIxEGu8OlSp
         HxXEdkS3+mBAYlIJGKsX/Rspfg7zTgAjVhfQrTo+o5BSugHT+IiX5UbPwHcGyYzQQR
         kPp+s/6iaTFc9NdAtz/9s41cM2ZaBod2uPmlDXH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 15/35] mac80211: ensure that mgmt tx skbs have tailroom for encryption
Date:   Wed, 13 Feb 2019 19:38:10 +0100
Message-Id: <20190213183706.873434419@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
References: <20190213183706.176685027@linuxfoundation.org>
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

From: Felix Fietkau <nbd@nbd.name>

commit 9d0f50b80222dc273e67e4e14410fcfa4130a90c upstream.

Some drivers use IEEE80211_KEY_FLAG_SW_MGMT_TX to indicate that management
frames need to be software encrypted. Since normal data packets are still
encrypted by the hardware, crypto_tx_tailroom_needed_cnt gets decremented
after key upload to hw. This can lead to passing skbs to ccmp_encrypt_skb,
which don't have the necessary tailroom for software encryption.

Change the code to add tailroom for encrypted management packets, even if
crypto_tx_tailroom_needed_cnt is 0.

Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/tx.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1856,9 +1856,16 @@ static int ieee80211_skb_resize(struct i
 				int head_need, bool may_encrypt)
 {
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_hdr *hdr;
+	bool enc_tailroom;
 	int tail_need = 0;
 
-	if (may_encrypt && sdata->crypto_tx_tailroom_needed_cnt) {
+	hdr = (struct ieee80211_hdr *) skb->data;
+	enc_tailroom = may_encrypt &&
+		       (sdata->crypto_tx_tailroom_needed_cnt ||
+			ieee80211_is_mgmt(hdr->frame_control));
+
+	if (enc_tailroom) {
 		tail_need = IEEE80211_ENCRYPT_TAILROOM;
 		tail_need -= skb_tailroom(skb);
 		tail_need = max_t(int, tail_need, 0);
@@ -1866,8 +1873,7 @@ static int ieee80211_skb_resize(struct i
 
 	if (skb_cloned(skb) &&
 	    (!ieee80211_hw_check(&local->hw, SUPPORTS_CLONED_SKBS) ||
-	     !skb_clone_writable(skb, ETH_HLEN) ||
-	     (may_encrypt && sdata->crypto_tx_tailroom_needed_cnt)))
+	     !skb_clone_writable(skb, ETH_HLEN) || enc_tailroom))
 		I802_DEBUG_INC(local->tx_expand_skb_head_cloned);
 	else if (head_need || tail_need)
 		I802_DEBUG_INC(local->tx_expand_skb_head);


