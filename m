Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6021FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA16208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ADN2M//O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA16208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbeHATnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:43:22 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33206 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732375AbeHATnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:43:20 -0400
Received: by mail-qt0-f194.google.com with SMTP id c15-v6so20881663qtp.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KwrDBNo657A6SiUK12ekfX5MSVNPn+Tny6h4zOx1v7o=;
        b=ADN2M//OHKi4uiNBD4q4CyciI935grsJgXSOUkJwYhzhPZVKgyT+VgZjqFuOD6ucxr
         8ejwydIZVEaeYsEt25pf+kdEsuiC9wJu78XjctwqGmEjh6EdnnXgjAESQi4OoKQJ5bqq
         Cmn46dzQI4iJvPd2hl6kqaQEZpah4q9JiWQiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KwrDBNo657A6SiUK12ekfX5MSVNPn+Tny6h4zOx1v7o=;
        b=CuQMQT1hPNRGG7kt/2jzXrt9FNkY566HmzI/D6gy65MeWINitnH1m2TtC84p7N9Kr8
         xt7rjDUraF9V+vLMTIjXv2higRrfbueEBxLI1ir0HnBOg+5qjP/1s5uv3oNVOyGzLq25
         cSJ1TSaDPWUDMqPTXsUIAhgcQxo0QcXKh8ykBYpaGSGBjMxB4onLJTBmr8IBcDH8NS0H
         wEx/U4AeylVCk/bN6Wef/+3dCRA7CkQEjhQVp/SL/xykSIt85wBdU9SIBLiHc5B9D/dC
         XcIHq1pTGKlJd2d/BnUEAlbStaeo5Rc9eQ14SzEvGBs9ODzY6Z9ipkybNHaOnQrkBAtr
         T5Uw==
X-Gm-Message-State: AOUpUlHmOA403N+FX/spw24M/T/5slPmiy2e1lkLbIFFJBffv8hRqfs8
        Ix3k7f94Mlf7DsgnW5zU+LD8Uw==
X-Google-Smtp-Source: AAOMgpdeIzDT19HL2XwHdCup+oDoPcFUrlF5G9CZMuof/QyUlZggaOLonbM2/sAVZrSVx/lu+EfdZw==
X-Received: by 2002:a0c:d24d:: with SMTP id o13-v6mr23305952qvh.210.1533146188321;
        Wed, 01 Aug 2018 10:56:28 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m12-v6sm14401729qkl.54.2018.08.01.10.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 10:56:27 -0700 (PDT)
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
Subject: [PATCH v3 5/8] net: phy: Use devm api for mdio bus allocation in bcm iproc mdio mux
Date:   Wed,  1 Aug 2018 10:56:23 -0700
Message-Id: <1533146186-8374-6-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_mdiobus_alloc() instead of mdiobus_alloc() in the Broadcom
iProc mdio mux driver.

Also, clear the driver data on error from probe or when remove() is
called.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index c36ce4b..5640d78 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -198,7 +198,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 		return PTR_ERR(md->base);
 	}
 
-	md->mii_bus = mdiobus_alloc();
+	md->mii_bus = devm_mdiobus_alloc(&pdev->dev);
 	if (!md->mii_bus) {
 		dev_err(&pdev->dev, "mdiomux bus alloc failed\n");
 		return -ENOMEM;
@@ -217,7 +217,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 	rc = mdiobus_register(bus);
 	if (rc) {
 		dev_err(&pdev->dev, "mdiomux registration failed\n");
-		goto out;
+		return rc;
 	}
 
 	platform_set_drvdata(pdev, md);
@@ -226,6 +226,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 			   &md->mux_handle, md, md->mii_bus);
 	if (rc) {
 		dev_info(md->dev, "mdiomux initialization failed\n");
+		platform_set_drvdata(pdev, NULL);
 		goto out_register;
 	}
 
@@ -236,8 +237,6 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 
 out_register:
 	mdiobus_unregister(bus);
-out:
-	mdiobus_free(bus);
 	return rc;
 }
 
@@ -247,7 +246,7 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
 
 	mdio_mux_uninit(md->mux_handle);
 	mdiobus_unregister(md->mii_bus);
-	mdiobus_free(md->mii_bus);
+	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.9.1

