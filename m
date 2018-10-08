Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38677C6787A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38A7206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38A7206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeJIGCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:02:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbeJIGCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:02:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B0B2A8831A;
        Mon,  8 Oct 2018 22:48:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FB2A6DAE9;
        Mon,  8 Oct 2018 22:48:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 07/10] rxrpc: Only take the rwind and mtu values from
 latest ACK
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, pabeni@redhat.com, eric.dumazet@gmail.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Oct 2018 23:48:10 +0100
Message-ID: <153903889076.17944.18262157992091484473.stgit@warthog.procyon.org.uk>
In-Reply-To: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
References: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 08 Oct 2018 22:48:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the out-of-order and duplicate ACK packet check to before the call to
rxrpc_input_ackinfo() so that the receive window size and MTU size are only
checked in the latest ACK packet and don't regress.

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/input.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index af8ce64f4162..04213a65c1ac 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -868,6 +868,16 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb,
 				  rxrpc_propose_ack_respond_to_ack);
 	}
 
+	/* Discard any out-of-order or duplicate ACKs. */
+	if (before_eq(sp->hdr.serial, call->acks_latest)) {
+		_debug("discard ACK %d <= %d",
+		       sp->hdr.serial, call->acks_latest);
+		return;
+	}
+	call->acks_latest_ts = skb->tstamp;
+	call->acks_latest = sp->hdr.serial;
+
+	/* Parse rwind and mtu sizes if provided. */
 	ioffset = offset + nr_acks + 3;
 	if (skb->len >= ioffset + sizeof(buf.info)) {
 		if (skb_copy_bits(skb, ioffset, &buf.info, sizeof(buf.info)) < 0)
@@ -889,15 +899,6 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb,
 		return;
 	}
 
-	/* Discard any out-of-order or duplicate ACKs. */
-	if (before_eq(sp->hdr.serial, call->acks_latest)) {
-		_debug("discard ACK %d <= %d",
-		       sp->hdr.serial, call->acks_latest);
-		return;
-	}
-	call->acks_latest_ts = skb->tstamp;
-	call->acks_latest = sp->hdr.serial;
-
 	if (before(hard_ack, call->tx_hard_ack) ||
 	    after(hard_ack, call->tx_top))
 		return rxrpc_proto_abort("AKW", call, 0);

