Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B14AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687AF222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083619;
	bh=0vV8SkjlVGikjtuJR9BQnGMJqvfC+g6EJjWvqmE1+jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DB/sn2dFdYk+B4eN57ZnG4RjL3pV0r/YcWytg32yXDkjR5S2Z38tVIQB/7K9pgnzq
	 DAcxukn+2OiRwspsVciPjNvi9QaPkm8o7g+AxberIpOBvZeyGrnRjzTDmpqob6pGyV
	 Fhn9uox+8KrOj2bYSCZRTEI2LKZOVh0nh1NxH0tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406556AbfBMSq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:46:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389765AbfBMSqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:46:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72F3020835;
        Wed, 13 Feb 2019 18:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083614;
        bh=0vV8SkjlVGikjtuJR9BQnGMJqvfC+g6EJjWvqmE1+jA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zDUqbPtLPyUHmLrmeC0dSGVQZozpNg+TDvzvp7rIhiZzEQsqcgRyyo9HCKzj9lvGk
         IlLd/gWhn72YpwjUMCFp+uHqN+Msg6xk5vltvzNMbXv0EgieHYc7wZ6BnlgFiYSXhy
         7lxM6h/Dg4pXYy0ZsmeRxy5VFmQu0xVVKVno7XA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+9d7405c7faa390e60b4e@syzkaller.appspotmail.com,
        syzbot+7d20bc3f1ddddc0f9079@syzkaller.appspotmail.com,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4.20 50/50] batman-adv: Force mac header to start of data on xmit
Date:   Wed, 13 Feb 2019 19:38:55 +0100
Message-Id: <20190213183659.596955407@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
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


