Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FF2C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D980F20862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J48J08jB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D980F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbeHBCmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:42:35 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46340 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732630AbeHBCme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:42:34 -0400
Received: by mail-qt0-f195.google.com with SMTP id d4-v6so490498qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HOqtMPkRrllAA9/+1/Qd/9RyHYWH1PW90do0Y7O7k3s=;
        b=J48J08jBgOnEIbwT8l0S0/82Ii1879zCV/9p5UpdQFlc43+A3FWHywZ9wQoyWKZPfA
         RKn+abxX/Jz1nJpUcCt4ckHqBTeXKx3DOu4CoOsVKC96PZJYHG2lmaaa3aR3VEiwQVKh
         xoa4hjSLtTrfau0si20EQZmyJF5r+HNoT9h+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HOqtMPkRrllAA9/+1/Qd/9RyHYWH1PW90do0Y7O7k3s=;
        b=bv8udnw1YieyoQPezaxdps1WN8WcvDLG91oMWN1CfNUbWwoiDnb5OnMkGw4a2UH7jg
         F7EvT52vHBXxQoOe5bqQTcnIemWRjsKhJ5gG2NeiQ4bddU5p20ue0Jc+vTeiliRSnShk
         3yxtN8dlRcrinYvAAtHZ21G/Bgdpin+mPici+8lnp+lWlTUZYT1rDQLrqh+DyVZVDbp/
         m256kESADI/VjzhcdUbl9HpElYxXqIVq6tqMpxxpiwZzPSqXSpLBDvCwFwkzXUj4MKih
         3y6cp99nCINLY1chg6h693yfRkJAi90sbf4LAKz9YUzvuKW7XhqyMcBIMHf3CJWzautG
         2rhA==
X-Gm-Message-State: AOUpUlHF597DamSV7aRY0mhZDH7RDhJnHXJ7h/l46Rj/CzaqyPWL8GTL
        giTETq0lMYoTqAXDBHTM8lg4yw==
X-Google-Smtp-Source: AAOMgpd3V7XjdMbu7A+lB59HapT77cCdi4ISeBtIH9hK9rurnSlrysgteY308G4SOwHYL7NWB7KHPw==
X-Received: by 2002:ac8:16ee:: with SMTP id y43-v6mr658592qtk.148.1533171244590;
        Wed, 01 Aug 2018 17:54:04 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e81-v6sm325116qka.3.2018.08.01.17.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 17:54:04 -0700 (PDT)
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
Subject: [PATCH v4 8/8] net: phy: Add pm support to Broadcom iProc mdio mux driver
Date:   Wed,  1 Aug 2018 17:53:53 -0700
Message-Id: <1533171233-14557-9-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for suspend and resume to the Broadcom iProc mdio
mux driver.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index c608e3c4..518f4c7 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -286,6 +286,32 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int mdio_mux_iproc_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iproc_mdiomux_desc *md = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(md->core_clk);
+
+	return 0;
+}
+
+static int mdio_mux_iproc_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iproc_mdiomux_desc *md = platform_get_drvdata(pdev);
+
+	clk_prepare_enable(md->core_clk);
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
@@ -298,6 +324,7 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
 	.driver = {
 		.name		= "mdio-mux-iproc",
 		.of_match_table = mdio_mux_iproc_match,
+		.pm		= &mdio_mux_iproc_pm_ops,
 	},
 	.probe		= mdio_mux_iproc_probe,
 	.remove		= mdio_mux_iproc_remove,
-- 
1.9.1

