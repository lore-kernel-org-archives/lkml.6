Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A702AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7B42089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7B42089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeJBNNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:13:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49419 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeJBNNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:13:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w926VPpI1862963
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 1 Oct 2018 23:31:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w926VOsD1862958;
        Mon, 1 Oct 2018 23:31:24 -0700
Date:   Mon, 1 Oct 2018 23:31:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-7c03e7035ac1cf2a6165754e4f3a49c2f1977838@git.kernel.org>
Cc:     mingo@kernel.org, luto@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          luto@kernel.org, mingo@kernel.org
In-Reply-To: <082399674de2619b2befd8c0dde49b260605b126.1538422295.git.luto@kernel.org>
References: <082399674de2619b2befd8c0dde49b260605b126.1538422295.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] selftests/x86: Add clock_gettime() tests to
 test_vdso
Git-Commit-ID: 7c03e7035ac1cf2a6165754e4f3a49c2f1977838
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7c03e7035ac1cf2a6165754e4f3a49c2f1977838
Gitweb:     https://git.kernel.org/tip/7c03e7035ac1cf2a6165754e4f3a49c2f1977838
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Mon, 1 Oct 2018 12:52:16 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 2 Oct 2018 08:28:32 +0200

selftests/x86: Add clock_gettime() tests to test_vdso

Now that the vDSO implementation of clock_gettime() is getting
reworked, add a selftest for it.  This tests that its output is
consistent with the syscall version.

This is marked for stable to serve as a test for commit

  715bd9d12f84 ("x86/vdso: Fix asm constraints on vDSO syscall fallbacks")

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/082399674de2619b2befd8c0dde49b260605b126.1538422295.git.luto@kernel.org
---
 tools/testing/selftests/x86/test_vdso.c | 99 +++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/testing/selftests/x86/test_vdso.c b/tools/testing/selftests/x86/test_vdso.c
index 235259011704..49f7294fb382 100644
--- a/tools/testing/selftests/x86/test_vdso.c
+++ b/tools/testing/selftests/x86/test_vdso.c
@@ -17,6 +17,7 @@
 #include <errno.h>
 #include <sched.h>
 #include <stdbool.h>
+#include <limits.h>
 
 #ifndef SYS_getcpu
 # ifdef __x86_64__
@@ -31,6 +32,10 @@
 
 int nerrs = 0;
 
+typedef int (*vgettime_t)(clockid_t, struct timespec *);
+
+vgettime_t vdso_clock_gettime;
+
 typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
 
 getcpu_t vgetcpu;
@@ -95,6 +100,10 @@ static void fill_function_pointers()
 		printf("Warning: failed to find getcpu in vDSO\n");
 
 	vgetcpu = (getcpu_t) vsyscall_getcpu();
+
+	vdso_clock_gettime = (vgettime_t)dlsym(vdso, "__vdso_clock_gettime");
+	if (!vdso_clock_gettime)
+		printf("Warning: failed to find clock_gettime in vDSO\n");
 }
 
 static long sys_getcpu(unsigned * cpu, unsigned * node,
@@ -103,6 +112,11 @@ static long sys_getcpu(unsigned * cpu, unsigned * node,
 	return syscall(__NR_getcpu, cpu, node, cache);
 }
 
+static inline int sys_clock_gettime(clockid_t id, struct timespec *ts)
+{
+	return syscall(__NR_clock_gettime, id, ts);
+}
+
 static void test_getcpu(void)
 {
 	printf("[RUN]\tTesting getcpu...\n");
@@ -155,10 +169,95 @@ static void test_getcpu(void)
 	}
 }
 
+static bool ts_leq(const struct timespec *a, const struct timespec *b)
+{
+	if (a->tv_sec != b->tv_sec)
+		return a->tv_sec < b->tv_sec;
+	else
+		return a->tv_nsec <= b->tv_nsec;
+}
+
+static char const * const clocknames[] = {
+	[0] = "CLOCK_REALTIME",
+	[1] = "CLOCK_MONOTONIC",
+	[2] = "CLOCK_PROCESS_CPUTIME_ID",
+	[3] = "CLOCK_THREAD_CPUTIME_ID",
+	[4] = "CLOCK_MONOTONIC_RAW",
+	[5] = "CLOCK_REALTIME_COARSE",
+	[6] = "CLOCK_MONOTONIC_COARSE",
+	[7] = "CLOCK_BOOTTIME",
+	[8] = "CLOCK_REALTIME_ALARM",
+	[9] = "CLOCK_BOOTTIME_ALARM",
+	[10] = "CLOCK_SGI_CYCLE",
+	[11] = "CLOCK_TAI",
+};
+
+static void test_one_clock_gettime(int clock, const char *name)
+{
+	struct timespec start, vdso, end;
+	int vdso_ret, end_ret;
+
+	printf("[RUN]\tTesting clock_gettime for clock %s (%d)...\n", name, clock);
+
+	if (sys_clock_gettime(clock, &start) < 0) {
+		if (errno == EINVAL) {
+			vdso_ret = vdso_clock_gettime(clock, &vdso);
+			if (vdso_ret == -EINVAL) {
+				printf("[OK]\tNo such clock.\n");
+			} else {
+				printf("[FAIL]\tNo such clock, but __vdso_clock_gettime returned %d\n", vdso_ret);
+				nerrs++;
+			}
+		} else {
+			printf("[WARN]\t clock_gettime(%d) syscall returned error %d\n", clock, errno);
+		}
+		return;
+	}
+
+	vdso_ret = vdso_clock_gettime(clock, &vdso);
+	end_ret = sys_clock_gettime(clock, &end);
+
+	if (vdso_ret != 0 || end_ret != 0) {
+		printf("[FAIL]\tvDSO returned %d, syscall errno=%d\n",
+		       vdso_ret, errno);
+		nerrs++;
+		return;
+	}
+
+	printf("\t%llu.%09ld %llu.%09ld %llu.%09ld\n",
+	       (unsigned long long)start.tv_sec, start.tv_nsec,
+	       (unsigned long long)vdso.tv_sec, vdso.tv_nsec,
+	       (unsigned long long)end.tv_sec, end.tv_nsec);
+
+	if (!ts_leq(&start, &vdso) || !ts_leq(&vdso, &end)) {
+		printf("[FAIL]\tTimes are out of sequence\n");
+		nerrs++;
+	}
+}
+
+static void test_clock_gettime(void)
+{
+	for (int clock = 0; clock < sizeof(clocknames) / sizeof(clocknames[0]);
+	     clock++) {
+		test_one_clock_gettime(clock, clocknames[clock]);
+	}
+
+	/* Also test some invalid clock ids */
+	test_one_clock_gettime(-1, "invalid");
+	test_one_clock_gettime(INT_MIN, "invalid");
+	test_one_clock_gettime(INT_MAX, "invalid");
+}
+
 int main(int argc, char **argv)
 {
 	fill_function_pointers();
 
+	test_clock_gettime();
+
+	/*
+	 * Test getcpu() last so that, if something goes wrong setting affinity,
+	 * we still run the other tests.
+	 */
 	test_getcpu();
 
 	return nerrs ? 1 : 0;
