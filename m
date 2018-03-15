Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvIhINBtmu61bzElR/FAdP5chSKsv7puVcsDS3zGJ9LfoXSzsZpCZNKRJheCXNr0KUgzgmq
ARC-Seal: i=1; a=rsa-sha256; t=1521133161; cv=none;
        d=google.com; s=arc-20160816;
        b=IMX0hhtYXlw8SqB8qj/iYopd+Gyk/mH2Cdf2hCcbZepoqMTAuRB8oqUjaz57E1pB3o
         Z3ybrjbAeJ0CJUX4nP+YCaK2Yny0cCNEEM5h7PlXEC/VsQ9tYdPexGLMr5l+xJk7vri0
         mkDJ/TCjgN4L24e+gMiqctvbawM8/tqJq3UNzTWmwE35yagvD09EQZPGQ9b69p1objKK
         VJPA9xA/0s+UruLeGqS6EdDsl2SwWHYeLweTSsgMpz1X0HgbysMWvm8Aa112A6XLKOn9
         4tLLKZ+vHyRe8QjYK8SfxBAhptZvHYcLzj1xmgPl1QhdIrs0F1IHBWyo0RZn14pNLMSE
         5bxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ZyGTMHnccU0iHJW8jN0UCJeHByzFuRBGu6GJEyb2xP0=;
        b=tnOIj7ptgXMmtj3dpCA6uU5bKnVNmJKN6Butih+GJ3OVKi79AE9SW9vPAolm7dVqph
         oDqy7jKNy0jrPzcRZwONZ6JIhdXBVZgiId59DEwmellYrdc0hAgQBx8y+zYdSyFuAyaH
         qrqDjguNZaf1ZjxwY2UlceL4TT3zANypYOxuiDsHwxTCo4DrWQGOpWhSQdHifOAUILdX
         +QrrQQz5X9HLu8OAEux3XgW+zTY7+r3nRTsod+RZDbDfve+iNLdQ/a/b/OWk7XGL5UjA
         3VX3f1XRsPGliKLhQs7w0vGY/eUJ6mR+J1P6X/Z39YicRPqXVb3GRjOcEi/d3PXVqVI2
         U/VA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@chromium.org header.s=google header.b=GcxYsWGl;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@chromium.org header.s=google header.b=GcxYsWGl;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751466AbeCOQ7V (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 15 Mar 2018 12:59:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43253 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeCOQ7U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Mar 2018 12:59:20 -0400
Date: Thu, 15 Mar 2018 09:59:16 -0700
From: Kees Cook <keescook@chromium.org>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH] selftests/seccomp: Allow get_metadata to XFAIL
Message-ID: <20180315165916.GA31072@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595023726325314850?=
X-GMAIL-MSGID: =?utf-8?q?1595023726325314850?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since seccomp_get_metadata() depends on CHECKPOINT_RESTORE, XFAIL the
test if the ptrace reports it as missing.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h   | 26 +++++++++++++++++++++++++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 15 +++++++++++++--
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index e81bd28bdd89..6ae3730c4ee3 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -107,6 +107,27 @@
 			__FILE__, __LINE__, _metadata->name, ##__VA_ARGS__)
 
 /**
+ * XFAIL(statement, fmt, ...)
+ *
+ * @statement: statement to run after reporting XFAIL
+ * @fmt: format string
+ * @...: optional arguments
+ *
+ * This forces a "pass" after reporting a failure with an XFAIL prefix,
+ * and runs "statement", which is usually "return" or "goto skip".
+ */
+#define XFAIL(statement, fmt, ...) do { \
+	if (TH_LOG_ENABLED) { \
+		fprintf(TH_LOG_STREAM, "[  XFAIL!  ] " fmt "\n", \
+			##__VA_ARGS__); \
+	} \
+	/* TODO: find a way to pass xfail to test runner process. */ \
+	_metadata->passed = 1; \
+	_metadata->trigger = 0; \
+	statement; \
+} while (0)
+
+/**
  * TEST(test_name) - Defines the test function and creates the registration
  * stub
  *
@@ -198,7 +219,7 @@
 
 /**
  * FIXTURE_SETUP(fixture_name) - Prepares the setup function for the fixture.
- * *_metadata* is included so that ASSERT_* work as a convenience
+ * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
  *
  * @fixture_name: fixture name
  *
@@ -221,6 +242,7 @@
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
 /**
  * FIXTURE_TEARDOWN(fixture_name)
+ * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
  *
  * @fixture_name: fixture name
  *
@@ -253,6 +275,8 @@
  * Defines a test that depends on a fixture (e.g., is part of a test case).
  * Very similar to TEST() except that *self* is the setup instance of fixture's
  * datatype exposed for use by the implementation.
+ *
+ * Warning: use of ASSERT_* here will skip TEARDOWN.
  */
 /* TODO(wad) register fixtures on dedicated test lists. */
 #define TEST_F(fixture_name, test_name) \
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 92db48825dc1..d7e54031e26b 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -2860,6 +2860,7 @@ TEST(get_metadata)
 	int pipefd[2];
 	char buf;
 	struct seccomp_metadata md;
+	long ret;
 
 	ASSERT_EQ(0, pipe(pipefd));
 
@@ -2893,16 +2894,26 @@ TEST(get_metadata)
 	ASSERT_EQ(0, ptrace(PTRACE_ATTACH, pid));
 	ASSERT_EQ(pid, waitpid(pid, NULL, 0));
 
+	/* Past here must not use ASSERT or child process is never killed. */
+
 	md.filter_off = 0;
-	ASSERT_EQ(sizeof(md), ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md));
+	errno = 0;
+	ret = ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md);
+	EXPECT_EQ(sizeof(md), ret) {
+		if (errno == EINVAL)
+			XFAIL(goto skip, "Kernel does not support PTRACE_SECCOMP_GET_METADATA (missing CONFIG_CHECKPOINT_RESTORE?)");
+	}
+
 	EXPECT_EQ(md.flags, SECCOMP_FILTER_FLAG_LOG);
 	EXPECT_EQ(md.filter_off, 0);
 
 	md.filter_off = 1;
-	ASSERT_EQ(sizeof(md), ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md));
+	ret = ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md);
+	EXPECT_EQ(sizeof(md), ret);
 	EXPECT_EQ(md.flags, 0);
 	EXPECT_EQ(md.filter_off, 1);
 
+skip:
 	ASSERT_EQ(0, kill(pid, SIGKILL));
 }
 
-- 
2.7.4


-- 
Kees Cook
Pixel Security
