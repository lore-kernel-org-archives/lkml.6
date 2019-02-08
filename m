Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8044C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8822521929
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TNQ20UIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfBHABi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:01:38 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40205 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBHABf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:01:35 -0500
Received: by mail-yb1-f196.google.com with SMTP id y13so729181ybr.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 16:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Q08blxnkX/VNLjbDdifa1q1/CqzE5wTUvZFrw3nbrB0=;
        b=TNQ20UIX8LlosZRnx38Lexd4cmULtA3Roy1ugKNFxiGDqy33k7tLK9Ke93Bzb1xX0O
         PbIVIV52nK9zLq4DXf8JhAxlK4ZC0XGDU0kHdDhGO9W5wULtn1Vde3To6a+NuWFn6Z68
         TrRFh+dopgnPc1Msspm4VnfZZER/YmVyH9OWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q08blxnkX/VNLjbDdifa1q1/CqzE5wTUvZFrw3nbrB0=;
        b=IDhQ4A0F911yZnxqnIBi2jnkP6s04cp0+KxvKqahGlOO3UwSuh1t8r9J6QWML8xgBr
         MUk2fR1Mx7hNyAJthP6BcXDC9CajMV4yE0PTdnFuqYbja+Ll1lby1IRc6Nzne38kdWUR
         7sq1fO+HcapniViFHIyTFJCWtdeJ/ojLbFWXv+WtMG3XIuqlzTY2Jzy43RMjQ2Xkng8L
         mAgw5/8Yq3KxtV22910m9WQfUyWXBO8HvdvyNYvEcM+/cbVSQvGoeTHDyvGj7zuLmJtO
         0spBrv+NtxCOGogmwMhA7+eYEU4HHcs0b8dhbkqs7Ux29HcC//ahPqT4BXkKjMD6fcFk
         gxLg==
X-Gm-Message-State: AHQUAuYRBc3s1bjCcN+wlIi4Zz2gBneXNWV40TEh9VvIAFJV/xWHOQTp
        mAtLjMrpQl1bpc/0YdStW5Z6Gw==
X-Google-Smtp-Source: AHgI3IbVN8Bg6QSF+vzFRZBbqRKnAc8qiX0Is6Wd3tSuWXde6In02NXwrPTVi0PuLhIrqxUFaK2tsQ==
X-Received: by 2002:a25:40e:: with SMTP id 14mr2262198ybe.42.1549584094327;
        Thu, 07 Feb 2019 16:01:34 -0800 (PST)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 141sm161050yws.47.2019.02.07.16.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 16:01:33 -0800 (PST)
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arun Parameswaran <arun.parameswaran@broadcom.com>
Subject: [PATCH 1/1] net: dsa: b53: Fix for failure when irq is not defined in dt
Date:   Thu,  7 Feb 2019 16:01:18 -0800
Message-Id: <20190208000118.9268-1-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the issues with non BCM58XX chips in the b53 driver
failing, when the irq is not specified in the device tree.

Removed the check for BCM58XX in b53_srab_prepare_irq(),
so the 'port->irq' will be set to '-EXIO' if the irq is not
specified in the device tree.

Fixes: 16994374a6fc ("net: dsa: b53: Make SRAB driver manage port interrupts")
Fixes: b2ddc48a81b5 ("net: dsa: b53: Do not fail when IRQ are not initialized")
Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/dsa/b53/b53_srab.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index 90f514252987..d9c56a779c08 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -511,9 +511,6 @@ static void b53_srab_prepare_irq(struct platform_device *pdev)
 	/* Clear all pending interrupts */
 	writel(0xffffffff, priv->regs + B53_SRAB_INTR);
 
-	if (dev->pdata && dev->pdata->chip_id != BCM58XX_DEVICE_ID)
-		return;
-
 	for (i = 0; i < B53_N_PORTS; i++) {
 		port = &priv->port_intrs[i];
 
-- 
2.17.1

