Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F64BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4331D205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4331D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeH2XES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:04:18 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39845 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeH2XES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:04:18 -0400
Received: by mail-oi0-f68.google.com with SMTP id c190-v6so11083326oig.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 12:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zEveqf8BwEa1CUsTPvCJk1PmvPcUpOVrjiiX5mHBSEY=;
        b=ajRrV2wvTvdnEnEOl46TcxtaUcYEIIEZDdxYTMchaezw9N4gSBT40w8PfgKUQBx/Hb
         o0MedFUJC3mSdJam4tsbTGKF68njm9lpUKjgeg1YsQnc9Dz3kfEXK28eU7pwWFMQcIaV
         z1EjOcHmMIyplJ2PQCxuJMox7IwZZ9H9esIT9RrUE045R9ftMl5lEsSSbyKY94ThwHtY
         r9Vg7rZSyT4VZljGOaw4gb2HQzbrFtkavErQ2fOqtnBIrBHoLI5XtK9vEkkjLy1UFMUf
         mNs2ZPQXJO+76gQTY57ZWGabciFu5w/owoI9erfZQVePvUwU7/FnjVdkp6C7Sc8T42AO
         2gEQ==
X-Gm-Message-State: APzg51DN5hNHxSs06RA+wEyiN78Yovtv6cBQVHEC1OZPZLF6cqAMGwWL
        9pSMP81B37kLu5IA2tuURbxQoI4=
X-Google-Smtp-Source: ANB0VdbqCVbYQ+UY4LIU9Z5NQ8ZCjx4Z6MhXsxCY4iyg+TC+L30muf0JlivvTtP5EJHpPin1GMKX3Q==
X-Received: by 2002:aca:44c5:: with SMTP id r188-v6mr4269632oia.280.1535569562233;
        Wed, 29 Aug 2018 12:06:02 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s133-v6sm6011840oie.4.2018.08.29.12.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 12:06:01 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] mtd: Convert to using %pOFn instead of device_node.name
Date:   Wed, 29 Aug 2018 14:06:00 -0500
Message-Id: <20180829190600.25529-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-mtd@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
One more %pOFn conversion for MTD. Please apply to MTD tree.

 drivers/mtd/devices/powernv_flash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index 33593122e49b..22f753e555ac 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -212,7 +212,7 @@ static int powernv_flash_set_driver_info(struct device *dev,
 	 * Going to have to check what details I need to set and how to
 	 * get them
 	 */
-	mtd->name = of_get_property(dev->of_node, "name", NULL);
+	mtd->name = devm_kasprintf(dev, GFP_KERNEL, "%pOFn", dev->of_node);
 	mtd->type = MTD_NORFLASH;
 	mtd->flags = MTD_WRITEABLE;
 	mtd->size = size;
-- 
2.17.1

