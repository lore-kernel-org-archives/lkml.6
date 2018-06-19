Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60696C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174C820661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174C820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967361AbeFSVr1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:47:27 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43771 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967294AbeFSVrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:47:19 -0400
Received: by mail-yw0-f195.google.com with SMTP id r19-v6so441973ywc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8RXql62/dQvZpkpAbxhcxM+PugjdkCOIwRwB4Nmmg1k=;
        b=NC3yEbjMJB2p4qlK/Cq2PvVJJ5uv2xpriy+LxF7Em2Mh6KTiz7xbOru/V7WpP3BmeN
         HG2Cl75b4MnbTgqlriVWSzICcA41fhhmx4QoHtGz6EZAepbe7cfw0AlwXjfJ9GjJzMFl
         uobs+b1+TmiWgZ8H4ZZOS2yjSuZnR0g6iUKN58ltO8KzwIsKWuud0jBy665AjWOOf+Kr
         mb9/Ewy2ZsbybveVK+eOsHuPTrKdRTD7gbz3JrzSvC8ama/nbIqyclePLUTh+uP/V9rU
         fxJ5SNM0dPJ3ybcN45YkOUvHBN0TJF6hyoK7wydwgTw1ovoid2gnzONtnD4rIGzOjUnH
         LuRg==
X-Gm-Message-State: APt69E0r2JW6xzFBv74SuOfsRE0vN1PlTbGUGGHMnVKU65U5INhiVj+U
        +oi4Ked4l1cx5YC9l8q/xw==
X-Google-Smtp-Source: ADUXVKJZiJ6h2fYXypqCdEj79PpwEojYfikwuP4+wenuiCzgT5xRq77x3ANdUD+ZlWapubFLbvPiTw==
X-Received: by 2002:a81:ad44:: with SMTP id l4-v6mr9285131ywk.68.1529444838893;
        Tue, 19 Jun 2018 14:47:18 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id x66-v6sm333612ywc.76.2018.06.19.14.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:47:18 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 4/5] MIPS: generic: remove unnecessary of_platform_populate call
Date:   Tue, 19 Jun 2018 15:47:09 -0600
Message-Id: <20180619214710.22066-5-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619214710.22066-1-robh@kernel.org>
References: <20180619214710.22066-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT core will call of_platform_populate, so it is not necessary for
arch specific code to call it unless there are custom match entries,
auxdata or parent device. Neither of those apply here, so remove the call.

Cc: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/generic/init.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index 5ba6fcc26fa7..07ec08462d70 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/irqchip.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 
 #include <asm/bootinfo.h>
 #include <asm/fw/fw.h>
@@ -208,18 +207,6 @@ void __init arch_init_irq(void)
 	irqchip_init();
 }
 
-static int __init publish_devices(void)
-{
-	if (!of_have_populated_dt())
-		panic("Device-tree not present");
-
-	if (of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL))
-		panic("Failed to populate DT");
-
-	return 0;
-}
-arch_initcall(publish_devices);
-
 void __init prom_free_prom_memory(void)
 {
 }
-- 
2.17.1

