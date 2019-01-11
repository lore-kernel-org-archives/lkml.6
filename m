Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABB0C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838B221841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547219398;
	bh=YvrNItZCldQ/mjigH0sxyozWASdnddTcGR1QbSG1TTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zOVUAhRGXjf4cR8prIaf9Jq0OI5WBbLqHi5ksywhw3J1r/ne20Atbfv7Kv6FBjyAu
	 dSA1TSJLTa6OLEvWuFUYG2J4gv37rMiHODe5/N0m2KAZtDFHV9J7CawCboVlUv0aBj
	 QP3MLrRSZ3Pgb6+tK2BMRsqctSgwpaGVtS/5dXZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfAKORK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:17:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387805AbfAKORH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:17:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCEA9214D8;
        Fri, 11 Jan 2019 14:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216227;
        bh=YvrNItZCldQ/mjigH0sxyozWASdnddTcGR1QbSG1TTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q+YmIFu78kPkVtF07980/LK33J8fxtoOTKV9Nf5GQ2Y2/pFDi+kwYPZ99AiznnnM/
         df3QysjRqGF+YS2aMXnxaLuvHcx6nWw78tZULIfhuJwLTbMfJtm98KDeQdDIKCmRHZ
         tT4F6okH9DrqPZomaJ9G0HZ1KlCUVPR5gj0ak5Z4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 22/88] packet: validate address length
Date:   Fri, 11 Jan 2019 15:07:51 +0100
Message-Id: <20190111131049.427523584@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 99137b7888f4058087895d035d81c6b2d31015c5 ]

Packet sockets with SOCK_DGRAM may pass an address for use in
dev_hard_header. Ensure that it is of sufficient length.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2513,6 +2513,8 @@ static int tpacket_snd(struct packet_soc
 		proto	= saddr->sll_protocol;
 		addr	= saddr->sll_addr;
 		dev = dev_get_by_index(sock_net(&po->sk), saddr->sll_ifindex);
+		if (addr && dev && saddr->sll_halen < dev->addr_len)
+			goto out;
 	}
 
 	err = -ENXIO;
@@ -2680,6 +2682,8 @@ static int packet_snd(struct socket *soc
 		proto	= saddr->sll_protocol;
 		addr	= saddr->sll_addr;
 		dev = dev_get_by_index(sock_net(sk), saddr->sll_ifindex);
+		if (addr && dev && saddr->sll_halen < dev->addr_len)
+			goto out;
 	}
 
 	err = -ENXIO;


