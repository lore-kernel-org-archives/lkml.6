Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D29C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC0321841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130574;
	bh=TMzj3ELJpZJVfCkiYErPtRGYvG7WXfw3nPtV1BQL3XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ArRuOTXqLtzRckwqh/azLMjwjPVG5GbKm7V6WFu4xHId8K+ot2J/xX02vQhKvLEd
	 tFOCOsWWXzg+JyyMQq9y/C6twWYG9cpmMemhbf4YEeY+bLqeuMQUSZIdNyNglqCiAl
	 WGm8i+U+a7a01I63tp45Npe+SnWBAIWSeWxUAalg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbfBYVgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:36:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733106AbfBYVgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:36:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80A58217F5;
        Mon, 25 Feb 2019 21:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130568;
        bh=TMzj3ELJpZJVfCkiYErPtRGYvG7WXfw3nPtV1BQL3XU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=narVUuszDXC2uTc/K05w61YkLGqL6sop3xYgSgJTwe3+dq9wtUhPufE8obChVFR8x
         NxREBiFp6lFsLXcu2QFzd4x9Ft6t0lLrAIXVOlEYGCtFNXDhN/w8Fm/6t8X/0vR5gv
         ZAKKVsjuilIaaQQid+aGS83CfoOFYUcIs7BflLkc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.20 162/183] mac80211: allocate tailroom for forwarded mesh packets
Date:   Mon, 25 Feb 2019 22:12:15 +0100
Message-Id: <20190225195122.371692719@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

From: Felix Fietkau <nbd@nbd.name>

commit 51d0af222f6fa43134c6187ab4f374630f6e0d96 upstream.

Forwarded packets enter the tx path through ieee80211_add_pending_skb,
which skips the ieee80211_skb_resize call.
Fixes WARN_ON in ccmp_encrypt_skb and resulting packet loss.

Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/rx.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2640,6 +2640,7 @@ ieee80211_rx_h_mesh_fwding(struct ieee80
 	struct ieee80211_sub_if_data *sdata = rx->sdata;
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 	u16 ac, q, hdrlen;
+	int tailroom = 0;
 
 	hdr = (struct ieee80211_hdr *) skb->data;
 	hdrlen = ieee80211_hdrlen(hdr->frame_control);
@@ -2726,8 +2727,12 @@ ieee80211_rx_h_mesh_fwding(struct ieee80
 	if (!ifmsh->mshcfg.dot11MeshForwarding)
 		goto out;
 
+	if (sdata->crypto_tx_tailroom_needed_cnt)
+		tailroom = IEEE80211_ENCRYPT_TAILROOM;
+
 	fwd_skb = skb_copy_expand(skb, local->tx_headroom +
-				       sdata->encrypt_headroom, 0, GFP_ATOMIC);
+				       sdata->encrypt_headroom,
+				  tailroom, GFP_ATOMIC);
 	if (!fwd_skb)
 		goto out;
 


