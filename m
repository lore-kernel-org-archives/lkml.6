Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAF2C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D345208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D345208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934718AbeFRIRI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:17:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934611AbeFRIRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:17:04 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C90B2C77;
        Mon, 18 Jun 2018 08:17:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tung Nguyen <tung.q.nguyen@dektech.com.au>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 049/279] tipc: fix infinite loop when dumping link monitor summary
Date:   Mon, 18 Jun 2018 10:10:34 +0200
Message-Id: <20180618080610.867190924@linuxfoundation.org>
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

From: Tung Nguyen <tung.q.nguyen@dektech.com.au>

[ Upstream commit 36a50a989ee8267588de520b8704b85f045a3220 ]

When configuring the number of used bearers to MAX_BEARER and issuing
command "tipc link monitor summary", the command enters infinite loop
in user space.

This issue happens because function tipc_nl_node_dump_monitor() returns
the wrong 'prev_bearer' value when all potential monitors have been
scanned.

The correct behavior is to always try to scan all monitors until either
the netlink message is full, in which case we return the bearer identity
of the affected monitor, or we continue through the whole bearer array
until we can return MAX_BEARERS. This solution also caters for the case
where there may be gaps in the bearer array.

Signed-off-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/monitor.c |    2 +-
 net/tipc/node.c    |   11 ++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -777,7 +777,7 @@ int __tipc_nl_add_monitor(struct net *ne
 
 	ret = tipc_bearer_get_name(net, bearer_name, bearer_id);
 	if (ret || !mon)
-		return -EINVAL;
+		return 0;
 
 	hdr = genlmsg_put(msg->skb, msg->portid, msg->seq, &tipc_genl_family,
 			  NLM_F_MULTI, TIPC_NL_MON_GET);
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -2145,8 +2145,8 @@ int tipc_nl_node_dump_monitor(struct sk_
 	struct net *net = sock_net(skb->sk);
 	u32 prev_bearer = cb->args[0];
 	struct tipc_nl_msg msg;
+	int bearer_id;
 	int err;
-	int i;
 
 	if (prev_bearer == MAX_BEARERS)
 		return 0;
@@ -2156,16 +2156,13 @@ int tipc_nl_node_dump_monitor(struct sk_
 	msg.seq = cb->nlh->nlmsg_seq;
 
 	rtnl_lock();
-	for (i = prev_bearer; i < MAX_BEARERS; i++) {
-		prev_bearer = i;
+	for (bearer_id = prev_bearer; bearer_id < MAX_BEARERS; bearer_id++) {
 		err = __tipc_nl_add_monitor(net, &msg, prev_bearer);
 		if (err)
-			goto out;
+			break;
 	}
-
-out:
 	rtnl_unlock();
-	cb->args[0] = prev_bearer;
+	cb->args[0] = bearer_id;
 
 	return skb->len;
 }


