Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCF7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3F1206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865709;
	bh=0xLUIajsQJ9mtEw6R5TFXOdmeLoQ5AJX7MpZ5wkKfSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QJP+q2Eo7Yyhp1mPB0aRssn6kvNzQI99fesMkri+5tCW8vVs1F2E+Yc9RUJOPd5eh
	 7m+VLZVjJ5Y2Ffbyr2Xe8mS742OukDcFRjKjTk2nHYFEAmbPxWfKNrmo8CkZ1kWzow
	 sxcG0uZctm5Jt38yI6iUQxKBKzhxQKQUXVgWxv0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfAGMzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:55:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729165AbfAGMs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9446E20651;
        Mon,  7 Jan 2019 12:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865306;
        bh=0xLUIajsQJ9mtEw6R5TFXOdmeLoQ5AJX7MpZ5wkKfSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJY9HA/GAGqZ4WrwyapTHwVB8lcPxVjfyF/X/cSN796AFE5w2FCjDTTi80CWN3KTS
         VzqiQc5vvDQa83sdGxcU6tD4iRUUdWWSywUOL4N1CeRQeR8w8j4kJx/prmHLp/dwt7
         3A3aZx6Kqo84mTCIf3xekRuXnnL6YhjaZHLgdsO0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 023/170] packet: validate address length
Date:   Mon,  7 Jan 2019 13:30:50 +0100
Message-Id: <20190107104455.787018910@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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
@@ -2627,6 +2627,8 @@ static int tpacket_snd(struct packet_soc
 		proto	= saddr->sll_protocol;
 		addr	= saddr->sll_addr;
 		dev = dev_get_by_index(sock_net(&po->sk), saddr->sll_ifindex);
+		if (addr && dev && saddr->sll_halen < dev->addr_len)
+			goto out;
 	}
 
 	err = -ENXIO;
@@ -2825,6 +2827,8 @@ static int packet_snd(struct socket *soc
 		proto	= saddr->sll_protocol;
 		addr	= saddr->sll_addr;
 		dev = dev_get_by_index(sock_net(sk), saddr->sll_ifindex);
+		if (addr && dev && saddr->sll_halen < dev->addr_len)
+			goto out;
 	}
 
 	err = -ENXIO;


