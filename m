Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A21C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAC620700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895849;
	bh=+KYsp6FP/vNIsTkQPZM2tF9JaivqOZma+SXx70UnLLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OtmAAZ9fPy4ZbY+5Jl11c0c4RPP5lccLv/N+/AVdSVi7JVWN61Sz26czJp1DVGz3m
	 c9vcheTE8PxCs6yErfzklvzOG+0oFu0h/b9OliSYStY5ldK73RgDPd6b5xRJoGheN1
	 TKdDOAIbWjq55w8SuZrEfZSXyO6mTYO+3f0x2d+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbfBKOh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:37:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731440AbfBKOhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:37:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 283F521B24;
        Mon, 11 Feb 2019 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895842;
        bh=+KYsp6FP/vNIsTkQPZM2tF9JaivqOZma+SXx70UnLLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UQkvClP8x1KaGCpgV4ZVxajz3gyeUJB2NvEJMum7WYzlqBXfPZ6IINOvDiCsm9dbZ
         g54jw2yvmI1BJ3VxU3McCRt7mqj1RiNrCe1vnqEx1N98oIEuIaKG137Rg6pYq344sy
         5TOPlugnfzbd0aW6YEZsCalv2BQ2WUh1DsnbCLxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 310/352] net: dsa: b53: Fix for failure when irq is not defined in dt
Date:   Mon, 11 Feb 2019 15:18:57 +0100
Message-Id: <20190211141906.561014730@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arun Parameswaran <arun.parameswaran@broadcom.com>

[ Upstream commit 39841cc1cbb69344539c98a1fa9d858ed124c7ba ]

Fixes the issues with non BCM58XX chips in the b53 driver
failing, when the irq is not specified in the device tree.

Removed the check for BCM58XX in b53_srab_prepare_irq(),
so the 'port->irq' will be set to '-EXIO' if the irq is not
specified in the device tree.

Fixes: 16994374a6fc ("net: dsa: b53: Make SRAB driver manage port interrupts")
Fixes: b2ddc48a81b5 ("net: dsa: b53: Do not fail when IRQ are not initialized")
Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/b53/b53_srab.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -511,9 +511,6 @@ static void b53_srab_prepare_irq(struct
 	/* Clear all pending interrupts */
 	writel(0xffffffff, priv->regs + B53_SRAB_INTR);
 
-	if (dev->pdata && dev->pdata->chip_id != BCM58XX_DEVICE_ID)
-		return;
-
 	for (i = 0; i < B53_N_PORTS; i++) {
 		port = &priv->port_intrs[i];
 


