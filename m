Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412D4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046B120862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046B120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407997AbeHATSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:18:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52918 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436570AbeHATSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 98753E9C;
        Wed,  1 Aug 2018 16:54:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 037/336] rxrpc: Fix terminal retransmission connection ID to include the channel
Date:   Wed,  1 Aug 2018 18:46:12 +0200
Message-Id: <20180801165030.503060011@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit fb1967a69f756073362b8f19347f863f227320ad ]

When retransmitting the final ACK or ABORT packet for a call, the cid field
in the packet header is set to the connection's cid, but this is incorrect
as it also needs to include the channel number on that connection that the
call was made on.

Fix this by OR'ing in the channel number.

Note that this fixes the bug that:

	commit 1a025028d400b23477341aa7ec2ce55f8b39b554
	rxrpc: Fix handling of call quietly cancelled out on server

works around.  I'm not intending to revert that as it will help protect
against problems that might occur on the server.

Fixes: 3136ef49a14c ("rxrpc: Delay terminal ACK transmission on a client call")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/conn_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -70,7 +70,7 @@ static void rxrpc_conn_retransmit_call(s
 	iov[2].iov_len	= sizeof(ack_info);
 
 	pkt.whdr.epoch		= htonl(conn->proto.epoch);
-	pkt.whdr.cid		= htonl(conn->proto.cid);
+	pkt.whdr.cid		= htonl(conn->proto.cid | channel);
 	pkt.whdr.callNumber	= htonl(call_id);
 	pkt.whdr.seq		= 0;
 	pkt.whdr.type		= chan->last_type;


