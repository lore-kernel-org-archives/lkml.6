Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753566AbeDSMvW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:51:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33437 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753515AbeDSMuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:50:50 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Shuah Khan <shuah@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/4] selftests: timers: move PIE tests out of rtctest
Date: Thu, 19 Apr 2018 14:50:27 +0200
Message-Id: <20180419125030.5076-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419125030.5076-1-alexandre.belloni@bootlin.com>
References: <20180419125030.5076-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 6610e0893b8bc ("RTC: Rework RTC code to use timerqueue for
events"), PIE are completely handled using hrtimers, without actually using
any underlying hardware RTC.

Move PIE testing out of rtctest. It still depends on the presence of an RTC
(to access the device file) but doesn't depend on it actually working.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 tools/testing/selftests/timers/.gitignore |   1 +
 tools/testing/selftests/timers/Makefile   |   2 +-
 tools/testing/selftests/timers/rtcpie.c   | 132 ++++++++++++++++++++++
 tools/testing/selftests/timers/rtctest.c  |  83 +-------------
 4 files changed, 138 insertions(+), 80 deletions(-)
 create mode 100644 tools/testing/selftests/timers/rtcpie.c

diff --git a/tools/testing/selftests/timers/.gitignore b/tools/testing/selftests/timers/.gitignore
index 2c8ac8416299..353ae15daa1e 100644
--- a/tools/testing/selftests/timers/.gitignore
+++ b/tools/testing/selftests/timers/.gitignore
@@ -9,6 +9,7 @@ nanosleep
 nsleep-lat
 posix_timers
 raw_skew
+rtcpie
 rtctest
 set-2038
 set-tai
diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
index 3496680981f2..8be7895ff918 100644
--- a/tools/testing/selftests/timers/Makefile
+++ b/tools/testing/selftests/timers/Makefile
@@ -5,7 +5,7 @@ LDFLAGS += -lrt -lpthread -lm
 # these are all "safe" tests that don't modify
 # system time or require escalated privileges
 TEST_GEN_PROGS = posix_timers nanosleep nsleep-lat set-timer-lat mqueue-lat \
-	     inconsistency-check raw_skew threadtest rtctest
+	     inconsistency-check raw_skew threadtest rtctest rtcpie
 
 DESTRUCTIVE_TESTS = alarmtimer-suspend valid-adjtimex adjtick change_skew \
 		      skew_consistency clocksource-switch freq-step leap-a-day \
diff --git a/tools/testing/selftests/timers/rtcpie.c b/tools/testing/selftests/timers/rtcpie.c
new file mode 100644
index 000000000000..ea98b1f6ac17
--- /dev/null
+++ b/tools/testing/selftests/timers/rtcpie.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Real Time Clock Periodic Interrupt test program
+ *
+ * Since commit 6610e0893b8bc ("RTC: Rework RTC code to use timerqueue for
+ * events"), PIE are completely handled using hrtimers, without actually using
+ * any underlying hardware RTC.
+ *
+ */
+
+#include <stdio.h>
+#include <linux/rtc.h>
+#include <sys/ioctl.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <errno.h>
+
+/*
+ * This expects the new RTC class driver framework, working with
+ * clocks that will often not be clones of what the PC-AT had.
+ * Use the command line to specify another RTC if you need one.
+ */
+static const char default_rtc[] = "/dev/rtc0";
+
+int main(int argc, char **argv)
+{
+	int i, fd, retval, irqcount = 0;
+	unsigned long tmp, data;
+	const char *rtc = default_rtc;
+	struct timeval start, end, diff;
+
+	switch (argc) {
+	case 2:
+		rtc = argv[1];
+		/* FALLTHROUGH */
+	case 1:
+		break;
+	default:
+		fprintf(stderr, "usage:  rtctest [rtcdev] [d]\n");
+		return 1;
+	}
+
+	fd = open(rtc, O_RDONLY);
+
+	if (fd ==  -1) {
+		perror(rtc);
+		exit(errno);
+	}
+
+	/* Read periodic IRQ rate */
+	retval = ioctl(fd, RTC_IRQP_READ, &tmp);
+	if (retval == -1) {
+		/* not all RTCs support periodic IRQs */
+		if (errno == EINVAL) {
+			fprintf(stderr, "\nNo periodic IRQ support\n");
+			goto done;
+		}
+		perror("RTC_IRQP_READ ioctl");
+		exit(errno);
+	}
+	fprintf(stderr, "\nPeriodic IRQ rate is %ldHz.\n", tmp);
+
+	fprintf(stderr, "Counting 20 interrupts at:");
+	fflush(stderr);
+
+	/* The frequencies 128Hz, 256Hz, ... 8192Hz are only allowed for root. */
+	for (tmp=2; tmp<=64; tmp*=2) {
+
+		retval = ioctl(fd, RTC_IRQP_SET, tmp);
+		if (retval == -1) {
+			/* not all RTCs can change their periodic IRQ rate */
+			if (errno == EINVAL) {
+				fprintf(stderr,
+					"\n...Periodic IRQ rate is fixed\n");
+				goto done;
+			}
+			perror("RTC_IRQP_SET ioctl");
+			exit(errno);
+		}
+
+		fprintf(stderr, "\n%ldHz:\t", tmp);
+		fflush(stderr);
+
+		/* Enable periodic interrupts */
+		retval = ioctl(fd, RTC_PIE_ON, 0);
+		if (retval == -1) {
+			perror("RTC_PIE_ON ioctl");
+			exit(errno);
+		}
+
+		for (i=1; i<21; i++) {
+			gettimeofday(&start, NULL);
+			/* This blocks */
+			retval = read(fd, &data, sizeof(unsigned long));
+			if (retval == -1) {
+				perror("read");
+				exit(errno);
+			}
+			gettimeofday(&end, NULL);
+			timersub(&end, &start, &diff);
+			if (diff.tv_sec > 0 ||
+			    diff.tv_usec > ((1000000L / tmp) * 1.10)) {
+				fprintf(stderr, "\nPIE delta error: %ld.%06ld should be close to 0.%06ld\n",
+				       diff.tv_sec, diff.tv_usec,
+				       (1000000L / tmp));
+				fflush(stdout);
+				exit(-1);
+			}
+
+			fprintf(stderr, " %d",i);
+			fflush(stderr);
+			irqcount++;
+		}
+
+		/* Disable periodic interrupts */
+		retval = ioctl(fd, RTC_PIE_OFF, 0);
+		if (retval == -1) {
+			perror("RTC_PIE_OFF ioctl");
+			exit(errno);
+		}
+	}
+
+done:
+	fprintf(stderr, "\n\n\t\t\t *** Test complete ***\n");
+
+	close(fd);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/timers/rtctest.c b/tools/testing/selftests/timers/rtctest.c
index 411eff625e66..6e17b96551ec 100644
--- a/tools/testing/selftests/timers/rtctest.c
+++ b/tools/testing/selftests/timers/rtctest.c
@@ -94,10 +94,9 @@ static int compare_dates(struct rtc_time *a, struct rtc_time *b)
 int main(int argc, char **argv)
 {
 	int i, fd, retval, irqcount = 0, dangerous = 0;
-	unsigned long tmp, data;
+	unsigned long data;
 	struct rtc_time rtc_tm;
 	const char *rtc = default_rtc;
-	struct timeval start, end, diff;
 
 	switch (argc) {
 	case 3:
@@ -211,7 +210,7 @@ int main(int argc, char **argv)
 		if (errno == EINVAL) {
 			fprintf(stderr,
 				"\n...Alarm IRQs not supported.\n");
-			goto test_PIE;
+			goto test_DATE;
 		}
 
 		perror("RTC_ALM_SET ioctl");
@@ -224,7 +223,7 @@ int main(int argc, char **argv)
 		if (errno == EINVAL) {
 			fprintf(stderr,
 					"\n...EINVAL reading current alarm setting.\n");
-			goto test_PIE;
+			goto test_DATE;
 		}
 		perror("RTC_ALM_READ ioctl");
 		exit(errno);
@@ -239,7 +238,7 @@ int main(int argc, char **argv)
 		if (errno == EINVAL || errno == EIO) {
 			fprintf(stderr,
 				"\n...Alarm IRQs not supported.\n");
-			goto test_PIE;
+			goto test_DATE;
 		}
 
 		perror("RTC_AIE_ON ioctl");
@@ -264,80 +263,6 @@ int main(int argc, char **argv)
 		exit(errno);
 	}
 
-test_PIE:
-	/* Read periodic IRQ rate */
-	retval = ioctl(fd, RTC_IRQP_READ, &tmp);
-	if (retval == -1) {
-		/* not all RTCs support periodic IRQs */
-		if (errno == EINVAL) {
-			fprintf(stderr, "\nNo periodic IRQ support\n");
-			goto test_DATE;
-		}
-		perror("RTC_IRQP_READ ioctl");
-		exit(errno);
-	}
-	fprintf(stderr, "\nPeriodic IRQ rate is %ldHz.\n", tmp);
-
-	fprintf(stderr, "Counting 20 interrupts at:");
-	fflush(stderr);
-
-	/* The frequencies 128Hz, 256Hz, ... 8192Hz are only allowed for root. */
-	for (tmp=2; tmp<=64; tmp*=2) {
-
-		retval = ioctl(fd, RTC_IRQP_SET, tmp);
-		if (retval == -1) {
-			/* not all RTCs can change their periodic IRQ rate */
-			if (errno == EINVAL) {
-				fprintf(stderr,
-					"\n...Periodic IRQ rate is fixed\n");
-				goto test_DATE;
-			}
-			perror("RTC_IRQP_SET ioctl");
-			exit(errno);
-		}
-
-		fprintf(stderr, "\n%ldHz:\t", tmp);
-		fflush(stderr);
-
-		/* Enable periodic interrupts */
-		retval = ioctl(fd, RTC_PIE_ON, 0);
-		if (retval == -1) {
-			perror("RTC_PIE_ON ioctl");
-			exit(errno);
-		}
-
-		for (i=1; i<21; i++) {
-			gettimeofday(&start, NULL);
-			/* This blocks */
-			retval = read(fd, &data, sizeof(unsigned long));
-			if (retval == -1) {
-				perror("read");
-				exit(errno);
-			}
-			gettimeofday(&end, NULL);
-			timersub(&end, &start, &diff);
-			if (diff.tv_sec > 0 ||
-			    diff.tv_usec > ((1000000L / tmp) * 1.10)) {
-				fprintf(stderr, "\nPIE delta error: %ld.%06ld should be close to 0.%06ld\n",
-				       diff.tv_sec, diff.tv_usec,
-				       (1000000L / tmp));
-				fflush(stdout);
-				exit(-1);
-			}
-
-			fprintf(stderr, " %d",i);
-			fflush(stderr);
-			irqcount++;
-		}
-
-		/* Disable periodic interrupts */
-		retval = ioctl(fd, RTC_PIE_OFF, 0);
-		if (retval == -1) {
-			perror("RTC_PIE_OFF ioctl");
-			exit(errno);
-		}
-	}
-
 test_DATE:
 	if (!dangerous)
 		goto done;
-- 
2.17.0
