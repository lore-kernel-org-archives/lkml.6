Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9454FECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5326D21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9s6vIdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5326D21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388389AbeIUBCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:02:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39035 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388353AbeIUBCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:02:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so4791032plp.6;
        Thu, 20 Sep 2018 12:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cd3q5/Kewn+hTh4W6f3AEry026X+iQnpvdBvEnZ6ivs=;
        b=f9s6vIduHIafl/mFN0dEBP/UVsboVxrEzIOReZWKGX3sjtacRiLoqP+WrOGx9S4qhx
         sffkqpZAcBxC9QGicPuHTSNYxOMffX5yRZT5LzXiqZuCznXX82UgF0VX+qbxzdJzZ10r
         OeBQk16GpB4HZyTU+ZGMkpS/xtc6WgzcUw312SsiIS7C6DwtbCM0hociGsRH906p79ne
         7ItiMtzE/ljgnBdsYU0+ZoyWIY0PtMSRoYs/dRkjWVJKhkVqytFim2AQbkbixpanaGSS
         +NrRVmNfOciZu7CRf02rsw2oKblC84nsJZxEaMa5olkBrbWMiczuCO7kdR6HtNl45I5a
         ErUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cd3q5/Kewn+hTh4W6f3AEry026X+iQnpvdBvEnZ6ivs=;
        b=tcmrhT4/Q+/OJbE8ina7Ak5RDzhAFtBCtUtIa98G4a5r7D575AaImJilN3qMuYhmYw
         zmPZyNdK6cZbo+EBwxGZUV6OjnXiD0Ob0rtd+iPYSQf9Pb+kaDZd9xKh/LUlf/S26UH4
         sBLy+sJM0Lgk6haWXG0J+EO0TuxV53r1Dm4AKKm7o8FtpwGtDdcX1A5HKyALjsF7+KfM
         vEzhoj2e1mxD4aIWCz7ffjGBbPb5106tMA+cCIi1P6fT2rFokW/B8v7bjVw+qAk5DDN2
         JdJ9vfwYO/uaap3rrD8aZmzhC3XttniXdlHQriQGTh1XKjLnfQXdCXApYITbWQO9fUDK
         9WYQ==
X-Gm-Message-State: APzg51CxbBcDBLjVhBEyxPWV3CnmAO613nnBEzVn+kVK5nhufBPuYG2u
        V5SH5rc6vKZ11ig/ab4m84lHD0ca
X-Google-Smtp-Source: ANB0VdbgGpVBEQ80A1Az3JnCbOv/5YAh8IJCNwgWj0gfdbmkw+FabNbVg7xNgfIST9AnvsG9iZleiQ==
X-Received: by 2002:a17:902:7102:: with SMTP id a2-v6mr40795561pll.217.1537471037853;
        Thu, 20 Sep 2018 12:17:17 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n9-v6sm40665601pfg.21.2018.09.20.12.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:17:16 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 2/9] phy: brcm-sata: allow PHY_BRCM_SATA driver to be built for DSL SoCs
Date:   Thu, 20 Sep 2018 12:16:36 -0700
Message-Id: <20180920191646.18198-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broadcom ARM-based DSL SoCs (BCM63xx product line) have the same
Broadcom SATA PHY that other SoCs are using, make it possible to select
that driver on these platforms.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/phy/broadcom/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
index 8786a9674471..aa917a61071d 100644
--- a/drivers/phy/broadcom/Kconfig
+++ b/drivers/phy/broadcom/Kconfig
@@ -60,7 +60,8 @@ config PHY_NS2_USB_DRD
 
 config PHY_BRCM_SATA
 	tristate "Broadcom SATA PHY driver"
-	depends on ARCH_BRCMSTB || ARCH_BCM_IPROC || BMIPS_GENERIC || COMPILE_TEST
+	depends on ARCH_BRCMSTB || ARCH_BCM_IPROC || BMIPS_GENERIC || \
+		   ARCH_BCM_63XX || COMPILE_TEST
 	depends on OF
 	select GENERIC_PHY
 	default ARCH_BCM_IPROC
-- 
2.17.1

