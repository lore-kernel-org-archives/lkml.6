Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E215C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB74208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB74208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389495AbeHAOpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:45:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389476AbeHAOpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:45:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 089B47DAC7;
        Wed,  1 Aug 2018 12:59:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B98620180EB;
        Wed,  1 Aug 2018 12:59:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 10/10] rxrpc: Transmit more ACKs during data
 reception
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Aug 2018 13:59:50 +0100
Message-ID: <153312839071.27702.9716522833877492451.stgit@warthog.procyon.org.uk>
In-Reply-To: <153312832565.27702.15302541876382957550.stgit@warthog.procyon.org.uk>
References: <153312832565.27702.15302541876382957550.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 01 Aug 2018 12:59:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 01 Aug 2018 12:59:52 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Immediately flush any outstanding ACK on entry to rxrpc_recvmsg_data() -
which transfers data to the target buffers - if we previously had an Rx
underrun (ie. we returned -EAGAIN because we ran out of received data).
This lets the server know what we've managed to receive something.

Also flush any outstanding ACK after calling the function if it hit -EAGAIN
to let the server know we processed some data.

It might be better to send more ACKs, possibly on a time-based scheme, but
that needs some more consideration.

With this and some additional AFS patches, it is possible to get large
unencrypted O_DIRECT reads to be almost as fast as NFS over TCP.  It looks
like it might be theoretically possible to improve performance yet more for
a server running a single operation as investigation of packet timestamps
indicates that the server keeps stalling.

The issue appears to be that rxrpc runs in to trouble with ACK packets
getting batched together (up to ~32 at a time) somewhere between the IP
transmit queue on the client and the ethernet receive queue on the server.

However, this case isn't too much of a worry as even a lightly loaded
server should be receiving sufficient packet flux to flush the ACK packets
to the UDP socket.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/ar-internal.h |    1 +
 net/rxrpc/recvmsg.c     |   17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index e791d35ee34b..9d9278a13d91 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -479,6 +479,7 @@ enum rxrpc_call_flag {
 	RXRPC_CALL_RETRANS_TIMEOUT,	/* Retransmission due to timeout occurred */
 	RXRPC_CALL_BEGAN_RX_TIMER,	/* We began the expect_rx_by timer */
 	RXRPC_CALL_RX_HEARD,		/* The peer responded at least once to this call */
+	RXRPC_CALL_RX_UNDERRUN,		/* Got data underrun */
 };
 
 /*
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 02f1f768e16a..a57ea96c84ea 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -313,6 +313,10 @@ static int rxrpc_recvmsg_data(struct socket *sock, struct rxrpc_call *call,
 	unsigned int rx_pkt_offset, rx_pkt_len;
 	int ix, copy, ret = -EAGAIN, ret2;
 
+	if (test_and_clear_bit(RXRPC_CALL_RX_UNDERRUN, &call->flags) &&
+	    call->ackr_reason)
+		rxrpc_send_ack_packet(call, false, NULL);
+
 	rx_pkt_offset = call->rx_pkt_offset;
 	rx_pkt_len = call->rx_pkt_len;
 
@@ -412,6 +416,8 @@ static int rxrpc_recvmsg_data(struct socket *sock, struct rxrpc_call *call,
 done:
 	trace_rxrpc_recvmsg(call, rxrpc_recvmsg_data_return, seq,
 			    rx_pkt_offset, rx_pkt_len, ret);
+	if (ret == -EAGAIN)
+		set_bit(RXRPC_CALL_RX_UNDERRUN, &call->flags);
 	return ret;
 }
 
@@ -684,6 +690,17 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 read_phase_complete:
 	ret = 1;
 out:
+	switch (call->ackr_reason) {
+	case RXRPC_ACK_IDLE:
+		break;
+	case RXRPC_ACK_DELAY:
+		if (ret != -EAGAIN)
+			break;
+		/* Fall through */
+	default:
+		rxrpc_send_ack_packet(call, false, NULL);
+	}
+
 	if (_service)
 		*_service = call->service_id;
 	mutex_unlock(&call->user_mutex);

