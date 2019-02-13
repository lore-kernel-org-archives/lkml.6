Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F57AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8BE206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xY92Dfor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436808AbfBMVcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:32:46 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34989 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436757AbfBMVcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id p48so4496144qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yEcpOWz45DlZuRpoVIt2gmwCWgLldnvEJdiWLJe6SsM=;
        b=xY92DforhFbv2cZWVFuA+wAEWISzJgcbN6lHdt7O1OIqMul7FpvwUY4dO3MIKKf/BW
         ZwKyf5Bd+OiyU2l9g5HX8FtPcTV8U9gx5CUlAVD4tdNesRc7WswCrkahrnXbPkYEmBJC
         wkcU2K8p5lNL/CjZQS7If8YheKGndJ8eMWrSJ2Vdx5Dlgw7LRcUWjR2AuU0YB5zp+dhZ
         vVj6l2hxFqC6pfU+8/Odg+708ZzJK1s+AYVFIqaJOItwRe99hBN9rTyoqxljJjvOZshk
         isJv095UXK19rzhdejQCouHBYXeTpeKpeZkUngSMmvlSEyVLShes3zM61p3n6vOQP3Rq
         PKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yEcpOWz45DlZuRpoVIt2gmwCWgLldnvEJdiWLJe6SsM=;
        b=cCEy16bnVXZwJ9Klt5obz25VYSwglewdNC/+86FXSf9irv43hcBMNCX5ryVAwExuin
         G/dnEsAq0/w1YwWUrJGOb5FvF56LHYrKXWGL6vvmLatoXKsOvB7MbldPSTfMfls0Iu/J
         nj+KLgzDqaugfJaDSzN1Q9YCJ4/pWCaZY91xMaXn+vVJTRjEhJ3ZK1vZVcbPSVyrqrIH
         pQOrEtNdCdLTdHLASeAFbDjjaL+SYsxq007T+iyDiT9bZY9/n+rapuP7wdtaxWqAxJnw
         Lmq5dQKAKoBnPcdcFv3lI8XHYU3PUAFPJrZ48XIAorecSiB7NnpnDTIcRQeMkRwrLPPe
         f6YA==
X-Gm-Message-State: AHQUAuYSzANUHp4NzSbqRTuf0vCHuNp2krbfenzHxLB7XJ0dduOdvlce
        7wjQ/DoHTvVowvkewdCOl/nXYA==
X-Google-Smtp-Source: AHgI3Ib42+Syja8TX47oCJxenG/mcxAIKVkK95CvCXAvrmSpO6ztKtl0b+jWng2Z16b0f6Me+RQrlA==
X-Received: by 2002:a0c:b90d:: with SMTP id u13mr247321qvf.66.1550093562264;
        Wed, 13 Feb 2019 13:32:42 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id 8sm382675qtr.7.2019.02.13.13.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:32:41 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.19 12/17] ARM: split out processor lookup
Date:   Wed, 13 Feb 2019 16:32:18 -0500
Message-Id: <20190213213223.916-13-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
References: <20190213213223.916-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit 65987a8553061515b5851b472081aedb9837a391 upstream.

Split out the lookup of the processor type and associated error handling
from the rest of setup_processor() - we will need to use this in the
secondary CPU bringup path for big.Little Spectre variant 2 mitigation.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/include/asm/cputype.h |  1 +
 arch/arm/kernel/setup.c        | 31 +++++++++++++++++++------------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 0d289240b6ca..775cac3c02bb 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -111,6 +111,7 @@
 #include <linux/kernel.h>
 
 extern unsigned int processor_id;
+struct proc_info_list *lookup_processor(u32 midr);
 
 #ifdef CONFIG_CPU_CP15
 #define read_cpuid(reg)							\
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 4c249cb261f3..8fd7baa158a4 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -667,22 +667,29 @@ static void __init smp_build_mpidr_hash(void)
 }
 #endif
 
-static void __init setup_processor(void)
+/*
+ * locate processor in the list of supported processor types.  The linker
+ * builds this table for us from the entries in arch/arm/mm/proc-*.S
+ */
+struct proc_info_list *lookup_processor(u32 midr)
 {
-	struct proc_info_list *list;
+	struct proc_info_list *list = lookup_processor_type(midr);
 
-	/*
-	 * locate processor in the list of supported processor
-	 * types.  The linker builds this table for us from the
-	 * entries in arch/arm/mm/proc-*.S
-	 */
-	list = lookup_processor_type(read_cpuid_id());
 	if (!list) {
-		pr_err("CPU configuration botched (ID %08x), unable to continue.\n",
-		       read_cpuid_id());
-		while (1);
+		pr_err("CPU%u: configuration botched (ID %08x), CPU halted\n",
+		       smp_processor_id(), midr);
+		while (1)
+		/* can't use cpu_relax() here as it may require MMU setup */;
 	}
 
+	return list;
+}
+
+static void __init setup_processor(void)
+{
+	unsigned int midr = read_cpuid_id();
+	struct proc_info_list *list = lookup_processor(midr);
+
 	cpu_name = list->cpu_name;
 	__cpu_architecture = __get_cpu_architecture();
 
@@ -700,7 +707,7 @@ static void __init setup_processor(void)
 #endif
 
 	pr_info("CPU: %s [%08x] revision %d (ARMv%s), cr=%08lx\n",
-		cpu_name, read_cpuid_id(), read_cpuid_id() & 15,
+		list->cpu_name, midr, midr & 15,
 		proc_arch[cpu_architecture()], get_cr());
 
 	snprintf(init_utsname()->machine, __NEW_UTS_LEN + 1, "%s%c",
-- 
2.17.1

