Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414B3C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14667222D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083424;
	bh=5lK1AkqWFmFILfg8Xdk55nlGwNP4VXPagNKtJ93V9dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZNJmsK+6+kzJVKu2CyI6O9isG4YYUYVU42QOTia4O42rYvvxYkugoOcdDSmcjrFhf
	 BbtmJe2j/V+Nac//GUGsVseHIX2a1WVI+6EsjR0MK3o6Wq6uEAbh8LWmvl4l3WNj/t
	 8jo4yOFnNWOyttiON9sy2M92n9emSsHJ99D7nCQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405951AbfBMSnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:43:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405385AbfBMSnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66C24222D5;
        Wed, 13 Feb 2019 18:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083419;
        bh=5lK1AkqWFmFILfg8Xdk55nlGwNP4VXPagNKtJ93V9dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zGMI+xDod3EcIgjhNoKIpSl0JgP7qnG9R0SEwEilfmYqQ4CxOJBtoOfwgeHaHzIDN
         uwMU2B7/VSTu9ZSHe67WGskO+ugysoPFvAsG2kpHCQKBmX24czSqHU0LRJuWwUhhUM
         CK2qXcJgrG7AzdfJwMkfqWE7xle78ASaf229XVyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.19 30/44] mac80211: ensure that mgmt tx skbs have tailroom for encryption
Date:   Wed, 13 Feb 2019 19:38:31 +0100
Message-Id: <20190213183654.316203382@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1913,9 +1913,16 @@ static int ieee80211_skb_resize(struct i
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
@@ -1923,8 +1930,7 @@ static int ieee80211_skb_resize(struct i
 
 	if (skb_cloned(skb) &&
 	    (!ieee80211_hw_check(&local->hw, SUPPORTS_CLONED_SKBS) ||
-	     !skb_clone_writable(skb, ETH_HLEN) ||
-	     (may_encrypt && sdata->crypto_tx_tailroom_needed_cnt)))
+	     !skb_clone_writable(skb, ETH_HLEN) || enc_tailroom))
 		I802_DEBUG_INC(local->tx_expand_skb_head_cloned);
 	else if (head_need || tail_need)
 		I802_DEBUG_INC(local->tx_expand_skb_head);


