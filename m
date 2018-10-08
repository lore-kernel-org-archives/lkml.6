Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CA1C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48661214DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48661214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJIGCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:02:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbeJIGCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:02:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84773307D912;
        Mon,  8 Oct 2018 22:48:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46726261AB;
        Mon,  8 Oct 2018 22:48:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 06/10] rxrpc: Carry call state out of locked section in
 rxrpc_rotate_tx_window()
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, pabeni@redhat.com, eric.dumazet@gmail.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Oct 2018 23:48:03 +0100
Message-ID: <153903888348.17944.12633118494706316191.stgit@warthog.procyon.org.uk>
In-Reply-To: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
References: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 08 Oct 2018 22:48:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carry the call state out of the locked section in rxrpc_rotate_tx_window()
rather than sampling it afterwards.  This is only used to select tracepoint
data, but could have changed by the time we do the tracepoint.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/input.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 8834aa627371..af8ce64f4162 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -278,23 +278,26 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 static bool rxrpc_end_tx_phase(struct rxrpc_call *call, bool reply_begun,
 			       const char *abort_why)
 {
+	unsigned int state;
 
 	ASSERT(test_bit(RXRPC_CALL_TX_LAST, &call->flags));
 
 	write_lock(&call->state_lock);
 
-	switch (call->state) {
+	state = call->state;
+	switch (state) {
 	case RXRPC_CALL_CLIENT_SEND_REQUEST:
 	case RXRPC_CALL_CLIENT_AWAIT_REPLY:
 		if (reply_begun)
-			call->state = RXRPC_CALL_CLIENT_RECV_REPLY;
+			call->state = state = RXRPC_CALL_CLIENT_RECV_REPLY;
 		else
-			call->state = RXRPC_CALL_CLIENT_AWAIT_REPLY;
+			call->state = state = RXRPC_CALL_CLIENT_AWAIT_REPLY;
 		break;
 
 	case RXRPC_CALL_SERVER_AWAIT_ACK:
 		__rxrpc_call_completed(call);
 		rxrpc_notify_socket(call);
+		state = call->state;
 		break;
 
 	default:
@@ -302,11 +305,10 @@ static bool rxrpc_end_tx_phase(struct rxrpc_call *call, bool reply_begun,
 	}
 
 	write_unlock(&call->state_lock);
-	if (call->state == RXRPC_CALL_CLIENT_AWAIT_REPLY) {
+	if (state == RXRPC_CALL_CLIENT_AWAIT_REPLY)
 		trace_rxrpc_transmit(call, rxrpc_transmit_await_reply);
-	} else {
+	else
 		trace_rxrpc_transmit(call, rxrpc_transmit_end);
-	}
 	_leave(" = ok");
 	return true;
 

