Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5744C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E45F20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eSMMhD2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E45F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389952AbeG0Wr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:47:27 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33230 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389890AbeG0Wr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:47:26 -0400
Received: by mail-qk0-f195.google.com with SMTP id 27-v6so4219819qkv.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ogW1NFRN4aOL8E2KY+5+PQwBZjlherVYGuxwPJtFmI=;
        b=eSMMhD2Ipzrbm/K/jrt4buWJYqIi9coI/HClew6qyJHhgpJr4gZQJlr2yc+sRvFRZW
         j6rS5Na/fcrmEC9cXvvUQF9xM/VXGFKxyPFL+7kFu1kiAzwKOE8yr15oDd8NHnK1eDoz
         wnBD1xV54QRgz+7Je2Yz2ay/vSZFj1Z4QZMSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ogW1NFRN4aOL8E2KY+5+PQwBZjlherVYGuxwPJtFmI=;
        b=IlPob/UpmU7Ms5umzU/xk05vYdyGDUGGaC7mGkr9liFoi30wQk9unswbnaLKuikdCr
         gD1UN2bl6AbmfpGnbyW8Egf8WPyAYHPBn67KQSbP/Z6z9pFz1ZFzxBOl9OdscjjxSJ7F
         TQPiRvmPQ87la2gzORYVyt5St0Ih9v8wsB0jPrQ21bnHfKZxTxBx9sTC1KdzosqHKARp
         SNRBSXvTsSb1bGAOszQjyaCAGTe96/xwOIqz1pZZlwATm3vmcSQuPrElnPxJz6yAHNXv
         K8EwgIiVm45NFMqll0TU7C1MxrKkhteUbeGr1DfQIcu54cDq46RHkS6pB3MH8dc+gdzJ
         U7LA==
X-Gm-Message-State: AOUpUlFjeluOLit7ITBFQ/xcE+QN8W0HERwykiqzHWbLUAgn4IJ+tLGW
        Im254vxjUJY2+8HJALW+49hcLA==
X-Google-Smtp-Source: AAOMgpfWlUnKHE0cOmpBrNoFFGEv4JSBhIZ+XC3j9D1lggej2K0WqAUP1g+fJG9Wx3LJfhvSG4trog==
X-Received: by 2002:a37:8e46:: with SMTP id q67-v6mr7147729qkd.439.1532726622482;
        Fri, 27 Jul 2018 14:23:42 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e21-v6sm3416622qtc.67.2018.07.27.14.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 14:23:41 -0700 (PDT)
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
Subject: [PATCH v2 7/7] net: phy: Add pm support to Broadcom iProc mdio mux driver
Date:   Fri, 27 Jul 2018 14:23:33 -0700
Message-Id: <1532726613-6483-8-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for suspend and resume to the Broadcom iProc mdio
mux driver.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 51d1003..d89dce0 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -290,6 +290,33 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int mdio_mux_iproc_suspend(struct device *dev)
+{
+	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
+
+	if (md->core_clk)
+		clk_disable_unprepare(md->core_clk);
+
+	return 0;
+}
+
+static int mdio_mux_iproc_resume(struct device *dev)
+{
+	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
+
+	if (md->core_clk)
+		clk_prepare_enable(md->core_clk);
+
+	mdio_mux_iproc_config(md);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(mdio_mux_iproc_pm_ops,
+			 mdio_mux_iproc_suspend, mdio_mux_iproc_resume);
+
 static const struct of_device_id mdio_mux_iproc_match[] = {
 	{
 		.compatible = "brcm,mdio-mux-iproc",
@@ -302,6 +329,7 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
 	.driver = {
 		.name		= "mdio-mux-iproc",
 		.of_match_table = mdio_mux_iproc_match,
+		.pm		= &mdio_mux_iproc_pm_ops,
 	},
 	.probe		= mdio_mux_iproc_probe,
 	.remove		= mdio_mux_iproc_remove,
-- 
1.9.1

