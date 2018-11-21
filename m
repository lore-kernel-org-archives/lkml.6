Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AC1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37002151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhEcxyJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37002151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbeKVFpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732102AbeKVFpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:45:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B836206BB;
        Wed, 21 Nov 2018 19:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827368;
        bh=7wRg1cQoSHyUH8t6RqLifDV9MUE0rMfPR3nx1vxQCSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhEcxyJn1ZvdF/Uwjy8rsBcF5+P2XEMNjEuSobnYkSAtY2jP9gOw4Uv6tnu9VbXD+
         bvO63UpsjDRhhw4CMxt43iqLOZjFcxx3Zy76ktxCWS0OahSbxNwpmshJE7HjGTF/3y
         qjndRRDYoHSFwUUdb/RJgT+K7VmD65czE4iossok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 05/21] net-gro: reset skb->pkt_type in napi_reuse_skb()
Date:   Wed, 21 Nov 2018 20:06:49 +0100
Message-Id: <20181121183422.316187694@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183422.103826775@linuxfoundation.org>
References: <20181121183422.103826775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4993,6 +4993,10 @@ static void napi_reuse_skb(struct napi_s
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


