Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938932AbeBUR7m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:59:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45543 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933620AbeBUR7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:59:40 -0500
Date: Wed, 21 Feb 2018 09:59:11 -0800
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-b2fbf6f282147b42d669a4bd4a7b1de2e2d6a792@git.kernel.org>
Cc: tony.luck@intel.com, bp@alien8.de, hpa@zytor.com, bp@suse.de,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, tony.luck@intel.com, hpa@zytor.com,
        bp@alien8.de, bp@suse.de, linux-edac@vger.kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180221101900.10326-4-bp@alien8.de>
References: <20180221101900.10326-4-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Issue the 'mcelog --ascii' message only on
 !AMD
Git-Commit-ID: b2fbf6f282147b42d669a4bd4a7b1de2e2d6a792
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

Commit-ID:  b2fbf6f282147b42d669a4bd4a7b1de2e2d6a792
Gitweb:     https://git.kernel.org/tip/b2fbf6f282147b42d669a4bd4a7b1de2e2d6a792
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Wed, 21 Feb 2018 11:18:55 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 17:00:53 +0100

x86/mce: Issue the 'mcelog --ascii' message only on !AMD

mcelog cannot decode AMD MCEs.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180221101900.10326-4-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index db5b1e4..d7dff23 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -268,7 +268,9 @@ static void __print_mce(struct mce *m)
 static void print_mce(struct mce *m)
 {
 	__print_mce(m);
-	pr_emerg_ratelimited(HW_ERR "Run the above through 'mcelog --ascii'\n");
+
+	if (m->cpuvendor != X86_VENDOR_AMD)
+		pr_emerg_ratelimited(HW_ERR "Run the above through 'mcelog --ascii'\n");
 }
 
 #define PANIC_TIMEOUT 5 /* 5 seconds */
