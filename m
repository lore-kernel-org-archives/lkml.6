Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92365C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592F720661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592F720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeLIWOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:14:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38096 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbeLIWOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:14:39 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73F-0002ii-LT; Sun, 09 Dec 2018 21:55:49 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72d-0003N9-0T; Sun, 09 Dec 2018 21:55:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Hari Bathini" <hbathini@linux.ibm.com>,
        "Mahesh Salgaonkar" <mahesh@linux.vnet.ibm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.362293323@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 124/328] powerpc/fadump: handle crash memory ranges
 array index overflow
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hari Bathini <hbathini@linux.ibm.com>

commit 1bd6a1c4b80a28d975287630644e6b47d0f977a5 upstream.

Crash memory ranges is an array of memory ranges of the crashing kernel
to be exported as a dump via /proc/vmcore file. The size of the array
is set based on INIT_MEMBLOCK_REGIONS, which works alright in most cases
where memblock memory regions count is less than INIT_MEMBLOCK_REGIONS
value. But this count can grow beyond INIT_MEMBLOCK_REGIONS value since
commit 142b45a72e22 ("memblock: Add array resizing support").

On large memory systems with a few DLPAR operations, the memblock memory
regions count could be larger than INIT_MEMBLOCK_REGIONS value. On such
systems, registering fadump results in crash or other system failures
like below:

  task: c00007f39a290010 ti: c00000000b738000 task.ti: c00000000b738000
  NIP: c000000000047df4 LR: c0000000000f9e58 CTR: c00000000010f180
  REGS: c00000000b73b570 TRAP: 0300   Tainted: G          L   X  (4.4.140+)
  MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22004484  XER: 20000000
  CFAR: c000000000008500 DAR: 000007a450000000 DSISR: 40000000 SOFTE: 0
  ...
  NIP [c000000000047df4] smp_send_reschedule+0x24/0x80
  LR [c0000000000f9e58] resched_curr+0x138/0x160
  Call Trace:
    resched_curr+0x138/0x160 (unreliable)
    check_preempt_curr+0xc8/0xf0
    ttwu_do_wakeup+0x38/0x150
    try_to_wake_up+0x224/0x4d0
    __wake_up_common+0x94/0x100
    ep_poll_callback+0xac/0x1c0
    __wake_up_common+0x94/0x100
    __wake_up_sync_key+0x70/0xa0
    sock_def_readable+0x58/0xa0
    unix_stream_sendmsg+0x2dc/0x4c0
    sock_sendmsg+0x68/0xa0
    ___sys_sendmsg+0x2cc/0x2e0
    __sys_sendmsg+0x5c/0xc0
    SyS_socketcall+0x36c/0x3f0
    system_call+0x3c/0x100

as array index overflow is not checked for while setting up crash memory
ranges causing memory corruption. To resolve this issue, dynamically
allocate memory for crash memory ranges and resize it incrementally,
in units of pagesize, on hitting array size limit.

Fixes: 2df173d9e85d ("fadump: Initialize elfcore header and add PT_LOAD program headers.")
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
[mpe: Just use PAGE_SIZE directly, fixup variable placement]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[bwh: Backported to 3.16:
 - register_fadump() returns void
 - Include <linux/slab.h> for kfree(), krealloc()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -194,9 +194,6 @@ struct fadump_crash_info_header {
 	struct cpumask	cpu_online_mask;
 };
 
-/* Crash memory ranges */
-#define INIT_CRASHMEM_RANGES	(INIT_MEMBLOCK_REGIONS + 2)
-
 struct fad_crash_memory_ranges {
 	unsigned long long	base;
 	unsigned long long	size;
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -35,6 +35,7 @@
 #include <linux/crash_dump.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
+#include <linux/slab.h>
 
 #include <asm/page.h>
 #include <asm/prom.h>
@@ -48,8 +49,10 @@ static struct fadump_mem_struct fdm;
 static const struct fadump_mem_struct *fdm_active;
 
 static DEFINE_MUTEX(fadump_mutex);
-struct fad_crash_memory_ranges crash_memory_ranges[INIT_CRASHMEM_RANGES];
+struct fad_crash_memory_ranges *crash_memory_ranges;
+int crash_memory_ranges_size;
 int crash_mem_ranges;
+int max_crash_mem_ranges;
 
 /* Scan the Firmware Assisted dump configuration details. */
 int __init early_init_dt_scan_fw_dump(unsigned long node,
@@ -726,38 +729,88 @@ static int __init process_fadump(const s
 	return 0;
 }
 
-static inline void fadump_add_crash_memory(unsigned long long base,
-					unsigned long long end)
+static void free_crash_memory_ranges(void)
+{
+	kfree(crash_memory_ranges);
+	crash_memory_ranges = NULL;
+	crash_memory_ranges_size = 0;
+	max_crash_mem_ranges = 0;
+}
+
+/*
+ * Allocate or reallocate crash memory ranges array in incremental units
+ * of PAGE_SIZE.
+ */
+static int allocate_crash_memory_ranges(void)
+{
+	struct fad_crash_memory_ranges *new_array;
+	u64 new_size;
+
+	new_size = crash_memory_ranges_size + PAGE_SIZE;
+	pr_debug("Allocating %llu bytes of memory for crash memory ranges\n",
+		 new_size);
+
+	new_array = krealloc(crash_memory_ranges, new_size, GFP_KERNEL);
+	if (new_array == NULL) {
+		pr_err("Insufficient memory for setting up crash memory ranges\n");
+		free_crash_memory_ranges();
+		return -ENOMEM;
+	}
+
+	crash_memory_ranges = new_array;
+	crash_memory_ranges_size = new_size;
+	max_crash_mem_ranges = (new_size /
+				sizeof(struct fad_crash_memory_ranges));
+	return 0;
+}
+
+static inline int fadump_add_crash_memory(unsigned long long base,
+					  unsigned long long end)
 {
 	if (base == end)
-		return;
+		return 0;
+
+	if (crash_mem_ranges == max_crash_mem_ranges) {
+		int ret;
+
+		ret = allocate_crash_memory_ranges();
+		if (ret)
+			return ret;
+	}
 
 	pr_debug("crash_memory_range[%d] [%#016llx-%#016llx], %#llx bytes\n",
 		crash_mem_ranges, base, end - 1, (end - base));
 	crash_memory_ranges[crash_mem_ranges].base = base;
 	crash_memory_ranges[crash_mem_ranges].size = end - base;
 	crash_mem_ranges++;
+	return 0;
 }
 
-static void fadump_exclude_reserved_area(unsigned long long start,
+static int fadump_exclude_reserved_area(unsigned long long start,
 					unsigned long long end)
 {
 	unsigned long long ra_start, ra_end;
+	int ret = 0;
 
 	ra_start = fw_dump.reserve_dump_area_start;
 	ra_end = ra_start + fw_dump.reserve_dump_area_size;
 
 	if ((ra_start < end) && (ra_end > start)) {
 		if ((start < ra_start) && (end > ra_end)) {
-			fadump_add_crash_memory(start, ra_start);
-			fadump_add_crash_memory(ra_end, end);
+			ret = fadump_add_crash_memory(start, ra_start);
+			if (ret)
+				return ret;
+
+			ret = fadump_add_crash_memory(ra_end, end);
 		} else if (start < ra_start) {
-			fadump_add_crash_memory(start, ra_start);
+			ret = fadump_add_crash_memory(start, ra_start);
 		} else if (ra_end < end) {
-			fadump_add_crash_memory(ra_end, end);
+			ret = fadump_add_crash_memory(ra_end, end);
 		}
 	} else
-		fadump_add_crash_memory(start, end);
+		ret = fadump_add_crash_memory(start, end);
+
+	return ret;
 }
 
 static int fadump_init_elfcore_header(char *bufp)
@@ -793,10 +846,11 @@ static int fadump_init_elfcore_header(ch
  * Traverse through memblock structure and setup crash memory ranges. These
  * ranges will be used create PT_LOAD program headers in elfcore header.
  */
-static void fadump_setup_crash_memory_ranges(void)
+static int fadump_setup_crash_memory_ranges(void)
 {
 	struct memblock_region *reg;
 	unsigned long long start, end;
+	int ret;
 
 	pr_debug("Setup crash memory ranges.\n");
 	crash_mem_ranges = 0;
@@ -807,7 +861,9 @@ static void fadump_setup_crash_memory_ra
 	 * specified during fadump registration. We need to create a separate
 	 * program header for this chunk with the correct offset.
 	 */
-	fadump_add_crash_memory(RMA_START, fw_dump.boot_memory_size);
+	ret = fadump_add_crash_memory(RMA_START, fw_dump.boot_memory_size);
+	if (ret)
+		return ret;
 
 	for_each_memblock(memory, reg) {
 		start = (unsigned long long)reg->base;
@@ -816,8 +872,12 @@ static void fadump_setup_crash_memory_ra
 			start = fw_dump.boot_memory_size;
 
 		/* add this range excluding the reserved dump area. */
-		fadump_exclude_reserved_area(start, end);
+		ret = fadump_exclude_reserved_area(start, end);
+		if (ret)
+			return ret;
 	}
+
+	return 0;
 }
 
 /*
@@ -941,6 +1001,7 @@ static void register_fadump(void)
 {
 	unsigned long addr;
 	void *vaddr;
+	int ret;
 
 	/*
 	 * If no memory is reserved then we can not register for firmware-
@@ -949,7 +1010,9 @@ static void register_fadump(void)
 	if (!fw_dump.reserve_dump_area_size)
 		return;
 
-	fadump_setup_crash_memory_ranges();
+	ret = fadump_setup_crash_memory_ranges();
+	if (ret)
+		return;
 
 	addr = fdm.rmr_region.destination_address + fdm.rmr_region.source_len;
 	/* Initialize fadump crash info header. */
@@ -1028,6 +1091,7 @@ void fadump_cleanup(void)
 	} else if (fw_dump.dump_registered) {
 		/* Un-register Firmware-assisted dump if it was registered. */
 		fadump_unregister_dump(&fdm);
+		free_crash_memory_ranges();
 	}
 }
 

