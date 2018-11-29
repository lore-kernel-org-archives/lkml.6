Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D659CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C33F21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+bBMQbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C33F21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbeK2RE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:04:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeK2RE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:04:28 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC8E021019;
        Thu, 29 Nov 2018 06:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471217;
        bh=EtMx7+MboHey7wODh/G1FmqQ1Erc1Bym5UWRYpkqX90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+bBMQbQuAomV8IOUlfpfgJXGyy4gAOrj7xLd0hYAE30vgD8xOMibPpD/dw00z0Qt
         JIbRwzmzKLDtfJkZVqfQ+uQtz5Gwp5bjoRkoReKi404H5+cQOapAe6H1wiYW1gCDS8
         kHh10SScYyEUQlT3aLvK2awdJ54+rzx+EqoF7+8I=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vincent Chen <vincentc@andestech.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 55/68] net: faraday: ftmac100: remove netif_running(netdev) check before disabling interrupts
Date:   Thu, 29 Nov 2018 00:55:46 -0500
Message-Id: <20181129055559.159228-55-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen <vincentc@andestech.com>

[ Upstream commit 426a593e641ebf0d9288f0a2fcab644a86820220 ]

In the original ftmac100_interrupt(), the interrupts are only disabled when
the condition "netif_running(netdev)" is true. However, this condition
causes kerenl hang in the following case. When the user requests to
disable the network device, kernel will clear the bit __LINK_STATE_START
from the dev->state and then call the driver's ndo_stop function. Network
device interrupts are not blocked during this process. If an interrupt
occurs between clearing __LINK_STATE_START and stopping network device,
kernel cannot disable the interrupts due to the condition
"netif_running(netdev)" in the ISR. Hence, kernel will hang due to the
continuous interruption of the network device.

In order to solve the above problem, the interrupts of the network device
should always be disabled in the ISR without being restricted by the
condition "netif_running(netdev)".

[V2]
Remove unnecessary curly braces.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/faraday/ftmac100.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftmac100.c b/drivers/net/ethernet/faraday/ftmac100.c
index a1197d3adbe0..9015bd911bee 100644
--- a/drivers/net/ethernet/faraday/ftmac100.c
+++ b/drivers/net/ethernet/faraday/ftmac100.c
@@ -872,11 +872,10 @@ static irqreturn_t ftmac100_interrupt(int irq, void *dev_id)
 	struct net_device *netdev = dev_id;
 	struct ftmac100 *priv = netdev_priv(netdev);
 
-	if (likely(netif_running(netdev))) {
-		/* Disable interrupts for polling */
-		ftmac100_disable_all_int(priv);
+	/* Disable interrupts for polling */
+	ftmac100_disable_all_int(priv);
+	if (likely(netif_running(netdev)))
 		napi_schedule(&priv->napi);
-	}
 
 	return IRQ_HANDLED;
 }
-- 
2.17.1

