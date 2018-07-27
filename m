Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CD7C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFA420857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eAMVYrEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFA420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389829AbeG0WrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:47:12 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41763 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389791AbeG0WrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:47:11 -0400
Received: by mail-qt0-f196.google.com with SMTP id e19-v6so6510028qtp.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=glrFiC2JaRHiBpgqj/ziGAvHYME6SZdoFPAAkgy0RgQ=;
        b=eAMVYrEVayz/VBQ3w9slcxxuf0bquDmzmByVbJEay6ord4hkfaBA6eh7GUSkKjQVij
         l3UXPQ+xOLAfF6rZPKG+owzEFkUxVd8blxtDVgHjFReE5h46QTQ9W80oJYtvXtbrJ323
         vTQCYC4uA4ej8LplirFIl4tNV/Ji6NGby/9Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=glrFiC2JaRHiBpgqj/ziGAvHYME6SZdoFPAAkgy0RgQ=;
        b=J+aeT6yP+OYEG3NQvQMuxnLawGX/WBmFZT3peqpnpPgdZA+fqO56MNvZAmTE18QmYx
         aIswGjaBBT+D0rYRy3yWnJodw27KR8qiGsgt0Wlz+yZUt3ZlfReVZuMYFGg9+va5wOJX
         nBaoUcDld4s3FUdfO0hUJkNq8kW5gEFLK1MyZ7dqPpf8aX//LVZjlNFoBSiqv3qNU725
         XJ7w1nR8FjePxnPBq/WtUJjjYbaoiGlmbwqopQImfqUQxyfV6iQrDiVJMYTMyy5ZLQQT
         5Z74ZYxv+Ajvulof3PFViUC5MZGAdTmWpvMTNGw12U05xjiv0Ta7mwZpUIlOYzEmhk5j
         nxwA==
X-Gm-Message-State: AOUpUlGTohWL/4M6B4wt4/9EexnXMDaaxMr8XxuCxv8efciKJdIALIlr
        WONpOhkdX0jNBuisPolpdCXD4Q==
X-Google-Smtp-Source: AAOMgpfOhpmzDwiBOMviPPUDVF9H9HGWlc7Z6/x+9Pc+q/84OE1vu2PFxlyIzr0Wa/bL3UMOIlufbw==
X-Received: by 2002:ac8:3692:: with SMTP id a18-v6mr8029803qtc.406.1532726607593;
        Fri, 27 Jul 2018 14:23:27 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e21-v6sm3416622qtc.67.2018.07.27.14.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 14:23:27 -0700 (PDT)
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
Subject: [PATCH v2 2/7] net: phy: Fix the register offsets in Broadcom iProc mdio mux driver
Date:   Fri, 27 Jul 2018 14:23:28 -0700
Message-Id: <1532726613-6483-3-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the register offsets in the Broadcom iProc mdio mux to start
from the top of the register address space.

Earlier, the base address pointed to the end of the block's register
space. The base address will now point to the start of the mdio's
address space. The offsets have been fixed to match this.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 0831b71..48bb74a 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -22,7 +22,7 @@
 #include <linux/mdio-mux.h>
 #include <linux/delay.h>
 
-#define MDIO_PARAM_OFFSET		0x00
+#define MDIO_PARAM_OFFSET		0x23c
 #define MDIO_PARAM_MIIM_CYCLE		29
 #define MDIO_PARAM_INTERNAL_SEL		25
 #define MDIO_PARAM_BUS_ID		22
@@ -30,20 +30,22 @@
 #define MDIO_PARAM_PHY_ID		16
 #define MDIO_PARAM_PHY_DATA		0
 
-#define MDIO_READ_OFFSET		0x04
+#define MDIO_READ_OFFSET		0x240
 #define MDIO_READ_DATA_MASK		0xffff
-#define MDIO_ADDR_OFFSET		0x08
+#define MDIO_ADDR_OFFSET		0x244
 
-#define MDIO_CTRL_OFFSET		0x0C
+#define MDIO_CTRL_OFFSET		0x248
 #define MDIO_CTRL_WRITE_OP		0x1
 #define MDIO_CTRL_READ_OP		0x2
 
-#define MDIO_STAT_OFFSET		0x10
+#define MDIO_STAT_OFFSET		0x24c
 #define MDIO_STAT_DONE			1
 
 #define BUS_MAX_ADDR			32
 #define EXT_BUS_START_ADDR		16
 
+#define MDIO_REG_ADDR_SPACE_SIZE	0x250
+
 struct iproc_mdiomux_desc {
 	void *mux_handle;
 	void __iomem *base;
@@ -169,6 +171,14 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 	md->dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res->start & 0xfff) {
+		/* For backward compatibility in case the
+		 * base address is specified with an offset.
+		 */
+		dev_info(&pdev->dev, "fix base address in dt-blob\n");
+		res->start &= ~0xfff;
+		res->end = res->start + MDIO_REG_ADDR_SPACE_SIZE - 1;
+	}
 	md->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(md->base)) {
 		dev_err(&pdev->dev, "failed to ioremap register\n");
-- 
1.9.1

