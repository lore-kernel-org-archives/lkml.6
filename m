Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9470C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD4520862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD4520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408044AbeHATWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:22:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436585AbeHATSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D4A7CE3F;
        Wed,  1 Aug 2018 16:53:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 022/336] ixgbe: Fix setting of TC configuration for macvlan case
Date:   Wed,  1 Aug 2018 18:45:57 +0200
Message-Id: <20180801165029.861505937@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Duyck <alexander.h.duyck@intel.com>

[ Upstream commit 646bb57ce86e4d7b0bd9d33244450ae009411e48 ]

When we were enabling macvlan interfaces we weren't correctly configuring
things until ixgbe_setup_tc was called a second time either by tweaking the
number of queues or increasing the macvlan count past 15.

The issue came down to the fact that num_rx_pools is not populated until
after the queues and interrupts are reinitialized.

Instead of trying to set it sooner we can just move the call to setup at
least 1 traffic class to the SR-IOV/VMDq setup function so that we just set
it for this one case. We already had a spot that was configuring the queues
for TC 0 in the code here anyway so it makes sense to also set the number
of TCs here as well.

Fixes: 49cfbeb7a95c ("ixgbe: Fix handling of macvlan Tx offload")
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    8 ++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -618,6 +618,14 @@ static bool ixgbe_set_sriov_queues(struc
 	}
 
 #endif
+	/* To support macvlan offload we have to use num_tc to
+	 * restrict the queues that can be used by the device.
+	 * By doing this we can avoid reporting a false number of
+	 * queues.
+	 */
+	if (vmdq_i > 1)
+		netdev_set_num_tc(adapter->netdev, 1);
+
 	/* populate TC0 for use by pool 0 */
 	netdev_set_tc_queue(adapter->netdev, 0,
 			    adapter->num_rx_queues_per_pool, 0);
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8875,14 +8875,6 @@ int ixgbe_setup_tc(struct net_device *de
 	} else {
 		netdev_reset_tc(dev);
 
-		/* To support macvlan offload we have to use num_tc to
-		 * restrict the queues that can be used by the device.
-		 * By doing this we can avoid reporting a false number of
-		 * queues.
-		 */
-		if (!tc && adapter->num_rx_pools > 1)
-			netdev_set_num_tc(dev, 1);
-
 		if (adapter->hw.mac.type == ixgbe_mac_82598EB)
 			adapter->hw.fc.requested_mode = adapter->last_lfc_mode;
 


