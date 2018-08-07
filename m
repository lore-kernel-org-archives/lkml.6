Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF350C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A35D21884
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P2zu3nMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A35D21884
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389929AbeHGTRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:17:53 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40443 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389182AbeHGTRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:17:42 -0400
Received: by mail-qk0-f196.google.com with SMTP id c126-v6so11909201qkd.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nyzubDi3jL/TObKoMWlexN4OMzGWcc7moMA6xbh5aB4=;
        b=P2zu3nMfw2r0p/ctflwLKq9EK5MeA4aZqK9reZGkUvhBL1pCcT2QFHvKdA6AVktlsy
         PPHbgSbZm/rMXzj26id5LsYSkb3iO+OGz+cn4g6vtz5vFYLwY8y5wuHEvjaRdbXj9W/6
         l5A5FZUNdI8TWChPnVlXK/erKMcZD/9ZMIGj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nyzubDi3jL/TObKoMWlexN4OMzGWcc7moMA6xbh5aB4=;
        b=blfFiMFPFW+TKfn9TBjOiAzACS4Sk5Da6vv1haGJcl7ZngzI+7NWDBquTY4n0U53oi
         BiAg33rTUDpnLBOyAREG5OVg+oQIf15ljv1x4cphiGGbw7TpqYVF06fLc5hS8sIfXnzs
         Mb049fozjjqy/Gc48nBC+ljXrl1xCWCzLhCuVXNnLPL2/BxQSeaT2qMTUlQUgeJ1Bz4w
         sH3X/2QphByJ9QMPuAeVDB7x4zBmnjzf4oTIy+SD2jTC3Zzfds6XzNDgnuCNLXYcRQ1H
         4hl869ZQdG90K8Kq6ZigCoekhrRbF09fPFKLg7wS7JBmlaG3EZHHkgdPcM4PHEAszflj
         qGPg==
X-Gm-Message-State: AOUpUlFNjlYaJ+LAyI0icqbAqfLlLL0eZMrUWSCrW6XAt2JD238p+ncG
        IiETmrRO0+9gHfcG/mKbggf0jg==
X-Google-Smtp-Source: AAOMgpelJnP+iLMoyncmr1xAE+feFOXEf/SrCOX6stXCHiIw+Ci01/rZ41eNFCbPr+/NdlaZQ0b54w==
X-Received: by 2002:a37:ad07:: with SMTP id f7-v6mr17013801qkm.114.1533661347834;
        Tue, 07 Aug 2018 10:02:27 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d12-v6sm867483qth.35.2018.08.07.10.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 10:02:27 -0700 (PDT)
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Arun Parameswaran <arun.parameswaran@broadcom.com>
Subject: [PATCH 2/3] net: dsa: b53: Add support for Broadcom Omega SoC internal switch
Date:   Tue,  7 Aug 2018 10:02:43 -0700
Message-Id: <1533661364-15381-3-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533661364-15381-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533661364-15381-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Broadcom Omega SoC internal ethernet switch
to the b53 srab driver in the DSA framework.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/dsa/b53/b53_srab.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index 8247481..91de2ba 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -374,6 +374,7 @@ static int b53_srab_write64(struct b53_device *dev, u8 page, u8 reg,
 	{ .compatible = "brcm,bcm88312-srab", .data = (void *)BCM58XX_DEVICE_ID },
 	{ .compatible = "brcm,cygnus-srab", .data = (void *)BCM583XX_DEVICE_ID },
 	{ .compatible = "brcm,nsp-srab", .data = (void *)BCM58XX_DEVICE_ID },
+	{ .compatible = "brcm,omega-srab", .data = (void *)BCM583XX_DEVICE_ID },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, b53_srab_of_match);
-- 
1.9.1

