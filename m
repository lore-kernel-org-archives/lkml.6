Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFE4C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB5A20883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b+mTB1+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB5A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbeGZTyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:54:33 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33644 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731513AbeGZTyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:54:32 -0400
Received: by mail-qt0-f194.google.com with SMTP id c15-v6so2586935qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 11:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qhMmO3t4z8ApHkpA1UI4UHn9wqbdJDZKJChQ0iIzYhg=;
        b=b+mTB1+Id4OXIMjtmmUo17TKsBC2RBtwe9HD+nkGGBoOdfLtMG6WsqPh3GW4+dq4Lu
         eBBr1HRVaR49WZYoeu9oKeTGwgZ3PPPVAfSKdmNjAGWMDjZOo0dTuUKi0KLeFO0pcE3H
         lEXjSZgDbiaNg19Ot6nrNhcIfrj1uL6ChOv6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qhMmO3t4z8ApHkpA1UI4UHn9wqbdJDZKJChQ0iIzYhg=;
        b=UNijuUKqxKJAzxDGgbcRrlkCht27jJ28vwLTXWALvqjSPLH3XBbIcMFgeyah7MMM0Y
         v0a5JJ6tGYGJ07lhBpVqlw1zb3PMm+vyNTt7THL04Pbd4xG3X/H71Q+mOuLh5Dzh09QL
         IoHhWF2h+7s5lE6Y5t9mw9AGyMDi0xzKnC2/CYg89MDI6DYek1CSmjRmrYdw++0H2qMw
         bFGHq1cPDk107bV9amhNVzdHLGV/aBY6mHHuskk/b2DGwnfDHOPrL7wSClcHahjWsysg
         HOJJ1aiuGT/gnDxntMG3gntlEh1axveKtkSVeRuFSMHxplFyN2hsJlluRg+jgTlrHbQE
         wPHg==
X-Gm-Message-State: AOUpUlFg+wx3Bo4B2wXBF446SCY/B0dNWuCvB7v2gz7UbLv8Nwh/HfZE
        9iyegXm6qpVkHhRRa4iHOW87PQ==
X-Google-Smtp-Source: AAOMgpfLrc9XDZPDp9DKjov4e+e0M45XKV1xMv9ZdN+pWcU6zvOpg5dzXuwvPCmXm6jSlIY7ILypYA==
X-Received: by 2002:aed:2207:: with SMTP id n7-v6mr3046886qtc.302.1532630188715;
        Thu, 26 Jul 2018 11:36:28 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a187-v6sm1383359qkd.47.2018.07.26.11.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 11:36:28 -0700 (PDT)
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
Subject: [PATCH 2/7] net: phy: Fix the register offsets in Broadcom iProc mdio mux driver
Date:   Thu, 26 Jul 2018 11:36:19 -0700
Message-Id: <1532630184-29450-3-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the register offsets in the Broadcom iProc mdio mux to start
from the top of the register address space.

Earlier the base address specified was from the middle of the block's
register space. The base address will now point to the start of the
mdio's address space. The offsets have been fixed to match this.

Fixes: 98bc865a1ec8 ("net: mdio-mux: Add MDIO mux driver for iProc SoCs")
Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 0831b71..dc65e95 100644
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
@@ -30,15 +30,15 @@
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
-- 
1.9.1

