Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DA0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071E82084A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071E82084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbeHWM12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:27:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHWM11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:27:27 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 416DACA0;
        Thu, 23 Aug 2018 08:58:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 203/324] tipc: fix correct setting of message type in second discoverer
Date:   Thu, 23 Aug 2018 09:54:29 +0200
Message-Id: <20180823075006.295218239@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Maloy <jon.maloy@ericsson.com>

[ Upstream commit 92018c7ca959ccd346d6235dac03cf7fc1ba51f7 ]

The duplicate address discovery protocol is not safe against two
discoverers running in parallel. The one executing first after the
trial period is over will set the node address and change its own
message type to DSC_REQ_MSG. The one executing last may find that the
node address is already set, and never change message type, with the
result that its links may never be established.

In this commmit we ensure that the message type always is set correctly
after the trial period is over.

Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash values")
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/discover.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/net/tipc/discover.c
+++ b/net/tipc/discover.c
@@ -287,7 +287,6 @@ static void tipc_disc_timeout(struct tim
 {
 	struct tipc_discoverer *d = from_timer(d, t, timer);
 	struct tipc_net *tn = tipc_net(d->net);
-	u32 self = tipc_own_addr(d->net);
 	struct tipc_media_addr maddr;
 	struct sk_buff *skb = NULL;
 	struct net *net = d->net;
@@ -301,12 +300,14 @@ static void tipc_disc_timeout(struct tim
 		goto exit;
 	}
 
-	/* Did we just leave the address trial period ? */
-	if (!self && !time_before(jiffies, tn->addr_trial_end)) {
-		self = tn->trial_addr;
-		tipc_net_finalize(net, self);
-		msg_set_prevnode(buf_msg(d->skb), self);
+	/* Trial period over ? */
+	if (!time_before(jiffies, tn->addr_trial_end)) {
+		/* Did we just leave it ? */
+		if (!tipc_own_addr(net))
+			tipc_net_finalize(net, tn->trial_addr);
+
 		msg_set_type(buf_msg(d->skb), DSC_REQ_MSG);
+		msg_set_prevnode(buf_msg(d->skb), tipc_own_addr(net));
 	}
 
 	/* Adjust timeout interval according to discovery phase */


