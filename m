Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFDCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D133720867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D133720867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeICVLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:11:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36146 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbeICVLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:11:32 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1ED23CF4;
        Mon,  3 Sep 2018 16:50:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 17/56] atl1c: reserve min skb headroom
Date:   Mon,  3 Sep 2018 18:49:07 +0200
Message-Id: <20180903164924.953648522@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 6e56830776828d8ca9897fc4429eeab47c3bb432 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c |    1 +
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


