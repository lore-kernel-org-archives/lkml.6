Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6F7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154D1208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154D1208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeH1FoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:17 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33484 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeH1FoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:15 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so52713oip.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wPIunOIYyix8Z5l2mPd0qgkLBqpPQfTEbmG6JutqlK0=;
        b=V8dGifi0z8Qg8vDikQoS7n9TwbXuNeakz973UPkBf5hlQNKeuVk23y8XeXs7u1jPbo
         ydNmJcRS2r4x8CmhLHeExdn/agmPJOX0Y0sy6Yml937FaVQwnURl5x9DFwl/EkVczgWK
         ef0qLYvrJBYUXmnppo0jZ3mRRKTivkwwQTSjMicIZRo0YqMeWFCLU6oxJC4TJUckjkbH
         DGgeyNi6OOfIlnfYCY7ckL1idK7IvIDgNevBYUSDS/MAOFzSnAtPOlKaZU2vh6KnepBc
         rxsMGhB4VDJegwiMAW+nbkM4lX8o1/KJQCUaSM8kPHZCfke/2HQIyC0QqbRsN8T+79HG
         9oPQ==
X-Gm-Message-State: APzg51DNFuXtu/Ax3unZqJapzntZsRmXsk7IJLdJSSEom/1TQNVI3Q+S
        cqsNVpK5G1WVEn4YknFqOj4EElY=
X-Google-Smtp-Source: ANB0VdbNnKqkBtGxWAlqAKLxI6Kh47cDa883NU4GGxqUc/HIPoI62IlGPgh3akhN7svGv44b3QRDyg==
X-Received: by 2002:aca:e2d3:: with SMTP id z202-v6mr957021oig.121.1535421299921;
        Mon, 27 Aug 2018 18:54:59 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:54:59 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: rawnand: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:34 -0500
Message-Id: <20180828015252.28511-33-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mtd/nand/raw/fsl_upm.c | 4 ++--
 drivers/mtd/nand/raw/ndfc.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index a88e2cf66e0f..ca82727eca94 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -184,8 +184,8 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
 		return -ENODEV;
 
 	nand_set_flash_node(&fun->chip, flash_np);
-	mtd->name = kasprintf(GFP_KERNEL, "0x%llx.%s", (u64)io_res->start,
-			      flash_np->name);
+	mtd->name = kasprintf(GFP_KERNEL, "0x%llx.%pOFn", (u64)io_res->start,
+			      flash_np);
 	if (!mtd->name) {
 		ret = -ENOMEM;
 		goto err;
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index 540fa1a0ea24..b193f373f235 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -174,8 +174,8 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 		return -ENODEV;
 	nand_set_flash_node(chip, flash_np);
 
-	mtd->name = kasprintf(GFP_KERNEL, "%s.%s", dev_name(&ndfc->ofdev->dev),
-			      flash_np->name);
+	mtd->name = kasprintf(GFP_KERNEL, "%s.%pOFn", dev_name(&ndfc->ofdev->dev),
+			      flash_np);
 	if (!mtd->name) {
 		ret = -ENOMEM;
 		goto err;
-- 
2.17.1

