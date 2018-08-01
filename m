Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBEBC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49080208B0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IkrcMBqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49080208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbeHATnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:43:18 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38325 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbeHATnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:43:17 -0400
Received: by mail-qt0-f193.google.com with SMTP id y19-v6so20884567qto.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nf12dmutfgCfp/0jaiDAW47A5xaVfjlLX5su1g70bm4=;
        b=IkrcMBqXejJbjiM9esDZ0KrloX+mFKyLKzB9nhDcjUYPH1D6er4lezIalmpfbsVeMX
         Ae7xzxcOPMbm4t9dOGA9jB2B8DcxW+yPutDonqgEMqZibeiAOOv8aE9Ek7HL8BEstxUR
         tfHQHydIgUSEQcplQwUvBZuYDChkAWLorSPxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nf12dmutfgCfp/0jaiDAW47A5xaVfjlLX5su1g70bm4=;
        b=lqRyyh2ppsAei+btS7LrSZoELTNvS1IRlUCI2mWkudJSqohh4ETPnB1UnWMnByxC3j
         3XZULNTDx32PDLFNci3hFQZZz5aMzZSuu1nWTRJ5T2+f4zXOoZat0rzkp8j4IyopJhZ+
         kYA9PddQb+5qV9S/h9i2MfvCDPh1DzgRgHrcGiwhMdSWoVrFp7RmG55ZQ/K0CraHEruh
         FGwABwlqyouA+ZKp9NlJTkeum5uxlH/iHiI3MIj1h0CXwERnh9au2W19A+/8su/1JPnU
         hgVbZt0fXgWf0bxiWCKpOrK9mm57/iFBznzskFfdfIpFeq/nynjDLrJ7r3KQXOXeKmv2
         /oQQ==
X-Gm-Message-State: AOUpUlF3AV1lyicKmrFRn8EhL+QO+KzVD//RcNcyF5M3+Y/PlbMqSNt1
        sRRnNOM9rlWz6R/sOCGmA/A/ag==
X-Google-Smtp-Source: AAOMgpfmhVFCO2E//aPsp2brBTIDzbbcNJEQ1NFN+UyQUdkP/y4t9PFcCW7kZDbt4CXIm8ACtfx2rA==
X-Received: by 2002:ac8:3473:: with SMTP id v48-v6mr25139566qtb.400.1533146184959;
        Wed, 01 Aug 2018 10:56:24 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m12-v6sm14401729qkl.54.2018.08.01.10.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 10:56:24 -0700 (PDT)
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Arun Parameswaran <arun.parameswaran@broadcom.com>
Subject: [PATCH v3 4/8] net: phy: Disable external master access in bcm mdio mux driver
Date:   Wed,  1 Aug 2018 10:56:22 -0700
Message-Id: <1533146186-8374-5-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the scan control register in the Broadcom iProc
mdio mux driver to disable access to external master.

In some SoC's, the scan control register defaults to an incorrect
value.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 48bb74a..c36ce4b 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -22,6 +22,9 @@
 #include <linux/mdio-mux.h>
 #include <linux/delay.h>
 
+#define MDIO_SCAN_CTRL_OFFSET		0x008
+#define MDIO_SCAN_CTRL_OVRIDE_EXT_MSTR	28
+
 #define MDIO_PARAM_OFFSET		0x23c
 #define MDIO_PARAM_MIIM_CYCLE		29
 #define MDIO_PARAM_INTERNAL_SEL		25
@@ -53,6 +56,16 @@ struct iproc_mdiomux_desc {
 	struct mii_bus *mii_bus;
 };
 
+static void mdio_mux_iproc_config(struct iproc_mdiomux_desc *md)
+{
+	u32 val;
+
+	/* Disable external mdio master access */
+	val = readl(md->base + MDIO_SCAN_CTRL_OFFSET);
+	val |= BIT(MDIO_SCAN_CTRL_OVRIDE_EXT_MSTR);
+	writel(val, md->base + MDIO_SCAN_CTRL_OFFSET);
+}
+
 static int iproc_mdio_wait_for_idle(void __iomem *base, bool result)
 {
 	unsigned int timeout = 1000; /* loop for 1s */
@@ -216,6 +229,8 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 		goto out_register;
 	}
 
+	mdio_mux_iproc_config(md);
+
 	dev_info(md->dev, "iProc mdiomux registered\n");
 	return 0;
 
-- 
1.9.1

