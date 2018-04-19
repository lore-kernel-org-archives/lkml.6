Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbeDSMux (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:50:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33443 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753517AbeDSMuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:50:51 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Shuah Khan <shuah@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/4] selftests: move RTC tests to rtc subfolder
Date: Thu, 19 Apr 2018 14:50:29 +0200
Message-Id: <20180419125030.5076-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419125030.5076-1-alexandre.belloni@bootlin.com>
References: <20180419125030.5076-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the RTC tests out of the timers folder as they are mostly unrelated.
Keep rtcpie in timers as it only test hrtimers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 MAINTAINERS                                              | 2 +-
 tools/testing/selftests/Makefile                         | 1 +
 tools/testing/selftests/rtc/.gitignore                   | 2 ++
 tools/testing/selftests/rtc/Makefile                     | 9 +++++++++
 tools/testing/selftests/{timers => rtc}/rtctest.c        | 0
 .../{timers/rtctest_setdate.c => rtc/setdate.c}          | 0
 tools/testing/selftests/timers/.gitignore                | 2 --
 tools/testing/selftests/timers/Makefile                  | 4 ++--
 8 files changed, 15 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/rtc/.gitignore
 create mode 100644 tools/testing/selftests/rtc/Makefile
 rename tools/testing/selftests/{timers => rtc}/rtctest.c (100%)
 rename tools/testing/selftests/{timers/rtctest_setdate.c => rtc/setdate.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1410d5a621..0d86deb969bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11868,7 +11868,7 @@ F:	include/linux/rtc.h
 F:	include/uapi/linux/rtc.h
 F:	include/linux/rtc/
 F:	include/linux/platform_data/rtc-*
-F:	tools/testing/selftests/timers/rtctest.c
+F:	tools/testing/selftests/rtc/
 
 REALTEK AUDIO CODECS
 M:	Bard Liao <bardliao@realtek.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 32aafa92074c..a368279301b7 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -28,6 +28,7 @@ TARGETS += powerpc
 TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
+TARGETS += rtc
 TARGETS += seccomp
 TARGETS += sigaltstack
 TARGETS += size
diff --git a/tools/testing/selftests/rtc/.gitignore b/tools/testing/selftests/rtc/.gitignore
new file mode 100644
index 000000000000..d0ad44f6294a
--- /dev/null
+++ b/tools/testing/selftests/rtc/.gitignore
@@ -0,0 +1,2 @@
+rtctest
+setdate
diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
new file mode 100644
index 000000000000..de9c8566672a
--- /dev/null
+++ b/tools/testing/selftests/rtc/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -O3 -Wl,-no-as-needed -Wall
+LDFLAGS += -lrt -lpthread -lm
+
+TEST_GEN_PROGS = rtctest
+
+TEST_GEN_PROGS_EXTENDED = setdate
+
+include ../lib.mk
diff --git a/tools/testing/selftests/timers/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
similarity index 100%
rename from tools/testing/selftests/timers/rtctest.c
rename to tools/testing/selftests/rtc/rtctest.c
diff --git a/tools/testing/selftests/timers/rtctest_setdate.c b/tools/testing/selftests/rtc/setdate.c
similarity index 100%
rename from tools/testing/selftests/timers/rtctest_setdate.c
rename to tools/testing/selftests/rtc/setdate.c
diff --git a/tools/testing/selftests/timers/.gitignore b/tools/testing/selftests/timers/.gitignore
index 353ae15daa1e..32a9eadb2d4e 100644
--- a/tools/testing/selftests/timers/.gitignore
+++ b/tools/testing/selftests/timers/.gitignore
@@ -10,7 +10,6 @@ nsleep-lat
 posix_timers
 raw_skew
 rtcpie
-rtctest
 set-2038
 set-tai
 set-timer-lat
@@ -20,4 +19,3 @@ valid-adjtimex
 adjtick
 set-tz
 freq-step
-rtctest_setdate
diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
index 8be7895ff918..c02683cfb6c9 100644
--- a/tools/testing/selftests/timers/Makefile
+++ b/tools/testing/selftests/timers/Makefile
@@ -5,13 +5,13 @@ LDFLAGS += -lrt -lpthread -lm
 # these are all "safe" tests that don't modify
 # system time or require escalated privileges
 TEST_GEN_PROGS = posix_timers nanosleep nsleep-lat set-timer-lat mqueue-lat \
-	     inconsistency-check raw_skew threadtest rtctest rtcpie
+	     inconsistency-check raw_skew threadtest rtcpie
 
 DESTRUCTIVE_TESTS = alarmtimer-suspend valid-adjtimex adjtick change_skew \
 		      skew_consistency clocksource-switch freq-step leap-a-day \
 		      leapcrash set-tai set-2038 set-tz
 
-TEST_GEN_PROGS_EXTENDED = $(DESTRUCTIVE_TESTS) rtctest_setdate
+TEST_GEN_PROGS_EXTENDED = $(DESTRUCTIVE_TESTS)
 
 
 include ../lib.mk
-- 
2.17.0
