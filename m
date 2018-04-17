Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx490vllxPbjhYw8IqOaR02NIzRCj21vsUcv7/U5nQjmHIV9rYz+yQbP9w932BaZurAm9Qstv
ARC-Seal: i=1; a=rsa-sha256; t=1523955603; cv=none;
        d=google.com; s=arc-20160816;
        b=xddsKteUvbTlzfmdbqqLlAURpyHymAOvu53rk9hFCsxdCfX+vrCnFsHa7geT11MN8Z
         D9PzPFL97TmoAnT9Orxy3c/R6+vcDhlgAx+DcVvladgdDMqSFxijsTKFPt5TPvbISf8o
         ha4CKUCezqfm8i1fhTrMn5q/A6OXgUgDrfa6VMe4WYphXFvqahdkppz/qY7vcgFcUDAY
         e88q0s5gTTz6jHl6xk3mHwQY4nKTqVyWLhAdfz1MBStBUKWmE/i4KFeMgN8wzOJViSIo
         BdRjB9VNLNx0V0HA295O4rsrQVJDRR3BYIedl4RCHm8jDL6zXIo0Yl9ztW8kNZ1CjwQa
         js4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=y1VMXRSO+5J9e8ykbNcmmrD7WGm8yT4fb5NJGN7mSec=;
        b=yHJEb3AgAihUNW0+4LN+fdBA1LTAi3Qdn989KEMWSqAsv5oAs+bLAPt2EzGrTcF8LY
         I56iCXeU/tvdyU1vQKAkqYze77OTgHX38C6Ceir6EqHdoPQItiJPVXLSjHCXmo5pIEGv
         06PN2yBK+hvGK6BzsyAM9V7TOQB1LWN7pK3ugZVOEK+6ReXd2qGS5552FE+uN62mB/Hq
         8v7gSw0eTkfeNsjYwetSU5KASp/8fUYFQS1u3g4HkcEwDhHSKCuQuej7s4u5e6fzQ3rw
         zd1t4StjbGTdhDCTevhSMy1RqOWCFmasCNvkzqMPXw8zB56K5bBv6W5KbH05QTQ1EqKr
         mxlw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=ZNAZo2Z2;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=ZNAZo2Z2;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeDQJAD (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 17 Apr 2018 05:00:03 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40985 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbeDQJAC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Apr 2018 05:00:02 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org, dh.herrmann@gmail.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/memfd: move common code into common.c
Date: Tue, 17 Apr 2018 10:59:36 +0200
Message-Id: <20180417085936.19512-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597983271126552958?=
X-GMAIL-MSGID: =?utf-8?q?1597983271126552958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove code duplication, in the current code, we move common code for
memfd to common.c.

The duplicate functions got added in commit 87b2d44026e0 ("selftests:
add memfd/sealing page-pinning tests")

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/memfd/common.c     | 37 +++++++++++++++++++
 tools/testing/selftests/memfd/common.h     |  4 ++
 tools/testing/selftests/memfd/fuse_test.c  | 43 +---------------------
 tools/testing/selftests/memfd/memfd_test.c | 37 -------------------
 4 files changed, 43 insertions(+), 78 deletions(-)

diff --git a/tools/testing/selftests/memfd/common.c b/tools/testing/selftests/memfd/common.c
index 8eb3d75f6e60..fee1f07828a3 100644
--- a/tools/testing/selftests/memfd/common.c
+++ b/tools/testing/selftests/memfd/common.c
@@ -44,3 +44,40 @@ int sys_memfd_create(const char *name, unsigned int flags)
 
 	return syscall(__NR_memfd_create, name, flags);
 }
+
+unsigned int mfd_assert_get_seals(int fd)
+{
+	int r;
+
+	r = fcntl(fd, F_GET_SEALS);
+	if (r < 0) {
+		printf("GET_SEALS(%d) failed: %m\n", fd);
+		abort();
+	}
+
+	return (unsigned int)r;
+}
+
+void mfd_assert_add_seals(int fd, unsigned int seals)
+{
+	int r;
+	unsigned int s;
+
+	s = mfd_assert_get_seals(fd);
+	r = fcntl(fd, F_ADD_SEALS, seals);
+	if (r < 0) {
+		printf("ADD_SEALS(%d, %u -> %u) failed: %m\n", fd, s, seals);
+		abort();
+	}
+}
+
+void mfd_assert_has_seals(int fd, unsigned int seals)
+{
+	unsigned int s;
+
+	s = mfd_assert_get_seals(fd);
+	if (s != seals) {
+		printf("%u != %u = GET_SEALS(%d)\n", seals, s, fd);
+		abort();
+	}
+}
diff --git a/tools/testing/selftests/memfd/common.h b/tools/testing/selftests/memfd/common.h
index 522d2c630bd8..5c778d15e8c7 100644
--- a/tools/testing/selftests/memfd/common.h
+++ b/tools/testing/selftests/memfd/common.h
@@ -6,4 +6,8 @@ extern int hugetlbfs_test;
 unsigned long default_huge_page_size(void);
 int sys_memfd_create(const char *name, unsigned int flags);
 
+void mfd_assert_add_seals(int fd, unsigned int seals);
+void mfd_assert_has_seals(int fd, unsigned int seals);
+unsigned int mfd_assert_get_seals(int fd);
+
 #endif
diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index b018e835737d..231714615861 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -60,49 +60,10 @@ static int mfd_assert_new(const char *name, loff_t sz, unsigned int flags)
 	return fd;
 }
 
-static __u64 mfd_assert_get_seals(int fd)
+static int mfd_busy_add_seals(int fd, unsigned int seals)
 {
 	long r;
-
-	r = fcntl(fd, F_GET_SEALS);
-	if (r < 0) {
-		printf("GET_SEALS(%d) failed: %m\n", fd);
-		abort();
-	}
-
-	return r;
-}
-
-static void mfd_assert_has_seals(int fd, __u64 seals)
-{
-	__u64 s;
-
-	s = mfd_assert_get_seals(fd);
-	if (s != seals) {
-		printf("%llu != %llu = GET_SEALS(%d)\n",
-		       (unsigned long long)seals, (unsigned long long)s, fd);
-		abort();
-	}
-}
-
-static void mfd_assert_add_seals(int fd, __u64 seals)
-{
-	long r;
-	__u64 s;
-
-	s = mfd_assert_get_seals(fd);
-	r = fcntl(fd, F_ADD_SEALS, seals);
-	if (r < 0) {
-		printf("ADD_SEALS(%d, %llu -> %llu) failed: %m\n",
-		       fd, (unsigned long long)s, (unsigned long long)seals);
-		abort();
-	}
-}
-
-static int mfd_busy_add_seals(int fd, __u64 seals)
-{
-	long r;
-	__u64 s;
+	unsigned int s;
 
 	r = fcntl(fd, F_GET_SEALS);
 	if (r < 0)
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 10baa1652fc2..527789de69b5 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -67,43 +67,6 @@ static void mfd_fail_new(const char *name, unsigned int flags)
 	}
 }
 
-static unsigned int mfd_assert_get_seals(int fd)
-{
-	int r;
-
-	r = fcntl(fd, F_GET_SEALS);
-	if (r < 0) {
-		printf("GET_SEALS(%d) failed: %m\n", fd);
-		abort();
-	}
-
-	return (unsigned int)r;
-}
-
-static void mfd_assert_has_seals(int fd, unsigned int seals)
-{
-	unsigned int s;
-
-	s = mfd_assert_get_seals(fd);
-	if (s != seals) {
-		printf("%u != %u = GET_SEALS(%d)\n", seals, s, fd);
-		abort();
-	}
-}
-
-static void mfd_assert_add_seals(int fd, unsigned int seals)
-{
-	int r;
-	unsigned int s;
-
-	s = mfd_assert_get_seals(fd);
-	r = fcntl(fd, F_ADD_SEALS, seals);
-	if (r < 0) {
-		printf("ADD_SEALS(%d, %u -> %u) failed: %m\n", fd, s, seals);
-		abort();
-	}
-}
-
 static void mfd_fail_add_seals(int fd, unsigned int seals)
 {
 	int r;
-- 
2.17.0

