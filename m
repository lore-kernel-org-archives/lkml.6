Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeBBWl0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:41:26 -0500
Received: from terminus.zytor.com ([65.50.211.136]:35541 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeBBWlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:41:17 -0500
Date: Fri, 2 Feb 2018 14:36:48 -0800
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-ebfc15019cfa72496c674ffcb0b8ef10790dcddc@git.kernel.org>
Cc: tglx@linutronix.de, dave.hansen@linux.intel.com, jpoimboe@redhat.com,
        mingo@kernel.org, vbabka@suse.cz, nico@linaro.org, arnd@arndb.de,
        bpetkov@suse.de, luto@kernel.org, hpa@zytor.com, peterz@infradead.org,
        ak@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, dave.hansen@linux.intel.com, jpoimboe@redhat.com,
        tglx@linutronix.de, nico@linaro.org, arnd@arndb.de, vbabka@suse.cz,
        peterz@infradead.org, luto@kernel.org, hpa@zytor.com, bpetkov@suse.de,
        linux-kernel@vger.kernel.org, ak@linux.intel.com
In-Reply-To: <20180202145634.200291-1-arnd@arndb.de>
References: <20180202145634.200291-1-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/dumpstack: Avoid uninitlized variable
Git-Commit-ID: ebfc15019cfa72496c674ffcb0b8ef10790dcddc
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

Commit-ID:  ebfc15019cfa72496c674ffcb0b8ef10790dcddc
Gitweb:     https://git.kernel.org/tip/ebfc15019cfa72496c674ffcb0b8ef10790dcddc
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Fri, 2 Feb 2018 15:56:17 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 2 Feb 2018 23:33:50 +0100

x86/dumpstack: Avoid uninitlized variable

In some configurations, 'partial' does not get initialized, as shown by
this gcc-8 warning:

arch/x86/kernel/dumpstack.c: In function 'show_trace_log_lvl':
arch/x86/kernel/dumpstack.c:156:4: error: 'partial' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    show_regs_if_on_stack(&stack_info, regs, partial);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This initializes it to false, to get the previous behavior in this case.

Fixes: a9cdbe72c4e8 ("x86/dumpstack: Fix partial register dumps")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Link: https://lkml.kernel.org/r/20180202145634.200291-1-arnd@arndb.de

---
 arch/x86/kernel/dumpstack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index afbecff..a2d8a39 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -109,7 +109,7 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	struct stack_info stack_info = {0};
 	unsigned long visit_mask = 0;
 	int graph_idx = 0;
-	bool partial;
+	bool partial = false;
 
 	printk("%sCall Trace:\n", log_lvl);
 
