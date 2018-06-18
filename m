Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC7FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F9D208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F9D208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965828AbeFRIZa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:25:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56262 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965768AbeFRIZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:25:23 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9BC66C7F;
        Mon, 18 Jun 2018 08:25:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 217/279] rxrpc: Fix error reception on AF_INET6 sockets
Date:   Mon, 18 Jun 2018 10:13:22 +0200
Message-Id: <20180618080617.835384607@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit f2aeed3a591ff29a82495eeaa92ac4780bad7487 ]

AF_RXRPC tries to turn on IP_RECVERR and IP_MTU_DISCOVER on the UDP socket
it just opened for communications with the outside world, regardless of the
type of socket.  Unfortunately, this doesn't work with an AF_INET6 socket.

Fix this by turning on IPV6_RECVERR and IPV6_MTU_DISCOVER instead if the
socket is of the AF_INET6 family.

Without this, kAFS server and address rotation doesn't work correctly
because the algorithm doesn't detect received network errors.

Fixes: 75b54cb57ca3 ("rxrpc: Add IPv6 support")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/local_object.c |   57 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 15 deletions(-)

--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -133,22 +133,49 @@ static int rxrpc_open_socket(struct rxrp
 		}
 	}
 
-	/* we want to receive ICMP errors */
-	opt = 1;
-	ret = kernel_setsockopt(local->socket, SOL_IP, IP_RECVERR,
-				(char *) &opt, sizeof(opt));
-	if (ret < 0) {
-		_debug("setsockopt failed");
-		goto error;
-	}
+	switch (local->srx.transport.family) {
+	case AF_INET:
+		/* we want to receive ICMP errors */
+		opt = 1;
+		ret = kernel_setsockopt(local->socket, SOL_IP, IP_RECVERR,
+					(char *) &opt, sizeof(opt));
+		if (ret < 0) {
+			_debug("setsockopt failed");
+			goto error;
+		}
+
+		/* we want to set the don't fragment bit */
+		opt = IP_PMTUDISC_DO;
+		ret = kernel_setsockopt(local->socket, SOL_IP, IP_MTU_DISCOVER,
+					(char *) &opt, sizeof(opt));
+		if (ret < 0) {
+			_debug("setsockopt failed");
+			goto error;
+		}
+		break;
+
+	case AF_INET6:
+		/* we want to receive ICMP errors */
+		opt = 1;
+		ret = kernel_setsockopt(local->socket, SOL_IPV6, IPV6_RECVERR,
+					(char *) &opt, sizeof(opt));
+		if (ret < 0) {
+			_debug("setsockopt failed");
+			goto error;
+		}
+
+		/* we want to set the don't fragment bit */
+		opt = IPV6_PMTUDISC_DO;
+		ret = kernel_setsockopt(local->socket, SOL_IPV6, IPV6_MTU_DISCOVER,
+					(char *) &opt, sizeof(opt));
+		if (ret < 0) {
+			_debug("setsockopt failed");
+			goto error;
+		}
+		break;
 
-	/* we want to set the don't fragment bit */
-	opt = IP_PMTUDISC_DO;
-	ret = kernel_setsockopt(local->socket, SOL_IP, IP_MTU_DISCOVER,
-				(char *) &opt, sizeof(opt));
-	if (ret < 0) {
-		_debug("setsockopt failed");
-		goto error;
+	default:
+		BUG();
 	}
 
 	/* set the socket up */


