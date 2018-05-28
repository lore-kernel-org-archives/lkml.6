Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424430AbeE1LhR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423177AbeE1LM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:12:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Gorinov <ivan.gorinov@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 197/272] x86/devicetree: Initialize device tree before using it
Date: Mon, 28 May 2018 12:03:50 +0200
Message-Id: <20180528100257.158979631@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Gorinov <ivan.gorinov@intel.com>

[ Upstream commit 628df9dc5ad886b0a9b33c75a7b09710eb859ca1 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/devicetree.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

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
@@ -270,14 +271,15 @@ static void __init x86_flattree_get_conf
 
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
