Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085ABC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7F120839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7F120839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeILKjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 06:39:31 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:33516 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbeILKjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 06:39:31 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w8C5aZ0N021173;
        Wed, 12 Sep 2018 07:36:35 +0200
Date:   Wed, 12 Sep 2018 07:36:35 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: [PATCH] net/appletalk: fix minor pointer leak to userspace in
 SIOCFINDIPDDPRT
Message-ID: <20180912053635.GA21168@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fields ->dev and ->next of struct ipddp_route may be copied to
userspace on the SIOCFINDIPDDPRT ioctl. This is only accessible
to CAP_NET_ADMIN though. Let's manually copy the relevant fields
instead of using memcpy().

BugLink: http://blog.infosectcbr.com.au/2018/09/linux-kernel-infoleaks.html
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/net/appletalk/ipddp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/appletalk/ipddp.c b/drivers/net/appletalk/ipddp.c
index 9375cef..3d27616 100644
--- a/drivers/net/appletalk/ipddp.c
+++ b/drivers/net/appletalk/ipddp.c
@@ -283,8 +283,12 @@ static int ipddp_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
                 case SIOCFINDIPDDPRT:
 			spin_lock_bh(&ipddp_route_lock);
 			rp = __ipddp_find_route(&rcp);
-			if (rp)
-				memcpy(&rcp2, rp, sizeof(rcp2));
+			if (rp) {
+				memset(&rcp2, 0, sizeof(rcp2));
+				rcp2.ip    = rp->ip;
+				rcp2.at    = rp->at;
+				rcp2.flags = rp->flags;
+			}
 			spin_unlock_bh(&ipddp_route_lock);
 
 			if (rp) {
-- 
2.8.0.rc2.1.gbe9624a

