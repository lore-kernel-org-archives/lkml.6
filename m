Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF39AC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F70B2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYFX0F0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfBTPzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:55:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45577 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfBTPzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:55:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id w17so26523083wrn.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 07:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WYT38OLrPVg9S6X2MhbH3YDUija7usseRIKSRWILMjE=;
        b=UYFX0F0OThw7N0PyeqCyt0irylizzHeD9kLgxsa8k+zjiaCPAzarRJ/HkE6XJ9KCjk
         lKxBE5kvHvbEjQZUTewsDE0gcg0U9ddWJ11dhS2mUWkEsSaQGYh9dcJVnMXk1rRhWx0V
         796niuhMXoifCIGOX3KHMZgkigOQIoQgBXD3LklyqToxv8aMxOKMXHU6JbnZlgDE59Qf
         Edc8+Mb4a7tCtVUcPONrdth2cPdbDKf5K/toe5YIpkMrrLA6RYiiAYUnxD0QsLWlBQOW
         Xv5cvVvJaUiSehf0vBMlnbvASYBXSUc+rxERYW7IF4up0ZjC2UtZM5FqtQzE2a2zGrph
         EKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WYT38OLrPVg9S6X2MhbH3YDUija7usseRIKSRWILMjE=;
        b=uQvZ1pNDwMQY6k/kVixR8PfkevI3NOL3Dl4JKqxye9v7AfPygEATrzsMdfDjrW8o4u
         rSdxjpOo8URkQLEBd+4SvyzbufG3ZQLzdCz8xoyiqGcMwocFLCM6WMFmLLZGXN/0TuHf
         6vfjyZx6XVs33/ja7d2fiZPROC9iFosHa0ixfyQys17MV4u/huDbizAxT8YrJLlIlUk5
         AmDoFtsPALafD+Ra7Zt/NZrkXS71dhB0O/saw4IL9Bg7YTi+/60BdPTl3N9qs6OK/kgq
         4wLE+l/f2jj9ix4UrSf6OWUluSn9l8yhlcakGkgm74ryKZPNcpzB9G5rtfx06WxTmZds
         VOCw==
X-Gm-Message-State: AHQUAuYm/QgrGk9BLdj4BtdtoAAAf/Kjv9a+R1GuseYdwF7xnkb1xrTj
        eI9gF10O/GrWYZ45Hk0YxsRONw==
X-Google-Smtp-Source: AHgI3Ib7iotiEeNe3DMKzry1okFfh8qa+obGm4GtHqr2CY6I9l57NhS0zMjAvSlHCbguN8qtlDB2wQ==
X-Received: by 2002:adf:f305:: with SMTP id i5mr19396335wro.161.1550678122707;
        Wed, 20 Feb 2019 07:55:22 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id r15sm23730158wrt.37.2019.02.20.07.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 07:55:21 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Cc:     Qian Cai <cai@lca.pw>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>
Subject: [PATCH] kasan: fix random seed generation for tag-based mode
Date:   Wed, 20 Feb 2019 16:55:18 +0100
Message-Id: <1f815cc914b61f3516ed4cc9bfd9eeca9bd5d9de.1550677973.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two issues with assigning random percpu seeds right now:

1. We use for_each_possible_cpu() to iterate over cpus, but cpumask is
   not set up yet at the moment of kasan_init(), and thus we only set
   the seed for cpu #0.

2. A call to get_random_u32() always returns the same number and produces
   a message in dmesg, since the random subsystem is not yet initialized.

Fix 1 by calling kasan_init_tags() after cpumask is set up.

Fix 2 by using get_cycles() instead of get_random_u32(). This gives us
lower quality random numbers, but it's good enough, as KASAN is meant to
be used as a debugging tool and not a mitigation.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/kernel/setup.c  | 3 +++
 arch/arm64/mm/kasan_init.c | 2 --
 mm/kasan/tags.c            | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index d09ec76f08cf..009849328289 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -339,6 +339,9 @@ void __init setup_arch(char **cmdline_p)
 	smp_init_cpus();
 	smp_build_mpidr_hash();
 
+	/* Init percpu seeds for random tags after cpus are set up. */
+	kasan_init_tags();
+
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	/*
 	 * Make sure init_thread_info.ttbr0 always generates translation
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 4b55b15707a3..f37a86d2a69d 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -252,8 +252,6 @@ void __init kasan_init(void)
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 
-	kasan_init_tags();
-
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
 	pr_info("KernelAddressSanitizer initialized\n");
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 0777649e07c4..63fca3172659 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -46,7 +46,7 @@ void kasan_init_tags(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		per_cpu(prng_state, cpu) = get_random_u32();
+		per_cpu(prng_state, cpu) = (u32)get_cycles();
 }
 
 /*
-- 
2.21.0.rc0.258.g878e2cd30e-goog

