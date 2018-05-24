Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971421AbeEXURZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:17:25 -0400
Received: from relay1.sgi.com ([192.48.180.66]:60396 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967867AbeEXURQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:17:16 -0400
Message-Id: <20180524201711.854849120@stormcage.americas.sgi.com>
References: <20180524201711.437084301@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date: Thu, 24 May 2018 15:17:14 -0500
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
Subject: [PATCH 3/3] x86/platform/UV: Add kernel parameter to set memory block size
Content-Disposition: inline; filename=add-set_memory_block_size-param
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a kernel parameter that allows setting UV memory block size.  This
is to provide an adjustment for new forms of PMEM and other DIMM memory
that might require alignment restrictions other than scanning the global
address table for the required minimum alignment.  The value set will be
further adjusted by both the GAM range table scan as well as restrictions
imposed by set_memory_block_size_order().

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Andrew Banman <andrew.banman@hpe.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/apic/x2apic_uv_x.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -396,6 +396,17 @@ EXPORT_SYMBOL(uv_hub_info_version);
 /* Default UV memory block size is 2GB */
 static unsigned long mem_block_size = (2UL << 30);
 
+/* Kernel parameter to specify UV mem block size */
+static int parse_mem_block_size(char *ptr)
+{
+	unsigned long size = memparse(ptr, NULL);
+
+	/* Size will be rounded down by set_block_size() below */
+	mem_block_size = size;
+	return 0;
+}
+early_param("uv_memblksize", parse_mem_block_size);
+
 static __init int adj_blksize(u32 lgre)
 {
 	unsigned long base = (unsigned long)lgre << UV_GAM_RANGE_SHFT;

-- 
