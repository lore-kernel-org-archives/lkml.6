Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeDYJI6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:08:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55347 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeDYJI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:08:56 -0400
Date: Wed, 25 Apr 2018 02:08:02 -0700
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-a44ca8f5a30c008b54d07b00eed4eae7f169fcd0@git.kernel.org>
Cc: jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, hughd@google.com, bp@alien8.de,
        arjan@linux.intel.com, luto@kernel.org, aarcange@redhat.com,
        tglx@linutronix.de, jgross@suse.com, keescook@google.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org, namit@vmware.com,
        peterz@infradead.org, dan.j.williams@intel.com, mingo@kernel.org
Reply-To: aarcange@redhat.com, luto@kernel.org, arjan@linux.intel.com,
        bp@alien8.de, hughd@google.com, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, jpoimboe@redhat.com, mingo@kernel.org,
        peterz@infradead.org, dan.j.williams@intel.com, dwmw2@infradead.org,
        namit@vmware.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        keescook@google.com, dave.hansen@linux.intel.com, jgross@suse.com,
        tglx@linutronix.de
In-Reply-To: <20180420222023.1C8B2B20@viggo.jf.intel.com>
References: <20180420222023.1C8B2B20@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pti: Reduce amount of kernel text allowed to be
 Global
Git-Commit-ID: a44ca8f5a30c008b54d07b00eed4eae7f169fcd0
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

Commit-ID:  a44ca8f5a30c008b54d07b00eed4eae7f169fcd0
Gitweb:     https://git.kernel.org/tip/a44ca8f5a30c008b54d07b00eed4eae7f169fcd0
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 20 Apr 2018 15:20:23 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 25 Apr 2018 11:02:50 +0200

x86/pti: Reduce amount of kernel text allowed to be Global

commit abb67605203687c8b7943d760638d0301787f8d9

Kees reported to me that I made too much of the kernel image global.
It was far more than just text:

	I think this is too much set global: _end is after data,
	bss, and brk, and all kinds of other stuff that could
	hold secrets. I think this should match what
	mark_rodata_ro() is doing.

This does exactly that.  We use __end_rodata_hpage_align as our
marker both because it is huge-page-aligned and it does not contain
any sections we expect to hold secrets.

Kees's logic was that r/o data is in the kernel image anyway and,
in the case of traditional distributions, can be freely downloaded
from the web, so there's no reason to hide it.

Fixes: 8c06c7740 (x86/pti: Leave kernel text global for !PCID)
Reported-by: Kees Cook <keescook@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Link: https://lkml.kernel.org/r/20180420222023.1C8B2B20@viggo.jf.intel.com


---
 arch/x86/mm/pti.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index f1fd52f449e0..ae3eb4f5d53b 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -430,12 +430,24 @@ static inline bool pti_kernel_image_global_ok(void)
  */
 void pti_clone_kernel_text(void)
 {
+	/*
+	 * rodata is part of the kernel image and is normally
+	 * readable on the filesystem or on the web.  But, do not
+	 * clone the areas past rodata, they might contain secrets.
+	 */
 	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = ALIGN((unsigned long)_end, PMD_PAGE_SIZE);
+	unsigned long end = (unsigned long)__end_rodata_hpage_align;
 
 	if (!pti_kernel_image_global_ok())
 		return;
 
+	pr_debug("mapping partial kernel image into user address space\n");
+
+	/*
+	 * Note that this will undo _some_ of the work that
+	 * pti_set_kernel_image_nonglobal() did to clear the
+	 * global bit.
+	 */
 	pti_clone_pmds(start, end, _PAGE_RW);
 }
 
@@ -458,8 +470,6 @@ void pti_set_kernel_image_nonglobal(void)
 	if (pti_kernel_image_global_ok())
 		return;
 
-	pr_debug("set kernel image non-global\n");
-
 	set_memory_nonglobal(start, (end - start) >> PAGE_SHIFT);
 }
 
