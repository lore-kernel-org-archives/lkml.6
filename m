Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF17C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A0E20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A0E20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968085AbeFRIgn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:36:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36444 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967702AbeFRIgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:36:40 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7C4B0CBB;
        Mon, 18 Jun 2018 08:36:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ma Yuying <yuma@redhat.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 132/189] net: aquantia: driver should correctly declare vlan_features bits
Date:   Mon, 18 Jun 2018 10:13:48 +0200
Message-Id: <20180618081214.532270988@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Igor Russkikh <igor.russkikh@aquantia.com>

[ Upstream commit 8c61ab7f111a2b29d051348b9cb9a39804ebf1f8 ]

In particular, not reporting SG forced skbs to be linear for vlan
interfaces over atlantic NIC.

With this fix it is possible to enable SG feature on device and
therefore optimize performance.

Reported-by: Ma Yuying <yuma@redhat.com>
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -310,6 +310,8 @@ int aq_nic_ndev_init(struct aq_nic_s *se
 
 	self->ndev->hw_features |= aq_hw_caps->hw_features;
 	self->ndev->features = aq_hw_caps->hw_features;
+	self->ndev->vlan_features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
+				     NETIF_F_RXHASH | NETIF_F_SG | NETIF_F_LRO;
 	self->ndev->priv_flags = aq_hw_caps->hw_priv_flags;
 	self->ndev->mtu = aq_nic_cfg->mtu - ETH_HLEN;
 	self->ndev->max_mtu = self->aq_hw_caps.mtu - ETH_FCS_LEN - ETH_HLEN;


