Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D40FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B400C2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B400C2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeH3NAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:00:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:52785 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbeH3NAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:00:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 01:58:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="228840483"
Received: from shbuild888.sh.intel.com ([10.239.146.239])
  by orsmga004.jf.intel.com with ESMTP; 30 Aug 2018 01:58:54 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH] x86, mm: Reserver some memory for bootmem allocator for NO_BOOTMEM
Date:   Thu, 30 Aug 2018 17:03:19 +0800
Message-Id: <20180830090319.985-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We hit a kernel panic when enabling earlycon for a platform, the
call trace is:

	  panic+0xd2/0x220
	  __alloc_bootmem+0x31/0x34
	  spp_getpage+0x60/0x8a
	  fill_pte+0x71/0x130
	  __set_pte_vaddr+0x1d/0x50
	  set_pte_vaddr+0x3c/0x60
	  __native_set_fixmap+0x23/0x30
	  native_set_fixmap+0x30/0x40
	  setup_earlycon+0x1e0/0x32f
	  param_setup_earlycon+0x13/0x22
	  do_early_param+0x5b/0x90
	  parse_args+0x1f7/0x300
	  parse_early_options+0x24/0x28
	  parse_early_param+0x65/0x73
	  setup_arch+0x31e/0x9f1
	  start_kernel+0x58/0x44e

The root cause is that when CONFIG_NO_BOOTMEM=y,  before
e820__memblock_setup() is called there is no memory for bootmem
to allocate, and any alloc_bootmem() in this time window will
trigger a panic. Seems this is a known issue as already
mentioned in arch/x86/kernel/setup.c:
	"
	/* after early param, so could get panic from serial */
	memblock_x86_reserve_range_setup_data();
	"
By reserving some memory in the linker script, small memory request
could be fulfilled by bootmem allocator. And this memory region
is not wasted, but usable after kernel boot.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/include/asm/sections.h |  5 +++++
 arch/x86/kernel/setup.c         | 12 +++++++++++-
 arch/x86/kernel/vmlinux.lds.S   |  9 +++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 4a911a382ade..d568829510e4 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -9,6 +9,11 @@ extern char __brk_base[], __brk_limit[];
 extern struct exception_table_entry __stop___ex_table[];
 extern char __end_rodata_aligned[];
 
+#ifdef CONFIG_NO_BOOTMEM
+extern char __bootmem_start[], __bootmem_end[];
+#endif
+
+
 #if defined(CONFIG_X86_64)
 extern char __end_rodata_hpage_align[];
 extern char __entry_trampoline_start[], __entry_trampoline_end[];
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index b4866badb235..a4e3d9ec1a83 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -829,6 +829,17 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	memblock_reserve(0, PAGE_SIZE);
 
+#ifdef CONFIG_NO_BOOTMEM
+	/*
+	 * There is small time window till e820__memblock_setup() is
+	 * called, in which __bootmem_alloc() has no available memory
+	 * to allocate and will trigger panic. Adding this revered bootmem
+	 * can alleviate the situation.
+	 */
+	memblock_add(__pa_symbol(__bootmem_start),
+			__bootmem_end - __bootmem_start);
+#endif
+
 	early_reserve_initrd();
 
 	/*
@@ -989,7 +1000,6 @@ void __init setup_arch(char **cmdline_p)
 
 	x86_report_nx();
 
-	/* after early param, so could get panic from serial */
 	memblock_x86_reserve_range_setup_data();
 
 	if (acpi_mps_check()) {
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 8bde0a419f86..fec1965d668f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -367,6 +367,15 @@ SECTIONS
 		__brk_limit = .;
 	}
 
+#ifdef CONFIG_NO_BOOTMEM
+	. = ALIGN(PAGE_SIZE);
+	.bootmem : AT(ADDR(.bootmem) - LOAD_OFFSET) {
+		__bootmem_start = .;
+		. += 128 * 1024;		/* 128 KB for early boot mem */
+		__bootmem_end = .;
+	}
+#endif
+
 	. = ALIGN(PAGE_SIZE);		/* keep VO_INIT_SIZE page aligned */
 	_end = .;
 
-- 
2.14.1

