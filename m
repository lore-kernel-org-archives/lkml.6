Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4C0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304FC2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304FC2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeKUMK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 07:10:58 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:54211 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725913AbeKUMK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 07:10:58 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id wAL1bYQo004897;
        Wed, 21 Nov 2018 09:37:34 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 21 Nov 2018
 09:38:15 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <rdunlap@infradead.org>, <yuehaibing@huawei.com>
CC:     <vincentc@andestech.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] net: faraday: ftmac100: remove netif_running(netdev) check before disabling interrupts
Date:   Wed, 21 Nov 2018 09:38:11 +0800
Message-ID: <1542764291-11208-1-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com wAL1bYQo004897
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/net/ethernet/faraday/ftmac100.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftmac100.c b/drivers/net/ethernet/faraday/ftmac100.c
index 21d7660..17a3625 100644
--- a/drivers/net/ethernet/faraday/ftmac100.c
+++ b/drivers/net/ethernet/faraday/ftmac100.c
@@ -875,11 +875,10 @@ static irqreturn_t ftmac100_interrupt(int irq, void *dev_id)
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
1.7.1

