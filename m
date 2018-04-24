Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeDXPjq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:39:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55564 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750935AbeDXPjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:39:45 -0400
Date: Tue, 24 Apr 2018 10:39:43 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Namhyung Kim <namhyung@kernel.org>, Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Michal Marek <mmarek@suse.cz>
Subject: [PATCH v2] arm64/kernel: rename
 module_emit_adrp_veneer->module_emit_veneer_for_adrp
Message-Id: <20180424103943.453d3449bbe2b35b86cc3443@arm.com>
In-Reply-To: <CAKv+Gu_LJB1Zkg26kCcAUs6eAcZFpX4LUnWuEhjo8OA=83fz+A@mail.gmail.com>
References: <20180416042240.21528-1-namhyung@kernel.org>
        <20180416092345.GA23274@krava>
        <20180416135125.GA23802@kernel.org>
        <20180416110730.1dd12801e43be66ea5d0cc48@arm.com>
        <20180416165800.GD3202@kernel.org>
        <20180416122407.0d90863b69fed80166384850@arm.com>
        <20180416174811.1aca9106364effe435f363c8@arm.com>
        <20180417022726.GA31947@sejong>
        <20180418193759.b63912fe5e5b8a9023ec80a8@arm.com>
        <20180419025424.GC13370@sejong>
        <20180419183313.db3e3a105191a7f30b7650b2@arm.com>
        <CAKv+Gu_sY+Q+kqO1hp6f30WSGNPY1cnW5VJYj9cuVA0hU5YDVw@mail.gmail.com>
        <20180423164317.5a47f3dd9842d533413a1d4b@arm.com>
        <CAKv+Gu-u1E9gH7=p5sbiA4k_9mQ13y+056nYKnr2D9BPENNyMg@mail.gmail.com>
        <20180424075003.48ab0015efc0892832343546@arm.com>
        <CAKv+Gu-Y8D3Se7yc+8LifMmSAmURj4ZYBwVAbdkL-Krr_=1K3A@mail.gmail.com>
        <20180424101302.922f38032a32ee2034ccfc05@arm.com>
        <CAKv+Gu_LJB1Zkg26kCcAUs6eAcZFpX4LUnWuEhjo8OA=83fz+A@mail.gmail.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a257e02579e ("arm64/kernel: don't ban ADRP to work around
Cortex-A53 erratum #843419") introduced a function whose name ends with
"_veneer".

This clashes with commit bd8b22d2888e ("Kbuild: kallsyms: ignore veneers
emitted by the ARM linker"), which removes symbols ending in "_veneer"
from kallsyms.

The problem was manifested as 'perf test -vvvvv vmlinux' failed,
correctly claiming the symbol 'module_emit_adrp_veneer' was present in
vmlinux, but not in kallsyms.

...
    ERR : 0xffff00000809aa58: module_emit_adrp_veneer not on kallsyms
...
    test child finished with -1
    ---- end ----
    vmlinux symtab matches kallsyms: FAILED!

Fix the problem by renaming module_emit_adrp_veneer to 
module_emit_veneer_for_adrp.  Now the test passes.

Fixes: a257e02579e ("arm64/kernel: don't ban ADRP to work around Cortex-A53 erratum #843419")
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Michal Marek <mmarek@suse.cz>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
v2: fixed naming and wording of last sentence in commit text.

 arch/arm64/include/asm/module.h | 2 +-
 arch/arm64/kernel/module-plts.c | 2 +-
 arch/arm64/kernel/module.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index b6dbbe3123a9..97d0ef12e2ff 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -39,7 +39,7 @@ struct mod_arch_specific {
 u64 module_emit_plt_entry(struct module *mod, void *loc, const Elf64_Rela *rela,
 			  Elf64_Sym *sym);
 
-u64 module_emit_adrp_veneer(struct module *mod, void *loc, u64 val);
+u64 module_emit_veneer_for_adrp(struct module *mod, void *loc, u64 val);
 
 #ifdef CONFIG_RANDOMIZE_BASE
 extern u64 module_alloc_base;
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index fa3637284a3d..f0690c2ca3e0 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -43,7 +43,7 @@ u64 module_emit_plt_entry(struct module *mod, void *loc, const Elf64_Rela *rela,
 }
 
 #ifdef CONFIG_ARM64_ERRATUM_843419
-u64 module_emit_adrp_veneer(struct module *mod, void *loc, u64 val)
+u64 module_emit_veneer_for_adrp(struct module *mod, void *loc, u64 val)
 {
 	struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
 							  &mod->arch.init;
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 719fde8dcc19..155fd91e78f4 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -215,7 +215,7 @@ static int reloc_insn_adrp(struct module *mod, __le32 *place, u64 val)
 		insn &= ~BIT(31);
 	} else {
 		/* out of range for ADR -> emit a veneer */
-		val = module_emit_adrp_veneer(mod, place, val & ~0xfff);
+		val = module_emit_veneer_for_adrp(mod, place, val & ~0xfff);
 		if (!val)
 			return -ENOEXEC;
 		insn = aarch64_insn_gen_branch_imm((u64)place, val,
-- 
2.17.0
