Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0BCADC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60CF208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxgE/1Iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60CF208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966072AbeFNOMf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966052AbeFNOM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:12:29 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50DE5208DB;
        Thu, 14 Jun 2018 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985548;
        bh=7ja21815WS/0I8JoxcQBNtvpOI5YLN3zrZDRc0AtHbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FxgE/1IyR1ImKRwkS3j7o0hvkpSRaBKO+7TYjGF2StwVRoUhVDwCreMJrD8LSAj4n
         9TwQiYdsPHQsY+x2e3EowwJzdKIema3/v/4FP8+sBe32OY23sMwyp0xRJ5aAL3OKub
         9PxhgOQMtmJux690U4PRL5Idrzixcdr9VzdczZkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mahesh Bandewar <maheshb@google.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Nate Clark <nate@neworld.us>
Subject: [PATCH 4.9 03/30] bonding: fix active-backup transition
Date:   Thu, 14 Jun 2018 16:04:44 +0200
Message-Id: <20180614132600.393644176@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132600.255515394@linuxfoundation.org>
References: <20180614132600.255515394@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mahesh Bandewar <maheshb@google.com>

commit 3f3c278c94dd994fe0d9f21679ae19b9c0a55292 upstream.

Earlier patch c4adfc822bf5 ("bonding: make speed, duplex setting
consistent with link state") made an attempt to keep slave state
consistent with speed and duplex settings. Unfortunately link-state
transition is used to change the active link especially when used
in conjunction with mii-mon. The above mentioned patch broke that
logic. Also when speed and duplex settings for a link are updated
during a link-event, the link-status should not be changed to
invoke correct transition logic.

This patch fixes this issue by moving the link-state update outside
of the bond_update_speed_duplex() fn and to the places where this fn
is called and update link-state selectively.

Fixes: c4adfc822bf5 ("bonding: make speed, duplex setting consistent
with link state")
Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Reviewed-by: Andy Gospodarek <andy@greyhouse.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Nate Clark <nate@neworld.us>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/bonding/bond_main.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -384,20 +384,15 @@ static int bond_update_speed_duplex(stru
 	slave->duplex = DUPLEX_UNKNOWN;
 
 	res = __ethtool_get_link_ksettings(slave_dev, &ecmd);
-	if (res < 0) {
-		slave->link = BOND_LINK_DOWN;
+	if (res < 0)
 		return 1;
-	}
-	if (ecmd.base.speed == 0 || ecmd.base.speed == ((__u32)-1)) {
-		slave->link = BOND_LINK_DOWN;
+	if (ecmd.base.speed == 0 || ecmd.base.speed == ((__u32)-1))
 		return 1;
-	}
 	switch (ecmd.base.duplex) {
 	case DUPLEX_FULL:
 	case DUPLEX_HALF:
 		break;
 	default:
-		slave->link = BOND_LINK_DOWN;
 		return 1;
 	}
 
@@ -1536,7 +1531,8 @@ int bond_enslave(struct net_device *bond
 	new_slave->delay = 0;
 	new_slave->link_failure_count = 0;
 
-	bond_update_speed_duplex(new_slave);
+	if (bond_update_speed_duplex(new_slave))
+		new_slave->link = BOND_LINK_DOWN;
 
 	new_slave->last_rx = jiffies -
 		(msecs_to_jiffies(bond->params.arp_interval) + 1);
@@ -2141,6 +2137,7 @@ static void bond_miimon_commit(struct bo
 
 		case BOND_LINK_UP:
 			if (bond_update_speed_duplex(slave)) {
+				slave->link = BOND_LINK_DOWN;
 				netdev_warn(bond->dev,
 					    "failed to get link speed/duplex for %s\n",
 					    slave->dev->name);


