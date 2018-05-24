Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032521AbeEXURV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:17:21 -0400
Received: from relay2.sgi.com ([192.48.180.65]:52964 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967850AbeEXURQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:17:16 -0400
Message-Id: <20180524201711.732785782@stormcage.americas.sgi.com>
References: <20180524201711.437084301@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date: Thu, 24 May 2018 15:17:13 -0500
From: <mike.travis@hpe.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>, jgross@suse.com,
        dan.j.williams@intel.com, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 2/3] x86/platform/UV: Use new set memory block size function
Content-Disposition: inline; filename=use-set_memory_block_size
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a call to the new function to "adjust" the current fixed UV memory
block size of 2GB so it can be changed to a different physical boundary.
This accommodates changes in the Intel BIOS, and therefore UV BIOS,
which now can align boundaries different than the previous UV standard
of 2GB.  It also flags any UV Global Address boundaries from BIOS that
cause a change in the mem block size (boundary).

The current boundary of 2GB has been used on UV since the first system
release in 2009 with Linux 2.6 and has worked fine.  But the new NVDIMM
persistent memory modules (PMEM), along with the Intel BIOS changes to
support these modules caused the memory block size boundary to be set
to a lower limit.  Intel only guarantees that this minimum boundary at
64MB though the current Linux limit is 128MB.

Note that the default remains 2GB if no changes occur.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Andrew Banman <andrew.banman@hpe.com>
Cc: stable@vger.kernel.org
---
v2: Update description
---
 arch/x86/kernel/apic/x2apic_uv_x.c |   49 ++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
 #include <linux/reboot.h>
+#include <linux/memory.h>
 
 #include <asm/uv/uv_mmrs.h>
 #include <asm/uv/uv_hub.h>
@@ -392,6 +393,40 @@ extern int uv_hub_info_version(void)
 }
 EXPORT_SYMBOL(uv_hub_info_version);
 
+/* Default UV memory block size is 2GB */
+static unsigned long mem_block_size = (2UL << 30);
+
+static __init int adj_blksize(u32 lgre)
+{
+	unsigned long base = (unsigned long)lgre << UV_GAM_RANGE_SHFT;
+	unsigned long size;
+
+	for (size = mem_block_size; size > MIN_MEMORY_BLOCK_SIZE; size >>= 1)
+		if (IS_ALIGNED(base, size))
+			break;
+
+	if (size >= mem_block_size)
+		return 0;
+
+	mem_block_size = size;
+	return 1;
+}
+
+static __init void set_block_size(void)
+{
+	unsigned int order = ffs(mem_block_size);
+
+	if (order) {
+		/* adjust for ffs return of 1..64 */
+		set_memory_block_size_order(order - 1);
+		pr_info("UV: mem_block_size set to 0x%lx\n", mem_block_size);
+	} else {
+		/* bad or zero value, default to 1UL << 31 (2GB) */
+		pr_err("UV: mem_block_size error with 0x%lx\n", mem_block_size);
+		set_memory_block_size_order(31);
+	}
+}
+
 /* Build GAM range lookup table: */
 static __init void build_uv_gr_table(void)
 {
@@ -1180,23 +1215,30 @@ static void __init decode_gam_rng_tbl(un
 					<< UV_GAM_RANGE_SHFT);
 		int order = 0;
 		char suffix[] = " KMGTPE";
+		int flag = ' ';
 
 		while (size > 9999 && order < sizeof(suffix)) {
 			size /= 1024;
 			order++;
 		}
 
+		/* adjust max block size to current range start */
+		if (gre->type == 1 || gre->type == 2)
+			if (adj_blksize(lgre))
+				flag = '*';
+
 		if (!index) {
 			pr_info("UV: GAM Range Table...\n");
-			pr_info("UV:  # %20s %14s %5s %4s %5s %3s %2s\n", "Range", "", "Size", "Type", "NASID", "SID", "PN");
+			pr_info("UV:  # %20s %14s %6s %4s %5s %3s %2s\n", "Range", "", "Size", "Type", "NASID", "SID", "PN");
 		}
-		pr_info("UV: %2d: 0x%014lx-0x%014lx %5lu%c %3d   %04x  %02x %02x\n",
+		pr_info("UV: %2d: 0x%014lx-0x%014lx%c %5lu%c %3d   %04x  %02x %02x\n",
 			index++,
 			(unsigned long)lgre << UV_GAM_RANGE_SHFT,
 			(unsigned long)gre->limit << UV_GAM_RANGE_SHFT,
-			size, suffix[order],
+			flag, size, suffix[order],
 			gre->type, gre->nasid, gre->sockid, gre->pnode);
 
+		/* update to next range start */
 		lgre = gre->limit;
 		if (sock_min > gre->sockid)
 			sock_min = gre->sockid;
@@ -1427,6 +1469,7 @@ static void __init uv_system_init_hub(vo
 
 	build_socket_tables();
 	build_uv_gr_table();
+	set_block_size();
 	uv_init_hub_info(&hub_info);
 	uv_possible_blades = num_possible_nodes();
 	if (!_node_to_pnode)

-- 
