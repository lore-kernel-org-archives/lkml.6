Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DKARHOtIGVv9SwAAmS7hNA
	; Thu, 07 Jun 2018 15:03:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 33194608B8; Thu,  7 Jun 2018 15:03:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 10654606DD;
	Thu,  7 Jun 2018 15:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10654606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964997AbeFGPC7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:02:59 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41463 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964982AbeFGPCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:02:54 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbJ-0005Zj-5f; Thu, 07 Jun 2018 15:09:17 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbF-0003Jb-Ez; Thu, 07 Jun 2018 15:09:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Xin Long" <lucien.xin@gmail.com>,
        "Andy Gospodarek" <andy@greyhouse.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.628703974@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 402/410] bonding: process the err returned by
 dev_set_allmulti properly in bond_enslave
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

From: Xin Long <lucien.xin@gmail.com>

commit 9f5a90c107741b864398f4ac0014711a8c1d8474 upstream.

When dev_set_promiscuity(1) succeeds but dev_set_allmulti(1) fails,
dev_set_promiscuity(-1) should be done before going to the err path.
Otherwise, dev->promiscuity will leak.

Fixes: 7e1a1ac1fbaa ("bonding: Check return of dev_set_promiscuity/allmulti")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Andy Gospodarek <andy@greyhouse.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/bonding/bond_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1579,8 +1579,11 @@ int bond_enslave(struct net_device *bond
 		/* set allmulti level to new slave */
 		if (bond_dev->flags & IFF_ALLMULTI) {
 			res = dev_set_allmulti(slave_dev, 1);
-			if (res)
+			if (res) {
+				if (bond_dev->flags & IFF_PROMISC)
+					dev_set_promiscuity(slave_dev, -1);
 				goto err_sysfs_del;
+			}
 		}
 
 		netif_addr_lock_bh(bond_dev);
