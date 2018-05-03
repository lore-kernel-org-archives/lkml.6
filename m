Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeECXjM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 19:39:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56355 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeECXjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 19:39:11 -0400
To: ying.huang@intel.com, hpa@zytor.com, mingo@elte.hu, mingo@redhat.com,
        syzbot+d96f60296ef613fe1d69@syzkaller.appspotmail.com
Cc: kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        bhe@redhat.com, dyoung@redhat.com, linux-kernel@vger.kernel.org,
        prudo@linux.vnet.ibm.com, syzkaller-bugs@googlegroups.com,
        takahiro.akashi@linaro.org, tglx@linutronix.de,
        thomas.lendacky@amd.com, x86@kernel.org, xlpang@redhat.com
Subject: [PATCH v2] x86/kexec: avoid double free_page() upon do_kexec_load() failure.
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <0000000000005dbad8056b20cabc@google.com>
        <000000000000000722056b538b68@google.com>
In-Reply-To: <000000000000000722056b538b68@google.com>
Message-Id: <201805040838.JJI05295.FSVMOHFLFQJOtO@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Fri, 4 May 2018 08:38:11 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From 91a78abed036e1662b11cb54ae6300864e17b709 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Fri, 4 May 2018 08:26:41 +0900
Subject: [PATCH v2] x86/kexec: avoid double free_page() upon do_kexec_load() failure.

syzbot is reporting crashes after memory allocation failure inside
do_kexec_load() [1]. This is because free_transition_pgtable() is called
by both init_transition_pgtable() and machine_kexec_cleanup() when memory
allocation failed inside init_transition_pgtable().

Regarding 32bit code, machine_kexec_free_page_tables() is called by both
machine_kexec_alloc_page_tables() and machine_kexec_cleanup() when memory
allocation failed inside machine_kexec_alloc_page_tables().

Fix this by leaving the error handling to machine_kexec_cleanup().

[1] https://syzkaller.appspot.com/bug?id=91e52396168cf2bdd572fe1e1bc0bc645c1c6b40

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+d96f60296ef613fe1d69@syzkaller.appspotmail.com>
Fixes: f5deb79679af6eb4 ("x86: kexec: Use one page table in x86_64 machine_kexec")
Fixes: 92be3d6bdf2cb349 ("kexec/i386: allocate page table pages dynamically")
Cc: Huang Ying <ying.huang@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@elte.hu>
---
 arch/x86/kernel/machine_kexec_32.c | 1 -
 arch/x86/kernel/machine_kexec_64.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 60cdec6..170fbf8 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -79,7 +79,6 @@ static int machine_kexec_alloc_page_tables(struct kimage *image)
 	    !image->arch.pmd0 || !image->arch.pmd1 ||
 #endif
 	    !image->arch.pte0 || !image->arch.pte1) {
-		machine_kexec_free_page_tables(image);
 		return -ENOMEM;
 	}
 	return 0;
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a5e55d8..ffe0174 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -91,7 +91,6 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL_EXEC_NOENC));
 	return 0;
 err:
-	free_transition_pgtable(image);
 	return result;
 }
 
-- 
1.8.3.1
