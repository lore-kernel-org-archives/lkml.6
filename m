Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeCLJbD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:31:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58661 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeCLJbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:31:00 -0400
Date: Mon, 12 Mar 2018 02:30:32 -0700
From: tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-c100a583601d357f923c41af5434dc1f8d07890f@git.kernel.org>
Cc: kirill.shutemov@linux.intel.com, peterz@infradead.org,
        torvalds@linux-foundation.org, bhe@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org
Reply-To: peterz@infradead.org, kirill.shutemov@linux.intel.com,
        tglx@linutronix.de, bhe@redhat.com, torvalds@linux-foundation.org,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180302051801.19594-1-bhe@redhat.com>
References: <20180302051801.19594-1-bhe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] kdump, vmcoreinfo: Export pgtable_l5_enabled value
Git-Commit-ID: c100a583601d357f923c41af5434dc1f8d07890f
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

Commit-ID:  c100a583601d357f923c41af5434dc1f8d07890f
Gitweb:     https://git.kernel.org/tip/c100a583601d357f923c41af5434dc1f8d07890f
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Fri, 2 Mar 2018 13:18:01 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 09:43:56 +0100

kdump, vmcoreinfo: Export pgtable_l5_enabled value

User-space utilities examining crash-kernels need to know if the
crashed kernel was in 5-level paging mode or not.

So write 'pgtable_l5_enabled' to vmcoreinfo, which covers these
three cases:

  pgtable_l5_enabled == 0 when:
   - Compiled with !CONFIG_X86_5LEVEL
   - Compiled with CONFIG_X86_5LEVEL=y while CPU has no 'la57' flag

  pgtable_l5_enabled != 0 when:
   - Compiled with CONFIG_X86_5LEVEL=y and CPU has 'la57' flag

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: douly.fnst@cn.fujitsu.com
Cc: dyoung@redhat.com
Cc: ebiederm@xmission.com
Cc: kirill.shutemov@linux.intel.com
Cc: vgoyal@redhat.com
Link: http://lkml.kernel.org/r/20180302051801.19594-1-bhe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/machine_kexec_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 3b7427aa7d85..02f913cb27b5 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -350,6 +350,7 @@ void arch_crash_save_vmcoreinfo(void)
 {
 	VMCOREINFO_NUMBER(phys_base);
 	VMCOREINFO_SYMBOL(init_top_pgt);
+	VMCOREINFO_NUMBER(pgtable_l5_enabled);
 
 #ifdef CONFIG_NUMA
 	VMCOREINFO_SYMBOL(node_data);
