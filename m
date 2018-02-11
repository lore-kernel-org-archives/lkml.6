Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932404AbeBLBxl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 20:53:41 -0500
Received: from [198.137.202.136] ([198.137.202.136]:54011 "EHLO
        terminus.zytor.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932331AbeBLBxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 20:53:40 -0500
Date: Sun, 11 Feb 2018 04:11:15 -0800
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-c80c5ec1b2fa8d3675fc2a6807a64771ea156698@git.kernel.org>
Cc: bp@suse.de, sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, mingo@kernel.org,
        hpa@zytor.com
Reply-To: tony.luck@intel.com, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        peterz@infradead.org, bp@suse.de
In-Reply-To: <20180210145314.22174-1-bp@alien8.de>
References: <20180210145314.22174-1-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/MCE: Fix build warning introduced by "x86: do
 not use print_symbol()"
Git-Commit-ID: c80c5ec1b2fa8d3675fc2a6807a64771ea156698
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

Commit-ID:  c80c5ec1b2fa8d3675fc2a6807a64771ea156698
Gitweb:     https://git.kernel.org/tip/c80c5ec1b2fa8d3675fc2a6807a64771ea156698
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sat, 10 Feb 2018 15:53:14 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 11 Feb 2018 11:37:39 +0100

x86/MCE: Fix build warning introduced by "x86: do not use print_symbol()"

The following commit:

  7b6061627eb8 ("x86: do not use print_symbol()")

... introduced a new build warning on 32-bit x86:

  arch/x86/kernel/cpu/mcheck/mce.c:237:21: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      pr_cont("{%pS}", (void *)m->ip);
                       ^

Fix the type mismatch between the 'void *' expected by %pS and the mce->ip
field which is u64 by casting to long.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
Fixes: 7b6061627eb8 ("x86: do not use print_symbol()")
Link: http://lkml.kernel.org/r/20180210145314.22174-1-bp@alien8.de
[ Cleaned up the changelog. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 3a8e88a..75f405a 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -234,7 +234,7 @@ static void __print_mce(struct mce *m)
 			m->cs, m->ip);
 
 		if (m->cs == __KERNEL_CS)
-			pr_cont("{%pS}", (void *)m->ip);
+			pr_cont("{%pS}", (void *)(unsigned long)m->ip);
 		pr_cont("\n");
 	}
 
