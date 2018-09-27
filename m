Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85801C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FE521712
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbLZoFn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FE521712
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeI1CyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:54:01 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33230 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeI1CyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:54:01 -0400
Received: by mail-qt1-f194.google.com with SMTP id i10-v6so4343221qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wX9c6L0ppsCvK4n6MoWQcsqdE557eipciyxbajazBV4=;
        b=cbLZoFn1DD72nuAoz6vuc2x57RyfoajlUtve9WQ6xxTGHxnsks8aBkrZiCA2DOgerO
         X7naJCe3j8QVoRKaKARs7KXNcSpdlyl63phx1QXJvO2ZYtoJmKk1H9z87hKNNE5CvSu3
         3fwLD0Ip8GY+MDk+51bY+/iSSpXoljl/+rDKEL6UyYNs9w+GgPPozFroM9+I0uswYH9S
         Yd8ZVE0r3Nqd+7v+Aoy3aVf8HjFpH0Uycwj0IqzXeq+KrfteNWlu0kJyInysUabMy47y
         Lr4nKQpRH/46CZnvdYPAxdAg+rmDzJUQ1l1x4QPejMCnFZJuvbv/6syS4jFEe9dQi9SS
         lbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wX9c6L0ppsCvK4n6MoWQcsqdE557eipciyxbajazBV4=;
        b=euN+dy959BkrtK0nmMiZT3UdM2GR37Ji64tNyDQjYtTTEwB9itlNcoy190h9xcipWV
         yNNCNGpgp+Snotmqn862JUsDPlcRtaMUh+azemO9nNPkTSTKjKyed6Lf5UHV5YqhWkrm
         86LmUdxssZ1KigaOffW41NM2zzVNT3r3BbuHovlq4BGK+jyJQPgejUQXD+tKt/TVL/ef
         0wQq2AUcHB4Hm32GNg659Gb1dbI/VjPlsquAwI3JeKQMate8lnGrmriodnVivtyGbU3Q
         wh6ui5S13EufJFJ1HequdeHWArg7gUVOm8sKyjUQ5qXypbFZVexI7gzFibD5/Zrgfv2s
         INBg==
X-Gm-Message-State: ABuFfohlUp++r3BbnWoLTfPQ23fZykvEk+8EzOzaidRmNxabkvJJJskE
        d7FvJiSU5QVLpSSXxKLRLg==
X-Google-Smtp-Source: ACcGV63Gktp4FcRqw02YApeEQPJlnOAsMXGizXHbP3afcfvODxxes5iIcjEQIbixiKosBmyLeGCZ6g==
X-Received: by 2002:ad4:5004:: with SMTP id s4-v6mr9495349qvo.207.1538080436583;
        Thu, 27 Sep 2018 13:33:56 -0700 (PDT)
Received: from centos7.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v187-v6sm1649374qka.73.2018.09.27.13.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:33:56 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] x86/mm: Add a kernel parameter to change the padding used for the physical memory mapping
Date:   Thu, 27 Sep 2018 16:31:44 -0400
Message-Id: <20180927203146.12201-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927203146.12201-1-msys.mizuma@gmail.com>
References: <20180927203146.12201-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

If the physical memory layout has huge space for memory hotplug,
the padding used for the physical memory mapping section is not enough.
For example of the layout:
  SRAT: Node 6 PXM 4 [mem 0x100000000000-0x13ffffffffff] hotplug
  SRAT: Node 7 PXM 5 [mem 0x140000000000-0x17ffffffffff] hotplug
  SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
  SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug

We can increase the padding by CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
however, the needed padding size depends on the physical memory layout
defined by SRAT. The kernel option is better than changing the config.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/kaslr.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 61db77b..00cf4ca 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -40,6 +40,7 @@
  */
 static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
 
+int __initdata rand_mem_physical_padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
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

