Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D1AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706F3208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pl4NRqzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706F3208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbeHATnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:43:31 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33355 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732418AbeHATnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:43:31 -0400
Received: by mail-qk0-f195.google.com with SMTP id 27-v6so13279887qkv.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N+kIkDYP/D6+lxFIQ9EfJw/C6zC9oAhfDWWx9Ovhv9M=;
        b=Pl4NRqznZj2NDw6bs7H/bqjnS85Wyvn78vtXuUXvlkBENaHlrDcYgUTzSgM4noQNM1
         xZEB+siPZ+Ex9+zDjdNz/hHo940Z9oxdbg6uu+6ckmQ7vFlQdA380pIPRVgo7nLbA3gh
         syF0QIE/9xG/40Et0WqrHlhYgIG/dlrGynAmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N+kIkDYP/D6+lxFIQ9EfJw/C6zC9oAhfDWWx9Ovhv9M=;
        b=kID00lHHiz+F6OOqdhiEMKFFgI0SbnwyYxwwaXmq2kaUwjvbtELElEIJ/WnjmrdEXG
         GPcHELiOD03XlGKiDqiMlBlL5b85nMwhbMJJPv2RtwrXZC2u7QwpYo7qUthcAItGWp90
         rOgRHIXcT8l/HuAGtv5zmOesZ58omao6HNk7t0KDNaR9S3R9Egi/NmWCMDpxFnWhjatO
         Ubuaeypm1NXXzKCcfgieacixkbKL6DWR7oCeWiBLW1RK192YlQdY+kF9HenX0BqaX5ep
         kDiZR/aAv/SQrMYIhRwkLt0eHjsx/Z5Zh99H1PcaGWi92IchyEDQzh7BAjNJt1Ecbx/f
         OM7Q==
X-Gm-Message-State: AOUpUlF5IShEEUk2Mg9qVMrgBqsXxsL5M1q+ASz6osO7a02tJDmYZeUC
        bduaTeIq/varA2hzEodPfUr4eA==
X-Google-Smtp-Source: AAOMgpe9uSYp6c9j+Uxd8IGvbG+6SpQRgHfeVJq+EmgDcblIju84GsC4WsmGnBYbTZwq6T0QEMrABQ==
X-Received: by 2002:a37:1194:: with SMTP id 20-v6mr26087359qkr.379.1533146198648;
        Wed, 01 Aug 2018 10:56:38 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m12-v6sm14401729qkl.54.2018.08.01.10.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 10:56:38 -0700 (PDT)
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
Subject: [PATCH v3 8/8] net: phy: Add pm support to Broadcom iProc mdio mux driver
Date:   Wed,  1 Aug 2018 10:56:26 -0700
Message-Id: <1533146186-8374-9-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for suspend and resume to the Broadcom iProc mdio
mux driver.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 5127010..4e2c51b 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -289,6 +289,32 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
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
@@ -301,6 +327,7 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
 	.driver = {
 		.name		= "mdio-mux-iproc",
 		.of_match_table = mdio_mux_iproc_match,
+		.pm		= &mdio_mux_iproc_pm_ops,
 	},
 	.probe		= mdio_mux_iproc_probe,
 	.remove		= mdio_mux_iproc_remove,
-- 
1.9.1

