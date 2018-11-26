Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D9CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF3C20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNDhVt3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF3C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbeKZV6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:58:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeKZV6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:58:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C095420645;
        Mon, 26 Nov 2018 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230307;
        bh=nC0LQtWFYP38M6oBkQWU4CoZC8ZYDAfyplTYUfzoC+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNDhVt3hUiXsLyhTkoFSqwEFxKzNTzq0dLpSxv5H8BqEj6hAwCUCHJt6Z7bFy0smW
         SZpqCe++u70Sp6UXpH0oe8eV/cWLonbAKLmKOMLLuyF+aFtQyFiW6fOGYp8pPY2SzE
         uIVVX1Fa2KCEQVVgkZjuqSSqtspnTZinGWG2vDMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Russkikh <igor.russkikh@aquantia.com>,
        Nikita Danilov <nikita.danilov@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 087/118] net: aquantia: fixed enable unicast on 32 macvlan
Date:   Mon, 26 Nov 2018 11:51:21 +0100
Message-Id: <20181126105105.197176890@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



