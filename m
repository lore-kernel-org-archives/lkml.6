Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932211AbeCLJ2m (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:28:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36275 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbeCLJ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:28:39 -0400
Date: Mon, 12 Mar 2018 02:27:58 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-a403d798182f4f7be5e9bab56cfa37e9828fd92a@git.kernel.org>
Cc: kirill.shutemov@linux.intel.com, gorcunov@openvz.org,
        keescook@chromium.org, luto@amacapital.net, willy@infradead.org,
        torvalds@linux-foundation.org, andy.shevchenko@gmail.com, bp@suse.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, ebiederm@xmission.com, peterz@infradead.org,
        jgross@suse.com
Reply-To: kirill.shutemov@linux.intel.com, gorcunov@openvz.org,
        luto@amacapital.net, keescook@chromium.org, willy@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, bp@suse.de,
        andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, peterz@infradead.org, ebiederm@xmission.com,
        jgross@suse.com
In-Reply-To: <20180226180451.86788-2-kirill.shutemov@linux.intel.com>
References: <20180226180451.86788-2-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/boot/compressed/64: Describe the logic behind the
 LA57 check
Git-Commit-ID: a403d798182f4f7be5e9bab56cfa37e9828fd92a
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

Commit-ID:  a403d798182f4f7be5e9bab56cfa37e9828fd92a
Gitweb:     https://git.kernel.org/tip/a403d798182f4f7be5e9bab56cfa37e9828fd92a
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 26 Feb 2018 21:04:47 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 09:29:24 +0100

x86/boot/compressed/64: Describe the logic behind the LA57 check

The patch explains the LA57 check in more details.

Tested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180226180451.86788-2-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/pgtable_64.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 3f1697fcc7a8..45c76eff2718 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -18,10 +18,22 @@ struct paging_config paging_prepare(void)
 {
 	struct paging_config paging_config = {};
 
-	/* Check if LA57 is desired and supported */
-	if (IS_ENABLED(CONFIG_X86_5LEVEL) && native_cpuid_eax(0) >= 7 &&
-			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
+	/*
+	 * Check if LA57 is desired and supported.
+	 *
+	 * There are two parts to the check:
+	 *   - if the kernel supports 5-level paging: CONFIG_X86_5LEVEL=y
+	 *   - if the machine supports 5-level paging:
+	 *     + CPUID leaf 7 is supported
+	 *     + the leaf has the feature bit set
+	 *
+	 * That's substitute for boot_cpu_has() in early boot code.
+	 */
+	if (IS_ENABLED(CONFIG_X86_5LEVEL) &&
+			native_cpuid_eax(0) >= 7 &&
+			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
 		paging_config.l5_required = 1;
+	}
 
 	return paging_config;
 }
