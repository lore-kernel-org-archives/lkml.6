Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3700FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D79E21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU4klzIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D79E21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbeIUBCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:02:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47023 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387773AbeIUBCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:02:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so4861130pga.13;
        Thu, 20 Sep 2018 12:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0uRAIVcdH8toYzrgLq2G7JJQGoFy2AMVSmgM/5AWEMU=;
        b=EU4klzIMUUF4WlJdwAVePjMxPMucGmebKd8Y8/8rNhc5+frIfAL4GO1/Xdj2ufM7NW
         nL4plllUyWRK3ygiFyOLoO4TKdaIcWkj7xh7TGXSGEaXuqnns7a1SWAMfKJ7V97L9Rr9
         NTJXBjGCjqq8q0RsfFVjF97Ii9Wn14vWg5W0J4bn7gAel5sEzuzGZQ6ypReM3v/fofTZ
         FeGSFT34a5eJHsdNhBmSALey0OKrJIZYg4h1mITohd1iy1Kcd5A95Y/5Mt/8sKohWi9U
         WFPA+mvTzcmMi2EZHKIejOaVZdTd/eY5tN/Q9mMsiMNKOxv1cO4Er1KB9MBkydi3yK9K
         MDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0uRAIVcdH8toYzrgLq2G7JJQGoFy2AMVSmgM/5AWEMU=;
        b=jxJgb5IoGqql00VRrVeTH/mMAjhE+xSAfsM1oBt8/j9lps8Nq/AL3KZcymfJu/Y7Jk
         hUSSEnXuj13xM1KNCc7FYE60ggTBOra6C0rZYWPmSm23d0H1n8MVV6rOqsbimdQ8bKcJ
         ZaletMb5O2qhL8XrQrswrYUbOysFb/izpY9+I6DIO4ip8TUjWZ1sXccNYsTZbSLDOcaz
         St91hecnSF9pQ7X3ysWYaIr9tC7TR/GEECWw+x+HmtVDgjPgQWytMikkBXZ41Pm2qlU/
         o5csiH4KjxvJQ7wEIA9bZKyiOADx+3UV90fLIn1KA57JbShs7IhFx1fhZqEBL4/k7Cm+
         bB5A==
X-Gm-Message-State: APzg51D718PGpywGXfc234HaCBxqJa57+RSMUSQ8eikCyX9ul4TTGqe8
        dEhhbBHT9H/dvgzHkGlBMas5n1B8
X-Google-Smtp-Source: ANB0Vda9IDcdMQT0MOYb7orK/aVuXs4zw73oP5S+mRQU9satfBmGa290PveB3SexoZ0G1Nuswe7KlA==
X-Received: by 2002:a62:1016:: with SMTP id y22-v6mr42771479pfi.109.1537471035877;
        Thu, 20 Sep 2018 12:17:15 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n9-v6sm40665601pfg.21.2018.09.20.12.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:17:14 -0700 (PDT)
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
Subject: [PATCH 1/9] dt-bindings: phy: Document BCM63138 compatible string
Date:   Thu, 20 Sep 2018 12:16:35 -0700
Message-Id: <20180920191646.18198-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible string "brcm,bcm63138-sata-phy" as a valid
compatible string describing the standard Broadcom SATA PHY block.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/phy/brcm-sata-phy.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt b/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
index 0aced97d8092..b640845fec67 100644
--- a/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
+++ b/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
@@ -8,6 +8,7 @@ Required properties:
      "brcm,iproc-nsp-sata-phy"
      "brcm,phy-sata3"
      "brcm,iproc-sr-sata-phy"
+     "brcm,bcm63138-sata-phy"
 - address-cells: should be 1
 - size-cells: should be 0
 - reg: register ranges for the PHY PCB interface
-- 
2.17.1

