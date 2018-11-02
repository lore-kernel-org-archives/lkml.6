Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A933EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2512084D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+Fx3Xe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2512084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeKCDwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728565AbeKCDwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:52:04 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BDA020854;
        Fri,  2 Nov 2018 18:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184231;
        bh=P79rj0hN0MtIOh+Dqs0wpOEfGPMC1We9rHekZIe5Jcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F+Fx3Xe2Tw0NApAhlONGewYyFkEC+fkU5WiDddD+Zt1GVgCQq5Z0E7YhomjLKKXj2
         GBZSLGemnomjf73jh0lrpqklOjMqDeXCBo1cPviBdg6mrJwcS4e7LRNSmFGVNhQqpQ
         ZURWO2CTFEe2k0kl+krNYKPVGbL5uGUinAxNPS2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 084/150] rxrpc: Carry call state out of locked section in rxrpc_rotate_tx_window()
Date:   Fri,  2 Nov 2018 19:34:06 +0100
Message-Id: <20181102182909.382656762@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



