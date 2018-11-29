Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305DBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB48D2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO5ORNsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB48D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbeK2REy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:04:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbeK2REx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:04:53 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B5C721104;
        Thu, 29 Nov 2018 06:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471242;
        bh=o1zBCJFnDGEf/mD/Zl1nFABTbvIqlrhJN3D305sI+nI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QO5ORNsd0q2cEvfKJRwEdTQskLTbWqXHcjwM+txGDDaNNMlEV3A2CtaF501QgMMX6
         8jRvziO4d3K9XIuqOQ8tEMko9dbACITBWKXfIbEDM9pP4fVsoJ2rQhnlkcgZ4jfqWS
         Y3IjX2/TaNMLnQVuRihCNxyM/TnTHk/WQS4gCLYA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 61/68] ibmvnic: Fix RX queue buffer cleanup
Date:   Thu, 29 Nov 2018 00:55:52 -0500
Message-Id: <20181129055559.159228-61-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Falcon <tlfalcon@linux.ibm.com>

[ Upstream commit b7cdec3d699db2e5985ad39de0f25d3b6111928e ]

The wrong index is used when cleaning up RX buffer objects during release
of RX queues. Update to use the correct index counter.

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index a646de07cbdc..f1d4d7a1278b 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -485,8 +485,8 @@ static void release_rx_pools(struct ibmvnic_adapter *adapter)
 
 		for (j = 0; j < rx_pool->size; j++) {
 			if (rx_pool->rx_buff[j].skb) {
-				dev_kfree_skb_any(rx_pool->rx_buff[i].skb);
-				rx_pool->rx_buff[i].skb = NULL;
+				dev_kfree_skb_any(rx_pool->rx_buff[j].skb);
+				rx_pool->rx_buff[j].skb = NULL;
 			}
 		}
 
-- 
2.17.1

