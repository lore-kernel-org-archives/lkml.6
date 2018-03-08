Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934717AbeCHJEF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:04:05 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48541 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbeCHJD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:03:59 -0500
Date: Thu, 8 Mar 2018 01:03:48 -0800
From: tip-bot for Ivan Gorinov <tipbot@zytor.com>
Message-ID: <tip-628df9dc5ad886b0a9b33c75a7b09710eb859ca1@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, ivan.gorinov@intel.com,
        tglx@linutronix.de, mark.rutland@arm.com, robh+dt@kernel.org,
        mingo@kernel.org
Reply-To: mingo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        ivan.gorinov@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <c8c7e941efc63b5d25ebf9b6350b0f3df38f6098.1520450752.git.ivan.gorinov@intel.com>
References: <c8c7e941efc63b5d25ebf9b6350b0f3df38f6098.1520450752.git.ivan.gorinov@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/devicetree: Initialize device tree before
 using it
Git-Commit-ID: 628df9dc5ad886b0a9b33c75a7b09710eb859ca1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  628df9dc5ad886b0a9b33c75a7b09710eb859ca1
Gitweb:     https://git.kernel.org/tip/628df9dc5ad886b0a9b33c75a7b09710eb859ca1
Author:     Ivan Gorinov <ivan.gorinov@intel.com>
AuthorDate: Wed, 7 Mar 2018 11:46:29 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 09:59:53 +0100

x86/devicetree: Initialize device tree before using it

Commit 08d53aa58cb1 added CRC32 calculation in early_init_dt_verify() and
checking in late initcall of_fdt_raw_init(), making early_init_dt_verify()
mandatory.

The required call to early_init_dt_verify() was not added to the
x86-specific implementation, causing failure to create the sysfs entry in
of_fdt_raw_init().

Fixes: 08d53aa58cb1 ("of/fdt: export fdt blob as /sys/firmware/fdt")
Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Link: https://lkml.kernel.org/r/c8c7e941efc63b5d25ebf9b6350b0f3df38f6098.1520450752.git.ivan.gorinov@intel.com

---
 arch/x86/kernel/devicetree.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 25de5f6ca997..63d2ebc21825 100644
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
