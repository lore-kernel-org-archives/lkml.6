Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753318AbeA3Wi4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:38:56 -0500
Received: from terminus.zytor.com ([65.50.211.136]:33073 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753169AbeA3Wix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:38:53 -0500
Date: Tue, 30 Jan 2018 14:35:34 -0800
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-b3bbfb3fb5d25776b8e3f361d2eedaabb0b496cd@git.kernel.org>
Cc: thomas.lendacky@amd.com, dan.j.williams@intel.com,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        keescook@chromium.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, ak@linux.intel.com, mingo@kernel.org,
        mingo@redhat.com
Reply-To: tglx@linutronix.de, ak@linux.intel.com, mingo@kernel.org,
        mingo@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, dan.j.williams@intel.com,
        thomas.lendacky@amd.com
In-Reply-To: <151727415922.33451.5796614273104346583.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151727415922.33451.5796614273104346583.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86: Introduce __uaccess_begin_nospec() and
 uaccess_try_nospec
Git-Commit-ID: b3bbfb3fb5d25776b8e3f361d2eedaabb0b496cd
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

Commit-ID:  b3bbfb3fb5d25776b8e3f361d2eedaabb0b496cd
Gitweb:     https://git.kernel.org/tip/b3bbfb3fb5d25776b8e3f361d2eedaabb0b496cd
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Mon, 29 Jan 2018 17:02:39 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 21:54:30 +0100

x86: Introduce __uaccess_begin_nospec() and uaccess_try_nospec

For __get_user() paths, do not allow the kernel to speculate on the value
of a user controlled pointer. In addition to the 'stac' instruction for
Supervisor Mode Access Protection (SMAP), a barrier_nospec() causes the
access_ok() result to resolve in the pipeline before the CPU might take any
speculative action on the pointer value. Given the cost of 'stac' the
speculation barrier is placed after 'stac' to hopefully overlap the cost of
disabling SMAP with the cost of flushing the instruction pipeline.

Since __get_user is a major kernel interface that deals with user
controlled pointers, the __uaccess_begin_nospec() mechanism will prevent
speculative execution past an access_ok() permission check. While
speculative execution past access_ok() is not enough to lead to a kernel
memory leak, it is a necessary precondition.

To be clear, __uaccess_begin_nospec() is addressing a class of potential
problems near __get_user() usages.

Note, that while the barrier_nospec() in __uaccess_begin_nospec() is used
to protect __get_user(), pointer masking similar to array_index_nospec()
will be used for get_user() since it incorporates a bounds check near the
usage.

uaccess_try_nospec provides the same mechanism for get_user_try.

No functional changes.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727415922.33451.5796614273104346583.stgit@dwillia2-desk3.amr.corp.intel.com

---
 arch/x86/include/asm/uaccess.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 574dff4..663e9bd 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -124,6 +124,11 @@ extern int __get_user_bad(void);
 
 #define __uaccess_begin() stac()
 #define __uaccess_end()   clac()
+#define __uaccess_begin_nospec()	\
+({					\
+	stac();				\
+	barrier_nospec();		\
+})
 
 /*
  * This is a type: either unsigned long, if the argument fits into
@@ -487,6 +492,10 @@ struct __large_struct { unsigned long buf[100]; };
 	__uaccess_begin();						\
 	barrier();
 
+#define uaccess_try_nospec do {						\
+	current->thread.uaccess_err = 0;				\
+	__uaccess_begin_nospec();					\
+
 #define uaccess_catch(err)						\
 	__uaccess_end();						\
 	(err) |= (current->thread.uaccess_err ? -EFAULT : 0);		\
