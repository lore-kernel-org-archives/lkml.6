Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCAEECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEF52085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpgojnzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEF52085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbeJYWte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729416AbeJYWtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:32 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8798420854;
        Thu, 25 Oct 2018 14:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476995;
        bh=Gielzr20pzkfPyCSvakDaXM0j9ztGC/Jw7ftXf4Rcxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SpgojnzAqXlXf3IRytBfk69d+csTkLk9iH2UOQj+eUEThmXVP4bbiwPnbcwqGObNJ
         c3gI1NA8IHFllXtfxvpn7sU7KwKnvFppAxdYI/4G1/XVWhPu0xN9u7Vbs4Rrsq7z7W
         HN3YR7/YOqHi/q5ocZUMHWllg8ZSkUMFni0QUY3E=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Born <futur.andy@googlemail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 90/98] bonding: ratelimit failed speed/duplex update warning
Date:   Thu, 25 Oct 2018 10:14:15 -0400
Message-Id: <20181025141423.213774-90-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Born <futur.andy@googlemail.com>

[ Upstream commit 11e9d7829dd08dbafb24517fe922f11c3a8a9dc2 ]

bond_miimon_commit() handles the UP transition for each slave of a bond
in the case of MII. It is triggered 10 times per second for the default
MII Polling interval of 100ms. For device drivers that do not implement
__ethtool_get_link_ksettings() the call to bond_update_speed_duplex()
fails persistently while the MII status could remain UP. That is, in
this and other cases where the speed/duplex update keeps failing over a
longer period of time while the MII state is UP, a warning is printed
every MII polling interval.

To address these excessive warnings net_ratelimit() should be used.
Printing a warning once would not be sufficient since the call to
bond_update_speed_duplex() could recover to succeed and fail again
later. In that case there would be no new indication what went wrong.

Fixes: b5bf0f5b16b9c (bonding: correctly update link status during mii-commit phase)
Signed-off-by: Andreas Born <futur.andy@googlemail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b1ea29d8ad1a..389d1db69a32 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2132,9 +2132,10 @@ static void bond_miimon_commit(struct bonding *bond)
 			if (bond_update_speed_duplex(slave) &&
 			    bond_needs_speed_duplex(bond)) {
 				slave->link = BOND_LINK_DOWN;
-				netdev_warn(bond->dev,
-					    "failed to get link speed/duplex for %s\n",
-					    slave->dev->name);
+				if (net_ratelimit())
+					netdev_warn(bond->dev,
+						    "failed to get link speed/duplex for %s\n",
+						    slave->dev->name);
 				continue;
 			}
 			bond_set_slave_link_state(slave, BOND_LINK_UP,
-- 
2.17.1

