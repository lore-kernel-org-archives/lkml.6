Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DFDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B862089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866323;
	bh=zFRRhkLQmTQe0SxpQjl8SECTQkTaelCdvY/6mzqUnfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D5f/c5Vp5a0BR5c+QFMelz1Ec8qUug/uosJ2aSzgNEHUMRhKK42Ri4c5JrR5UlcCB
	 LySxZyIJDnFXsjgTh6DMtau4Z+ZMxfWuBNW3ZESmSY6Fd0/DhZ1TUuDSS2Aqb+Hefp
	 alN7X3NAzQC1WHLN55pMgW/5+Ss4yE7VNVlJhGLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbfAGNFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729264AbfAGNFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:05:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DEB22183F;
        Mon,  7 Jan 2019 13:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866319;
        bh=zFRRhkLQmTQe0SxpQjl8SECTQkTaelCdvY/6mzqUnfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rG0DMP/DEJIcxcJ4DGlhGvTdKbaA005L47HqRodhSMSDRRzWbw/HTyi/8+wp0adNP
         fbGTLepwX/0thEgPSkfrhvR5MYJtWgEs4o5o+77kgTaPQ6XIeeXnmiY8Hwjl8BffN3
         W3OV3NfM0o+LsJ7U5oyYIZc5t7zgBvlyficdhUjc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@idosch.org>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 17/71] packet: validate address length if non-zero
Date:   Mon,  7 Jan 2019 13:32:46 +0100
Message-Id: <20190107105332.602797054@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 6b8d95f1795c42161dc0984b6863e95d6acf24ed ]

Validate packet socket address length if a length is given. Zero
length is equivalent to not setting an address.

Fixes: 99137b7888f4 ("packet: validate address length")
Reported-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2660,7 +2660,7 @@ static int tpacket_snd(struct packet_soc
 						sll_addr)))
 			goto out;
 		proto	= saddr->sll_protocol;
-		addr	= saddr->sll_addr;
+		addr	= saddr->sll_halen ? saddr->sll_addr : NULL;
 		dev = dev_get_by_index(sock_net(&po->sk), saddr->sll_ifindex);
 		if (addr && dev && saddr->sll_halen < dev->addr_len)
 			goto out;
@@ -2859,7 +2859,7 @@ static int packet_snd(struct socket *soc
 		if (msg->msg_namelen < (saddr->sll_halen + offsetof(struct sockaddr_ll, sll_addr)))
 			goto out;
 		proto	= saddr->sll_protocol;
-		addr	= saddr->sll_addr;
+		addr	= saddr->sll_halen ? saddr->sll_addr : NULL;
 		dev = dev_get_by_index(sock_net(sk), saddr->sll_ifindex);
 		if (addr && dev && saddr->sll_halen < dev->addr_len)
 			goto out;


