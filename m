Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B562CC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715AC21884
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uih1h1m8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715AC21884
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389908AbeHGTRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:17:45 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43637 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389568AbeHGTRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:17:45 -0400
Received: by mail-qt0-f196.google.com with SMTP id f18-v6so18616683qtp.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 10:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZVNwSLfCpLHWod5kck08EyL9akFd9to3zjrlZvwR7M8=;
        b=Uih1h1m8GRHM2aohSPsWbeuiigfpdcOT4cTUtWF9zVjML1dkyIgQGTuhzWFly/5RXs
         da3qWl3heylnzFlLGxzHH0fUaokTNrMKr4kECOz6A1Vk6nWPtTuECQ7ZeBqK6vuPErIx
         OMK3ihgUjMEgZ7Mm80peFHeLhiOfXRrfMPIrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZVNwSLfCpLHWod5kck08EyL9akFd9to3zjrlZvwR7M8=;
        b=SCTnLlLTYqjFOY/tP4ol9ktvZzaZTAsBCtgpegvWuJMNBSMu+7QOV8FcAedBVJxq7V
         pcOEbCjpi0t7p3Dez9JEUphpxHY6Zy3WFy5DgYeabF8Ovh14FhP6hKvM6O2GqdFHsvje
         5ubPH8lGqjCwEFj0qophijsgxdZoLu7SmfFJNF3Vwhhgp4QbBw0Ih/qPCcxEPCUG3+Xf
         pbdROCtDyY07xP+D+0CIQ1my59kqZ+5t1iGhs00d1+QhjqTZEgak21ZOHn6DY2uJ76WX
         tmq5BpaSxiqnJdTReTidPRGtmCFBQfQIbRSnjq37gecwjYKX4XT0pkgIqE0nXVAVvvgS
         q9nA==
X-Gm-Message-State: AOUpUlEocwl9xYwCcoyaZuWChGvc0iX/4Br1UaZc7yS0Gzb1CU7FpgUx
        gdgmbInRw/h/KoqYnUVXal41MA==
X-Google-Smtp-Source: AAOMgpd1WpEVuqUy77v0v4E5fC0sYgY6B04lZHAMeJBtpM754nr+KYioJ5Z+GUAvyyCg8iTzZISlhA==
X-Received: by 2002:a0c:b9a9:: with SMTP id v41-v6mr17475940qvf.63.1533661350339;
        Tue, 07 Aug 2018 10:02:30 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d12-v6sm867483qth.35.2018.08.07.10.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 10:02:29 -0700 (PDT)
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
Subject: [PATCH 3/3] net: phy: Add support for Broadcom Omega internal Combo GPHY
Date:   Tue,  7 Aug 2018 10:02:44 -0700
Message-Id: <1533661364-15381-4-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533661364-15381-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533661364-15381-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Broadcom Omega SoC internal Combo Ethernet
GPHY to the bcm7xxx phy driver.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/phy/bcm7xxx.c | 2 ++
 include/linux/brcmphy.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/phy/bcm7xxx.c b/drivers/net/phy/bcm7xxx.c
index 01d2ff2f..b2b6307 100644
--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -229,6 +229,7 @@ static int bcm7xxx_28nm_config_init(struct phy_device *phydev)
 	phy_read(phydev, MII_BMSR);
 
 	switch (rev) {
+	case 0xa0:
 	case 0xb0:
 		ret = bcm7xxx_28nm_b0_afe_config_init(phydev);
 		break;
@@ -659,6 +660,7 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	BCM7XXX_28NM_GPHY(PHY_ID_BCM7439, "Broadcom BCM7439"),
 	BCM7XXX_28NM_GPHY(PHY_ID_BCM7439_2, "Broadcom BCM7439 (2)"),
 	BCM7XXX_28NM_GPHY(PHY_ID_BCM7445, "Broadcom BCM7445"),
+	BCM7XXX_28NM_GPHY(PHY_ID_BCM_OMEGA, "Broadcom Omega Combo GPHY"),
 	BCM7XXX_40NM_EPHY(PHY_ID_BCM7346, "Broadcom BCM7346"),
 	BCM7XXX_40NM_EPHY(PHY_ID_BCM7362, "Broadcom BCM7362"),
 	BCM7XXX_40NM_EPHY(PHY_ID_BCM7425, "Broadcom BCM7425"),
diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index daa9234..949e9af 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -45,6 +45,7 @@
 #define PHY_ID_BCM7445			0x600d8510
 
 #define PHY_ID_BCM_CYGNUS		0xae025200
+#define PHY_ID_BCM_OMEGA		0xae025100
 
 #define PHY_BCM_OUI_MASK		0xfffffc00
 #define PHY_BCM_OUI_1			0x00206000
-- 
1.9.1

