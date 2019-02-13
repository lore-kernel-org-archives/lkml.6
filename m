Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE08C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B27B222D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083481;
	bh=bb2VCuuEUi8HziRhangAfNt9ZTCt7ZZUqHW6VexNC3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m8p7dW9BDPr2wgCu8heAKd5jo2imGSH1Bw5rHJvkrsWtltrSHtlxqLWJHFcjfZTAk
	 6FxQHUvrsPNhQeF/vNhdbMqLMuHGcNp/1oe9BsWys/Xn0uj72Pnt5I1Vfy6tJc4srn
	 2w5X97TBEoZHeiU2Wmm+xV/K0DNrK2TzN5nlhHS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393977AbfBMSoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:44:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406148AbfBMSof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:44:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8DAB222D1;
        Wed, 13 Feb 2019 18:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083475;
        bh=bb2VCuuEUi8HziRhangAfNt9ZTCt7ZZUqHW6VexNC3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vXEdwqZXzhSi9zf86jXt8uArtn19zhP9x1MrZcRezMK9aKgHYgFxGbYM7qNDo/bR+
         qR6l5rJR6+S/BALBl7WX/so89BVS0vkCzDrgUtljxdqCQ2pyT6Au81+FBwb+k/OZmH
         Sonp3OzdtalqUIb7LhDleEKQ29dsLCHiuJb5I7E0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+9d7405c7faa390e60b4e@syzkaller.appspotmail.com,
        syzbot+7d20bc3f1ddddc0f9079@syzkaller.appspotmail.com,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4.19 42/44] batman-adv: Force mac header to start of data on xmit
Date:   Wed, 13 Feb 2019 19:38:43 +0100
Message-Id: <20190213183655.311077315@linuxfoundation.org>
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

From: Sven Eckelmann <sven@narfation.org>

commit 9114daa825fc3f335f9bea3313ce667090187280 upstream.

The caller of ndo_start_xmit may not already have called
skb_reset_mac_header. The returned value of skb_mac_header/eth_hdr
therefore can be in the wrong position and even outside the current skbuff.
This for example happens when the user binds to the device using a
PF_PACKET-SOCK_RAW with enabled qdisc-bypass:

  int opt = 4;
  setsockopt(sock, SOL_PACKET, PACKET_QDISC_BYPASS, &opt, sizeof(opt));

Since eth_hdr is used all over the codebase, the batadv_interface_tx
function must always take care of resetting it.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Reported-by: syzbot+9d7405c7faa390e60b4e@syzkaller.appspotmail.com
Reported-by: syzbot+7d20bc3f1ddddc0f9079@syzkaller.appspotmail.com
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/batman-adv/soft-interface.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -221,6 +221,8 @@ static netdev_tx_t batadv_interface_tx(s
 
 	netif_trans_update(soft_iface);
 	vid = batadv_get_vid(skb, 0);
+
+	skb_reset_mac_header(skb);
 	ethhdr = eth_hdr(skb);
 
 	switch (ntohs(ethhdr->h_proto)) {


