Return-Path: <michael@ozlabs.org>
X-Google-Smtp-Source: AIpwx4/gEvQYqxBqvEM6F8TYbko4uwf47WJ3Jhknuu0GBK7diUGUfheaIY3QtKEnXGIU+EVVYs+E
ARC-Seal: i=1; a=rsa-sha256; t=1523341257; cv=none;
        d=google.com; s=arc-20160816;
        b=cMe8BOYsIgYZdIllwZeIpoABKg9TCP9l7QTw8NUDa/wQGWjEMn4s8v4uSapE3jW4et
         WPpOTfNhkan7yEcMzoh4QkbZ+2/8CUZ4m9g0/1vKAwZJuc066874MWHbLdRBrGEmAZO3
         hV1WEKYwTjA920QT5iOJGs0dedEkGS4YvbFRoA2J70o6Gc0H6AAf2XsHkQHyyft8l2X3
         XQH94v5QI/WCGx/9t4UxeQhqM9q7vDB9KUXn1IL6qaFHwpYAbXTQcGNwNDzK12N9WVST
         HGbEtCgeCpj6e0NbohieT7Jg+SYcIdglulfisThAOsQ0XWE9JGmjSgodL3FJVmdRAet3
         f4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=CHLAzthtwGT5NHtJe8AbnIqhB2iZ3FjKo/zdumbCIZ0=;
        b=Cd92Oj5rEgSGCiKnC66nJDGad2slJ9rfSl01RFSfCA0y6NcEm+/NuQixxcL+j2SbwW
         m3+w/v/AoewLyETeZ3ClI2nOANPgImce+DXnuDNQIhDE4EfhhefkvDqmEK6TJbEclbfA
         UGrTn2r3gw70wsZH/0gySHXaaKz7dMZlTChx9fBYnPTtIrh2qVOzUr0OrGB3/7McLmZt
         4YZXUOrYKFUX7naHD/RNuAF+ruCGdh3t2lhbSxacWVWyn1ABf8tlL5mjbRiVZ+84YwNR
         tHVX5s3IN4EO3mP3ND5Z4qyzSi/QpGFC/RtQiHuF8EpvySin6h3qU4hZvmjr/Vn0IONr
         doaw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of michael@ozlabs.org designates 203.11.71.1 as permitted sender) smtp.mailfrom=michael@ozlabs.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of michael@ozlabs.org designates 203.11.71.1 as permitted sender) smtp.mailfrom=michael@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
To: shuahkh@osg.samsung.com,
	christian.brauner@ubuntu.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	ebiederm@xmission.com,
	torvalds@linux-foundation.org,
	gregkh@linuxfoundation.org
Subject: [PATCH] selftests/filesystems: Don't run dnotify_test by default
Date: Tue, 10 Apr 2018 16:20:53 +1000
Message-Id: <20180410062053.8816-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597339082431063754?=
X-GMAIL-MSGID: =?utf-8?q?1597339082431063754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In commit ce290a19609d ("selftests: add devpts selftests"), the
filesystems directory was added to the top-level selftests Makefile.

That had the effect of causing the existing dnotify_test in the
filesystems directory to now be run as part of the default selftests
test-run. Unfortunately dnotify_test is actually an infinite loop.

Fix it by moving dnotify_test to TEST_GEN_PROGS_EXTENDED, which says
that it's a generated file (ie. built) but should not be run as part
of the default test suite run (it's an "extendend" test).

While we're here cleanup a few other things, devpts_pts should be in
TEST_GEN_PROGS to indicate that it's built, and with the above two
changes we no longer need a custom all or clean rule.

Fixes: ce290a19609d ("selftests: add devpts selftests")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/filesystems/Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 4e6d09fb166f..5c7d7001ad37 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_PROGS := dnotify_test devpts_pts
-all: $(TEST_PROGS)
 
-include ../lib.mk
+TEST_GEN_PROGS := devpts_pts
+TEST_GEN_PROGS_EXTENDED := dnotify_test
 
-clean:
-	rm -fr $(TEST_PROGS)
+include ../lib.mk
-- 
2.14.1
