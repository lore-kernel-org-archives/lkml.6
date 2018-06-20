Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522A3C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001A52083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DBJ8yHjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001A52083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933552AbeFTV3K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:29:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51716 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933146AbeFTV3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:29:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5KLO7jC026283;
        Wed, 20 Jun 2018 21:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=9b24dXCYkVZi3mjnDpK4vrSJmPqsQtbnv3yif6qUOjs=;
 b=DBJ8yHjvsFgcHgi5iXC8hmBm2jMRWuj8zD9uYFCXQO/lVgJIpJtGErPL2YNfOb8K0Kbx
 E8kLcZXBh8RLpYgiTvOO5pQmuuYgDf7vxtKvGEHOdmCWtTdh/Vk3f63ihyFyC/VxM8nl
 8NYslitmzCea90zHdjJVMVJw5FO6SA+DKsHX+mwFdpjebJc8Y41ST8iYOmt9WHzSPS5F
 TtrS1H/VdKBIKfkiYw123FtHX9WvVz6mBmseEGzR0omf74BZ7TOFLz1rRUz7CjsHM0ar
 yT0QB/iAQICDl24oaf2DRbr69Yu6u6udTgYu/YtZPOgRtvCxI8hjiGnBXjelnqK2PiJS Dw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jmu6xx8q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 21:27:09 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5KLR9Ch001623
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 21:27:09 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5KLR8ao026527;
        Wed, 20 Jun 2018 21:27:08 GMT
Received: from xakep.us.oracle.com (/10.39.216.167)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 14:27:08 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: [PATCH v11 2/6] kvm/x86: remove kvm memblock dependency
Date:   Wed, 20 Jun 2018 17:26:56 -0400
Message-Id: <20180620212700.29178-3-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620212700.29178-1-pasha.tatashin@oracle.com>
References: <20180620212700.29178-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM clock is initialized later compared to other hypervisor because it has
dependency on memblock allocator.

Lets bring it inline with other hypervisors by removing this dependency by
using memory from BSS instead of allocating it.

The benefits:
- remove ifdef from common code
- earlier availability of TSC.
- remove dependency on memblock, and reduce code
- earlier kvm sched_clock()

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/kvm.c      |  1 +
 arch/x86/kernel/kvmclock.c | 64 ++++++--------------------------------
 arch/x86/kernel/setup.c    |  7 ++---
 3 files changed, 12 insertions(+), 60 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5b2300b818af..c65c232d3ddd 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -628,6 +628,7 @@ const __initconst struct hypervisor_x86 x86_hyper_kvm = {
 	.name			= "KVM",
 	.detect			= kvm_detect,
 	.type			= X86_HYPER_KVM,
+	.init.init_platform	= kvmclock_init,
 	.init.guest_late_init	= kvm_guest_init,
 	.init.x2apic_available	= kvm_para_available,
 };
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index bf8d1eb7fca3..01558d41ec2c 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -23,9 +23,9 @@
 #include <asm/apic.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
-#include <linux/memblock.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
+#include <linux/mm.h>
 
 #include <asm/mem_encrypt.h>
 #include <asm/x86_init.h>
@@ -44,6 +44,11 @@ static int parse_no_kvmclock(char *arg)
 }
 early_param("no-kvmclock", parse_no_kvmclock);
 
+/* Aligned to page sizes to match whats mapped via vsyscalls to userspace */
+#define HV_CLOCK_SIZE	(sizeof(struct pvclock_vsyscall_time_info) * NR_CPUS)
+#define WALL_CLOCK_SIZE	(sizeof(struct pvclock_wall_clock))
+static u8 hv_clock_mem[PAGE_ALIGN(HV_CLOCK_SIZE)] __aligned(PAGE_SIZE);
+static u8 wall_clock_mem[PAGE_ALIGN(WALL_CLOCK_SIZE)] __aligned(PAGE_SIZE);
 /* The hypervisor will put information about time periodically here */
 static struct pvclock_vsyscall_time_info *hv_clock;
 static struct pvclock_wall_clock *wall_clock;
@@ -244,43 +249,12 @@ static void kvm_shutdown(void)
 	native_machine_shutdown();
 }
 
-static phys_addr_t __init kvm_memblock_alloc(phys_addr_t size,
-					     phys_addr_t align)
-{
-	phys_addr_t mem;
-
-	mem = memblock_alloc(size, align);
-	if (!mem)
-		return 0;
-
-	if (sev_active()) {
-		if (early_set_memory_decrypted((unsigned long)__va(mem), size))
-			goto e_free;
-	}
-
-	return mem;
-e_free:
-	memblock_free(mem, size);
-	return 0;
-}
-
-static void __init kvm_memblock_free(phys_addr_t addr, phys_addr_t size)
-{
-	if (sev_active())
-		early_set_memory_encrypted((unsigned long)__va(addr), size);
-
-	memblock_free(addr, size);
-}
-
 void __init kvmclock_init(void)
 {
 	struct pvclock_vcpu_time_info *vcpu_time;
-	unsigned long mem, mem_wall_clock;
-	int size, cpu, wall_clock_size;
+	int cpu;
 	u8 flags;
 
-	size = PAGE_ALIGN(sizeof(struct pvclock_vsyscall_time_info)*NR_CPUS);
-
 	if (!kvm_para_available())
 		return;
 
@@ -290,28 +264,11 @@ void __init kvmclock_init(void)
 	} else if (!(kvmclock && kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)))
 		return;
 
-	wall_clock_size = PAGE_ALIGN(sizeof(struct pvclock_wall_clock));
-	mem_wall_clock = kvm_memblock_alloc(wall_clock_size, PAGE_SIZE);
-	if (!mem_wall_clock)
-		return;
-
-	wall_clock = __va(mem_wall_clock);
-	memset(wall_clock, 0, wall_clock_size);
-
-	mem = kvm_memblock_alloc(size, PAGE_SIZE);
-	if (!mem) {
-		kvm_memblock_free(mem_wall_clock, wall_clock_size);
-		wall_clock = NULL;
-		return;
-	}
-
-	hv_clock = __va(mem);
-	memset(hv_clock, 0, size);
+	wall_clock = (struct pvclock_wall_clock *)wall_clock_mem;
+	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
 
 	if (kvm_register_clock("primary cpu clock")) {
 		hv_clock = NULL;
-		kvm_memblock_free(mem, size);
-		kvm_memblock_free(mem_wall_clock, wall_clock_size);
 		wall_clock = NULL;
 		return;
 	}
@@ -354,13 +311,10 @@ int __init kvm_setup_vsyscall_timeinfo(void)
 	int cpu;
 	u8 flags;
 	struct pvclock_vcpu_time_info *vcpu_time;
-	unsigned int size;
 
 	if (!hv_clock)
 		return 0;
 
-	size = PAGE_ALIGN(sizeof(struct pvclock_vsyscall_time_info)*NR_CPUS);
-
 	cpu = get_cpu();
 
 	vcpu_time = &hv_clock[cpu].pvti;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 2f86d883dd95..5194d9c38a43 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1012,6 +1012,8 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	init_hypervisor_platform();
 
+	tsc_early_delay_calibrate();
+
 	x86_init.resources.probe_roms();
 
 	/* after parse_early_param, so could debug it */
@@ -1197,11 +1199,6 @@ void __init setup_arch(char **cmdline_p)
 
 	memblock_find_dma_reserve();
 
-#ifdef CONFIG_KVM_GUEST
-	kvmclock_init();
-#endif
-
-	tsc_early_delay_calibrate();
 	if (!early_xdbc_setup_hardware())
 		early_xdbc_register_console();
 
-- 
2.17.1

