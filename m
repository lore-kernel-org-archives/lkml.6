Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE129C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CE622438
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQSBBjXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CE622438
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeHJSxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:53:16 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42027 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHJSxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:53:16 -0400
Received: by mail-qk0-f195.google.com with SMTP id 13-v6so6720679qkl.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rinWVqwjcaL2eWnw/SuA6pRyxlzoVvJGfgLJWDsamaE=;
        b=gQSBBjXRLOdlqhaVDCgGaS4CA2Z4vZT9Cj2PPzKJEBWcBxBiuLcROyL6hDcHZdvIjE
         04T99aL04HxbRFilphx7ENZoSFLEFl03fbhmia0FnVtrNgDRVYn3WEObQcUFmDmkBSK+
         NLsvW+mTr9ugQVzN9mUBBrI7p23w3hzNPNVrwmZ62LrWdE9TGvmU4tUV5ZjJLEzIHVt6
         Y/0eReKEF6kK8On9TRVEFYIQg+eEwx3+1oWYIovjNccngqkuKYVhUa84V4/okEZop8ou
         pA3SDjRv/GfTkFPk/axbjqztRiMSeXMN+FO9Zz/ejpGEdVJpJJPa7h6peLScio30hA/+
         e/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rinWVqwjcaL2eWnw/SuA6pRyxlzoVvJGfgLJWDsamaE=;
        b=kGD8M+ZloBeBKMB4YqhSMHxtWpu9L0N6So4JE7wFQLmo5U6ZM7/fDAeXhxSmyFmedR
         z9okijzAUCZCLU8lK7AkGCDLlX41AvE/xCkDHYiEc3ssnhwhSIG/zsfpAh03IcecnKp/
         ElmVcftCvV+RfeB5GtD6+wOtF2ygl/3nWR9VtIYDMKCiOq0j/OZc1We8pFwMBIJim5Wx
         hzGQFN0BvtnZIA1MlDQlVIxgT1M9vG7ewrvRuJRoLA4YfDwDEQLlRy3pX5QJ6EBVmLjN
         rL3/gSBKP0diTuZlxsh94c81vJ3T4B0vQ2tImfet22FZlFHgSKf+CQxO6svs60eYh1dI
         VfJA==
X-Gm-Message-State: AOUpUlFm1XQTX3oVUoWIbLXR6ZaR4yexzfZ+vyC10z1HrXbSJgxYAAr2
        qza2BbQ/r3xrMtNhREMlUw==
X-Google-Smtp-Source: AA+uWPzZM5zVC7GYHPelsUtqJygO5Vwuzw9sVd6e1DXicbgt10DJl9fFRy6OCNtdRmCQcLjHkPin4g==
X-Received: by 2002:a37:2118:: with SMTP id h24-v6mr6395239qkh.263.1533918164196;
        Fri, 10 Aug 2018 09:22:44 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c138-v6sm5375962qkg.79.2018.08.10.09.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:22:43 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH 1/2] x86/mm: Add an option to change the padding used for the physical memory mapping.
Date:   Fri, 10 Aug 2018 12:21:37 -0400
Message-Id: <20180810162138.12597-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

There are some exceptional cases that the padding used for the physical
memory mapping section is not enough.

For example of the cases:
- As Baoquan reported in the following, SGI UV system.
  https://lkml.org/lkml/2017/9/7/87
- Each node of physical memory layout has huge space for hotplug.
  For exapmle of the layout:
    SRAT: Node 6 PXM 4 [mem 0x100000000000-0x13ffffffffff] hotplug
    SRAT: Node 7 PXM 5 [mem 0x140000000000-0x17ffffffffff] hotplug
    SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
    SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug

We can increase the padding by CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
however, the available entropy is decreased if the padding is increased.
So the config change is not very good for the other most of systems.
And, the needed padding size depends on the system environment, for
example physical memory layout, so the kernel option is better than
changing the config.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 arch/x86/mm/kaslr.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 61db77b..8c7b4f6 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -33,6 +33,9 @@
 
 #define TB_SHIFT 40
 
+#define MAX_PADDING_L4 63
+#define MAX_PADDING_L5 32767
+
 /*
  * The end address could depend on more configuration options to make the
  * highest amount of space for randomization available, but that's too hard
@@ -40,6 +43,7 @@
  */
 static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
 
+static int __initdata rand_mem_physical_padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
 /*
  * Memory regions randomized by KASLR (except modules that use a separate logic
  * earlier during boot). The list is ordered based on virtual addresses. This
@@ -69,6 +73,20 @@ static inline bool kaslr_memory_enabled(void)
 	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
 }
 
+static int __init rand_mem_physical_padding_setup(char *str)
+{
+	int max_padding = pgtable_l5_enabled() ? MAX_PADDING_L5 : MAX_PADDING_L4;
+
+	get_option(&str, &rand_mem_physical_padding);
+	if (rand_mem_physical_padding < 0)
+		rand_mem_physical_padding = 0;
+	else if (rand_mem_physical_padding > max_padding)
+		rand_mem_physical_padding = max_padding;
+
+	return 0;
+}
+early_param("rand_mem_physical_padding", rand_mem_physical_padding_setup);
+
 /* Initialize base and padding for each memory region randomized with KASLR */
 void __init kernel_randomize_memory(void)
 {
@@ -102,7 +120,7 @@ void __init kernel_randomize_memory(void)
 	 */
 	BUG_ON(kaslr_regions[0].base != &page_offset_base);
 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
-		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+		rand_mem_physical_padding;
 
 	/* Adapt phyiscal memory region size based on available memory */
 	if (memory_tb < kaslr_regions[0].size_tb)
-- 
2.18.0

