Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbeCIXQE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 18:16:04 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:47622 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932276AbeCIXQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 18:16:01 -0500
From: Sergei Trofimovich <slyfox@gentoo.org>
To: Tony Luck <tony.luck@intel.com>
Cc: Sergei Trofimovich <slyfox@gentoo.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2, simpler] ia64: fix ptrace(PTRACE_GETREGS) (unbreaks strace, gdb)
Date: Fri,  9 Mar 2018 23:15:55 +0000
Message-Id: <20180309231555.16925-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180211185134.76ccfd45@sf>
References: <20180211185134.76ccfd45@sf>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strace breakage looks like that:
./strace: get_regs: get_regs_error: Input/output error

It happens because ia64 needs to load unwind tables
to read certain registers in 'PTRACE_GETREGS'. Unwind
tables fail to load at kernel startup due to GCC quirk
on the following code (logged as PR 84184):

    extern char __end_unwind[];
    const struct unw_table_entry *end = (struct unw_table_entry *)table_end;
    table->end = segment_base + end[-1].end_offset;

GCC does not generate correct code for this single memory
reference after constant propagation.
Two triggers are required for bad code generation:
- '__end_unwind' has alignment lower (char), than
  'struct unw_table_entry' (8).
- symbol offset is negative.

This commit workarounds it by disabling inline on
init_unwind_table(). This way we avoid const-propagation
of '__end_unwind' and pass address via register.

Tested in ski (emulator) and on rx2600, rx3600 (real hardware).
In case of rx2600 it unbreaks booting.

This patch is a lighter version of patch
https://lkml.org/lkml/2018/2/2/914

CC: Tony Luck <tony.luck@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>
CC: linux-ia64@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Bug: https://github.com/strace/strace/issues/33
Bug: https://gcc.gnu.org/PR84184
Reported-by: Émeric Maschino <emeric.maschino@gmail.com>
Tested-by: stanton_arch@mail.com
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 arch/ia64/kernel/unwind.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/unwind.c b/arch/ia64/kernel/unwind.c
index e04efa088902..a18190bc99a9 100644
--- a/arch/ia64/kernel/unwind.c
+++ b/arch/ia64/kernel/unwind.c
@@ -2078,7 +2078,14 @@ unw_init_from_blocked_task (struct unw_frame_info *info, struct task_struct *t)
 }
 EXPORT_SYMBOL(unw_init_from_blocked_task);
 
-static void
+/*
+ * We use 'noinline' to evade GCC bug https://gcc.gnu.org/PR84184
+ * where gcc code generator emits incorrect code when '__end_unwind'
+ * is const-propagated to 'end[-1].end_offset' and gcc generates
+ * incorrect code. The prigger there is negative offset relative
+ * to externally-defined symbol.
+ */
+noinline static void
 init_unwind_table (struct unw_table *table, const char *name, unsigned long segment_base,
 		   unsigned long gp, const void *table_start, const void *table_end)
 {
-- 
2.16.2
