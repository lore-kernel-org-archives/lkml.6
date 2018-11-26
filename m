Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60D0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8BF21473
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoPrN5Af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8BF21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeKZVqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:46:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbeKZVqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:46:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB50B21104;
        Mon, 26 Nov 2018 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229559;
        bh=pJxNv8rUrg8qKDAHAa3oSjNjwQ0klkXzLOEFDoASijk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VoPrN5Af82j1vHecb81Z+oDczs48bO6QFplCA83xD+yfZhxAx+epsO3Lf41+THC7C
         P5zZ84wKbE1Wv9MqtNo0a7s1sEMF2Njz5ePFsgQcytBLDUvRoCy6NDygW94K7Wwyp0
         yl68iVURn7+7BCOjyXCToPBzRz0q23mDfsTLPQqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 01/24] net-gro: reset skb->pkt_type in napi_reuse_skb()
Date:   Mon, 26 Nov 2018 11:50:55 +0100
Message-Id: <20181126105029.963465279@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105029.790599475@linuxfoundation.org>
References: <20181126105029.790599475@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 33d9a2c72f086cbf1087b2fd2d1a15aa9df14a7f ]

eth_type_trans() assumes initial value for skb->pkt_type
is PACKET_HOST.

This is indeed the value right after a fresh skb allocation.

However, it is possible that GRO merged a packet with a different
value (like PACKET_OTHERHOST in case macvlan is used), so
we need to make sure napi->skb will have pkt_type set back to
PACKET_HOST.

Otherwise, valid packets might be dropped by the stack because
their pkt_type is not PACKET_HOST.

napi_reuse_skb() was added in commit 96e93eab2033 ("gro: Add
internal interfaces for VLAN"), but this bug always has
been there.

Fixes: 96e93eab2033 ("gro: Add internal interfaces for VLAN")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4201,6 +4201,10 @@ static void napi_reuse_skb(struct napi_s
 	skb->vlan_tci = 0;
 	skb->dev = napi->dev;
 	skb->skb_iif = 0;
+
+	/* eth_type_trans() assumes pkt_type is PACKET_HOST */
+	skb->pkt_type = PACKET_HOST;
+
 	skb->encapsulation = 0;
 	skb_shinfo(skb)->gso_type = 0;
 	skb->truesize = SKB_TRUESIZE(skb_end_offset(skb));


