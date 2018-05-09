Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934758AbeEILtM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:49:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:26332 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934508AbeEILpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:45:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="54445849"
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
Subject: [PATCH RFC 02/19] kallsyms, x86: Export addresses of syscall trampolines
Date: Wed,  9 May 2018 14:43:31 +0300
Message-Id: <1525866228-30321-3-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/mm/cpu_entry_area.c | 23 +++++++++++++++++++++++
 kernel/kallsyms.c            | 28 +++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index b45f5aaefd74..d1da5cf4b2de 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -2,6 +2,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/percpu.h>
+#include <linux/kallsyms.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/pgtable.h>
@@ -150,6 +151,28 @@ static void __init setup_cpu_entry_area(int cpu)
 	percpu_setup_debug_store(cpu);
 }
 
+#ifdef CONFIG_X86_64
+int arch_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
+		     char *name)
+{
+	unsigned int cpu, ncpu;
+
+	if (symnum >= num_possible_cpus())
+		return -EINVAL;
+
+	for (cpu = cpumask_first(cpu_possible_mask), ncpu = 0;
+	     cpu < num_possible_cpus() && ncpu < symnum;
+	     cpu = cpumask_next(cpu, cpu_possible_mask), ncpu++)
+		;
+
+	*value = (unsigned long)&get_cpu_entry_area(cpu)->entry_trampoline;
+	*type = 't';
+	strlcpy(name, "__entry_SYSCALL_64_trampoline", KSYM_NAME_LEN);
+
+	return 0;
+}
+#endif
+
 static __init void setup_cpu_entry_area_ptes(void)
 {
 #ifdef CONFIG_X86_32
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index eda4b0222dab..ebe6befac47e 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -432,6 +432,7 @@ int sprint_backtrace(char *buffer, unsigned long address)
 /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
 struct kallsym_iter {
 	loff_t pos;
+	loff_t pos_arch_end;
 	loff_t pos_mod_end;
 	loff_t pos_ftrace_mod_end;
 	unsigned long value;
@@ -443,9 +444,29 @@ struct kallsym_iter {
 	int show_value;
 };
 
+int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
+			    char *type, char *name)
+{
+	return -EINVAL;
+}
+
+static int get_ksymbol_arch(struct kallsym_iter *iter)
+{
+	int ret = arch_get_kallsym(iter->pos - kallsyms_num_syms,
+				   &iter->value, &iter->type,
+				   iter->name);
+
+	if (ret < 0) {
+		iter->pos_arch_end = iter->pos;
+		return 0;
+	}
+
+	return 1;
+}
+
 static int get_ksymbol_mod(struct kallsym_iter *iter)
 {
-	int ret = module_get_kallsym(iter->pos - kallsyms_num_syms,
+	int ret = module_get_kallsym(iter->pos - iter->pos_arch_end,
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
 				     &iter->exported);
@@ -501,6 +522,7 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
 	iter->nameoff = get_symbol_offset(new_pos);
 	iter->pos = new_pos;
 	if (new_pos == 0) {
+		iter->pos_arch_end = 0;
 		iter->pos_mod_end = 0;
 		iter->pos_ftrace_mod_end = 0;
 	}
@@ -510,6 +532,10 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 {
 	iter->pos = pos;
 
+	if ((!iter->pos_arch_end || iter->pos_arch_end > pos) &&
+	    get_ksymbol_arch(iter))
+		return 1;
+
 	if ((!iter->pos_mod_end || iter->pos_mod_end > pos) &&
 	    get_ksymbol_mod(iter))
 		return 1;
-- 
1.9.1
