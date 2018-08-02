Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1AFC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013C0208A6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XYU820zg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013C0208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbeHBCmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:42:24 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39267 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732507AbeHBCmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:42:21 -0400
Received: by mail-qk0-f196.google.com with SMTP id b5-v6so437597qkg.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nf12dmutfgCfp/0jaiDAW47A5xaVfjlLX5su1g70bm4=;
        b=XYU820zg1XHKnPlftT/nf8r+l7YBOPuDJ5zMrvEnp7kJ0PnUxT62LLTSaatdW4Sj24
         EXGQI+goI6WOaq/ssTyesoItgHbRUm4XXikraaj41Rj58sHf8sUjiAP94M/4mnRs3SVS
         JydIKAlzn9Qd9wYTybwlU795Tl7msV4dFy4WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nf12dmutfgCfp/0jaiDAW47A5xaVfjlLX5su1g70bm4=;
        b=SIyF4/5KxAkXg+eDwH3gqoNiFvJqWy7yCQwWuaAJbdqGrIo7blNgXsA0bppC0WIkuC
         uFLJYUjK5ZniMrw10mcG73xkAyJiZFlUNYz0QwRoHfo1Iq3wddVaJ/ZCY+I9lxUd1RAJ
         MpnCNUSjz9OH778TzhzA9obzbP/mmlO7eqniLBBd3osh8U2ewlbv1pQzstfOZiUsNJlv
         v27YBGXG+k8BbngqaDOeponhrkJzuA0AxhSdW2B+fhuk+tloVFuYq4Y1b38x3KxMA98L
         XQjfJIXf9Tf33oPCiSsG9Mubu1nawJ7cjS0oVeYnJQ7FjNFcDiUvDIyTbVoGwT6N62VS
         PjYQ==
X-Gm-Message-State: AOUpUlH8DiwByIaPoGLm18cybRlbQEkXrjtu2LVqWhDFGS+Eo44RR3of
        tbAdcIi3QHO23vyJetS5vgtaBg==
X-Google-Smtp-Source: AAOMgpf6yAKLaGbJlL9DM5N3NhcgVYe2C2w+WNGe1GOGuLlWoTQuMaLY6kx+qbZWXoiwjLpHi1FuYw==
X-Received: by 2002:a37:de1a:: with SMTP id h26-v6mr595757qkj.442.1533171231073;
        Wed, 01 Aug 2018 17:53:51 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e81-v6sm325116qka.3.2018.08.01.17.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 17:53:50 -0700 (PDT)
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
Subject: [PATCH v4 4/8] net: phy: Disable external master access in bcm mdio mux driver
Date:   Wed,  1 Aug 2018 17:53:49 -0700
Message-Id: <1533171233-14557-5-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
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

