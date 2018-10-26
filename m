Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0194ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E8820856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blN82QXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E8820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeJ0HTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:19:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36494 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJ0HTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:19:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id l81-v6so1217367pfg.3;
        Fri, 26 Oct 2018 15:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ajLeZHbXlraLlHu/vc18f241KhI3uvW5mJ0MvkSXLxU=;
        b=blN82QXNjSo0G+D078OWEQnw+uf/ibJjIbW5pVeKIESpOhFGCT/wWDwWOsKqOs1+cT
         rA1LVBwUlaBEpixZ5AH0NTImEfIqhOfNTkWvjlGxNUntz/YChQyS7KwnPZGEYsDbMLmp
         F8EcjLRpVnqB6o2MzccIdTHMTJEU0IxPqZO3igQkJGjJXinS+YEFaebC3eJkSefDPrPh
         SByr34Ft0AabUVVPhcgqyKYycQ9nPaTlvXC86ZAG9oun/l/b1Riu88Wre0MgDnVrSPoz
         VxU+VUKcLhx4bwaFXZ5gA2xW0kQqvLetvtYQgZ39/TzgFkSEO6IsJvgxDzRKi45Aqu8l
         rN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ajLeZHbXlraLlHu/vc18f241KhI3uvW5mJ0MvkSXLxU=;
        b=ByoybrhTmnivPRcncz/xBzUOjGgb/7Ml5VWvYpGkBO35cVkvzoYraKYkPNbB71LXKK
         uhk1TwVafkLA1E8Hq3Vl/yx1NbdeC8QxZbFQZ4ECSyWmSFvQB1a5KsFCMVg/wGoe22V0
         4YyJX5QcLBs1HML/+0ZgDip3Xl+abCR95e1WW/G42Blrv714I+6s/JdO9MMh/6Iznuhd
         2zmpKzdyxHKrSBQD0L8Ie6h+07AtX4GtDVl3wDwrvD0C+c5JjcCH864iiNLAGN18pRns
         q5A2YCyj9t8O6Z7RQyGsz08DDEqUTiFDgde7YxaPnyCDxMkZy7KPmIsEUCLg2KiLhydL
         6SeQ==
X-Gm-Message-State: AGRZ1gLPIWRP8J9snKlPPdgjdjgFCXV6ljkzxPHEdeIc2H3uod3OvXT1
        /pW0xlpSLUTtqxpek8o+9d9JlBcX
X-Google-Smtp-Source: AJdET5d9FOPg22MaXmTiIwoILCL//VIiMtUqoeckcPvGhb6+EbiQHHquNGbkz8SZflHmRsrCQgJYbg==
X-Received: by 2002:a63:9845:: with SMTP id l5mr5217527pgo.142.1540593617801;
        Fri, 26 Oct 2018 15:40:17 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id t9-v6sm3665536pgl.37.2018.10.26.15.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 15:40:16 -0700 (PDT)
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
        DEVICE TREE), rppt@linux.ibm.com, linux@armlinux.org.uk
Subject: [PATCH v4 1/2] arm64: Get rid of __early_init_dt_declare_initrd()
Date:   Fri, 26 Oct 2018 15:39:50 -0700
Message-Id: <20181026223951.30936-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181026223951.30936-1-f.fainelli@gmail.com>
References: <20181026223951.30936-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64 is the only architecture that re-defines
__early_init_dt_declare_initrd() in order for that function to populate
initrd_start/initrd_end with physical addresses instead of virtual
addresses. Instead of having an override, just get rid of that
implementation and perform the virtual to physical conversion of these
addresses in arm64_memblock_init() where relevant.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/memory.h |  8 --------
 arch/arm64/mm/init.c            | 26 ++++++++++++++++----------
 2 files changed, 16 insertions(+), 18 deletions(-)

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
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 3cf87341859f..98ff0f7a0f7a 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -364,6 +364,9 @@ static void __init fdt_enforce_memory_region(void)
 void __init arm64_memblock_init(void)
 {
 	const s64 linear_region_size = -(s64)PAGE_OFFSET;
+	unsigned long __maybe_unused phys_initrd_size;
+	u64 __maybe_unused phys_initrd_start;
+	u64 __maybe_unused base, size;
 
 	/* Handle linux,usable-memory-range property */
 	fdt_enforce_memory_region();
@@ -414,8 +417,11 @@ void __init arm64_memblock_init(void)
 		 * initrd to become inaccessible via the linear mapping.
 		 * Otherwise, this is a no-op
 		 */
-		u64 base = initrd_start & PAGE_MASK;
-		u64 size = PAGE_ALIGN(initrd_end) - base;
+		phys_initrd_start = __pa(initrd_start);
+		phys_initrd_size = __pa(initrd_end) - phys_initrd_start;
+
+		base = phys_initrd_start & PAGE_MASK;
+		size = PAGE_ALIGN(phys_initrd_size);
 
 		/*
 		 * We can only add back the initrd memory if we don't end up
@@ -459,15 +465,15 @@ void __init arm64_memblock_init(void)
 	 * pagetables with memblock.
 	 */
 	memblock_reserve(__pa_symbol(_text), _end - _text);
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		memblock_reserve(initrd_start, initrd_end - initrd_start);
-
-		/* the generic initrd code expects virtual addresses */
-		initrd_start = __phys_to_virt(initrd_start);
-		initrd_end = __phys_to_virt(initrd_end);
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
+		memblock_reserve(phys_initrd_start, phys_initrd_size);
+		/*
+		 * initrd_below_start_ok can be changed by
+		 * __early_init_dt_declare_initrd(), set it back to what
+		 * we want here.
+		 */
+		initrd_below_start_ok = 0;
 	}
-#endif
 
 	early_init_fdt_scan_reserved_mem();
 
-- 
2.17.1

