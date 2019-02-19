Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C732C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BA92146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfBSP61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:58:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:51914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfBSP5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:57:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6586AAEB2;
        Tue, 19 Feb 2019 15:57:37 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] MIPS: SGI-IP27: do boot CPU init later
Date:   Tue, 19 Feb 2019 16:57:19 +0100
Message-Id: <20190219155728.19163-6-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190219155728.19163-1-tbogendoerfer@suse.de>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make use of per_cpu variables in interrupt code per_cpu_init() must
be done after setup_per_cpu_areas(). This is achieved by calling it
in smp_prepare_boot_cpu() via a new smp_ops method.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/include/asm/smp-ops.h | 1 +
 arch/mips/kernel/smp.c          | 2 ++
 arch/mips/sgi-ip27/ip27-init.c  | 1 -
 arch/mips/sgi-ip27/ip27-smp.c   | 5 +++--
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index b7123f9c0785..65618ff1280c 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -29,6 +29,7 @@ struct plat_smp_ops {
 	int (*boot_secondary)(int cpu, struct task_struct *idle);
 	void (*smp_setup)(void);
 	void (*prepare_cpus)(unsigned int max_cpus);
+	void (*prepare_boot_cpu)(void);
 #ifdef CONFIG_HOTPLUG_CPU
 	int (*cpu_disable)(void);
 	void (*cpu_die)(unsigned int cpu);
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index d84b9066b465..3da3ef9a5d5f 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -443,6 +443,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 /* preload SMP state for boot cpu */
 void smp_prepare_boot_cpu(void)
 {
+	if (mp_ops->prepare_boot_cpu)
+		mp_ops->prepare_boot_cpu();
 	set_cpu_possible(0, true);
 	set_cpu_online(0, true);
 }
diff --git a/arch/mips/sgi-ip27/ip27-init.c b/arch/mips/sgi-ip27/ip27-init.c
index aba985cf07c0..e6fa9d0c708a 100644
--- a/arch/mips/sgi-ip27/ip27-init.c
+++ b/arch/mips/sgi-ip27/ip27-init.c
@@ -212,7 +212,6 @@ void __init plat_mem_setup(void)
 #endif
 
 	ioc3_eth_init();
-	per_cpu_init();
 
 	set_io_port_base(IO_BASE);
 }
diff --git a/arch/mips/sgi-ip27/ip27-smp.c b/arch/mips/sgi-ip27/ip27-smp.c
index 545446dfe7fa..20b81209c6b8 100644
--- a/arch/mips/sgi-ip27/ip27-smp.c
+++ b/arch/mips/sgi-ip27/ip27-smp.c
@@ -177,7 +177,7 @@ static void ip27_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 		ip27_send_ipi_single(i, action);
 }
 
-static void ip27_init_secondary(void)
+static void ip27_init_cpu(void)
 {
 	per_cpu_init();
 }
@@ -235,9 +235,10 @@ static void __init ip27_prepare_cpus(unsigned int max_cpus)
 const struct plat_smp_ops ip27_smp_ops = {
 	.send_ipi_single	= ip27_send_ipi_single,
 	.send_ipi_mask		= ip27_send_ipi_mask,
-	.init_secondary		= ip27_init_secondary,
+	.init_secondary		= ip27_init_cpu,
 	.smp_finish		= ip27_smp_finish,
 	.boot_secondary		= ip27_boot_secondary,
 	.smp_setup		= ip27_smp_setup,
 	.prepare_cpus		= ip27_prepare_cpus,
+	.prepare_boot_cpu	= ip27_init_cpu,
 };
-- 
2.13.7

