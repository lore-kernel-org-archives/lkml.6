Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526A2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CDD21479
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CDD21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeK2XAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:00:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:38394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbeK2XAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:00:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40324ACC8;
        Thu, 29 Nov 2018 11:55:44 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Palmer Dabbelt <palmer@sifive.com>, f.fainelli@gmail.com,
        sergei.shtylyov@cogentembedded.com, atish.patra@wdc.com,
        nicolas.ferre@microchip.com, netdev@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        hkallweit1@gmail.com
Subject: Re: macb: probe of 10090000.ethernet failed with error -110
References: <2e17bba6-d932-37b2-5dca-0963fc50f5e6@gmail.com>
        <mhng-0ddf5852-8900-4131-b3e0-81c5cc7de2eb@palmer-si-x1c4>
        <20181129055510.GB17675@lunn.ch>
X-Yow:  Can you MAIL a BEAN CAKE?
Date:   Thu, 29 Nov 2018 12:55:42 +0100
In-Reply-To: <20181129055510.GB17675@lunn.ch> (Andrew Lunn's message of "Thu,
        29 Nov 2018 06:55:10 +0100")
Message-ID: <mvmtvk0drnl.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29 2018, Andrew Lunn <andrew@lunn.ch> wrote:

> So if we assume you can identify the PHY using its ID registers, you
> can put this reset code into the soft_reset call. That gets called
> first before anything else. There is no need to add a new function to
> phy_driver.

I've tried the following, but it made things only worse, with the
probing not working at all.

Andreas.

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 7cae175177..65baf31331 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -1822,6 +1822,23 @@ static int vsc85xx_probe(struct phy_device *phydev)
 	return vsc85xx_dt_led_modes_get(phydev, default_mode);
 }
 
+static int vsc8541_soft_reset(struct phy_device *phydev)
+{
+	/* The VSC8541 has an unexpected feature where a single reset
+	 * rising edge can only be used to enter managed mode.  For
+	 * unmanaged mode a pair of reset rising edges is necessary.
+	 */
+	mdio_device_reset(&phydev->mdio, 0);
+	mdio_device_reset(&phydev->mdio, 1);
+
+	/* After this pair of reset rising edges we must wait at least
+	 * 15ms before writing any phy registers.
+	 */
+	msleep(15);
+
+	return genphy_soft_reset(phydev);
+}
+
 /* Microsemi VSC85xx PHYs */
 static struct phy_driver vsc85xx_driver[] = {
 {
@@ -1908,7 +1925,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.phy_id_mask    = 0xfffffff0,
 	.features	= PHY_GBIT_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
-	.soft_reset	= &genphy_soft_reset,
+	.soft_reset	= &vsc8541_soft_reset,
 	.config_init    = &vsc85xx_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
 	.aneg_done	= &genphy_aneg_done,
-- 
2.19.2


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
