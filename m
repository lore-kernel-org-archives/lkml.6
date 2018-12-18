Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6A7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012FF21850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeLROs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:48:57 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33387 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726629AbeLROs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:48:57 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBIEkYJA015616;
        Tue, 18 Dec 2018 15:48:28 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pcr8xr9fe-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 18 Dec 2018 15:48:28 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3A22734;
        Tue, 18 Dec 2018 14:48:28 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D75F54E6E;
        Tue, 18 Dec 2018 14:48:27 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 18 Dec 2018 15:48:27
 +0100
From:   <patrice.chotard@st.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <patrice.chotard@st.com>
Subject: [PATCH 1/1] ARM: STi: Restore secondary CPU's bringup
Date:   Tue, 18 Dec 2018 15:48:13 +0100
Message-ID: <1545144493-11600-1-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Due to pen_release and boot_lock removal, secondary CPU's bringup
was broken. Restore CPU's bringup by reworking properly
.smp_prepare_cpus and .smp_boot_secondary STi callbacks.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/mach-sti/platsmp.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
index 2166850..9bfc93a 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -28,8 +28,21 @@
 
 #include "smp.h"
 
+static u32 __iomem *cpu_strt_ptr;
+
 static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
+	unsigned long entry_pa = __pa_symbol(secondary_startup);
+
+	__raw_writel(entry_pa, cpu_strt_ptr);
+
+	/*
+	 * wmb so that data is actually written
+	 * before cache flush is done
+	 */
+	smp_wmb();
+	sync_cache_w(cpu_strt_ptr);
+
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
 	 * it to jump to the secondary entrypoint.
@@ -43,10 +56,8 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 {
 	struct device_node *np;
 	void __iomem *scu_base;
-	u32 __iomem *cpu_strt_ptr;
 	u32 release_phys;
 	int cpu;
-	unsigned long entry_pa = __pa_symbol(secondary_startup);
 
 	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
 
@@ -74,8 +85,8 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 		}
 
 		/*
-		 * holding pen is usually configured in SBC DMEM but can also be
-		 * in RAM.
+		 * cpu-release-addr is usually configured in SBC DMEM but can
+		 * also be in RAM.
 		 */
 
 		if (!memblock_is_memory(release_phys))
@@ -85,17 +96,7 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 			cpu_strt_ptr =
 				(u32 __iomem *)phys_to_virt(release_phys);
 
-		__raw_writel(entry_pa, cpu_strt_ptr);
-
-		/*
-		 * wmb so that data is actually written
-		 * before cache flush is done
-		 */
-		smp_wmb();
-		sync_cache_w(cpu_strt_ptr);
-
-		if (!memblock_is_memory(release_phys))
-			iounmap(cpu_strt_ptr);
+		set_cpu_possible(cpu, true);
 	}
 }
 
-- 
1.9.1

