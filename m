Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeBJOxr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 09:53:47 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58758 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751145AbeBJOxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 09:53:44 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH] x86/MCE: Cast rIP to respective width before printing
Date: Sat, 10 Feb 2018 15:53:14 +0100
Message-Id: <20180210145314.22174-1-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

7b6061627eb8 ("x86: do not use print_symbol()") got rid of
print_symbol() uses in favor of passing a %pS format specifier to
printk() in order to print "symbolic direct pointers with offset".

We use this to print the RIP as part of the MCE record. And %pS requires
a void *.

However, mce.ip is u64 and casting it to a void * on 32-bit rightfully
warns:

  arch/x86/kernel/cpu/mcheck/mce.c:237:21: warning: cast to pointer from integer \
	  of different size [-Wint-to-pointer-cast]
      pr_cont("{%pS}", (void *)m->ip);
                       ^

about the size mismatch.

So cast the RIP to the machine-specific unsigned long address width
first.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Fixes: 7b6061627eb8 ("x86: do not use print_symbol()")
---
 arch/x86/kernel/cpu/mcheck/mce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 3a8e88a611eb..75f405ac085c 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -234,7 +234,7 @@ static void __print_mce(struct mce *m)
 			m->cs, m->ip);
 
 		if (m->cs == __KERNEL_CS)
-			pr_cont("{%pS}", (void *)m->ip);
+			pr_cont("{%pS}", (void *)(unsigned long)m->ip);
 		pr_cont("\n");
 	}
 
-- 
2.13.0
