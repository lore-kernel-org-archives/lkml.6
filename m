Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842CBC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B2420862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y1QhijyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B2420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbeHBCmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:42:32 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45992 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732606AbeHBCmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:42:31 -0400
Received: by mail-qt0-f194.google.com with SMTP id y5-v6so496358qti.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8J6/E5DOdpzfUXnnAqdehMeunvpbQEWEvs4XzhoSLhM=;
        b=Y1QhijyF/0FEGSt6ebXo51NoscfwxhPvmVEWW5QQtxiISUZ0Oo/P5BbdxNtiD5zjOj
         b36E7rciHZuap/ewYq438GbxLqLGWS6GEoFHU8R6FLQsBf30U40FDSisJJ2A+9k5xgP3
         bukJ2PFNcm8Jcfa9BpoSyJkfFTRMNpWEOsGS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8J6/E5DOdpzfUXnnAqdehMeunvpbQEWEvs4XzhoSLhM=;
        b=LrFCkI84KRJ59BlaPrJMVYUCjfpQC3Fz2CsX5tfhnXsxMIlKnaKebFL7kfw0iyJCJV
         je111HRi/UAeBPiJ3Gzcd/rw0rsgFF/SS1VTxEXHDlWGYPH/799uY0LkDrKrsdqYgPTe
         I9B2hPXM9OGJ9BtEFflZksM6y9H3INISsq/Hp1nJ9NnmZOjDeOewcSxVdJETE8d81Wv4
         A3iGGcUk6EAMZWZ78bLoUOb9adLgHq2lxG0OI9GWDmLe/EtlSEamvAInJLsxjGXG+DBS
         2kvKKGM/Yep2mkfSTCp6Gk0n3lKD0aQJnVFH8yphW+YbfK8s3X6f9IkCW/ICWuxEyzAq
         zdTg==
X-Gm-Message-State: AOUpUlF+EW58DCd0Z4er//L7YtrJLtozomG96Y359d7wYwngQSeeB3wE
        in52gPt52CrF72QOoyR90Vh6pw==
X-Google-Smtp-Source: AAOMgpetCaWDQ2/TePDuTSovLx1xa7fLg0A3hqouBZ5Q2w+h3/iYLsSLYwGuWXvtR2VPhe/1cunoNQ==
X-Received: by 2002:ac8:37c2:: with SMTP id e2-v6mr593938qtc.417.1533171241252;
        Wed, 01 Aug 2018 17:54:01 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e81-v6sm325116qka.3.2018.08.01.17.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 17:54:00 -0700 (PDT)
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
Subject: [PATCH v4 7/8] net: phy: Add support to configure clock in Broadcom iProc mdio mux
Date:   Wed,  1 Aug 2018 17:53:52 -0700
Message-Id: <1533171233-14557-8-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
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
 drivers/net/phy/mdio-mux-bcm-iproc.c | 41 ++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 3ba9616..c608e3c4 100644
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
 #define MDIO_SCAN_CTRL_OFFSET		0x008
 #define MDIO_SCAN_CTRL_OVRIDE_EXT_MSTR	28
 
@@ -49,21 +53,38 @@
 
 #define MDIO_REG_ADDR_SPACE_SIZE	0x250
 
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
 
 static void mdio_mux_iproc_config(struct iproc_mdiomux_desc *md)
 {
+	u32 divisor;
 	u32 val;
 
 	/* Disable external mdio master access */
 	val = readl(md->base + MDIO_SCAN_CTRL_OFFSET);
 	val |= BIT(MDIO_SCAN_CTRL_OVRIDE_EXT_MSTR);
 	writel(val, md->base + MDIO_SCAN_CTRL_OFFSET);
+
+	if (md->core_clk) {
+		/* use rate adjust regs to derrive the mdio's operating
+		 * frequency from the specified core clock
+		 */
+		divisor = clk_get_rate(md->core_clk) / MDIO_OPERATING_FREQUENCY;
+		divisor = divisor / (MDIO_RATE_ADJ_DIVIDENT + 1);
+		val = divisor;
+		val |= MDIO_RATE_ADJ_DIVIDENT << MDIO_RATE_ADJ_DIVIDENT_SHIFT;
+		writel(val, md->base + MDIO_RATE_ADJ_EXT_OFFSET);
+		writel(val, md->base + MDIO_RATE_ADJ_INT_OFFSET);
+	}
 }
 
 static int iproc_mdio_wait_for_idle(void __iomem *base, bool result)
@@ -204,6 +225,19 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	md->core_clk = devm_clk_get(&pdev->dev, NULL);
+	if (md->core_clk == ERR_PTR(-ENOENT) ||
+	    md->core_clk == ERR_PTR(-EINVAL))
+		md->core_clk = NULL;
+	else if (IS_ERR(md->core_clk))
+		return PTR_ERR(md->core_clk);
+
+	rc = clk_prepare_enable(md->core_clk);
+	if (rc) {
+		dev_err(&pdev->dev, "failed to enable core clk\n");
+		return rc;
+	}
+
 	bus = md->mii_bus;
 	bus->priv = md;
 	bus->name = "iProc MDIO mux bus";
@@ -217,7 +251,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 	rc = mdiobus_register(bus);
 	if (rc) {
 		dev_err(&pdev->dev, "mdiomux registration failed\n");
-		return rc;
+		goto out_clk;
 	}
 
 	platform_set_drvdata(pdev, md);
@@ -236,6 +270,8 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 
 out_register:
 	mdiobus_unregister(bus);
+out_clk:
+	clk_disable_unprepare(md->core_clk);
 	return rc;
 }
 
@@ -245,6 +281,7 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
 
 	mdio_mux_uninit(md->mux_handle);
 	mdiobus_unregister(md->mii_bus);
+	clk_disable_unprepare(md->core_clk);
 
 	return 0;
 }
-- 
1.9.1

