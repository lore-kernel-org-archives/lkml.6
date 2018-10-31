Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47641C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087352080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSq5yexA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087352080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbeKAE2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:28:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43320 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbeKAE2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:28:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id g59-v6so3749680plb.10;
        Wed, 31 Oct 2018 12:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rTVZhghR1gxb15QVkw14B49JVfrcKlPIwzmIf6W2ysc=;
        b=WSq5yexAx0eBb4UQ4yKmF9SzyZevUYMsBeeoVXiWiFIoRnyVzWlgbtsB0MHQ9LAzRQ
         5x9Byv7ewitQN28uZlzGxh9Dut4KuhRtAC6hk3RfFVyjyUMkH5bf4boTjoO+kyQbmaVL
         GfejcvexUnua1b4T/spECN8FErCUEslSP8IkFR8BH4zPat8SPy3BfMxcPmNNDgle6FFE
         LQb5VSTzg7HAgKV1MavnSb4Itt6Qj8owr1ILe70zbTQ7GW47s8dcgxlG6LZWFAp2d8Rb
         LhowptkZEOBrd3HkDbzz4a4PUw0+UTFumwBF7jddBhgO49chctjjrTzUy+BAMc+lWlTt
         AE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rTVZhghR1gxb15QVkw14B49JVfrcKlPIwzmIf6W2ysc=;
        b=SeCO0LrwtwGNtjZwMhc8D/nL8VS2dZ71033RwwmICSeWxTCiMhvgA0nOpiD4gUq/KH
         flBk4/Bpy4yyBncHG0uKTCQmAZTNTT2wBUvP6FUEw2fA+6N4BolBUXzCb+vCwsACujm+
         2x0y7Qfn9tv0hSYIqr/qTla0AQof/Zoj+HrQDShAPnvMBZPQyI9PExLsGFZZAPofs5FW
         mJEGDfGJxGv5TJwUlAeL6NXWDyvcnEaKmajXsh9WFz7GZXPZVntZssU8W9vd3g33t+fS
         eRS21KjouW8eorHEu1ykk5glYL9WIVbVoR06PcNhkt9V5G7fGSXjoumtbIlRraA/fWzg
         uBqw==
X-Gm-Message-State: AGRZ1gIMUcHHBvLwmXM8ouYdM9bon4JMThiCOOOuWUoe4G+sJrRMKxIj
        tSRTqRgN5txjYfHxqlF9TTDIsXvr
X-Google-Smtp-Source: AJdET5daDSQCBMa+OjcVRxtbuc863y8/PiXtLjcpg35yDdF2Ym5vyGrBdl/MR3b+yuGzq4Y7OLMuEQ==
X-Received: by 2002:a17:902:8306:: with SMTP id bd6-v6mr4661149plb.321.1541014159363;
        Wed, 31 Oct 2018 12:29:19 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z26-v6sm28926456pfh.77.2018.10.31.12.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 12:29:18 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), rppt@linux.ibm.com, linux@armlinux.org.uk,
        green.hu@gmail.com, deanbo422@gmail.com, gxt@pku.edu.cn,
        ard.biesheuvel@linaro.org, linux-snps-arc@lists.infradead.org,
        vgupta@synopsys.com
Subject: [PATCH v3 5/6] of/fdt: Remove custom __early_init_dt_declare_initrd() implementation
Date:   Wed, 31 Oct 2018 12:28:42 -0700
Message-Id: <20181031192843.13230-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031192843.13230-1-f.fainelli@gmail.com>
References: <20181031192843.13230-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ARM64 uses phys_initrd_start/phys_initrd_size, we can get rid
of its custom __early_init_dt_declare_initrd() which causes a fair
amount of objects rebuild when changing CONFIG_BLK_DEV_INITRD. In order
to make sure ARM64 does not produce a BUG() when VM debugging is turned
on though, we must avoid early calls to __va() which is what
__early_init_dt_declare_initrd() does and wrap this around to avoid
running that code on ARM64.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/memory.h |  8 --------
 drivers/of/fdt.c                | 15 ++++++++++-----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..dc3ca21ba240 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -168,14 +168,6 @@
 #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-#define __early_init_dt_declare_initrd(__start, __end)			\
-	do {								\
-		initrd_start = (__start);				\
-		initrd_end = (__end);					\
-	} while (0)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index e34cb49231b5..4118a344cf45 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -892,15 +892,20 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-#ifndef __early_init_dt_declare_initrd
 static void __early_init_dt_declare_initrd(unsigned long start,
 					   unsigned long end)
 {
-	initrd_start = (unsigned long)__va(start);
-	initrd_end = (unsigned long)__va(end);
-	initrd_below_start_ok = 1;
+	/* ARM64 would cause a BUG to occur here when CONFIG_DEBUG_VM is
+	 * enabled since __va() is called too early. ARM64 does make use
+	 * of phys_initrd_start/phys_initrd_size so we can skip this
+	 * conversion.
+	 */
+	if (!IS_ENABLED(CONFIG_ARM64)) {
+		initrd_start = (unsigned long)__va(start);
+		initrd_end = (unsigned long)__va(end);
+		initrd_below_start_ok = 1;
+	}
 }
-#endif
 
 /**
  * early_init_dt_check_for_initrd - Decode initrd location from flat tree
-- 
2.17.1

