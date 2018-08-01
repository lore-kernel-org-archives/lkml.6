Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCB7C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7263320894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7263320894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389376AbeHAOox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:44:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389190AbeHAOow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:44:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 85AFE40201BE;
        Wed,  1 Aug 2018 12:59:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 050041C5B5;
        Wed,  1 Aug 2018 12:59:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 04/10] rxrpc: Fix the trace for terminal ACK
 (re)transmission
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Aug 2018 13:59:11 +0100
Message-ID: <153312835153.27702.11321927839615131736.stgit@warthog.procyon.org.uk>
In-Reply-To: <153312832565.27702.15302541876382957550.stgit@warthog.procyon.org.uk>
References: <153312832565.27702.15302541876382957550.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 01 Aug 2018 12:59:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 01 Aug 2018 12:59:12 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the trace for terminal ACK (re)transmission to put in the right
parameters.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/conn_event.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 8229a52c2acd..d46a68807f08 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -129,8 +129,10 @@ static void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 		_proto("Tx ABORT %%%u { %d } [re]", serial, conn->local_abort);
 		break;
 	case RXRPC_PACKET_TYPE_ACK:
-		trace_rxrpc_tx_ack(NULL, serial, chan->last_seq, 0,
-				   RXRPC_ACK_DUPLICATE, 0);
+		trace_rxrpc_tx_ack(NULL, serial,
+				   ntohl(pkt.ack.firstPacket),
+				   ntohl(pkt.ack.serial),
+				   pkt.ack.reason, 0);
 		_proto("Tx ACK %%%u [re]", serial);
 		break;
 	}

