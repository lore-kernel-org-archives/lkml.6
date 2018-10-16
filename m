Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2156C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7B821476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kncls2tO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7B821476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbeJQBJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbeJQBJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:09:29 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E1FE2089E;
        Tue, 16 Oct 2018 17:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710285;
        bh=YfOCQLbrZ9+KnOCM7Jfx1JrL81DBqa6yVI9NAHYnDx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kncls2tOAyWoSKy107ysOuID5/l6duu3UjVeOkWyYapASQTEHbs1E3V6O3R6pXSow
         DViZkvyKVNZUZ39uVXITHxdkAVoTek8aGxp/ulwpmyqVzPathdx++A/km7HJkjp++S
         RfT5JuyQp4ZOmfsxs0SCjWcVIzp66Gme6dnBqAy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 028/109] net: dsa: bcm_sf2: Fix unbind ordering
Date:   Tue, 16 Oct 2018 19:04:56 +0200
Message-Id: <20181016170526.602666064@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit bf3b452b7af787b8bf27de6490dc4eedf6f97599 ]

The order in which we release resources is unfortunately leading to bus
errors while dismantling the port. This is because we set
priv->wol_ports_mask to 0 to tell bcm_sf2_sw_suspend() that it is now
permissible to clock gate the switch. Later on, when dsa_slave_destroy()
comes in from dsa_unregister_switch() and calls
dsa_switch_ops::port_disable, we perform the same dismantling again, and
this time we hit registers that are clock gated.

Make sure that dsa_unregister_switch() is the first thing that happens,
which takes care of releasing all user visible resources, then proceed
with clock gating hardware. We still need to set priv->wol_ports_mask to
0 to make sure that an enabled port properly gets disabled in case it
was previously used as part of Wake-on-LAN.

Fixes: d9338023fb8e ("net: dsa: bcm_sf2: Make it a real platform device driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/bcm_sf2.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1264,10 +1264,10 @@ static int bcm_sf2_sw_remove(struct plat
 {
 	struct bcm_sf2_priv *priv = platform_get_drvdata(pdev);
 
-	/* Disable all ports and interrupts */
 	priv->wol_ports_mask = 0;
-	bcm_sf2_sw_suspend(priv->dev->ds);
 	dsa_unregister_switch(priv->dev->ds);
+	/* Disable all ports and interrupts */
+	bcm_sf2_sw_suspend(priv->dev->ds);
 	bcm_sf2_mdio_unregister(priv);
 
 	return 0;


