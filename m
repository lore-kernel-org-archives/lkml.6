Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeA3WiR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:38:17 -0500
Received: from terminus.zytor.com ([65.50.211.136]:57129 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeA3WiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:38:15 -0500
Date: Tue, 30 Jan 2018 14:35:59 -0800
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-b5c4ae4f35325d520b230bab6eb3310613b72ac1@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        keescook@chromium.org, mingo@redhat.com, mingo@kernel.org,
        hpa@zytor.com, thomas.lendacky@amd.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        keescook@chromium.org, mingo@redhat.com, mingo@kernel.org,
        hpa@zytor.com, thomas.lendacky@amd.com
In-Reply-To: <151727416438.33451.17309465232057176966.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151727416438.33451.17309465232057176966.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/usercopy: Replace open coded stac/clac with
 __uaccess_{begin, end}
Git-Commit-ID: b5c4ae4f35325d520b230bab6eb3310613b72ac1
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

Commit-ID:  b5c4ae4f35325d520b230bab6eb3310613b72ac1
Gitweb:     https://git.kernel.org/tip/b5c4ae4f35325d520b230bab6eb3310613b72ac1
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Mon, 29 Jan 2018 17:02:44 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 21:54:30 +0100

x86/usercopy: Replace open coded stac/clac with __uaccess_{begin, end}

In preparation for converting some __uaccess_begin() instances to
__uacess_begin_nospec(), make sure all 'from user' uaccess paths are
using the _begin(), _end() helpers rather than open-coded stac() and
clac().

No functional changes.

Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727416438.33451.17309465232057176966.stgit@dwillia2-desk3.amr.corp.intel.com

---
 arch/x86/lib/usercopy_32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
index 1b377f7..de34367 100644
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -331,12 +331,12 @@ do {									\
 
 unsigned long __copy_user_ll(void *to, const void *from, unsigned long n)
 {
-	stac();
+	__uaccess_begin();
 	if (movsl_is_ok(to, from, n))
 		__copy_user(to, from, n);
 	else
 		n = __copy_user_intel(to, from, n);
-	clac();
+	__uaccess_end();
 	return n;
 }
 EXPORT_SYMBOL(__copy_user_ll);
@@ -344,7 +344,7 @@ EXPORT_SYMBOL(__copy_user_ll);
 unsigned long __copy_from_user_ll_nocache_nozero(void *to, const void __user *from,
 					unsigned long n)
 {
-	stac();
+	__uaccess_begin();
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	if (n > 64 && static_cpu_has(X86_FEATURE_XMM2))
 		n = __copy_user_intel_nocache(to, from, n);
@@ -353,7 +353,7 @@ unsigned long __copy_from_user_ll_nocache_nozero(void *to, const void __user *fr
 #else
 	__copy_user(to, from, n);
 #endif
-	clac();
+	__uaccess_end();
 	return n;
 }
 EXPORT_SYMBOL(__copy_from_user_ll_nocache_nozero);
