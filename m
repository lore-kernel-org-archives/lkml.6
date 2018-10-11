Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C02EC67837
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84DC20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84DC20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJLFBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:01:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbeJLFBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:01:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 170DEC057E3D;
        Thu, 11 Oct 2018 21:32:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 390C482F48;
        Thu, 11 Oct 2018 21:32:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net] rxrpc: use correct kvec num when sending BUSY response
 packet
From:   David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 Oct 2018 22:32:39 +0100
Message-ID: <153929355947.15571.4673520692389673388.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 11 Oct 2018 21:32:41 +0000 (UTC)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

net/rxrpc/output.c: In function 'rxrpc_reject_packets':
net/rxrpc/output.c:527:11: warning:
 variable 'ioc' set but not used [-Wunused-but-set-variable]

'ioc' is the correct kvec num when sending a BUSY (or an ABORT) response
packet.

Fixes: ece64fec164f ("rxrpc: Emit BUSY packets when supposed to rather than ABORTs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/output.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index e8fb8922bca8..a141ee3ab812 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -572,7 +572,8 @@ void rxrpc_reject_packets(struct rxrpc_local *local)
 			whdr.flags	^= RXRPC_CLIENT_INITIATED;
 			whdr.flags	&= RXRPC_CLIENT_INITIATED;
 
-			ret = kernel_sendmsg(local->socket, &msg, iov, 2, size);
+			ret = kernel_sendmsg(local->socket, &msg,
+					     iov, ioc, size);
 			if (ret < 0)
 				trace_rxrpc_tx_fail(local->debug_id, 0, ret,
 						    rxrpc_tx_point_reject);

