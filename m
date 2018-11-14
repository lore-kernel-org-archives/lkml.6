Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9872CC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571B62251C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1zJf+VK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571B62251C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbeKOI2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729097AbeKOI12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:28 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A4E22520;
        Wed, 14 Nov 2018 22:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234144;
        bh=FFJQ/98twDEVx+zsWrG6gMpyUgTexkWm9ywafk98ux4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1zJf+VK3MR3iITiXQFtut/ODS2GEOMSXuhoRZKye3r9zHVTdZPgSo2Be3xSs0Y3OP
         uM2Xsamp4D1jd5F0TV5GBNTbqUHAq4+BOKZ6knoMOAcg7DU5YKYvAgHDrhwghvsV0S
         nFQsJjip/8bTDTcbv+KMo/nJF0dPLG3nv1YWDnxI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Igor Russkikh <Igor.Russkikh@aquantia.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 68/73] net: aquantia: fixed enable unicast on 32 macvlan
Date:   Wed, 14 Nov 2018 17:22:02 -0500
Message-Id: <20181114222207.98701-68-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Russkikh <Igor.Russkikh@aquantia.com>

[ Upstream commit bfaa9f8553d5c20703781e63f4fc8cb4792f18fd ]

Fixed a condition mistake due to which macvlans unicast
item number 32 was not added in the unicast filter.

The consequence is that when exactly 32 macvlans are created
on NIC, the last created macvlan receives no traffic because
its MAC was not registered in HW.

Fixes: 94b3b542303f ("net: aquantia: vlan unicast address list correct handling")
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Tested-by: Nikita Danilov <nikita.danilov@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 26dc6782b475..4f34808f1e06 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -590,7 +590,7 @@ int aq_nic_set_multicast_list(struct aq_nic_s *self, struct net_device *ndev)
 		}
 	}
 
-	if (i > 0 && i < AQ_HW_MULTICAST_ADDRESS_MAX) {
+	if (i > 0 && i <= AQ_HW_MULTICAST_ADDRESS_MAX) {
 		packet_filter |= IFF_MULTICAST;
 		self->mc_list.count = i;
 		self->aq_hw_ops->hw_multicast_list_set(self->aq_hw,
-- 
2.17.1

