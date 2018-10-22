Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A54C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333A120881
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7lDnkbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333A120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbeJVSnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728747AbeJVShn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:37:43 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64FA72087D;
        Mon, 22 Oct 2018 10:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203588;
        bh=WsP4ASvE6cdM5WB4YHTxJiuz8QGrUDZl/Bg9LwHDkck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e7lDnkbIFkAsG3bWxRu79lDhrGDAGWLcGJBBP7YOpWYT3A5kDmAWVGxUCbK7ePyQy
         eGn8oXNxrxaXFyXv0X9DjKx5bnRD7nVK19yVZdPuNpQiSI8E7BcV8hrhRhdP2PuzGE
         Q9nOGe4Bs40VbM9yd1791I/3uxnbWZwAiATwKhnM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 11/27] rxrpc: Carry call state out of locked section in rxrpc_rotate_tx_window()
Date:   Mon, 22 Oct 2018 06:19:08 -0400
Message-Id: <20181022101924.40531-11-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022101924.40531-1-sashal@kernel.org>
References: <20181022101924.40531-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit dfe995224693798e554ab4770f6d8a096afc60cd ]

Carry the call state out of the locked section in rxrpc_rotate_tx_window()
rather than sampling it afterwards.  This is only used to select tracepoint
data, but could have changed by the time we do the tracepoint.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/input.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 5e180a3c2d01..fe1cf206d12a 100644
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
 
-- 
2.17.1

