Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933970AbeBMJGv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:06:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52159 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933775AbeBMJGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:06:44 -0500
Date: Tue, 13 Feb 2018 01:06:20 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-2cbc0d66de0480449c75636f55697c7ff3af61fc@git.kernel.org>
Cc: linux@dominikbrodowski.net, luto@kernel.org, hpa@zytor.com,
        dsafonov@virtuozzo.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        peterz@infradead.org
Reply-To: tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        dsafonov@virtuozzo.com, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, luto@kernel.org
In-Reply-To: <20180211111013.16888-4-linux@dominikbrodowski.net>
References: <20180211111013.16888-4-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] selftests/x86: Do not rely on "int $0x80" in
 test_mremap_vdso.c
Git-Commit-ID: 2cbc0d66de0480449c75636f55697c7ff3af61fc
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

Commit-ID:  2cbc0d66de0480449c75636f55697c7ff3af61fc
Gitweb:     https://git.kernel.org/tip/2cbc0d66de0480449c75636f55697c7ff3af61fc
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Sun, 11 Feb 2018 12:10:11 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 09:05:37 +0100

selftests/x86: Do not rely on "int $0x80" in test_mremap_vdso.c

On 64-bit builds, we should not rely on "int $0x80" working (it only does if
CONFIG_IA32_EMULATION=y is enabled).

Without this patch, the move test may succeed, but the "int $0x80" causes
a segfault, resulting in a false negative output of this self-test.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org
Link: http://lkml.kernel.org/r/20180211111013.16888-4-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/test_mremap_vdso.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
index bf0d687..64f11c8 100644
--- a/tools/testing/selftests/x86/test_mremap_vdso.c
+++ b/tools/testing/selftests/x86/test_mremap_vdso.c
@@ -90,8 +90,12 @@ int main(int argc, char **argv, char **envp)
 			vdso_size += PAGE_SIZE;
 		}
 
+#ifdef __i386__
 		/* Glibc is likely to explode now - exit with raw syscall */
 		asm volatile ("int $0x80" : : "a" (__NR_exit), "b" (!!ret));
+#else /* __x86_64__ */
+		syscall(SYS_exit, ret);
+#endif
 	} else {
 		int status;
 
