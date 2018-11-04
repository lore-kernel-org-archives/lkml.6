Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF888C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 20:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791C02082D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 20:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791C02082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeKEFQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 00:16:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725745AbeKEFQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 00:16:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9CEEA30820C6;
        Sun,  4 Nov 2018 20:00:13 +0000 (UTC)
Received: from hp-dl360pgen8-07.khw.lab.eng.bos.redhat.com (hp-dl360pgen8-07.khw.lab.eng.bos.redhat.com [10.16.184.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D683B1057063;
        Sun,  4 Nov 2018 20:00:02 +0000 (UTC)
From:   Jarod Wilson <jarod@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarod Wilson <jarod@redhat.com>,
        Mahesh Bandewar <maheshb@google.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH net v2] bonding/802.3ad: fix link_failure_count tracking
Date:   Sun,  4 Nov 2018 14:59:46 -0500
Message-Id: <20181104195946.33861-1-jarod@redhat.com>
In-Reply-To: <20181101212240.26768-1-jarod@redhat.com>
References: <20181101212240.26768-1-jarod@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 04 Nov 2018 20:00:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4d2c0cda07448ea6980f00102dc3964eb25e241c set slave->link to
BOND_LINK_DOWN for 802.3ad bonds whenever invalid speed/duplex values
were read, to fix a problem with slaves getting into weird states, but
in the process, broke tracking of link failures, as going straight to
BOND_LINK_DOWN when a link is indeed down (cable pulled, switch rebooted)
means we broke out of bond_miimon_inspect()'s BOND_LINK_DOWN case because
!link_state was already true, we never incremented commit, and never got
a chance to call bond_miimon_commit(), where slave->link_failure_count
would be incremented. I believe the simple fix here is to mark the slave
as BOND_LINK_FAIL, and let bond_miimon_inspect() transition the link from
_FAIL to either _UP or _DOWN, and in the latter case, we now get proper
incrementing of link_failure_count again.

Fixes: 4d2c0cda0744 ("bonding: speed/duplex update at NETDEV_UP event")
CC: Mahesh Bandewar <maheshb@google.com>
CC: David S. Miller <davem@davemloft.net>
CC: netdev@vger.kernel.org
CC: stable@vger.kernel.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
v2: fix Fixes line

 drivers/net/bonding/bond_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index ffa37adb7681..333387f1f1fe 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3112,13 +3112,13 @@ static int bond_slave_netdev_event(unsigned long event,
 	case NETDEV_CHANGE:
 		/* For 802.3ad mode only:
 		 * Getting invalid Speed/Duplex values here will put slave
-		 * in weird state. So mark it as link-down for the time
+		 * in weird state. So mark it as link-fail for the time
 		 * being and let link-monitoring (miimon) set it right when
 		 * correct speeds/duplex are available.
 		 */
 		if (bond_update_speed_duplex(slave) &&
 		    BOND_MODE(bond) == BOND_MODE_8023AD)
-			slave->link = BOND_LINK_DOWN;
+			slave->link = BOND_LINK_FAIL;
 
 		if (BOND_MODE(bond) == BOND_MODE_8023AD)
 			bond_3ad_adapter_speed_duplex_changed(slave);
-- 
2.16.1

