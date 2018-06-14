Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A83D4C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E02E20020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPnkzxhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E02E20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966104AbeFNOZg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966026AbeFNOMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:12:32 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BA47208DA;
        Thu, 14 Jun 2018 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985551;
        bh=wOBdkDMBScUliAlqhps5XCJehChQj8WCmVYG9iLSDVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPnkzxhC76hbjJfdlbyOrsI4EZVgTN5+eOIcjFyB4XL4ZgN8hjsB9/aHr8Q8kw8ib
         gFNyZyY5i0bc/bBvlgPNsut/CvTKxnmqRpEU5VA3XRDet72J0yG5ffsD656KW6Qiqy
         6ZNvJjpbOzffXjY14OOJ+3LLHP/a4Yx7sVt7YaNw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Born <futur.andy@googlemail.com>,
        Mahesh Bandewar <maheshb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nate Clark <nate@neworld.us>
Subject: [PATCH 4.9 04/30] bonding: require speed/duplex only for 802.3ad, alb and tlb
Date:   Thu, 14 Jun 2018 16:04:45 +0200
Message-Id: <20180614132600.431273310@linuxfoundation.org>
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

From: Andreas Born <futur.andy@googlemail.com>

commit ad729bc9acfb7c47112964b4877ef5404578ed13 upstream.

The patch c4adfc822bf5 ("bonding: make speed, duplex setting consistent
with link state") puts the link state to down if
bond_update_speed_duplex() cannot retrieve speed and duplex settings.
Assumably the patch was written with 802.3ad mode in mind which relies
on link speed/duplex settings. For other modes like active-backup these
settings are not required. Thus, only for these other modes, this patch
reintroduces support for slaves that do not support reporting speed or
duplex such as wireless devices. This fixes the regression reported in
bug 196547 (https://bugzilla.kernel.org/show_bug.cgi?id=196547).

Fixes: c4adfc822bf5 ("bonding: make speed, duplex setting consistent
with link state")
Signed-off-by: Andreas Born <futur.andy@googlemail.com>
Acked-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Nate Clark <nate@neworld.us>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/bonding/bond_main.c |    6 ++++--
 include/net/bonding.h           |    5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1531,7 +1531,8 @@ int bond_enslave(struct net_device *bond
 	new_slave->delay = 0;
 	new_slave->link_failure_count = 0;
 
-	if (bond_update_speed_duplex(new_slave))
+	if (bond_update_speed_duplex(new_slave) &&
+	    bond_needs_speed_duplex(bond))
 		new_slave->link = BOND_LINK_DOWN;
 
 	new_slave->last_rx = jiffies -
@@ -2136,7 +2137,8 @@ static void bond_miimon_commit(struct bo
 			continue;
 
 		case BOND_LINK_UP:
-			if (bond_update_speed_duplex(slave)) {
+			if (bond_update_speed_duplex(slave) &&
+			    bond_needs_speed_duplex(bond)) {
 				slave->link = BOND_LINK_DOWN;
 				netdev_warn(bond->dev,
 					    "failed to get link speed/duplex for %s\n",
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -277,6 +277,11 @@ static inline bool bond_is_lb(const stru
 	       BOND_MODE(bond) == BOND_MODE_ALB;
 }
 
+static inline bool bond_needs_speed_duplex(const struct bonding *bond)
+{
+	return BOND_MODE(bond) == BOND_MODE_8023AD || bond_is_lb(bond);
+}
+
 static inline bool bond_is_nondyn_tlb(const struct bonding *bond)
 {
 	return (BOND_MODE(bond) == BOND_MODE_TLB)  &&


