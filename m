Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C85C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC60217DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRsxTdRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC60217DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeHVApH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:45:07 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42483 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHVApG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:45:06 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so22024206qto.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 14:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AtNcVsaR+inm710vQ2eUe5HIwdoCQdPpohPpPaLKF/c=;
        b=eRsxTdRu0n4HbB8yuy7aBE8d00H63l4wiQ0RcB7Lv4b+4aajbRmkknOK9WNJzfN6Lk
         ZjHGKCh1sU1pmUPImVM8MzgGmEMdbKiU76nYDUpZ2ZnkkdKh56FKfAjcoZFdw0/hbKCz
         47YOkGcHC46GdiPMaGT2W6MDoyuY3Mm+/mjTzuO71pnHmefqDiq08KPHwPiepg/A4s67
         5SKT+Ytf1OCwtay+9YhoLc5o1wEUCUWsOuvtQxvOmFkEkdRaM75VgOEFCCgAtkN3rzpj
         op5pBwCs9nx4H6E0r3+XjnpoYELkRKoBn3CxvLVgmgn4YK4MGB8mAIwcDY14bvC4Rw5f
         Ps8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AtNcVsaR+inm710vQ2eUe5HIwdoCQdPpohPpPaLKF/c=;
        b=UHDYteNz4J6Vy7uDuiZzlGEmPd9gdCNyDaIQ8c8uvjWZHnqXds6C8ExJay6vLrOold
         Rl4eJ1uv49NeAtDG7DNM22g0bZFuit7JXmts1LoDCPmsEEKcU3buJZ0Knr3btYXVC8NA
         t0BZLtmOzH2UiyfeHVBhJLqboUJLI2dDaxc88lqhaqKB3pd9S7jOA+xT8FDSB5Kv9iEn
         9dfUha8/cDnBU5Y78U8R7MZbvFTq0ehsWHbJ7nyOrzjZheDgc6E176G42BQ2xsLQhw8J
         eIc1nKxu+Yh4e3hUy3op74K8doSvn7N+PJpST0UkgFSXGWIVbQk22wUPqvLe31c9GN7Z
         xGsA==
X-Gm-Message-State: AOUpUlF8tc1a21ifVYs3WTKrD+1Fi0d6dPXvXvJ1G3t/52jU2LnndDEE
        m4ojVUcNCMHbh7AyhWjf3A==
X-Google-Smtp-Source: AA+uWPy5il42CzfXhulZDUlUh4EddU7BUIJPtfWs6Hi5fI/7ELQVtuMSWQnd2/t1W/DmSuNIk0JoNw==
X-Received: by 2002:ac8:3a05:: with SMTP id w5-v6mr12180653qte.142.1534886596819;
        Tue, 21 Aug 2018 14:23:16 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q6-v6sm2148525qtq.44.2018.08.21.14.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 14:23:16 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] x86/mm: Add an option to change the padding used for the physical memory mapping
Date:   Tue, 21 Aug 2018 17:23:04 -0400
Message-Id: <20180821212305.20214-1-msys.mizuma@gmail.com>
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
 arch/x86/mm/kaslr.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 61db77b0eda9..aeb62615bd46 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -40,6 +40,7 @@
  */
 static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
 
+static int __initdata rand_mem_physical_padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
 /*
  * Memory regions randomized by KASLR (except modules that use a separate logic
  * earlier during boot). The list is ordered based on virtual addresses. This
@@ -69,6 +70,20 @@ static inline bool kaslr_memory_enabled(void)
 	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
 }
 
+static int __init rand_mem_physical_padding_setup(char *str)
+{
+	int max_padding = (1 << (MAX_PHYSMEM_BITS - TB_SHIFT)) - 1;
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
@@ -102,7 +117,7 @@ void __init kernel_randomize_memory(void)
 	 */
 	BUG_ON(kaslr_regions[0].base != &page_offset_base);
 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
-		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+		rand_mem_physical_padding;
 
 	/* Adapt phyiscal memory region size based on available memory */
 	if (memory_tb < kaslr_regions[0].size_tb)
-- 
2.18.0

