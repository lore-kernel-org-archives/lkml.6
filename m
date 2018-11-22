Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DD1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9DE20892
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S13XSitG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9DE20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407419AbeKWGi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:38:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389557AbeKWGiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:38:55 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D29D120870;
        Thu, 22 Nov 2018 19:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916682;
        bh=gUw3LE2TwytgrWjG3kUgJFGAQOtJO+7CHQHltvAzt8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S13XSitGrMhxELWMW7vdiDxos8hVMiiRwfjvTlAaex4XLrEwy6yXjhnzoNNvtttyO
         Tbc3plV3iMM4cdEKK2bUbp9L4vJ6WGjxDVMxt7IXE5KC4Skvo/O7WmN7tDe++7tLOp
         RLzAW7jwVUtxUchAFuEkzfVJAhW8yeCO1XD1XDuU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 3/7] ARM: split out processor lookup
Date:   Thu, 22 Nov 2018 14:57:45 -0500
Message-Id: <20181122195749.14086-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195749.14086-1-sashal@kernel.org>
References: <20181122195749.14086-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 65987a8553061515b5851b472081aedb9837a391 ]

Split out the lookup of the processor type and associated error handling
from the rest of setup_processor() - we will need to use this in the
secondary CPU bringup path for big.Little Spectre variant 2 mitigation.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/cputype.h |  1 +
 arch/arm/kernel/setup.c        | 31 +++++++++++++++++++------------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 819777d0e91f..d944a1efa3c8 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -82,6 +82,7 @@
 #define ARM_CPU_XSCALE_ARCH_V3		0x6000
 
 extern unsigned int processor_id;
+struct proc_info_list *lookup_processor(u32 midr);
 
 #ifdef CONFIG_CPU_CP15
 #define read_cpuid(reg)							\
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 306e1ac2c8e3..8e8c42c1d98f 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -578,22 +578,29 @@ static void __init smp_build_mpidr_hash(void)
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
 
@@ -611,7 +618,7 @@ static void __init setup_processor(void)
 #endif
 
 	pr_info("CPU: %s [%08x] revision %d (ARMv%s), cr=%08lx\n",
-		cpu_name, read_cpuid_id(), read_cpuid_id() & 15,
+		list->cpu_name, midr, midr & 15,
 		proc_arch[cpu_architecture()], get_cr());
 
 	snprintf(init_utsname()->machine, __NEW_UTS_LEN + 1, "%s%c",
-- 
2.17.1

