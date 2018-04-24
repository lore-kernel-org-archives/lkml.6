Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756552AbeDXINY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:13:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33817 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756176AbeDXINS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:13:18 -0400
Date: Tue, 24 Apr 2018 01:06:54 -0700
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-16dce603adc9de4237b7bf2ff5c5290f34373e7b@git.kernel.org>
Cc: luto@kernel.org, keescook@google.com, dan.j.williams@intel.com,
        namit@vmware.com, jpoimboe@redhat.com, arjan@linux.intel.com,
        tglx@linutronix.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, aarcange@redhat.com, bp@alien8.de,
        aaro.koskinen@nokia.com, hpa@zytor.com, mingo@kernel.org,
        peterz@infradead.org, dwmw2@infradead.org, jgross@suse.com,
        mceier@gmail.com, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, hughd@google.com
Reply-To: linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        tglx@linutronix.de, peterz@infradead.org, bp@alien8.de,
        aaro.koskinen@nokia.com, hpa@zytor.com, mingo@kernel.org,
        aarcange@redhat.com, jpoimboe@redhat.com, namit@vmware.com,
        dan.j.williams@intel.com, keescook@google.com, luto@kernel.org,
        arjan@linux.intel.com, jgross@suse.com, mceier@gmail.com,
        torvalds@linux-foundation.org, hughd@google.com,
        gregkh@linuxfoundation.org, dwmw2@infradead.org
In-Reply-To: <20180420222019.20C4A410@viggo.jf.intel.com>
References: <20180420222019.20C4A410@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pti: Fix boot problems from Global-bit setting
Git-Commit-ID: 16dce603adc9de4237b7bf2ff5c5290f34373e7b
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

Commit-ID:  16dce603adc9de4237b7bf2ff5c5290f34373e7b
Gitweb:     https://git.kernel.org/tip/16dce603adc9de4237b7bf2ff5c5290f34373e7b
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 20 Apr 2018 15:20:19 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 24 Apr 2018 09:50:53 +0200

x86/pti: Fix boot problems from Global-bit setting

Part of the global bit _setting_ patches also includes clearing the
Global bit when it should not be enabled.  That is done with
set_memory_nonglobal(), which uses change_page_attr_clear() in
pageattr.c under the covers.

The TLB flushing code inside pageattr.c has has checks like
BUG_ON(irqs_disabled()), looking for interrupt disabling that might
cause deadlocks.  But, these also trip in early boot on certain
preempt configurations.  Just copy the existing BUG_ON() sequence from
cpa_flush_range() to the other two sites and check for early boot.

Fixes: 39114b7a7 (x86/pti: Never implicitly clear _PAGE_GLOBAL for kernel image)
Reported-by: Mariusz Ceier <mceier@gmail.com>
Reported-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Kees Cook <keescook@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Link: https://lkml.kernel.org/r/20180420222019.20C4A410@viggo.jf.intel.com

---
 arch/x86/mm/pageattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 0f3d50f4c48c..4fadfd2b7017 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -172,7 +172,7 @@ static void __cpa_flush_all(void *arg)
 
 static void cpa_flush_all(unsigned long cache)
 {
-	BUG_ON(irqs_disabled());
+	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
@@ -236,7 +236,7 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
 	unsigned long do_wbinvd = cache && numpages >= 1024; /* 4M threshold */
 #endif
 
-	BUG_ON(irqs_disabled());
+	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
 	on_each_cpu(__cpa_flush_all, (void *) do_wbinvd, 1);
 
