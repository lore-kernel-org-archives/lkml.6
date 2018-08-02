Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33785C46463
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE81B20862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E1ZGKzuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE81B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbeHBCmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:42:25 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35992 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732523AbeHBCmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:42:24 -0400
Received: by mail-qt0-f193.google.com with SMTP id t5-v6so561649qtn.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=27NQGqCuJeCZzYDzyqMtf4gclMxWU9BJMx0JatVN93M=;
        b=E1ZGKzuyLwXdkbCF9PRa0754sL7wKat2ynufKI/WLe7BeVS3f4I2UCPplLXPcGlixU
         Tjg8acoB/22G94yG+zLvExTV5xi3osjReQxPc9f1WkEqcICklkfMvv3xRQV15P0gHgwd
         PbwvZsoV3+yxQtuBNwcd+Z9iStj5V0soXW1DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=27NQGqCuJeCZzYDzyqMtf4gclMxWU9BJMx0JatVN93M=;
        b=uEkxzhEdymX12P0uMgtXkKNcd+srplPsZ7hB08CcV8vvr5epT9Sby+5xVLpehp94cl
         yOe8lq6C+Y76Ds3ajzsQivXPVXw0f6GNR8U0ZlUEvThbzpV9eRbezHOusNt/BcKMtw9m
         o8vWKPyzeM3OkNTu+accI/KI5FwSZibL0VJ/TKBcTQisszFB9rHq4fdZ4EtXPsZePyBM
         zkHJBB+bOvi2yhzJ5VHtCOOllXBk5cxZFXzdixQcd1fW1ZdM7qB9UX/VvlZ9LBeQC3Hn
         8NBTWBWPTvO2CrjPMsZg2PRH3wzpuFod7yvPIuJk8QUqikPmzuGzL4G91ruVNeaSdzbC
         qMlQ==
X-Gm-Message-State: AOUpUlGRyko+rmVRoR2EcISD+jQpBU2m9tNYHB+9gTWykylxIjQyVkGl
        9muLX2ll1dm9QWFDeyIQvl113Q==
X-Google-Smtp-Source: AAOMgpdpPS1QTP6WNym13vW/yroJQNS6bssvnZXJ22Xt9X1gpC00mIqKaXamtrtPK/HpGs0mlgeIGA==
X-Received: by 2002:a0c:d21d:: with SMTP id m29-v6mr650053qvh.86.1533171234515;
        Wed, 01 Aug 2018 17:53:54 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e81-v6sm325116qka.3.2018.08.01.17.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 17:53:53 -0700 (PDT)
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
Subject: [PATCH v4 5/8] net: phy: Use devm api for mdio bus allocation in bcm iproc mdio mux
Date:   Wed,  1 Aug 2018 17:53:50 -0700
Message-Id: <1533171233-14557-6-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_mdiobus_alloc() instead of mdiobus_alloc() in the Broadcom
iProc mdio mux driver.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index c36ce4b..3ba9616 100644
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
@@ -236,8 +236,6 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 
 out_register:
 	mdiobus_unregister(bus);
-out:
-	mdiobus_free(bus);
 	return rc;
 }
 
@@ -247,7 +245,6 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
 
 	mdio_mux_uninit(md->mux_handle);
 	mdiobus_unregister(md->mii_bus);
-	mdiobus_free(md->mii_bus);
 
 	return 0;
 }
-- 
1.9.1

