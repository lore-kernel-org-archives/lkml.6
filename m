Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933947AbeBMJF2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:05:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45681 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933860AbeBMJFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:05:20 -0500
Date: Tue, 13 Feb 2018 01:04:58 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-d8e92de8ef952bed88c56c7a44c02d8dcae0984e@git.kernel.org>
Cc: luto@kernel.org, linux@dominikbrodowski.net,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: luto@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, torvalds@linux-foundation.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20180211205924.GA23210@light.dominikbrodowski.net>
References: <20180211205924.GA23210@light.dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] selftests/x86: Clean up and document sscanf() usage
Git-Commit-ID: d8e92de8ef952bed88c56c7a44c02d8dcae0984e
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

Commit-ID:  d8e92de8ef952bed88c56c7a44c02d8dcae0984e
Gitweb:     https://git.kernel.org/tip/d8e92de8ef952bed88c56c7a44c02d8dcae0984e
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Sun, 11 Feb 2018 21:59:24 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 09:04:56 +0100

selftests/x86: Clean up and document sscanf() usage

Replace a couple of magically connected buffer length literal constants with
a common definition that makes their relationship obvious. Also document
why our sscanf() usage is safe.

No intended functional changes.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org
Link: http://lkml.kernel.org/r/20180211205924.GA23210@light.dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/test_vdso.c     | 11 ++++++++---
 tools/testing/selftests/x86/test_vsyscall.c | 11 ++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/x86/test_vdso.c b/tools/testing/selftests/x86/test_vdso.c
index 558c820..2352590 100644
--- a/tools/testing/selftests/x86/test_vdso.c
+++ b/tools/testing/selftests/x86/test_vdso.c
@@ -26,6 +26,9 @@
 # endif
 #endif
 
+/* max length of lines in /proc/self/maps - anything longer is skipped here */
+#define MAPS_LINE_LEN 128
+
 int nerrs = 0;
 
 typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
@@ -37,17 +40,19 @@ static void *vsyscall_getcpu(void)
 {
 #ifdef __x86_64__
 	FILE *maps;
-	char line[128];
+	char line[MAPS_LINE_LEN];
 	bool found = false;
 
 	maps = fopen("/proc/self/maps", "r");
 	if (!maps) /* might still be present, but ignore it here, as we test vDSO not vsyscall */
 		return NULL;
 
-	while (fgets(line, sizeof(line), maps)) {
+	while (fgets(line, MAPS_LINE_LEN, maps)) {
 		char r, x;
 		void *start, *end;
-		char name[128];
+		char name[MAPS_LINE_LEN];
+
+		/* sscanf() is safe here as strlen(name) >= strlen(line) */
 		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
 			   &start, &end, &r, &x, name) != 5)
 			continue;
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 7a744fa..be81621 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -33,6 +33,9 @@
 # endif
 #endif
 
+/* max length of lines in /proc/self/maps - anything longer is skipped here */
+#define MAPS_LINE_LEN 128
+
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -98,7 +101,7 @@ static int init_vsys(void)
 #ifdef __x86_64__
 	int nerrs = 0;
 	FILE *maps;
-	char line[128];
+	char line[MAPS_LINE_LEN];
 	bool found = false;
 
 	maps = fopen("/proc/self/maps", "r");
@@ -108,10 +111,12 @@ static int init_vsys(void)
 		return 0;
 	}
 
-	while (fgets(line, sizeof(line), maps)) {
+	while (fgets(line, MAPS_LINE_LEN, maps)) {
 		char r, x;
 		void *start, *end;
-		char name[128];
+		char name[MAPS_LINE_LEN];
+
+		/* sscanf() is safe here as strlen(name) >= strlen(line) */
 		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
 			   &start, &end, &r, &x, name) != 5)
 			continue;
