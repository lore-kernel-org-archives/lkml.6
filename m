Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0cOsDMlVGVtLOgAAmS7hNA
	; Thu, 07 Jun 2018 15:57:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E63676074D; Thu,  7 Jun 2018 15:57:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6809C60590;
	Thu,  7 Jun 2018 15:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6809C60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933391AbeFGOb1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:31:27 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39404 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933060AbeFGOJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:09 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-0005Zs-2Y; Thu, 07 Jun 2018 15:09:08 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-00032E-RJ; Thu, 07 Jun 2018 15:09:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Johannes Berg" <johannes.berg@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.761317939@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 220/410] netlink: ensure to loop over all netns in
 genlmsg_multicast_allns()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

commit cb9f7a9a5c96a773bbc9c70660dc600cfff82f82 upstream.

Nowadays, nlmsg_multicast() returns only 0 or -ESRCH but this was not the
case when commit 134e63756d5f was pushed.
However, there was no reason to stop the loop if a netns does not have
listeners.
Returns -ESRCH only if there was no listeners in all netns.

To avoid having the same problem in the future, I didn't take the
assumption that nlmsg_multicast() returns only 0 or -ESRCH.

Fixes: 134e63756d5f ("genetlink: make netns aware")
CC: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/netlink/genetlink.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1042,6 +1042,7 @@ static int genlmsg_mcast(struct sk_buff
 {
 	struct sk_buff *tmp;
 	struct net *net, *prev = NULL;
+	bool delivered = false;
 	int err;
 
 	for_each_net_rcu(net) {
@@ -1053,14 +1054,21 @@ static int genlmsg_mcast(struct sk_buff
 			}
 			err = nlmsg_multicast(prev->genl_sock, tmp,
 					      portid, group, flags);
-			if (err)
+			if (!err)
+				delivered = true;
+			else if (err != -ESRCH)
 				goto error;
 		}
 
 		prev = net;
 	}
 
-	return nlmsg_multicast(prev->genl_sock, skb, portid, group, flags);
+	err = nlmsg_multicast(prev->genl_sock, skb, portid, group, flags);
+	if (!err)
+		delivered = true;
+	else if (err != -ESRCH)
+		goto error;
+	return delivered ? 0 : -ESRCH;
  error:
 	kfree_skb(skb);
 	return err;
