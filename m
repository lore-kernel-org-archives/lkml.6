Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCFFC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3A32083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iKW1K+zF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3A32083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbeGZTyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:54:45 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36210 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730587AbeGZTyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:54:45 -0400
Received: by mail-qt0-f196.google.com with SMTP id t5-v6so2577199qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U06FaEejxyxvjAYaxOat2qv5fl7gaHh65Nf8HRFkW30=;
        b=iKW1K+zFeuKqGM3QvPsDT28zCqN+1KJCTfmkloSeyTV98rdaEczFQrO+5w92nftoOH
         8YjpOYcg9GsfLVwbQLv1FaV8rcQjrNv8jgm5Ybk8a6yQCSeS0jbAFxOHlPxMiqA8w3Qo
         YCKPlCnUW2Lyu7OuMiGg5T/0J8wnxbSmkUoVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U06FaEejxyxvjAYaxOat2qv5fl7gaHh65Nf8HRFkW30=;
        b=GTT+bqz7NQ2ODb/6nAAUY2VjPZgGs7+WyPBGG6h+feSkPfHiJngf2wox9h2muWCLUW
         ldySBBAB+J5J0YAmTPcRY9TrX63qFdhwHl4YZ5eqAjFI03yZZ9G/TuWquj+afTyi6Jvx
         K3qObpH7A+tjTMgXrakUjMVL6Q9MIVrORn0nABzdRvaTeCSyQXzZoq2boOZvocgNKvrA
         9FPiJs+5HLJgIcZDTGfAil1ytd9W/WhkTC3CYDAHYUTjCcyopt2ke51mCekM0EreLRGU
         co+Shv0xgmQ+g7bZq/kUkxozUZVjfKCaa1wUwvMBteOg1+ePkVb/xr2Mgc8I24JcxrhI
         7lIg==
X-Gm-Message-State: AOUpUlFsbrDNCxZVEFlvP244rrUL48aSuuB+9S0KsDPQ47K4obx2dZG0
        jdyvUlkawW9RlnfYYxoKqpxcUg==
X-Google-Smtp-Source: AAOMgpcHy5ED9ay2VhEUp4xZ8PGdvBS6bC6RmPb5qWrtzTuBDgM+pRtFgf9yyTj1NCKJixohwNUeQQ==
X-Received: by 2002:a0c:8441:: with SMTP id l59-v6mr2785673qva.5.1532630200886;
        Thu, 26 Jul 2018 11:36:40 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a187-v6sm1383359qkd.47.2018.07.26.11.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 11:36:40 -0700 (PDT)
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
Subject: [PATCH 6/7] net: phy: Add pm support to Broadcom iProc mdio mux driver
Date:   Thu, 26 Jul 2018 11:36:23 -0700
Message-Id: <1532630184-29450-7-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for suspend and resume to the Broadcom iProc mdio
mux driver.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 6b400dd..89c18d6 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -51,13 +51,25 @@
 #define MDIO_OPERATING_FREQUENCY	11000000
 #define MDIO_RATE_ADJ_DIVIDENT		1
 
+#define MDIO_NUM_OF_REGS_TO_RESTORE	2
+
 struct iproc_mdiomux_desc {
 	void *mux_handle;
 	void __iomem *base;
 	struct device *dev;
 	struct mii_bus *mii_bus;
 	struct clk *core_clk;
+#ifdef CONFIG_PM_SLEEP
+	u32 restore_regs[MDIO_NUM_OF_REGS_TO_RESTORE];
+#endif
+};
+
+#ifdef CONFIG_PM_SLEEP
+static const u16 restore_reg_offsets[MDIO_NUM_OF_REGS_TO_RESTORE] = {
+	MDIO_RATE_ADJ_EXT_OFFSET,
+	MDIO_RATE_ADJ_INT_OFFSET,
 };
+#endif
 
 static void mdio_mux_iproc_config_clk(struct iproc_mdiomux_desc *md)
 {
@@ -258,6 +270,35 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int mdio_mux_iproc_suspend(struct device *dev)
+{
+	int i;
+	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
+
+	for (i = 0; i < MDIO_NUM_OF_REGS_TO_RESTORE; i++)
+		md->restore_regs[i] = readl(md->base +
+					    restore_reg_offsets[i]);
+
+	return 0;
+}
+
+static int mdio_mux_iproc_resume(struct device *dev)
+{
+	int i;
+	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
+
+	for (i = 0; i < MDIO_NUM_OF_REGS_TO_RESTORE; i++)
+		writel(md->restore_regs[i],
+		       md->base + restore_reg_offsets[i]);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(mdio_mux_iproc_pm_ops,
+		mdio_mux_iproc_suspend, mdio_mux_iproc_resume);
+
 static const struct of_device_id mdio_mux_iproc_match[] = {
 	{
 		.compatible = "brcm,mdio-mux-iproc",
@@ -270,6 +311,7 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
 	.driver = {
 		.name		= "mdio-mux-iproc",
 		.of_match_table = mdio_mux_iproc_match,
+		.pm		= &mdio_mux_iproc_pm_ops,
 	},
 	.probe		= mdio_mux_iproc_probe,
 	.remove		= mdio_mux_iproc_remove,
-- 
1.9.1

