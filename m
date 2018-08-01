Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7440BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAA9208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAA9208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389330AbeHAOok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:44:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389226AbeHAOok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:44:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 392087A7E5;
        Wed,  1 Aug 2018 12:59:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD06F1C5B5;
        Wed,  1 Aug 2018 12:58:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 02/10] rxrpc: Display call expect-receive-by
 timeout in proc
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Aug 2018 13:58:58 +0100
Message-ID: <153312833821.27702.13554232112049667282.stgit@warthog.procyon.org.uk>
In-Reply-To: <153312832565.27702.15302541876382957550.stgit@warthog.procyon.org.uk>
References: <153312832565.27702.15302541876382957550.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 01 Aug 2018 12:59:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 01 Aug 2018 12:59:00 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display in /proc/net/rxrpc/calls the timeout by which a call next expects
to receive a packet.

This makes it easier to debug timeout issues.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/proc.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index d9fca8c4bcdc..bc6f27c8869d 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -63,6 +63,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 	struct rxrpc_peer *peer;
 	struct rxrpc_call *call;
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
+	unsigned long timeout = 0, nowj;
 	rxrpc_seq_t tx_hard_ack, rx_hard_ack;
 	char lbuff[50], rbuff[50];
 
@@ -71,7 +72,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 			 "Proto Local                                          "
 			 " Remote                                         "
 			 " SvID ConnID   CallID   End Use State    Abort   "
-			 " UserID\n");
+			 " UserID           TxSeq    TW RxSeq    RW RxTimo\n");
 		return 0;
 	}
 
@@ -94,11 +95,17 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 	else
 		strcpy(rbuff, "no_connection");
 
+	if (call->state != RXRPC_CALL_SERVER_PREALLOC) {
+		timeout = READ_ONCE(call->expect_rx_by);
+		nowj = jiffies;
+		timeout -= jiffies;
+	}
+
 	tx_hard_ack = READ_ONCE(call->tx_hard_ack);
 	rx_hard_ack = READ_ONCE(call->rx_hard_ack);
 	seq_printf(seq,
 		   "UDP   %-47.47s %-47.47s %4x %08x %08x %s %3u"
-		   " %-8.8s %08x %lx %08x %02x %08x %02x\n",
+		   " %-8.8s %08x %lx %08x %02x %08x %02x %06lx\n",
 		   lbuff,
 		   rbuff,
 		   call->service_id,
@@ -110,7 +117,8 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 		   call->abort_code,
 		   call->user_call_ID,
 		   tx_hard_ack, READ_ONCE(call->tx_top) - tx_hard_ack,
-		   rx_hard_ack, READ_ONCE(call->rx_top) - rx_hard_ack);
+		   rx_hard_ack, READ_ONCE(call->rx_top) - rx_hard_ack,
+		   timeout);
 
 	return 0;
 }

