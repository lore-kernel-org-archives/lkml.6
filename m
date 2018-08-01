Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CC7C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309E220894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309E220894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389356AbeHAOor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:44:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389332AbeHAOoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:44:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 610B24021703;
        Wed,  1 Aug 2018 12:59:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D20F02026D68;
        Wed,  1 Aug 2018 12:59:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 03/10] rxrpc: Show some more information through
 /proc files
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Aug 2018 13:59:05 +0100
Message-ID: <153312834537.27702.4145252451419809571.stgit@warthog.procyon.org.uk>
In-Reply-To: <153312832565.27702.15302541876382957550.stgit@warthog.procyon.org.uk>
References: <153312832565.27702.15302541876382957550.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 01 Aug 2018 12:59:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 01 Aug 2018 12:59:06 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show the four current call IDs in /proc/net/rxrpc/conns.

Show the current packet Rx serial number in /proc/net/rxrpc/calls.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/proc.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index bc6f27c8869d..163d05df339d 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -72,7 +72,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 			 "Proto Local                                          "
 			 " Remote                                         "
 			 " SvID ConnID   CallID   End Use State    Abort   "
-			 " UserID           TxSeq    TW RxSeq    RW RxTimo\n");
+			 " UserID           TxSeq    TW RxSeq    RW RxSerial RxTimo\n");
 		return 0;
 	}
 
@@ -105,7 +105,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 	rx_hard_ack = READ_ONCE(call->rx_hard_ack);
 	seq_printf(seq,
 		   "UDP   %-47.47s %-47.47s %4x %08x %08x %s %3u"
-		   " %-8.8s %08x %lx %08x %02x %08x %02x %06lx\n",
+		   " %-8.8s %08x %lx %08x %02x %08x %02x %08x %06lx\n",
 		   lbuff,
 		   rbuff,
 		   call->service_id,
@@ -118,6 +118,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 		   call->user_call_ID,
 		   tx_hard_ack, READ_ONCE(call->tx_top) - tx_hard_ack,
 		   rx_hard_ack, READ_ONCE(call->rx_top) - rx_hard_ack,
+		   call->rx_serial,
 		   timeout);
 
 	return 0;
@@ -187,7 +188,7 @@ static int rxrpc_connection_seq_show(struct seq_file *seq, void *v)
 print:
 	seq_printf(seq,
 		   "UDP   %-47.47s %-47.47s %4x %08x %s %3u"
-		   " %s %08x %08x %08x\n",
+		   " %s %08x %08x %08x %08x %08x %08x %08x\n",
 		   lbuff,
 		   rbuff,
 		   conn->service_id,
@@ -197,7 +198,11 @@ static int rxrpc_connection_seq_show(struct seq_file *seq, void *v)
 		   rxrpc_conn_states[conn->state],
 		   key_serial(conn->params.key),
 		   atomic_read(&conn->serial),
-		   conn->hi_serial);
+		   conn->hi_serial,
+		   conn->channels[0].call_id,
+		   conn->channels[1].call_id,
+		   conn->channels[2].call_id,
+		   conn->channels[3].call_id);
 
 	return 0;
 }

