Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA86ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6392080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8mgd9u4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6392080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbeKAE2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:28:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44866 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbeKAE2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:28:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3-v6so7835566pgs.11;
        Wed, 31 Oct 2018 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YKcUvpr43tRZJEMV+6lqsKVNVBN0qV74G4aF0FLNMqw=;
        b=X8mgd9u48c8usXYJHEMe4maQH5xySeqOruXgnCFMakeW6JyYExEpGgucdn69Z2b6da
         g3HdS/42akZuQM9ldwQWAjgxqYmM766FIXmha2NaSpsNhHPGrHtjN99WaTi5i8c07kSe
         cmn53a/owpyGrFoRlLs4iw0azaOClURfSWoIckpYqZ6pUqFfhwoJPDdQrz7OUy5Pwxtn
         eUqTKxbWo3LY3sy6+XM9oElaTTxdMrEx6azsYfcAFZGWe3eBJD0e5lAy49Fn/MhLmVox
         WR62Qy+7t6cI413Ir/Gmye0cPNL6Pp0Czk1OOHubcwJ6ygxY1OrAUZBNV8dxRSDpPoJV
         8MWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YKcUvpr43tRZJEMV+6lqsKVNVBN0qV74G4aF0FLNMqw=;
        b=OjyN1bSOHHiBxoefngAt3VK7uintSc8SgctrHZaZqg4Ve9PbdYRrUeZ/+6Dsz17TvE
         hQtKxGNE7HiJNqfShV3Mx7coOkRTcFtPrK+p6tHZ6L3SDASarztuadaUYMh6kC7pWKms
         i4mDmnf93feb0KFAcA9Iap1sqOoJhXToin1GrHGiNu9lk6sDBQm6odEQdocAqCJoGxnd
         ykjqgSww8iJSjwFCoV2p0v6a9s8ZLsfZ43R5jugdoPrCjozouOcZOzEVLkYSI2Tov12X
         Chs0bRPynP1XizV5Ebar6215kR5Zx6fkpE66RavsmGyxHtBR+AP8gpXt9xMHwjBiMWky
         DxiQ==
X-Gm-Message-State: AGRZ1gLTfIY2Wi1SJh78TWO8dZsnRg/DmT5FOzluXHPRqzLLUHyv+Wmw
        yfiiL3h1GBP4jk3V4TbqE6hz9TMH
X-Google-Smtp-Source: AJdET5fVtBytlMdLBieKeQys+1vFUgwXaUlrBNMuWmcKHBsv4uXYq/LQk5VOmGt1CI8MZb1YxAY30A==
X-Received: by 2002:a63:e818:: with SMTP id s24-v6mr4244256pgh.90.1541014157031;
        Wed, 31 Oct 2018 12:29:17 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z26-v6sm28926456pfh.77.2018.10.31.12.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 12:29:15 -0700 (PDT)
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
Subject: [PATCH v3 4/6] arm64: Utilize phys_initrd_start/phys_initrd_size
Date:   Wed, 31 Oct 2018 12:28:41 -0700
Message-Id: <20181031192843.13230-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031192843.13230-1-f.fainelli@gmail.com>
References: <20181031192843.13230-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64 is the only architecture that re-defines
__early_init_dt_declare_initrd() in order for that function to populate
initrd_start/initrd_end with physical addresses instead of virtual
addresses. Instead of having an override we can leverage
drivers/of/fdt.c populating phys_initrd_start/phys_initrd_size to
populate those variables for us.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/mm/init.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 3cf87341859f..00ef2166bb73 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -72,8 +72,8 @@ static int __init early_initrd(char *p)
 	if (*endp == ',') {
 		size = memparse(endp + 1, NULL);
 
-		initrd_start = start;
-		initrd_end = start + size;
+		phys_initrd_start = start;
+		phys_initrd_size = size;
 	}
 	return 0;
 }
@@ -408,14 +408,14 @@ void __init arm64_memblock_init(void)
 		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
 	}
 
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
 		/*
 		 * Add back the memory we just removed if it results in the
 		 * initrd to become inaccessible via the linear mapping.
 		 * Otherwise, this is a no-op
 		 */
-		u64 base = initrd_start & PAGE_MASK;
-		u64 size = PAGE_ALIGN(initrd_end) - base;
+		u64 base = phys_initrd_start & PAGE_MASK;
+		u64 size = PAGE_ALIGN(phys_initrd_size);
 
 		/*
 		 * We can only add back the initrd memory if we don't end up
@@ -460,12 +460,11 @@ void __init arm64_memblock_init(void)
 	 */
 	memblock_reserve(__pa_symbol(_text), _end - _text);
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		memblock_reserve(initrd_start, initrd_end - initrd_start);
-
+	if (phys_initrd_size) {
 		/* the generic initrd code expects virtual addresses */
-		initrd_start = __phys_to_virt(initrd_start);
-		initrd_end = __phys_to_virt(initrd_end);
+		initrd_start = __phys_to_virt(phys_initrd_start);
+		initrd_end = initrd_start + phys_initrd_size;
+		initrd_below_start_ok = 0;
 	}
 #endif
 
-- 
2.17.1

