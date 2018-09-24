Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBD9ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B498721486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B498721486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbeIXRlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:41:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50678 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbeIXRlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:41:18 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E4D04106F;
        Mon, 24 Sep 2018 11:39:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 053/105] net: dcb: For wild-card lookups, use priority -1, not 0
Date:   Mon, 24 Sep 2018 13:33:39 +0200
Message-Id: <20180924113119.048430778@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit 08193d1a893c802c4b807e4d522865061f4e9f4f ]

The function dcb_app_lookup walks the list of specified DCB APP entries,
looking for one that matches a given criteria: ifindex, selector,
protocol ID and optionally also priority. The "don't care" value for
priority is set to 0, because that priority has not been allowed under
CEE regime, which predates the IEEE standardization.

Under IEEE, 0 is a valid priority number. But because dcb_app_lookup
considers zero a wild card, attempts to add an APP entry with priority 0
fail when other entries exist for a given ifindex / selector / PID
triplet.

Fix by changing the wild-card value to -1.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dcb/dcbnl.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -1728,7 +1728,7 @@ static struct dcb_app_type *dcb_app_look
 		if (itr->app.selector == app->selector &&
 		    itr->app.protocol == app->protocol &&
 		    itr->ifindex == ifindex &&
-		    (!prio || itr->app.priority == prio))
+		    ((prio == -1) || itr->app.priority == prio))
 			return itr;
 	}
 
@@ -1763,7 +1763,8 @@ u8 dcb_getapp(struct net_device *dev, st
 	u8 prio = 0;
 
 	spin_lock_bh(&dcb_lock);
-	if ((itr = dcb_app_lookup(app, dev->ifindex, 0)))
+	itr = dcb_app_lookup(app, dev->ifindex, -1);
+	if (itr)
 		prio = itr->app.priority;
 	spin_unlock_bh(&dcb_lock);
 
@@ -1791,7 +1792,8 @@ int dcb_setapp(struct net_device *dev, s
 
 	spin_lock_bh(&dcb_lock);
 	/* Search for existing match and replace */
-	if ((itr = dcb_app_lookup(new, dev->ifindex, 0))) {
+	itr = dcb_app_lookup(new, dev->ifindex, -1);
+	if (itr) {
 		if (new->priority)
 			itr->app.priority = new->priority;
 		else {
@@ -1824,7 +1826,8 @@ u8 dcb_ieee_getapp_mask(struct net_devic
 	u8 prio = 0;
 
 	spin_lock_bh(&dcb_lock);
-	if ((itr = dcb_app_lookup(app, dev->ifindex, 0)))
+	itr = dcb_app_lookup(app, dev->ifindex, -1);
+	if (itr)
 		prio |= 1 << itr->app.priority;
 	spin_unlock_bh(&dcb_lock);
 


