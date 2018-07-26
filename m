Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A83C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F212083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="clNtaWq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F212083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbeGZTyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:54:43 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44919 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731701AbeGZTym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:54:42 -0400
Received: by mail-qt0-f196.google.com with SMTP id b15-v6so2573144qtp.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 11:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ikdg6TfgJbzPXN5/M/XZa8ZiI6+BvFzInZO5gyiw3Kw=;
        b=clNtaWq6HMGhWj/1UqXXdWVqA1vrQYtltDiUjk/fR+U4fxv9Lg7U7lDiRex/NWz/BB
         tf4ItbodXkp0DD3k4eobgmaOJMSxt5OBLqdzSNCGzdg+NWvfRu9x6HAkN3s5cOOZ5bFI
         jpPGd2jt3EpHwVzU1edbYqBeZkTCb/C96q8OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ikdg6TfgJbzPXN5/M/XZa8ZiI6+BvFzInZO5gyiw3Kw=;
        b=ZmsmO6ySptQJAzeOUJqm+TKZ8niTCjeAaMmlx5UPSg3XggR+Z6DwOsex+WbnOjH07b
         JMLS6a6vu46+NeDpQzG2kTgi4Aqr/deO1ngLl4FJ06j6B7VnmIS7IKWfjrwEQ71B7nEp
         GuJeOsGMutUfpAve4c4+JG5xsIFAVTT7Z8YuU8pgMgmZZvHWEB8QfD+j/LCtAxWtC6sQ
         j9icru2J9zLMZMP+D3Oa0QF24vWcmmXtZ1KqY2juBgXZAV86FQGBTlR9X77Yy+UWUHb4
         snk9Zg+UHxguFYc/FT1H7bQ9M5JJVH/EsTkf2dKTb6gA1OhxLsYRf4i7oH78BXSvA1sQ
         hZRw==
X-Gm-Message-State: AOUpUlFiQ5vWLSh67N18wjkX5Zy2ut1XBxTHPasZcFok7kyYlTK+xaeS
        ifh2W5B27Q7FKBAREvhyHgHnIw==
X-Google-Smtp-Source: AAOMgpdFJ2RDh9tPig5BouEq1S2HLkxPsFc3y0QdjSH5u75gFpe5/UJy3I4IaFflMnttreEs5+6bAQ==
X-Received: by 2002:a0c:9308:: with SMTP id d8-v6mr2795146qvd.121.1532630197877;
        Thu, 26 Jul 2018 11:36:37 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a187-v6sm1383359qkd.47.2018.07.26.11.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 11:36:37 -0700 (PDT)
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
Subject: [PATCH 5/7] net: phy: Add support to configure clock in Broadcom iProc mdio mux
Date:   Thu, 26 Jul 2018 11:36:22 -0700
Message-Id: <1532630184-29450-6-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to configure the internal rate adjust register based on the
core clock supplied through device tree in the Broadcom iProc mdio mux.

The operating frequency of the mdio mux block is 11MHz. This is derrived
by dividing the clock to the mdio mux with the rate adjust register.

In some SoC's the default values of the rate adjust register do not yield
11MHz. These SoC's are required to specify the clock via the device tree
for proper operation.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index dc65e95..6b400dd 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -13,7 +13,7 @@
  * You should have received a copy of the GNU General Public License
  * version 2 (GPLv2) along with this source code.
  */
-
+#include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/of_mdio.h>
@@ -22,6 +22,10 @@
 #include <linux/mdio-mux.h>
 #include <linux/delay.h>
 
+#define MDIO_RATE_ADJ_EXT_OFFSET	0x000
+#define MDIO_RATE_ADJ_INT_OFFSET	0x004
+#define MDIO_RATE_ADJ_DIVIDENT_SHIFT	16
+
 #define MDIO_PARAM_OFFSET		0x23c
 #define MDIO_PARAM_MIIM_CYCLE		29
 #define MDIO_PARAM_INTERNAL_SEL		25
@@ -44,13 +48,32 @@
 #define BUS_MAX_ADDR			32
 #define EXT_BUS_START_ADDR		16
 
+#define MDIO_OPERATING_FREQUENCY	11000000
+#define MDIO_RATE_ADJ_DIVIDENT		1
+
 struct iproc_mdiomux_desc {
 	void *mux_handle;
 	void __iomem *base;
 	struct device *dev;
 	struct mii_bus *mii_bus;
+	struct clk *core_clk;
 };
 
+static void mdio_mux_iproc_config_clk(struct iproc_mdiomux_desc *md)
+{
+	u32 val;
+	u32 divisor;
+
+	if (md->core_clk) {
+		divisor = clk_get_rate(md->core_clk) / MDIO_OPERATING_FREQUENCY;
+		divisor = divisor / (MDIO_RATE_ADJ_DIVIDENT + 1);
+		val = divisor;
+		val |= MDIO_RATE_ADJ_DIVIDENT << MDIO_RATE_ADJ_DIVIDENT_SHIFT;
+		writel(val, md->base + MDIO_RATE_ADJ_EXT_OFFSET);
+		writel(val, md->base + MDIO_RATE_ADJ_INT_OFFSET);
+	}
+}
+
 static int iproc_mdio_wait_for_idle(void __iomem *base, bool result)
 {
 	unsigned int timeout = 1000; /* loop for 1s */
@@ -175,6 +198,12 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 		return PTR_ERR(md->base);
 	}
 
+	md->core_clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(md->core_clk)) {
+		dev_info(&pdev->dev, "core_clk not specified\n");
+		md->core_clk = NULL;
+	}
+
 	md->mii_bus = mdiobus_alloc();
 	if (!md->mii_bus) {
 		dev_err(&pdev->dev, "mdiomux bus alloc failed\n");
@@ -206,6 +235,8 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 		goto out_register;
 	}
 
+	mdio_mux_iproc_config_clk(md);
+
 	dev_info(md->dev, "iProc mdiomux registered\n");
 	return 0;
 
-- 
1.9.1

