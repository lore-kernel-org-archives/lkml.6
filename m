Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C88C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD39208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD39208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbeHWM1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:27:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52970 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHWM1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:27:20 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9AB0BCA0;
        Thu, 23 Aug 2018 08:58:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 201/324] tipc: fix wrong return value from function tipc_node_try_addr()
Date:   Thu, 23 Aug 2018 09:54:27 +0200
Message-Id: <20180823075006.198607235@linuxfoundation.org>
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

[ Upstream commit 2a57f182420174c7fd4b19db979a2d135231a963 ]

The function for checking if there is an node address conflict is
supposed to return a suggestion for a new address if it finds a
conflict, and zero otherwise. But in case the peer being checked
is previously unknown it does instead return a "suggestion" for
the checked address itself. This results in a DSC_TRIAL_FAIL_MSG
being sent unecessarily to the peer, and sometimes makes the trial
period starting over again.

Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash values")
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/node.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -776,6 +776,7 @@ static u32 tipc_node_suggest_addr(struct
 }
 
 /* tipc_node_try_addr(): Check if addr can be used by peer, suggest other if not
+ * Returns suggested address if any, otherwise 0
  */
 u32 tipc_node_try_addr(struct net *net, u8 *id, u32 addr)
 {
@@ -798,12 +799,14 @@ u32 tipc_node_try_addr(struct net *net,
 	if (n) {
 		addr = n->addr;
 		tipc_node_put(n);
+		return addr;
 	}
-	/* Even this node may be in trial phase */
+
+	/* Even this node may be in conflict */
 	if (tn->trial_addr == addr)
 		return tipc_node_suggest_addr(net, addr);
 
-	return addr;
+	return 0;
 }
 
 void tipc_node_check_dest(struct net *net, u32 addr,


