Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BB3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E808921527
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E808921527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbeKLFsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51028 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730689AbeKLFs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:29 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvso-0000l6-QA; Sun, 11 Nov 2018 19:58:58 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsX-0001lA-Kt; Sun, 11 Nov 2018 19:58:41 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Florian Westphal" <fw@strlen.de>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.56502654@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 277/366] atl1c: reserve min skb headroom
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 6e56830776828d8ca9897fc4429eeab47c3bb432 upstream.

Got crash report with following backtrace:
BUG: unable to handle kernel paging request at ffff8801869daffe
RIP: 0010:[<ffffffff816429c4>]  [<ffffffff816429c4>] ip6_finish_output2+0x394/0x4c0
RSP: 0018:ffff880186c83a98  EFLAGS: 00010283
RAX: ffff8801869db00e ...
  [<ffffffff81644cdc>] ip6_finish_output+0x8c/0xf0
  [<ffffffff81644d97>] ip6_output+0x57/0x100
  [<ffffffff81643dc9>] ip6_forward+0x4b9/0x840
  [<ffffffff81645566>] ip6_rcv_finish+0x66/0xc0
  [<ffffffff81645db9>] ipv6_rcv+0x319/0x530
  [<ffffffff815892ac>] netif_receive_skb+0x1c/0x70
  [<ffffffffc0060bec>] atl1c_clean+0x1ec/0x310 [atl1c]
  ...

The bad access is in neigh_hh_output(), at skb->data - 16 (HH_DATA_MOD).
atl1c driver provided skb with no headroom, so 14 bytes (ethernet
header) got pulled, but then 16 are copied.

Reserve NET_SKB_PAD bytes headroom, like netdev_alloc_skb().

Compile tested only; I lack hardware.

Fixes: 7b7017642199 ("atl1c: Fix misuse of netdev_alloc_skb in refilling rx ring")
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -1674,6 +1674,7 @@ static struct sk_buff *atl1c_alloc_skb(s
 	skb = build_skb(page_address(page) + adapter->rx_page_offset,
 			adapter->rx_frag_size);
 	if (likely(skb)) {
+		skb_reserve(skb, NET_SKB_PAD);
 		adapter->rx_page_offset += adapter->rx_frag_size;
 		if (adapter->rx_page_offset >= PAGE_SIZE)
 			adapter->rx_page = NULL;

