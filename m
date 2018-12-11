Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CB3C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775A42084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545370;
	bh=+KkWSOO3i+L59g0JBEBiq0I9XqlNZBAv7BECA8Maqaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gO3t/t0WIT957aaAoPt1+QtoqTM4Hiksps5dbWbXB3wQB3+Wc7pyt6tsL76Yu6Xvk
	 SLNAunQJC8nUBV3QWe+weNZpfuYKHh2el4iJlXjFRrvn0QLNP2bC31KPuPao+mEH/K
	 ctLZ1KXXjFJgfxJkeRRd8siwQc61b14Gd1WCgQoM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775A42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeLKPnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:43:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbeLKPnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:43:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A308B20870;
        Tue, 11 Dec 2018 15:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543028;
        bh=+KkWSOO3i+L59g0JBEBiq0I9XqlNZBAv7BECA8Maqaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RrN699731CUqgA1c+02iURWAdlxS9hch+Lj1GxB6xivdU3PUiMrTojV8SCn9U5xeJ
         WNBNp4kZqAws2jnVqzbxYWHb3sFXR+rW8ckdtVkepMBP13TeizKBpwTTrIc3pQM2N+
         15zXRgXuzEVx+vHo66kU0fZMYw2V/Or7JlGsv98M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Chen <vincentc@andestech.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 38/54] net: faraday: ftmac100: remove netif_running(netdev) check before disabling interrupts
Date:   Tue, 11 Dec 2018 16:41:26 +0100
Message-Id: <20181211151548.232098611@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 4ff1adc6bfca..9a0703f2da9a 100644
--- a/drivers/net/ethernet/faraday/ftmac100.c
+++ b/drivers/net/ethernet/faraday/ftmac100.c
@@ -865,11 +865,10 @@ static irqreturn_t ftmac100_interrupt(int irq, void *dev_id)
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
2.19.1



