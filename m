Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B17C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056AA2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk4ueTpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056AA2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbeJLFfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:35:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42296 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeJLFfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:35:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so4805456pgq.9;
        Thu, 11 Oct 2018 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3C6u/ShLXSWtgH8qvX758ST7lZ3kV9q8XVqgGADVtoM=;
        b=Qk4ueTpdZv51r7bW9KbdF7G2hlKFh4J2Gr/xLV/rmm40aYmYv/dqrsFYrV/toNoh4o
         DFVgB6ZQOtgCKYc1kPdl+05WY7D5Frl9RBJ/YIyWceNZromIpxfCbK6tUOQ8cggui3ge
         1SrN29rm40Qp1PEh9yX0ZrMacLFJJ4BbIsVApBCyDqRH9qNV+v6IwQoOp8g/dc5MmYG/
         x9rlve3ZPb9TECCLrx9/N6VdOebQxxL8fP8a2jfmVPDV95w788ZlsX7ecZKEtqWLFz0u
         b4J7AeP5iZ6HAIF5S20KLJ1UXbqFPe538eVGsCLIizMutM4NghVun6AN1Vo1aDUUZ0CF
         Hc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3C6u/ShLXSWtgH8qvX758ST7lZ3kV9q8XVqgGADVtoM=;
        b=pbr8Acbw9sE+ym8wvSGU4+RnXbMm1ATTse4WS98vrZvoZhFdd9W9UUFlHLaUJdnkyW
         +v+b+CZhnBmr6bw3bsEPAMkG/Ff12sOI+prrto6Pz4H6eSH5b+BigrG7lze02O9Pkbdo
         dq0v9MqXWEw+eonz+WyS9piDYm409hlkRgBAilzj6yhO0lEk+mvh7qaRNE0uxuxghGfo
         NWIqoal2xUzoww8qqtmuGHdQ7u+2oiY1iXlNDOVjk1YutRomb4TxdSgqba9+7eGTyDau
         xsW5MLSEPXtPVXw2QyuwgRboLUsWoS9wLMk/GgYjR1SbZsX0OvSdV+IitzIBBlnn0za7
         +KsQ==
X-Gm-Message-State: ABuFfogH/EtpwVZu79BNDN8rTHtxHgK+lvHRJmmvIfXeCDeO5x1VrzCC
        4cRuUzI9aIcos0ZvdppWaCEHQmbs
X-Google-Smtp-Source: ACcGV60ZN/0tHhGAbgWXy+bTmShJulaYWEFSIKlM5peREPsWs0OYt0AO/pRy38L3wnf0qNypl1P/Xw==
X-Received: by 2002:a63:78cc:: with SMTP id t195-v6mr3012223pgc.329.1539295599861;
        Thu, 11 Oct 2018 15:06:39 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v38-v6sm60250233pgn.57.2018.10.11.15.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 15:06:38 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: bcmgenet: Poll internal PHY for GENETv5
Date:   Thu, 11 Oct 2018 15:06:33 -0700
Message-Id: <20181011220633.24450-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On GENETv5, there is a hardware issue which prevents the GENET hardware
from generating a link UP interrupt when the link is operating at
10Mbits/sec. Since we do not have any way to configure the link
detection logic, fallback to polling in that case.

Fixes: 421380856d9c ("net: bcmgenet: add support for the GENETv5 hardware")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 4241ae928d4a..34af5f1569c8 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -321,9 +321,12 @@ int bcmgenet_mii_probe(struct net_device *dev)
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
-- 
2.17.1

