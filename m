Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbeE3LUV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:20:21 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:32769 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752542AbeE3LHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:07 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Ben Hutchings" <ben.hutchings@codethink.co.uk>,
        "David S. Miller" <davem@davemloft.net>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.540714012@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 079/153] netlink: avoid a double skb free in
 genlmsg_mcast()
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

commit 02a2385f37a7c6594c9d89b64c4a1451276f08eb upstream.

nlmsg_multicast() consumes always the skb, thus the original skb must be
freed only when this function is called with a clone.

Fixes: cb9f7a9a5c96 ("netlink: ensure to loop over all netns in genlmsg_multicast_allns()")
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/netlink/genetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -942,7 +942,7 @@ static int genlmsg_mcast(struct sk_buff
 	if (!err)
 		delivered = true;
 	else if (err != -ESRCH)
-		goto error;
+		return err;
 	return delivered ? 0 : -ESRCH;
  error:
 	kfree_skb(skb);
