Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE35C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C0021470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C0021470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeJDNOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:14:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34351 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeJDNOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:14:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w946LqmK2638943
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 3 Oct 2018 23:21:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w946Lqmu2638940;
        Wed, 3 Oct 2018 23:21:52 -0700
Date:   Wed, 3 Oct 2018 23:21:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-02e425668f5c9deb42787d10001a3b605993ad15@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, luto@kernel.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, luto@kernel.org, mingo@kernel.org,
          torvalds@linux-foundation.org, tglx@linutronix.de
In-Reply-To: <21bd45ab04b6d838278fa5bebfa9163eceffa13c.1538608971.git.luto@kernel.org>
References: <21bd45ab04b6d838278fa5bebfa9163eceffa13c.1538608971.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/vdso: Fix vDSO syscall fallback asm constraint
 regression
Git-Commit-ID: 02e425668f5c9deb42787d10001a3b605993ad15
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

Commit-ID:  02e425668f5c9deb42787d10001a3b605993ad15
Gitweb:     https://git.kernel.org/tip/02e425668f5c9deb42787d10001a3b605993ad15
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 3 Oct 2018 16:23:49 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 4 Oct 2018 08:17:50 +0200

x86/vdso: Fix vDSO syscall fallback asm constraint regression

When I added the missing memory outputs, I failed to update the
index of the first argument (ebx) on 32-bit builds, which broke the
fallbacks.  Somehow I must have screwed up my testing or gotten
lucky.

Add another test to cover gettimeofday() as well.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: 715bd9d12f84 ("x86/vdso: Fix asm constraints on vDSO syscall fallbacks")
Link: http://lkml.kernel.org/r/21bd45ab04b6d838278fa5bebfa9163eceffa13c.1538608971.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/vclock_gettime.c    |  8 ++--
 tools/testing/selftests/x86/test_vdso.c | 73 +++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 134e2d2e8add..e48ca3afa091 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -68,11 +68,11 @@ notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
 
 	asm (
 		"mov %%ebx, %%edx \n"
-		"mov %2, %%ebx \n"
+		"mov %[clock], %%ebx \n"
 		"call __kernel_vsyscall \n"
 		"mov %%edx, %%ebx \n"
 		: "=a" (ret), "=m" (*ts)
-		: "0" (__NR_clock_gettime), "g" (clock), "c" (ts)
+		: "0" (__NR_clock_gettime), [clock] "g" (clock), "c" (ts)
 		: "memory", "edx");
 	return ret;
 }
@@ -83,11 +83,11 @@ notrace static long vdso_fallback_gtod(struct timeval *tv, struct timezone *tz)
 
 	asm (
 		"mov %%ebx, %%edx \n"
-		"mov %2, %%ebx \n"
+		"mov %[tv], %%ebx \n"
 		"call __kernel_vsyscall \n"
 		"mov %%edx, %%ebx \n"
 		: "=a" (ret), "=m" (*tv), "=m" (*tz)
-		: "0" (__NR_gettimeofday), "g" (tv), "c" (tz)
+		: "0" (__NR_gettimeofday), [tv] "g" (tv), "c" (tz)
 		: "memory", "edx");
 	return ret;
 }
diff --git a/tools/testing/selftests/x86/test_vdso.c b/tools/testing/selftests/x86/test_vdso.c
index 49f7294fb382..35edd61d1663 100644
--- a/tools/testing/selftests/x86/test_vdso.c
+++ b/tools/testing/selftests/x86/test_vdso.c
@@ -36,6 +36,10 @@ typedef int (*vgettime_t)(clockid_t, struct timespec *);
 
 vgettime_t vdso_clock_gettime;
 
+typedef long (*vgtod_t)(struct timeval *tv, struct timezone *tz);
+
+vgtod_t vdso_gettimeofday;
+
 typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
 
 getcpu_t vgetcpu;
@@ -104,6 +108,11 @@ static void fill_function_pointers()
 	vdso_clock_gettime = (vgettime_t)dlsym(vdso, "__vdso_clock_gettime");
 	if (!vdso_clock_gettime)
 		printf("Warning: failed to find clock_gettime in vDSO\n");
+
+	vdso_gettimeofday = (vgtod_t)dlsym(vdso, "__vdso_gettimeofday");
+	if (!vdso_gettimeofday)
+		printf("Warning: failed to find gettimeofday in vDSO\n");
+
 }
 
 static long sys_getcpu(unsigned * cpu, unsigned * node,
@@ -117,6 +126,11 @@ static inline int sys_clock_gettime(clockid_t id, struct timespec *ts)
 	return syscall(__NR_clock_gettime, id, ts);
 }
 
+static inline int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	return syscall(__NR_gettimeofday, tv, tz);
+}
+
 static void test_getcpu(void)
 {
 	printf("[RUN]\tTesting getcpu...\n");
@@ -177,6 +191,14 @@ static bool ts_leq(const struct timespec *a, const struct timespec *b)
 		return a->tv_nsec <= b->tv_nsec;
 }
 
+static bool tv_leq(const struct timeval *a, const struct timeval *b)
+{
+	if (a->tv_sec != b->tv_sec)
+		return a->tv_sec < b->tv_sec;
+	else
+		return a->tv_usec <= b->tv_usec;
+}
+
 static char const * const clocknames[] = {
 	[0] = "CLOCK_REALTIME",
 	[1] = "CLOCK_MONOTONIC",
@@ -248,11 +270,62 @@ static void test_clock_gettime(void)
 	test_one_clock_gettime(INT_MAX, "invalid");
 }
 
+static void test_gettimeofday(void)
+{
+	struct timeval start, vdso, end;
+	struct timezone sys_tz, vdso_tz;
+	int vdso_ret, end_ret;
+
+	if (!vdso_gettimeofday)
+		return;
+
+	printf("[RUN]\tTesting gettimeofday...\n");
+
+	if (sys_gettimeofday(&start, &sys_tz) < 0) {
+		printf("[FAIL]\tsys_gettimeofday failed (%d)\n", errno);
+		nerrs++;
+		return;
+	}
+
+	vdso_ret = vdso_gettimeofday(&vdso, &vdso_tz);
+	end_ret = sys_gettimeofday(&end, NULL);
+
+	if (vdso_ret != 0 || end_ret != 0) {
+		printf("[FAIL]\tvDSO returned %d, syscall errno=%d\n",
+		       vdso_ret, errno);
+		nerrs++;
+		return;
+	}
+
+	printf("\t%llu.%06ld %llu.%06ld %llu.%06ld\n",
+	       (unsigned long long)start.tv_sec, start.tv_usec,
+	       (unsigned long long)vdso.tv_sec, vdso.tv_usec,
+	       (unsigned long long)end.tv_sec, end.tv_usec);
+
+	if (!tv_leq(&start, &vdso) || !tv_leq(&vdso, &end)) {
+		printf("[FAIL]\tTimes are out of sequence\n");
+		nerrs++;
+	}
+
+	if (sys_tz.tz_minuteswest == vdso_tz.tz_minuteswest &&
+	    sys_tz.tz_dsttime == vdso_tz.tz_dsttime) {
+		printf("[OK]\ttimezones match: minuteswest=%d, dsttime=%d\n",
+		       sys_tz.tz_minuteswest, sys_tz.tz_dsttime);
+	} else {
+		printf("[FAIL]\ttimezones do not match\n");
+		nerrs++;
+	}
+
+	/* And make sure that passing NULL for tz doesn't crash. */
+	vdso_gettimeofday(&vdso, NULL);
+}
+
 int main(int argc, char **argv)
 {
 	fill_function_pointers();
 
 	test_clock_gettime();
+	test_gettimeofday();
 
 	/*
 	 * Test getcpu() last so that, if something goes wrong setting affinity,
