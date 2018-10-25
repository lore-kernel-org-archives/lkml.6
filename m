Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E326C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED2A20868
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zm2uhnj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED2A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeJYWob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbeJYWob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:31 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9DD420868;
        Thu, 25 Oct 2018 14:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476695;
        bh=0cxbgjxg22jFj49zjD77FNVZidUJ6PeA+VNHqT+fcOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zm2uhnj2Rzv1oPIXmKBtHyfi3kVgyxGV83qXiMAl0nA0B5yGnCDs2frU12hVce3T4
         DdtxuzPi/hOrXYI+Ljus2mFw192X7JnFdfy3paM9Q9dTJIZY/ScBR9Ylur0Yn4qoGb
         5D12yZ35DqMHnzSwmtbwcgU7rrtwMB6WRhH7m2DA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 29/46] xen-netfront: Update features after registering netdev
Date:   Thu, 25 Oct 2018 10:10:36 -0400
Message-Id: <20181025141053.213330-29-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 45c8184c1bed1ca8a7f02918552063a00b909bf5 ]

Update the features after calling register_netdev() otherwise the
device features are not set up correctly and it not possible to change
the MTU of the device. After this change, the features reported by
ethtool match the device's features before the commit which introduced
the issue and it is possible to change the device's MTU.

Fixes: f599c64fdf7d ("xen-netfront: Fix race between device setup and open")
Reported-by: Liam Shepherd <liam@dancer.es>
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/xen-netfront.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 1a40fc3517a8..ca239912c0e6 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1964,10 +1964,6 @@ static int xennet_connect(struct net_device *dev)
 	/* talk_to_netback() sets the correct number of queues */
 	num_queues = dev->real_num_tx_queues;
 
-	rtnl_lock();
-	netdev_update_features(dev);
-	rtnl_unlock();
-
 	if (dev->reg_state == NETREG_UNINITIALIZED) {
 		err = register_netdev(dev);
 		if (err) {
@@ -1977,6 +1973,10 @@ static int xennet_connect(struct net_device *dev)
 		}
 	}
 
+	rtnl_lock();
+	netdev_update_features(dev);
+	rtnl_unlock();
+
 	/*
 	 * All public and private state should now be sane.  Get
 	 * ready to start sending and receiving packets and give the driver
-- 
2.17.1

