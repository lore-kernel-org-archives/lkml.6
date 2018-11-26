Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B20C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14BC20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GafBDE6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14BC20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeKZVre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:47:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeKZVrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:47:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35F882089F;
        Mon, 26 Nov 2018 10:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229627;
        bh=Y5qMITy+GG7Oxmf5I/NQXpDAkrmoTf0AA01D3W3O5lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GafBDE6YJPi73HhJcNMQRVm+v7oOCJPAfgZOm57tcOc88cH1W4BASHXrAP6bDOYXd
         nARCQEGcziEMpVQyiS6n5AZA04Tgqbh/tGEf3no2NzBQPdot+y1vfyB5McQD58UbJ8
         ZCIaZU7nmF5lFJkdErwaNXc9CmTNY3KmaHFNl6uc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 03/70] net-gro: reset skb->pkt_type in napi_reuse_skb()
Date:   Mon, 26 Nov 2018 11:50:18 +0100
Message-Id: <20181126105047.236363945@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4481,6 +4481,10 @@ static void napi_reuse_skb(struct napi_s
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


