Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2070CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DC5222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ysqTniWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390735AbfBNCKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:10:44 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43698 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404202AbfBNCKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:42 -0500
Received: by mail-qk1-f196.google.com with SMTP id f196so2695144qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yvoFdkch7Gd4/MbRPm6+HJonlCHu2OWfPFxCbumCzMk=;
        b=ysqTniWxOkEN223i3ZqWK3+2Xx1kjnpb4gHRW2xyYDchldG5zL+5a7Q45TMllbqhik
         UMkxm3LHpdFxxbq6PxHFEf0+SBDVl2Xu8qSZDx3G3Mz3fWBKF+WyDb1kkr3+VxCWv4Pd
         k1j0NvkzzmIvTB63xRZU9nTgReJRTN40s0dNxlf1e2t20U6XEqi+Y47J6xrizZKowm53
         z13xmgLXYXfKsA8zfiN8Wyu3LUa3daVdekpZ6dgt6RGt/4Ioxo99mQ+vAfIrLwmvtNbN
         j3cOHDiedKf01Bf28npHWE8pKictERK9jStB1KOLoTqgPk/y1sL3E7fNMqtdHlb05Ugj
         bO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yvoFdkch7Gd4/MbRPm6+HJonlCHu2OWfPFxCbumCzMk=;
        b=R3CUYbc4axNGssxK86iTvxf7vF5OlvA8kSArmTAlJC15lf6UAUYgz04fGdWQtof/lW
         WmfNMnuPw114yPEmJiAu9LuaTmwJ+D9N6SEzEytUHlYvhuohbjTVBVxQ/5hLw1o+t/mu
         co7IvMEGODhMHKLW6ZtAoCH7363iT+dOBHENfE8HdCME6cbfMD8H2L/e1AaQIK0lHJbi
         dTNcs0rlzdMkoISvrLslM1l8XHBR1Ou8OmCDwCUeugrdBLqo2yq4YqXKmhhSkm1LAldM
         +3ohnwFdJrD2+3W56sfXXKT9Jwm4TSG6FZq/KkuDvNZOKStmcNIrnAlWWEmcwspls2aj
         0aug==
X-Gm-Message-State: AHQUAuZqfuuNZT0lLBiiIn1Nu4ALI6l8PLvb68olrxpFtJl9m/Qw8Q21
        3J1CU45CB/cePpx9KVAI6a1A8g==
X-Google-Smtp-Source: AHgI3IabMFdTfhlPPpeJQQWD5R+ltUy+nb2QKWqd38UJDeiPhzGdYN9mZwzizCIwSQRfAGIynBGIRw==
X-Received: by 2002:a37:8e81:: with SMTP id q123mr998935qkd.34.1550110241233;
        Wed, 13 Feb 2019 18:10:41 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id d63sm1091575qka.22.2019.02.13.18.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:10:40 -0800 (PST)
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
Subject: [PATCH 4.14 V2 12/17] ARM: split out processor lookup
Date:   Wed, 13 Feb 2019 21:10:17 -0500
Message-Id: <20190214021022.5313-13-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214021022.5313-1-dave.long@linaro.org>
References: <20190214021022.5313-1-dave.long@linaro.org>
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
index 3379c2c684c2..25d523185c6a 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -107,6 +107,7 @@
 #define ARM_CPU_PART_SCORPION		0x510002d0
 
 extern unsigned int processor_id;
+struct proc_info_list *lookup_processor(u32 midr);
 
 #ifdef CONFIG_CPU_CP15
 #define read_cpuid(reg)							\
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 8e9a3e40d949..1a041ad4881e 100644
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

