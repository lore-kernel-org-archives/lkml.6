Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968869AbeEXUSW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:18:22 -0400
Received: from relay1.sgi.com ([192.48.180.66]:60385 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967858AbeEXURQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:17:16 -0400
Message-Id: <20180524201711.609546602@stormcage.americas.sgi.com>
References: <20180524201711.437084301@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date: Thu, 24 May 2018 15:17:12 -0500
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
Subject: [PATCH 1/3] x86/platform/UV: Add adjustable set memory block size function
Content-Disposition: inline; filename=add-set_memory_block_size_order
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new function to "adjust" the current fixed UV memory block size
of 2GB so it can be changed to a different physical boundary.  This is
out of necessity so arch dependent code can accommodate specific BIOS
requirements which can align these new PMEM modules at less than the
default boundaries.

A "set order" type of function was used to insure that the memory block
size will be a power of two value without requiring a validity check.
64GB was chosen as the upper limit for memory block size values to
accommodate upcoming 4PB systems which have 6 more bits of physical
address space (46 becoming 52).

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Andrew Banman <andrew.banman@hpe.com>
Cc: stable@vger.kernel.org
---
v2: Update description
---
 arch/x86/mm/init_64.c  |   20 ++++++++++++++++----
 include/linux/memory.h |    1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

--- linux.orig/arch/x86/mm/init_64.c
+++ linux/arch/x86/mm/init_64.c
@@ -1350,16 +1350,28 @@ int kern_addr_valid(unsigned long addr)
 /* Amount of ram needed to start using large blocks */
 #define MEM_SIZE_FOR_LARGE_BLOCK (64UL << 30)
 
+/* Adjustable memory block size */
+static unsigned long set_memory_block_size;
+int __init set_memory_block_size_order(unsigned int order)
+{
+	unsigned long size = 1UL << order;
+
+	if (size > MEM_SIZE_FOR_LARGE_BLOCK || size < MIN_MEMORY_BLOCK_SIZE)
+		return -EINVAL;
+
+	set_memory_block_size = size;
+	return 0;
+}
+
 static unsigned long probe_memory_block_size(void)
 {
 	unsigned long boot_mem_end = max_pfn << PAGE_SHIFT;
 	unsigned long bz;
 
-	/* If this is UV system, always set 2G block size */
-	if (is_uv_system()) {
-		bz = MAX_BLOCK_SIZE;
+	/* If memory block size has been set, then use it */
+	bz = set_memory_block_size;
+	if (bz)
 		goto done;
-	}
 
 	/* Use regular block if RAM is smaller than MEM_SIZE_FOR_LARGE_BLOCK */
 	if (boot_mem_end < MEM_SIZE_FOR_LARGE_BLOCK) {
--- linux.orig/include/linux/memory.h
+++ linux/include/linux/memory.h
@@ -38,6 +38,7 @@ struct memory_block {
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
 unsigned long memory_block_size_bytes(void);
+int set_memory_block_size_order(unsigned int order);
 
 /* These states are exposed to userspace as text strings in sysfs */
 #define	MEM_ONLINE		(1<<0) /* exposed to userspace */

-- 
