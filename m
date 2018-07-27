Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083B0C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBEC20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gXoZFa7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBEC20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389887AbeG0WrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:47:18 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45534 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389863AbeG0WrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:47:17 -0400
Received: by mail-qk0-f195.google.com with SMTP id c192-v6so4223416qkg.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fPy8zPe6vPwzlEfwZqSfCetRsqsUUmfFrykow6BYHEI=;
        b=gXoZFa7q++vuUQsgIhl7QzDxj6Ewj4MMz5xAvSRPv2XQ6HaDHcLtwM7z4CcKbavpR9
         Ra8YRK8xVpDopM8ckq5nahnfUo9mE+Q9GI8UitiNOaa4UIlw/0y5LB/Q9+E8Iy5L6IZ6
         rSNAvCrOkno/dYNCoXjvGeF6hYLsrNsA8i/YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fPy8zPe6vPwzlEfwZqSfCetRsqsUUmfFrykow6BYHEI=;
        b=HOLK4t71A68cwm527s2uelv4V194bu3pr5usqUDc9hEioTTQEtyBUTT1GLVKOgItKO
         DhvJCOSADafyhq/JG8MOZJbSyKZWXUfKvHk7nnDMbpwf4IWJLfVWVAkWTQhbm73XBgjW
         E9RfZbRLHXtDm1Vl/nhv8U8z+uFKb/b0Ct0qynNfxAWpbTvJwo2Kgw91OMhAAQnZjYy1
         G5AV7IXGCXu1epGpLsdh2oKPxRylrzi+pR47UEbC7jAUUCoK0jzZM3TloF0TMzcu5Rho
         IF27obc6WXbCsdjtyqaUQKPnJcUuIEdxNTYeeXCo8kDAkYK6M6AFKdq8/p7LZAUSiD8b
         417g==
X-Gm-Message-State: AOUpUlEKgkkb2SZhiNziqmdyf1zG8F67Vho0ysdnd2d91/Kgk19MW5mL
        cZSNMwuYX3BLKIa1RT5NEeMaLQ==
X-Google-Smtp-Source: AAOMgpdPNuvW+4TsmXgdUVB17D885pAr87/wUNRnv9KI7qKKcmanY6lMflUedfCrv7tLVyz89ZMUHA==
X-Received: by 2002:a37:d401:: with SMTP id l1-v6mr7312531qki.221.1532726613522;
        Fri, 27 Jul 2018 14:23:33 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e21-v6sm3416622qtc.67.2018.07.27.14.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 14:23:33 -0700 (PDT)
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
Subject: [PATCH v2 4/7] net: phy: Disable external master access in bcm mdio mux driver
Date:   Fri, 27 Jul 2018 14:23:30 -0700
Message-Id: <1532726613-6483-5-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the scan control register in the Broadcom iProc
mdio mux driver to disable access to external master.

In some SoC's, the scan control register defaults to an incorrect
value.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
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

