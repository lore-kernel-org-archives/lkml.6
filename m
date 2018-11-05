Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7C9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56442085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4ra9uBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56442085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbeKFIUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:20:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38451 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388222AbeKFIUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:20:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id f8-v6so4902344pgq.5;
        Mon, 05 Nov 2018 14:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1qMAVSnywWT1jNzaP9Dz12jcC6XfF9pDAxMfxNaT2nA=;
        b=d4ra9uBPAAmaXzt9tx0OsjsWeY8LJMwuxLCAnpsrGxJq9R67gIIK2Ct6lTD94UTQO2
         qNz1+j2vm+tSCqGB1YXfwA6a63vN8rbIAFU/wp1ZYejV4SNcCFz3F03Ip3vNb5SNAJeK
         xVwOtoez07w6sWdhytcLAlVYXU+W/jhWcGMd0Kw7g4vHsp+NmXtHYxm8CCTCqqbxkT9F
         hMK/E3NbAHDDhKgNR6DKQ6K540B/GCi5E6iX7n8svrjdPZT/ijiGsw2oG7c3BTAD0Gva
         9DEy82/jaK56LGAx19a/gTMgEdTDIAPwmwfOkQF8e6maHuH4qzpLxUwMBQfzdo40gj6/
         8BAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1qMAVSnywWT1jNzaP9Dz12jcC6XfF9pDAxMfxNaT2nA=;
        b=N68+Istr358QhzEcmyj6IzUtMcPN/RjYIjDeK4tCrkibF+agrv37DTd3HOU4wQZUcg
         94chDexpBhvamA2YNtUhOVVneMr/+DWFbDkVIZtSKLFBNfIPj9LJckXDt9bI6F8rkIcn
         EtIrOJr6y4gRWuioZ2coFjqoknD9n1su5dN0r1AX3z2seO3Qw4N7mBxs7yYT77WTUMXb
         RNJXYP0/6iEfinQ/IRFkg3bwWUymNQW6tCdOChDVBhiAArdLiTzOPSL9jmIWaCaygNXp
         yoRMSMqVGrHXe91rbYUHFvLHNbffY76cMF2HALHJZnev3emFrfJ7R++FaQkkPq15WUub
         wYJQ==
X-Gm-Message-State: AGRZ1gI0jBeQWhvyDBaUxaHbjiWEuIdsxRrBGORTfy9UoQRLSICFrBfp
        Jim0xOKT17VAfJNuK7iivYgIHr3v
X-Google-Smtp-Source: AJdET5f5l3Ko7ytbCVM/WoG9Kg+wjAaM+wTpESLwsaPsa32UEj/0tMhbd8R0nYZTufuwdi4E1zRM1g==
X-Received: by 2002:a63:920a:: with SMTP id o10mr6911746pgd.141.1541458685571;
        Mon, 05 Nov 2018 14:58:05 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q195sm12898479pgq.7.2018.11.05.14.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 14:58:04 -0800 (PST)
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
Subject: [PATCH v4 5/6] of/fdt: Remove custom __early_init_dt_declare_initrd() implementation
Date:   Mon,  5 Nov 2018 14:54:30 -0800
Message-Id: <20181105225431.24485-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105225431.24485-1-f.fainelli@gmail.com>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
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
index 88760a0983a7..cd72a41fcab2 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -891,15 +891,20 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
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

