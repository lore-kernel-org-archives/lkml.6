Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933932AbeBMJFS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:05:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933901AbeBMJEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:04:54 -0500
Date: Tue, 13 Feb 2018 01:04:31 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-198ee8e17502da2634f7366395db1d77630e0219@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, linux@dominikbrodowski.net
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        linux@dominikbrodowski.net, luto@kernel.org, peterz@infradead.org
In-Reply-To: <20180211111013.16888-3-linux@dominikbrodowski.net>
References: <20180211111013.16888-3-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] selftests/x86: Fix vDSO selftest segfault for
 vsyscall=none
Git-Commit-ID: 198ee8e17502da2634f7366395db1d77630e0219
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

Commit-ID:  198ee8e17502da2634f7366395db1d77630e0219
Gitweb:     https://git.kernel.org/tip/198ee8e17502da2634f7366395db1d77630e0219
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Sun, 11 Feb 2018 12:10:10 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 09:04:55 +0100

selftests/x86: Fix vDSO selftest segfault for vsyscall=none

The vDSO selftest tries to execute a vsyscall unconditionally, even if it
is not present on the test system (e.g. if booted with vsyscall=none or
with CONFIG_LEGACY_VSYSCALL_NONE=y set. Fix this by copying (and tweaking)
the vsyscall check from test_vsyscall.c

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org
Link: http://lkml.kernel.org/r/20180211111013.16888-3-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/test_vdso.c | 50 ++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/x86/test_vdso.c b/tools/testing/selftests/x86/test_vdso.c
index 29973cd..558c820 100644
--- a/tools/testing/selftests/x86/test_vdso.c
+++ b/tools/testing/selftests/x86/test_vdso.c
@@ -28,18 +28,52 @@
 
 int nerrs = 0;
 
+typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
+
+getcpu_t vgetcpu;
+getcpu_t vdso_getcpu;
+
+static void *vsyscall_getcpu(void)
+{
 #ifdef __x86_64__
-# define VSYS(x) (x)
+	FILE *maps;
+	char line[128];
+	bool found = false;
+
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps) /* might still be present, but ignore it here, as we test vDSO not vsyscall */
+		return NULL;
+
+	while (fgets(line, sizeof(line), maps)) {
+		char r, x;
+		void *start, *end;
+		char name[128];
+		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
+			   &start, &end, &r, &x, name) != 5)
+			continue;
+
+		if (strcmp(name, "[vsyscall]"))
+			continue;
+
+		/* assume entries are OK, as we test vDSO here not vsyscall */
+		found = true;
+		break;
+	}
+
+	fclose(maps);
+
+	if (!found) {
+		printf("Warning: failed to find vsyscall getcpu\n");
+		return NULL;
+	}
+	return (void *) (0xffffffffff600800);
 #else
-# define VSYS(x) 0
+	return NULL;
 #endif
+}
 
-typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
-
-const getcpu_t vgetcpu = (getcpu_t)VSYS(0xffffffffff600800);
-getcpu_t vdso_getcpu;
 
-void fill_function_pointers()
+static void fill_function_pointers()
 {
 	void *vdso = dlopen("linux-vdso.so.1",
 			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
@@ -54,6 +88,8 @@ void fill_function_pointers()
 	vdso_getcpu = (getcpu_t)dlsym(vdso, "__vdso_getcpu");
 	if (!vdso_getcpu)
 		printf("Warning: failed to find getcpu in vDSO\n");
+
+	vgetcpu = (getcpu_t) vsyscall_getcpu();
 }
 
 static long sys_getcpu(unsigned * cpu, unsigned * node,
