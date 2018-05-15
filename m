Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeEOMpB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:45:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:14385 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752540AbeEOMo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:44:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="41390856"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH V1 03/19] x86: Add entry trampolines to kcore
Date: Tue, 15 May 2018 15:43:17 +0300
Message-Id: <1526388213-30696-4-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
References: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/mm/cpu_entry_area.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index d1da5cf4b2de..fb1fbc8538fa 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -3,6 +3,7 @@
 #include <linux/spinlock.h>
 #include <linux/percpu.h>
 #include <linux/kallsyms.h>
+#include <linux/kcore.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/pgtable.h>
@@ -14,6 +15,7 @@
 #ifdef CONFIG_X86_64
 static DEFINE_PER_CPU_PAGE_ALIGNED(char, exception_stacks
 	[(N_EXCEPTION_STACKS - 1) * EXCEPTION_STKSZ + DEBUG_STKSZ]);
+static DEFINE_PER_CPU(struct kcore_list, kcore_entry_trampoline);
 #endif
 
 struct cpu_entry_area *get_cpu_entry_area(int cpu)
@@ -147,6 +149,9 @@ static void __init setup_cpu_entry_area(int cpu)
 
 	cea_set_pte(&get_cpu_entry_area(cpu)->entry_trampoline,
 		     __pa_symbol(_entry_trampoline), PAGE_KERNEL_RX);
+	kclist_add(&per_cpu(kcore_entry_trampoline, cpu),
+		   &get_cpu_entry_area(cpu)->entry_trampoline, PAGE_SIZE,
+		   KCORE_TEXT);
 #endif
 	percpu_setup_debug_store(cpu);
 }
-- 
1.9.1
