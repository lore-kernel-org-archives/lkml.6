Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E66AC4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA6621736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500958;
	bh=z12ETBOzQWPaRF0m5T0Oz1jsrP90lGO0e9zbIDgEhkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BrJoldlM0Y2ZKcpiFJu1I9GSmPD39ySnAAzdp0oR+L2fInBlepGPhaS0OmFjFcKXM
	 YJccab0R26nH+9gqJ0VCDO3AB1BHF5Czucs2+afLCA4GSU3HTbki84JzFOERKok2Lc
	 8CxIiEfm3FG8eHRKFg7z+vCMpx/4fiNbe4YqTDTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbfBROmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:42:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732149AbfBRNuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:50:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F68F20842;
        Mon, 18 Feb 2019 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497804;
        bh=z12ETBOzQWPaRF0m5T0Oz1jsrP90lGO0e9zbIDgEhkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yqxa3KO8y59jRpYLaFnI+Ah/jmrI+hC8gcsxvlfvs1QOit3XVuNNbXW8BzXXoIttH
         eBM0QC6vOi7jxT9SVW4Xo5qH5EA+o/3Bty8dIfZ8aTrIrB1qT1Ofn1kpBR2l7HK9Vc
         agrh4/V0ck9m5BpUlR0JP/JM//tVFSINs5VqnVO0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 15/85] ARM: split out processor lookup
Date:   Mon, 18 Feb 2019 14:42:41 +0100
Message-Id: <20190218133501.344533012@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

Commit 65987a8553061515b5851b472081aedb9837a391 upstream.

Split out the lookup of the processor type and associated error handling
from the rest of setup_processor() - we will need to use this in the
secondary CPU bringup path for big.Little Spectre variant 2 mitigation.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Tested-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1



