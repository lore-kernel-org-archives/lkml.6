Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72541C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A752089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866318;
	bh=LM3y4/RZUVi5YB9ygjkpSbJXWL9V1DctC32beVMlU3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rDg3gEHCUCbyE9b2TpR0wGTyvz1xGV68m6mzOv4phHEpcyV9JIKp+79xWmUBRCWAn
	 a63iWwoIvgoXz5DOluwW07QWqqoUBtcliOEsKf8Q4PpXIo6L9n2ZgEaiJsuUm8teph
	 PpA10Vg/maxFicyGHKiV/diIK38N0EC3lWGFHZYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbfAGNFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:05:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbfAGNFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:05:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2895B2089F;
        Mon,  7 Jan 2019 13:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866312;
        bh=LM3y4/RZUVi5YB9ygjkpSbJXWL9V1DctC32beVMlU3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wevFT1YvVe6XQh1kuCC9nRItLmFpGwSN1Wg8bnEmSu3YPTHD29I8fxOMy7KVpvyCM
         v1Lfbrequ9kmK08pZTwT6WHCYqa8huODxV+7eJuELVycTjV6irGp2o44iWdxbtSfP/
         bZqvRliOUQC4ty119b7amp0LQWk/jcyurjXx3EgE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 16/71] packet: validate address length
Date:   Mon,  7 Jan 2019 13:32:45 +0100
Message-Id: <20190107105332.302209202@linuxfoundation.org>
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
@@ -2662,6 +2662,8 @@ static int tpacket_snd(struct packet_soc
 		proto	= saddr->sll_protocol;
 		addr	= saddr->sll_addr;
 		dev = dev_get_by_index(sock_net(&po->sk), saddr->sll_ifindex);
+		if (addr && dev && saddr->sll_halen < dev->addr_len)
+			goto out;
 	}
 
 	err = -ENXIO;
@@ -2859,6 +2861,8 @@ static int packet_snd(struct socket *soc
 		proto	= saddr->sll_protocol;
 		addr	= saddr->sll_addr;
 		dev = dev_get_by_index(sock_net(sk), saddr->sll_ifindex);
+		if (addr && dev && saddr->sll_halen < dev->addr_len)
+			goto out;
 	}
 
 	err = -ENXIO;


