Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2114C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6868E21471
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9zxOUu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6868E21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJBCbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:31:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbeJBCbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:31:42 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BCD221473;
        Mon,  1 Oct 2018 19:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538423539;
        bh=W48wOt9ALfkgvwdN3JUrj8xmM08Dk0h9bMWKkq7zey8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=f9zxOUu7SQ61l0RYfdZ0k8Uj6dSkkt659iGDFOXPqveo+JeqdpCJOZhfURDca7hng
         u0Crqq4xpAeIM004s4ILHX7Vk2PKhw/jgeeYJgbIHMGGaqtKs6WsSqSVyAOFkRqK41
         fsYSyZ42uGmTnvWYwjZ8/7k0Qnt9bVZQaCAsVmXs=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 2/2] selftests/x86: Add clock_gettime() tests to test_vdso
Date:   Mon,  1 Oct 2018 12:52:16 -0700
Message-Id: <082399674de2619b2befd8c0dde49b260605b126.1538422295.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1538422295.git.luto@kernel.org>
References: <cover.1538422295.git.luto@kernel.org>
In-Reply-To: <cover.1538422295.git.luto@kernel.org>
References: <cover.1538422295.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the vDSO implementation of clock_gettime() is getting
reworked, add a selftest for it.  This tests that its output is
consistent with the syscall version.

This is marked for stable to serve as a test for commit "x86/vdso:
Fix asm constraints on vDSO syscall fallbacks".

Cc: stable@vger.kernel.org
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/test_vdso.c | 99 +++++++++++++++++++++++++
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
-- 
2.17.1

