Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF94C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D794721905
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358572;
	bh=Wn6m1ZTI10gwQ+Xc+Ap0cGoiDL3KM3TBkUXWU2cLv6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fKyoPnbyJ4c13ZKC27aKDzCRW37CVAqHCgdoqn7EooBUCTpoUBINEA0ql+v2Z0Kq6
	 0OnSX1MCzJfhlhQoAYYGKJZ1hpm0rHq3tQKYdl9aNoWPwGxnh5zGAZrWx3VcVXQ/Cp
	 yLxoO+ziedtcHSJAVhJM5dFsNGzcKtXQyOYr8YxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbfAXTgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:36:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732461AbfAXTgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:36:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 983D3218FC;
        Thu, 24 Jan 2019 19:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358566;
        bh=Wn6m1ZTI10gwQ+Xc+Ap0cGoiDL3KM3TBkUXWU2cLv6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNWxlak/I9GKgduVkawZqubJQv1yqVO9qNaNI1Zt7+V3D3b+vDZinP94bUNUCkzwm
         WdjJmZ00BAe0tz6OwUZEkbqt+zRvc6zq4y8ihHm42xnWpQCqryxp7xK8cVLDO4g8OL
         uGNKY9flkWdackY6HFctS99tc8rWRt1gqHPqcKdo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 052/106] selftests: do not macro-expand failed assertion expressions
Date:   Thu, 24 Jan 2019 20:20:09 +0100
Message-Id: <20190124190209.733631568@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b708a3cc9600390ccaa2b68a88087dd265154b2b ]

I've stumbled over the current macro-expand behaviour of the test
harness:

$ gcc -Wall -xc - <<'__EOF__'
TEST(macro) {
	int status = 0;
	ASSERT_TRUE(WIFSIGNALED(status));
}
TEST_HARNESS_MAIN
__EOF__
$ ./a.out
[==========] Running 1 tests from 1 test cases.
[ RUN      ] global.macro
<stdin>:4:global.macro:Expected 0 (0) != (((signed char) (((status) & 0x7f) + 1) >> 1) > 0) (0)
global.macro: Test terminated by assertion
[     FAIL ] global.macro
[==========] 0 / 1 tests passed.
[  FAILED  ]

With this change the output of the same test looks much more
comprehensible:

[==========] Running 1 tests from 1 test cases.
[ RUN      ] global.macro
<stdin>:4:global.macro:Expected 0 (0) != WIFSIGNALED(status) (0)
global.macro: Test terminated by assertion
[     FAIL ] global.macro
[==========] 0 / 1 tests passed.
[  FAILED  ]

The issue is very similar to the bug fixed in glibc assert(3)
three years ago:
https://sourceware.org/bugzilla/show_bug.cgi?id=18604

Cc: Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 42 ++++++++++-----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 6ae3730c4ee3..76d654ef3234 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -354,7 +354,7 @@
  * ASSERT_EQ(expected, measured): expected == measured
  */
 #define ASSERT_EQ(expected, seen) \
-	__EXPECT(expected, seen, ==, 1)
+	__EXPECT(expected, #expected, seen, #seen, ==, 1)
 
 /**
  * ASSERT_NE(expected, seen)
@@ -365,7 +365,7 @@
  * ASSERT_NE(expected, measured): expected != measured
  */
 #define ASSERT_NE(expected, seen) \
-	__EXPECT(expected, seen, !=, 1)
+	__EXPECT(expected, #expected, seen, #seen, !=, 1)
 
 /**
  * ASSERT_LT(expected, seen)
@@ -376,7 +376,7 @@
  * ASSERT_LT(expected, measured): expected < measured
  */
 #define ASSERT_LT(expected, seen) \
-	__EXPECT(expected, seen, <, 1)
+	__EXPECT(expected, #expected, seen, #seen, <, 1)
 
 /**
  * ASSERT_LE(expected, seen)
@@ -387,7 +387,7 @@
  * ASSERT_LE(expected, measured): expected <= measured
  */
 #define ASSERT_LE(expected, seen) \
-	__EXPECT(expected, seen, <=, 1)
+	__EXPECT(expected, #expected, seen, #seen, <=, 1)
 
 /**
  * ASSERT_GT(expected, seen)
@@ -398,7 +398,7 @@
  * ASSERT_GT(expected, measured): expected > measured
  */
 #define ASSERT_GT(expected, seen) \
-	__EXPECT(expected, seen, >, 1)
+	__EXPECT(expected, #expected, seen, #seen, >, 1)
 
 /**
  * ASSERT_GE(expected, seen)
@@ -409,7 +409,7 @@
  * ASSERT_GE(expected, measured): expected >= measured
  */
 #define ASSERT_GE(expected, seen) \
-	__EXPECT(expected, seen, >=, 1)
+	__EXPECT(expected, #expected, seen, #seen, >=, 1)
 
 /**
  * ASSERT_NULL(seen)
@@ -419,7 +419,7 @@
  * ASSERT_NULL(measured): NULL == measured
  */
 #define ASSERT_NULL(seen) \
-	__EXPECT(NULL, seen, ==, 1)
+	__EXPECT(NULL, "NULL", seen, #seen, ==, 1)
 
 /**
  * ASSERT_TRUE(seen)
@@ -429,7 +429,7 @@
  * ASSERT_TRUE(measured): measured != 0
  */
 #define ASSERT_TRUE(seen) \
-	ASSERT_NE(0, seen)
+	__EXPECT(0, "0", seen, #seen, !=, 1)
 
 /**
  * ASSERT_FALSE(seen)
@@ -439,7 +439,7 @@
  * ASSERT_FALSE(measured): measured == 0
  */
 #define ASSERT_FALSE(seen) \
-	ASSERT_EQ(0, seen)
+	__EXPECT(0, "0", seen, #seen, ==, 1)
 
 /**
  * ASSERT_STREQ(expected, seen)
@@ -472,7 +472,7 @@
  * EXPECT_EQ(expected, measured): expected == measured
  */
 #define EXPECT_EQ(expected, seen) \
-	__EXPECT(expected, seen, ==, 0)
+	__EXPECT(expected, #expected, seen, #seen, ==, 0)
 
 /**
  * EXPECT_NE(expected, seen)
@@ -483,7 +483,7 @@
  * EXPECT_NE(expected, measured): expected != measured
  */
 #define EXPECT_NE(expected, seen) \
-	__EXPECT(expected, seen, !=, 0)
+	__EXPECT(expected, #expected, seen, #seen, !=, 0)
 
 /**
  * EXPECT_LT(expected, seen)
@@ -494,7 +494,7 @@
  * EXPECT_LT(expected, measured): expected < measured
  */
 #define EXPECT_LT(expected, seen) \
-	__EXPECT(expected, seen, <, 0)
+	__EXPECT(expected, #expected, seen, #seen, <, 0)
 
 /**
  * EXPECT_LE(expected, seen)
@@ -505,7 +505,7 @@
  * EXPECT_LE(expected, measured): expected <= measured
  */
 #define EXPECT_LE(expected, seen) \
-	__EXPECT(expected, seen, <=, 0)
+	__EXPECT(expected, #expected, seen, #seen, <=, 0)
 
 /**
  * EXPECT_GT(expected, seen)
@@ -516,7 +516,7 @@
  * EXPECT_GT(expected, measured): expected > measured
  */
 #define EXPECT_GT(expected, seen) \
-	__EXPECT(expected, seen, >, 0)
+	__EXPECT(expected, #expected, seen, #seen, >, 0)
 
 /**
  * EXPECT_GE(expected, seen)
@@ -527,7 +527,7 @@
  * EXPECT_GE(expected, measured): expected >= measured
  */
 #define EXPECT_GE(expected, seen) \
-	__EXPECT(expected, seen, >=, 0)
+	__EXPECT(expected, #expected, seen, #seen, >=, 0)
 
 /**
  * EXPECT_NULL(seen)
@@ -537,7 +537,7 @@
  * EXPECT_NULL(measured): NULL == measured
  */
 #define EXPECT_NULL(seen) \
-	__EXPECT(NULL, seen, ==, 0)
+	__EXPECT(NULL, "NULL", seen, #seen, ==, 0)
 
 /**
  * EXPECT_TRUE(seen)
@@ -547,7 +547,7 @@
  * EXPECT_TRUE(measured): 0 != measured
  */
 #define EXPECT_TRUE(seen) \
-	EXPECT_NE(0, seen)
+	__EXPECT(0, "0", seen, #seen, !=, 0)
 
 /**
  * EXPECT_FALSE(seen)
@@ -557,7 +557,7 @@
  * EXPECT_FALSE(measured): 0 == measured
  */
 #define EXPECT_FALSE(seen) \
-	EXPECT_EQ(0, seen)
+	__EXPECT(0, "0", seen, #seen, ==, 0)
 
 /**
  * EXPECT_STREQ(expected, seen)
@@ -597,7 +597,7 @@
 	if (_metadata->passed && _metadata->step < 255) \
 		_metadata->step++;
 
-#define __EXPECT(_expected, _seen, _t, _assert) do { \
+#define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
 	/* Avoid multiple evaluation of the cases */ \
 	__typeof__(_expected) __exp = (_expected); \
 	__typeof__(_seen) __seen = (_seen); \
@@ -606,8 +606,8 @@
 		unsigned long long __exp_print = (uintptr_t)__exp; \
 		unsigned long long __seen_print = (uintptr_t)__seen; \
 		__TH_LOG("Expected %s (%llu) %s %s (%llu)", \
-			 #_expected, __exp_print, #_t, \
-			 #_seen, __seen_print); \
+			 _expected_str, __exp_print, #_t, \
+			 _seen_str, __seen_print); \
 		_metadata->passed = 0; \
 		/* Ensure the optional handler is triggered */ \
 		_metadata->trigger = 1; \
-- 
2.19.1



