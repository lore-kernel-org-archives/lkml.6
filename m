Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D33EC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699732084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699732084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeJDUoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:44:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbeJDUoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:44:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA05480F6B;
        Thu,  4 Oct 2018 13:50:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04D8D690F9;
        Thu,  4 Oct 2018 13:50:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 2/9] rxrpc: Emit the data Tx trace line before
 transmitting
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 14:50:49 +0100
Message-ID: <153866104992.27255.1703827313979474969.stgit@warthog.procyon.org.uk>
In-Reply-To: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
References: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 04 Oct 2018 13:50:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print the data Tx trace line before transmitting so that it appears before
the trace lines indicating success or failure of the transmission.  This
makes the trace log less confusing.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/output.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index e8fb8922bca8..993d4cd247f9 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -378,11 +378,13 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 		if ((lose++ & 7) == 7) {
 			ret = 0;
 			lost = true;
-			goto done;
 		}
 	}
 
-	_proto("Tx DATA %%%u { #%u }", serial, sp->hdr.seq);
+	trace_rxrpc_tx_data(call, sp->hdr.seq, serial, whdr.flags,
+			    retrans, lost);
+	if (lost)
+		goto done;
 
 	/* send the packet with the don't fragment bit set if we currently
 	 * think it's small enough */
@@ -415,8 +417,6 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 		goto send_fragmentable;
 
 done:
-	trace_rxrpc_tx_data(call, sp->hdr.seq, serial, whdr.flags,
-			    retrans, lost);
 	if (ret >= 0) {
 		if (whdr.flags & RXRPC_REQUEST_ACK) {
 			call->peer->rtt_last_req = skb->tstamp;

