Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965844AbeCGTyE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:54:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:37690 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965786AbeCGTyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:54:00 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="26071900"
Date: Wed, 7 Mar 2018 11:46:29 -0800
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 1/4] x86/devicetree: Initialize device tree before using it
Message-ID: <c8c7e941efc63b5d25ebf9b6350b0f3df38f6098.1520450752.git.ivan.gorinov@intel.com>
References: <cover.1520450752.git.ivan.gorinov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520450752.git.ivan.gorinov@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 08d53aa58cb162e6 ("of/fdt: export fdt blob as /sys/firmware/fdt")
adds CRC32 calculation in early_init_dt_verify() and checking in late
initcall of_fdt_raw_init(), making early_init_dt_verify() mandatory.
Required call to early_init_dt_verify() was not added to the x86-specific
implementation, causing failure to create sysfs entry in of_fdt_raw_init().

Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
---
 arch/x86/kernel/devicetree.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 25de5f6..63d2ebc 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -11,6 +11,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
+#include <linux/libfdt.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/of_pci.h>
@@ -270,14 +271,15 @@ static void __init x86_flattree_get_config(void)
 
 	map_len = max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
 
-	initial_boot_params = dt = early_memremap(initial_dtb, map_len);
-	size = of_get_flat_dt_size();
+	dt = early_memremap(initial_dtb, map_len);
+	size = fdt_totalsize(dt);
 	if (map_len < size) {
 		early_memunmap(dt, map_len);
-		initial_boot_params = dt = early_memremap(initial_dtb, size);
+		dt = early_memremap(initial_dtb, size);
 		map_len = size;
 	}
 
+	early_init_dt_verify(dt);
 	unflatten_and_copy_device_tree();
 	early_memunmap(dt, map_len);
 }
-- 
2.7.4
