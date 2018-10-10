Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9A1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8922220645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8922220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJJNfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:35:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:47940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbeJJNfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:35:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E955AF6D;
        Wed, 10 Oct 2018 06:15:00 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-doc@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        corbet@lwn.net, boris.ostrovsky@oracle.com,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH v5 3/3] x86/acpi: take rsdp address for boot params if available
Date:   Wed, 10 Oct 2018 08:14:56 +0200
Message-Id: <20181010061456.22238-4-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181010061456.22238-1-jgross@suse.com>
References: <20181010061456.22238-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the rsdp address in struct boot_params is specified don't try
to find the table by searching, but take the address directly as set
by the boot loader.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3: use a generic retrieval function with a __weak annotated default
    function (Ingo Molnar)

V4: check boot params version before using acpi_rsdp_addr
    use x86_init structure instead of __weak
---
 arch/x86/include/asm/acpi.h | 7 +++++++
 arch/x86/kernel/acpi/boot.c | 6 ++++++
 arch/x86/kernel/x86_init.c  | 3 +--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index a303d7b7d763..2f01eb4d6208 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -142,6 +142,8 @@ static inline u64 acpi_arch_get_root_pointer(void)
 
 void acpi_generic_reduced_hw_init(void);
 
+u64 x86_default_get_root_pointer(void);
+
 #else /* !CONFIG_ACPI */
 
 #define acpi_lapic 0
@@ -153,6 +155,11 @@ static inline void disable_acpi(void) { }
 
 static inline void acpi_generic_reduced_hw_init(void) { }
 
+static inline u64 x86_default_get_root_pointer(void)
+{
+	return 0;
+}
+
 #endif /* !CONFIG_ACPI */
 
 #define ARCH_HAS_POWER_INIT	1
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 3b20607d581b..e8fea7ffa306 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -48,6 +48,7 @@
 #include <asm/mpspec.h>
 #include <asm/smp.h>
 #include <asm/i8259.h>
+#include <asm/setup.h>
 
 #include "sleep.h" /* To include x86_acpi_suspend_lowlevel */
 static int __initdata acpi_force = 0;
@@ -1771,3 +1772,8 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 	e820__range_add(addr, size, E820_TYPE_ACPI);
 	e820__update_table_print();
 }
+
+u64 x86_default_get_root_pointer(void)
+{
+	return boot_params.hdr.acpi_rsdp_addr;
+}
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 2792b5573818..50a2b492fdd6 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -31,7 +31,6 @@ static int __init iommu_init_noop(void) { return 0; }
 static void iommu_shutdown_noop(void) { }
 static bool __init bool_x86_init_noop(void) { return false; }
 static void x86_op_int_noop(int cpu) { }
-static u64 u64_x86_init_noop(void) { return 0; }
 
 /*
  * The platform setup functions are preset with the default functions
@@ -96,7 +95,7 @@ struct x86_init_ops x86_init __initdata = {
 	},
 
 	.acpi = {
-		.get_root_pointer	= u64_x86_init_noop,
+		.get_root_pointer	= x86_default_get_root_pointer,
 		.reduced_hw_early_init	= acpi_generic_reduced_hw_init,
 	},
 };
-- 
2.16.4

