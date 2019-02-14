Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7520AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5D8222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438450AbfBNKmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:42:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:55050 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438500AbfBNKmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:42:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 375FDB0BE;
        Thu, 14 Feb 2019 10:42:44 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-mm@kvack.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 2/2] x86/xen: dont add memory above max allowed allocation
Date:   Thu, 14 Feb 2019 11:42:40 +0100
Message-Id: <20190214104240.24428-3-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190214104240.24428-1-jgross@suse.com>
References: <20190214104240.24428-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't allow memory to be added above the allowed maximum allocation
limit set by Xen.

Trying to do so would result in cases like the following:

[  584.559652] ------------[ cut here ]------------
[  584.564897] WARNING: CPU: 2 PID: 1 at ../arch/x86/xen/multicalls.c:129 xen_alloc_pte+0x1c7/0x390()
[  584.575151] Modules linked in:
[  584.578643] Supported: Yes
[  584.581750] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.4.120-92.70-default #1
[  584.590000] Hardware name: Cisco Systems Inc UCSC-C460-M4/UCSC-C460-M4, BIOS C460M4.4.0.1b.0.0629181419 06/29/2018
[  584.601862]  0000000000000000 ffffffff813175a0 0000000000000000 ffffffff8184777c
[  584.610200]  ffffffff8107f4e1 ffff880487eb7000 ffff8801862b79c0 ffff88048608d290
[  584.618537]  0000000000487eb7 ffffea0000000201 ffffffff81009de7 ffffffff81068561
[  584.626876] Call Trace:
[  584.629699]  [<ffffffff81019ad9>] dump_trace+0x59/0x340
[  584.635645]  [<ffffffff81019eaa>] show_stack_log_lvl+0xea/0x170
[  584.642391]  [<ffffffff8101ac51>] show_stack+0x21/0x40
[  584.648238]  [<ffffffff813175a0>] dump_stack+0x5c/0x7c
[  584.654085]  [<ffffffff8107f4e1>] warn_slowpath_common+0x81/0xb0
[  584.660932]  [<ffffffff81009de7>] xen_alloc_pte+0x1c7/0x390
[  584.667289]  [<ffffffff810647f0>] pmd_populate_kernel.constprop.6+0x40/0x80
[  584.675241]  [<ffffffff815ecfe8>] phys_pmd_init+0x210/0x255
[  584.681587]  [<ffffffff815ed207>] phys_pud_init+0x1da/0x247
[  584.687931]  [<ffffffff815edb3b>] kernel_physical_mapping_init+0xf5/0x1d4
[  584.695682]  [<ffffffff815e9bdd>] init_memory_mapping+0x18d/0x380
[  584.702631]  [<ffffffff81064699>] arch_add_memory+0x59/0xf0

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/setup.c      | 13 +++++++++++++
 drivers/xen/xen-balloon.c | 11 +++++++++++
 include/xen/xen.h         |  4 ++++
 3 files changed, 28 insertions(+)

diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index d5f303c0e656..0e770f5e5e8c 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -12,6 +12,7 @@
 #include <linux/memblock.h>
 #include <linux/cpuidle.h>
 #include <linux/cpufreq.h>
+#include <linux/memory_hotplug.h>
 
 #include <asm/elf.h>
 #include <asm/vdso.h>
@@ -589,6 +590,14 @@ static void __init xen_align_and_add_e820_region(phys_addr_t start,
 	if (type == E820_TYPE_RAM) {
 		start = PAGE_ALIGN(start);
 		end &= ~((phys_addr_t)PAGE_SIZE - 1);
+#ifdef CONFIG_MEMORY_HOTPLUG
+		/*
+		 * Don't allow adding memory not in E820 map while booting the
+		 * system. Once the balloon driver is up it will remove that
+		 * restriction again.
+		 */
+		max_mem_size = end;
+#endif
 	}
 
 	e820__range_add(start, end - start, type);
@@ -748,6 +757,10 @@ char * __init xen_memory_setup(void)
 	memmap.nr_entries = ARRAY_SIZE(xen_e820_table.entries);
 	set_xen_guest_handle(memmap.buffer, xen_e820_table.entries);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+	xen_saved_max_mem_size = max_mem_size;
+#endif
+
 	op = xen_initial_domain() ?
 		XENMEM_machine_memory_map :
 		XENMEM_memory_map;
diff --git a/drivers/xen/xen-balloon.c b/drivers/xen/xen-balloon.c
index 2acbfe104e46..a67236b02452 100644
--- a/drivers/xen/xen-balloon.c
+++ b/drivers/xen/xen-balloon.c
@@ -37,6 +37,7 @@
 #include <linux/mm_types.h>
 #include <linux/init.h>
 #include <linux/capability.h>
+#include <linux/memory_hotplug.h>
 
 #include <xen/xen.h>
 #include <xen/interface/xen.h>
@@ -50,6 +51,10 @@
 
 #define BALLOON_CLASS_NAME "xen_memory"
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+u64 xen_saved_max_mem_size = 0;
+#endif
+
 static struct device balloon_dev;
 
 static int register_balloon(struct device *dev);
@@ -63,6 +68,12 @@ static void watch_target(struct xenbus_watch *watch,
 	static bool watch_fired;
 	static long target_diff;
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+	/* The balloon driver will take care of adding memory now. */
+	if (xen_saved_max_mem_size)
+		max_mem_size = xen_saved_max_mem_size;
+#endif
+
 	err = xenbus_scanf(XBT_NIL, "memory", "target", "%llu", &new_target);
 	if (err != 1) {
 		/* This is ok (for domain0 at least) - so just return */
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 0e2156786ad2..d8f1ab43ab56 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -46,4 +46,8 @@ struct bio_vec;
 bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 		const struct bio_vec *vec2);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+extern u64 xen_saved_max_mem_size;
+#endif
+
 #endif	/* _XEN_XEN_H */
-- 
2.16.4

