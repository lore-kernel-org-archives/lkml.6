Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54B8C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D232084D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsnvQGa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D232084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbeKCDxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbeKCDxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:53:13 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC0EF2084A;
        Fri,  2 Nov 2018 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184300;
        bh=WWC7YOcl/KHv47808iM/Ek6AkzoIXAsY2IjPaZ6NpTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gsnvQGa9bi+03s1Dh+fDRBbZtWPYYrNevLeY+YK+koYxZBwu2rhR7OB6348Q7o1bO
         bVLkj6tWmrltBIwFg76onDEuClLCrX7k35O8dmCm/QyLmP4dnCQVIpw+h/j5zqighB
         vyEPKZRjXmnRTitJzpKu76gscxv06CHkry7w9TCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 128/150] net: bcmgenet: Poll internal PHY for GENETv5
Date:   Fri,  2 Nov 2018 19:34:50 +0100
Message-Id: <20181102182911.740371760@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 64bd9c8135751b561f27edaaffe93d07093f81af ]

On GENETv5, there is a hardware issue which prevents the GENET hardware
from generating a link UP interrupt when the link is operating at
10Mbits/sec. Since we do not have any way to configure the link
detection logic, fallback to polling in that case.

Fixes: 421380856d9c ("net: bcmgenet: add support for the GENETv5 hardware")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -321,9 +321,12 @@ int bcmgenet_mii_probe(struct net_device
 	phydev->advertising = phydev->supported;
 
 	/* The internal PHY has its link interrupts routed to the
-	 * Ethernet MAC ISRs
+	 * Ethernet MAC ISRs. On GENETv5 there is a hardware issue
+	 * that prevents the signaling of link UP interrupts when
+	 * the link operates at 10Mbps, so fallback to polling for
+	 * those versions of GENET.
 	 */
-	if (priv->internal_phy)
+	if (priv->internal_phy && !GENET_IS_V5(priv))
 		dev->phydev->irq = PHY_IGNORE_INTERRUPT;
 
 	return 0;


