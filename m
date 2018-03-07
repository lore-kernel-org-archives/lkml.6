Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvRS3jTs3JJUVbvC572vTKEw149kihtPaXkUVcUJ5J8UhuyE2AWQOSoaqbnbkQIOdhqP3IF
ARC-Seal: i=1; a=rsa-sha256; t=1520428057; cv=none;
        d=google.com; s=arc-20160816;
        b=Zz4qjO+Z/7XbNMans/trmwIlrB7bQWHWK1kqufOHn4tuzZvUUsz+guBTDXJzcQw8YD
         1MxXIUdqzUoW/EWLgoSRNhmUZupUDSNKK6RnxNDpwBzGCdJXbM1C/ZufdhkcRBtuEDHd
         qPJ+cWyAKkK//u/qmOpR6t6hsAMuMWO8M1cKRg6yPHdHI+glMJTfx8sWNYL8K1iGu5PS
         V+tCwl3150BkmvRzAs8T02aD0ybt+KflNWh1FWbKGUG+Ve0Kh9pOYwWq/pR6FHvO2kAn
         JdB7OaYDNK2JVV4cHAqjULTh+spc16ATQlI9P78FIUAL1irnQOX5/Q3aeGCUJnci6TQh
         9BtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Lm6jIZ4BD8AdJYXG+LXGjpVxji85xqsZAuuHgp4ZGFY=;
        b=Kpcl8cIdx0vO+YPcEPxrxDF+oyB9V8JjWYobO/ozHz48QLhUlEqXFmGP53EOewWzOE
         yJXulljzYq0QWB0abA1yS/l4YAZDs0/xRHxPbT50nv+od/1L8Cm0EPBLOf34XTpBvGR0
         ZQ8OZzhOj6a8x7k6Y8Vk4JWq2p1o7Q/r/XI62SjptC4JFUM2ZoK1t9qR1XBRLWMkuV08
         2PdPvDVPqPSpgRFKu+w7aUP1yUX4Bi/SAp21WBCjoBBPXKVWTdh+Hjy/L5pRt+Zgk4IA
         JRaQAYI9tutEZssdu8VHtklaQ5+oXXuuR8S3BIha5PnpgmK07IjtIgIUYVvPkZJQigW0
         adSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=axv3AJce;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=axv3AJce;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeCGNHh (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 7 Mar 2018 08:07:37 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36540 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeCGNHf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Mar 2018 08:07:35 -0500
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org
Cc: tbird20d@gmail.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/size: rework to use main instead of _start
Date: Wed,  7 Mar 2018 14:07:25 +0100
Message-Id: <20180307130725.8267-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594284370957041073?=
X-GMAIL-MSGID: =?utf-8?q?1594284370957041073?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In a -ffreestanding environment without glibc, we shouldn't be able to
call either getenv or printf. It seems that printf() happens to work
fine, but it ends up using the glibc getenv(), which doesn't work unless
we call the glibc _start() function first.
Using _start() was originally meant as an optimization to reduce the
memory consumption of the test program itself, in order to get a more
accurate representation of the available RAM at system boot time.
However, it causes more problems than it helps, especially when run from
a shell script that also consumes some memory.

get_size[2838]: segfault at ffffffffffffffd0 ip 000000000040538b
   sp 00007ffc41980668 error 5 in get_size[400000+b0000]
audit: type=1701 audit(1521532923.838:4): auid=0 uid=0 gid=0 ses=2
   subj=kernel pid=2838 comm=\"get_size\"
   exe=\"/opt/kselftests/next/size/get_size\" sig=11 res=1
get_size[2840]: segfault at ffffffffffffffd0 ip 000000000040538b
   sp 00007ffdace9b378 error 5 in get_size[400000+b0000]
audit: type=1701 audit(1521532932.057:5): auid=0 uid=0 gid=0 ses=2
   subj=kernel pid=2840 comm=\"get_size\"
   exe=\"/opt/kselftests/next/size/get_size\" sig=11 res=1

Rework to get_size test to use main (and printf) instead of _start. All
other seftest tests uses main and not _start.

Fixes: 0081901af95f ("selftests: size call ksft_print_header() to print TAP header")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/size/Makefile   |  2 +-
 tools/testing/selftests/size/get_size.c | 47 ++++++++++-----------------------
 2 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/size/Makefile b/tools/testing/selftests/size/Makefile
index 4685b3e421fc..73932e0e7cd0 100644
--- a/tools/testing/selftests/size/Makefile
+++ b/tools/testing/selftests/size/Makefile
@@ -1,4 +1,4 @@
-CFLAGS := -static -ffreestanding -nostartfiles -s
+CFLAGS := -static -ffreestanding -s
 
 TEST_GEN_PROGS := get_size
 
diff --git a/tools/testing/selftests/size/get_size.c b/tools/testing/selftests/size/get_size.c
index 1280b09266f0..490cf4e26eaf 100644
--- a/tools/testing/selftests/size/get_size.c
+++ b/tools/testing/selftests/size/get_size.c
@@ -26,13 +26,6 @@
 #include <stdio.h>
 #include "../kselftest.h"
 
-#define STDOUT_FILENO 1
-
-static int print(const char *s)
-{
-	return write(STDOUT_FILENO, s, __builtin_strlen(s));
-}
-
 static inline char *num_to_str(unsigned long num, char *buf, int len)
 {
 	unsigned int digit;
@@ -49,30 +42,18 @@ static inline char *num_to_str(unsigned long num, char *buf, int len)
 	return buf;
 }
 
-static int print_num(unsigned long num)
-{
-	char num_buf[30];
-
-	return print(num_to_str(num, num_buf, sizeof(num_buf)));
-}
-
 static int print_k_value(const char *s, unsigned long num, unsigned long units)
 {
 	unsigned long long temp;
-	int ccode;
-
-	print(s);
 
 	temp = num;
 	temp = (temp * units)/1024;
 	num = temp;
-	ccode = print_num(num);
-	print("\n");
-	return ccode;
+	return printf("%s%d\n", s, num);
 }
 
 /* this program has no main(), as startup libraries are not used */
-void _start(void)
+int main(void)
 {
 	int ccode;
 	struct sysinfo info;
@@ -80,28 +61,28 @@ void _start(void)
 	static const char *test_name = " get runtime memory use\n";
 
 	ksft_print_header();
-	print("# Testing system size.\n");
+	printf("# Testing system size.\n");
 
 	ccode = sysinfo(&info);
 	if (ccode < 0) {
-		print("not ok 1");
-		print(test_name);
-		print(" ---\n reason: \"could not get sysinfo\"\n ...\n");
-		_exit(ccode);
+		printf("not ok 1");
+		printf(test_name);
+		printf(" ---\n reason: \"could not get sysinfo\"\n ...\n");
+		return 1;
 	}
-	print("ok 1");
-	print(test_name);
+	printf("ok 1");
+	printf(test_name);
 
 	/* ignore cache complexities for now */
 	used = info.totalram - info.freeram - info.bufferram;
-	print("# System runtime memory report (units in Kilobytes):\n");
-	print(" ---\n");
+	printf("# System runtime memory report (units in Kilobytes):\n");
+	printf(" ---\n");
 	print_k_value(" Total:  ", info.totalram, info.mem_unit);
 	print_k_value(" Free:   ", info.freeram, info.mem_unit);
 	print_k_value(" Buffer: ", info.bufferram, info.mem_unit);
 	print_k_value(" In use: ", used, info.mem_unit);
-	print(" ...\n");
-	print("1..1\n");
+	printf(" ...\n");
+	printf("1..1\n");
 
-	_exit(0);
+	return 0;
 }
-- 
2.11.0

