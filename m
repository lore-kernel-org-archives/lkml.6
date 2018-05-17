Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbeEQJXj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:23:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:6649 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750924AbeEQJXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:23:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,409,1520924400";
   d="scan'208";a="41683549"
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
Subject: [PATCH V2 03/20] x86: Add entry trampolines to kcore
Date: Thu, 17 May 2018 12:21:51 +0300
Message-Id: <1526548928-20790-4-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526548928-20790-1-git-send-email-adrian.hunter@intel.com>
References: <1526548928-20790-1-git-send-email-adrian.hunter@intel.com>
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
