Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B53C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CD72133F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry06Y+OR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CD72133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbeK2RE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:04:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728013AbeK2RE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:04:57 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66441213A2;
        Thu, 29 Nov 2018 06:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471246;
        bh=7hpmEqVv55ABWE4GjC7XfnAzjZIF9tDpMaVuDcwSe2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ry06Y+ORV9OJ5mCWcoo2wyH1Cw/CDApGXzMZWofhrgXrVa8zj/JDy7pyW2/EnUr0K
         MmKj9EodiUaeZH1QVwoyh9oBT1Yv6NeU95RDdkWAE27Y6iSWKhJmDDUu5mXiOY5L5T
         TGuD4NACHy+8mr4TU34ikTPu4uPknlYz5Bc2CrKA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 62/68] ibmvnic: Update driver queues after change in ring size support
Date:   Thu, 29 Nov 2018 00:55:53 -0500
Message-Id: <20181129055559.159228-62-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Falcon <tlfalcon@linux.ibm.com>

[ Upstream commit 5bf032ef08e6a110edc1e3bfb3c66a208fb55125 ]

During device reset, queue memory is not being updated to accommodate
changes in ring buffer sizes supported by backing hardware. Track
any differences in ring buffer sizes following the reset and update
queue memory when possible.

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index f1d4d7a1278b..5ab21a1b5444 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1737,6 +1737,7 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 		    struct ibmvnic_rwi *rwi, u32 reset_state)
 {
 	u64 old_num_rx_queues, old_num_tx_queues;
+	u64 old_num_rx_slots, old_num_tx_slots;
 	struct net_device *netdev = adapter->netdev;
 	int i, rc;
 
@@ -1748,6 +1749,8 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 
 	old_num_rx_queues = adapter->req_rx_queues;
 	old_num_tx_queues = adapter->req_tx_queues;
+	old_num_rx_slots = adapter->req_rx_add_entries_per_subcrq;
+	old_num_tx_slots = adapter->req_tx_entries_per_subcrq;
 
 	ibmvnic_cleanup(netdev);
 
@@ -1810,7 +1813,11 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 			if (rc)
 				return rc;
 		} else if (adapter->req_rx_queues != old_num_rx_queues ||
-			   adapter->req_tx_queues != old_num_tx_queues) {
+			   adapter->req_tx_queues != old_num_tx_queues ||
+			   adapter->req_rx_add_entries_per_subcrq !=
+							old_num_rx_slots ||
+			   adapter->req_tx_entries_per_subcrq !=
+							old_num_tx_slots) {
 			release_rx_pools(adapter);
 			release_tx_pools(adapter);
 			release_napi(adapter);
-- 
2.17.1

