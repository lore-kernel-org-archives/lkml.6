Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53E8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B15120847
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B15120847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbeHWM1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:27:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53002 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbeHWM1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:27:30 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8460EC83;
        Thu, 23 Aug 2018 08:58:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 204/324] tipc: make function tipc_net_finalize() thread safe
Date:   Thu, 23 Aug 2018 09:54:30 +0200
Message-Id: <20180823075006.350304705@linuxfoundation.org>
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

[ Upstream commit 9faa89d4ed9d7d326f4763d262842270450f9b1f ]

The setting of the node address is not thread safe, meaning that
two discoverers may decide to set it simultanously, with a duplicate
entry in the name table as result. We fix that with this commit.

Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash values")
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/net.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -121,12 +121,17 @@ int tipc_net_init(struct net *net, u8 *n
 
 void tipc_net_finalize(struct net *net, u32 addr)
 {
-	tipc_set_node_addr(net, addr);
-	smp_mb();
-	tipc_named_reinit(net);
-	tipc_sk_reinit(net);
-	tipc_nametbl_publish(net, TIPC_CFG_SRV, addr, addr,
-			     TIPC_CLUSTER_SCOPE, 0, addr);
+	struct tipc_net *tn = tipc_net(net);
+
+	spin_lock_bh(&tn->node_list_lock);
+	if (!tipc_own_addr(net)) {
+		tipc_set_node_addr(net, addr);
+		tipc_named_reinit(net);
+		tipc_sk_reinit(net);
+		tipc_nametbl_publish(net, TIPC_CFG_SRV, addr, addr,
+				     TIPC_CLUSTER_SCOPE, 0, addr);
+	}
+	spin_unlock_bh(&tn->node_list_lock);
 }
 
 void tipc_net_stop(struct net *net)


