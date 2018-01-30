Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753530AbeA3Wj7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:39:59 -0500
Received: from terminus.zytor.com ([65.50.211.136]:54449 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752812AbeA3Wj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:39:57 -0500
Date: Tue, 30 Jan 2018 14:36:49 -0800
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-c7f631cb07e7da06ac1d231ca178452339e32a94@git.kernel.org>
Cc: dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        luto@kernel.org, tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        keescook@chromium.org
Reply-To: keescook@chromium.org, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        luto@kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <151727417469.33451.11804043010080838495.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151727417469.33451.11804043010080838495.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/get_user: Use pointer masking to limit
 speculation
Git-Commit-ID: c7f631cb07e7da06ac1d231ca178452339e32a94
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

Commit-ID:  c7f631cb07e7da06ac1d231ca178452339e32a94
Gitweb:     https://git.kernel.org/tip/c7f631cb07e7da06ac1d231ca178452339e32a94
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Mon, 29 Jan 2018 17:02:54 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 21:54:31 +0100

x86/get_user: Use pointer masking to limit speculation

Quoting Linus:

    I do think that it would be a good idea to very expressly document
    the fact that it's not that the user access itself is unsafe. I do
    agree that things like "get_user()" want to be protected, but not
    because of any direct bugs or problems with get_user() and friends,
    but simply because get_user() is an excellent source of a pointer
    that is obviously controlled from a potentially attacking user
    space. So it's a prime candidate for then finding _subsequent_
    accesses that can then be used to perturb the cache.

Unlike the __get_user() case get_user() includes the address limit check
near the pointer de-reference. With that locality the speculation can be
mitigated with pointer narrowing rather than a barrier, i.e.
array_index_nospec(). Where the narrowing is performed by:

	cmp %limit, %ptr
	sbb %mask, %mask
	and %mask, %ptr

With respect to speculation the value of %ptr is either less than %limit
or NULL.

Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727417469.33451.11804043010080838495.stgit@dwillia2-desk3.amr.corp.intel.com

---
 arch/x86/lib/getuser.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index c97d935..49b167f 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -40,6 +40,8 @@ ENTRY(__get_user_1)
 	mov PER_CPU_VAR(current_task), %_ASM_DX
 	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 1:	movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -54,6 +56,8 @@ ENTRY(__get_user_2)
 	mov PER_CPU_VAR(current_task), %_ASM_DX
 	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 2:	movzwl -1(%_ASM_AX),%edx
 	xor %eax,%eax
@@ -68,6 +72,8 @@ ENTRY(__get_user_4)
 	mov PER_CPU_VAR(current_task), %_ASM_DX
 	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 3:	movl -3(%_ASM_AX),%edx
 	xor %eax,%eax
@@ -83,6 +89,8 @@ ENTRY(__get_user_8)
 	mov PER_CPU_VAR(current_task), %_ASM_DX
 	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 4:	movq -7(%_ASM_AX),%rdx
 	xor %eax,%eax
@@ -94,6 +102,8 @@ ENTRY(__get_user_8)
 	mov PER_CPU_VAR(current_task), %_ASM_DX
 	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user_8
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 4:	movl -7(%_ASM_AX),%edx
 5:	movl -3(%_ASM_AX),%ecx
