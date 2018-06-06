Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9DB5C60764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeFFN7R (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:59:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751851AbeFFN7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:59:16 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net] rxrpc: Fix terminal retransmission connection ID to
 include the channel
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Wed, 06 Jun 2018 14:59:14 +0100
Message-ID: <152829355456.15682.4887593676960385184.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

 net/rxrpc/conn_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 1350f1be8037..8229a52c2acd 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -70,7 +70,7 @@ static void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 	iov[2].iov_len	= sizeof(ack_info);
 
 	pkt.whdr.epoch		= htonl(conn->proto.epoch);
-	pkt.whdr.cid		= htonl(conn->proto.cid);
+	pkt.whdr.cid		= htonl(conn->proto.cid | channel);
 	pkt.whdr.callNumber	= htonl(call_id);
 	pkt.whdr.seq		= 0;
 	pkt.whdr.type		= chan->last_type;
