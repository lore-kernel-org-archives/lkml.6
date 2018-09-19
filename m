Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F8AECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2503521571
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="e93Uq9IB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2503521571
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733176AbeITCav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:30:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37433 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733121AbeITCat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id a20-v6so6041886edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VopBSEwitIpT7IZdHiVx92lBu5moRZLzTfTwrrJI6+8=;
        b=e93Uq9IBYm9NN9aZ/ySLPhC2Ht1aroFGRJ1X2C8xsIrnDQdJS6tDzv2e2x7WU4eTht
         WEA5swLJ6fxfWANc2AeZmWAzNHjSGkfoYCl2GSuhbYF6eSTswetxDgWxl7hn4U4r3krp
         vIYEY5Fffv3nWTydhA+lDxx/R5CcZsE/xbL/x0iAuD1hl+FCq5RfJlwAdd3389lR6OW9
         CFmOLRkB9mYl1ATk7vDiGMC5AVP7Cu/Dr2X7QgGi5HL5JB7kJ3IwBS7ehP3a2Jcjam7z
         UbFIOpcZauNzPa7heN3rfmX5V9UR7JjG0Yc+BaBhyJLjJRCtx86d+ghcPET5f3XeGzg+
         nJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VopBSEwitIpT7IZdHiVx92lBu5moRZLzTfTwrrJI6+8=;
        b=hxWQRAzhE33+GahPR8DDwCb2W9rJ2ixMfxolKcXf+XfhArswJX9ZUfwDmGV9Z+/PCA
         lCQbh8RaNgXrGTdEfzM/WrVhkbAKpZeh+R36UfinUFMEqk1DdEbo1lMbVBaFziMZUiYh
         N/YHYyVW9zFYIxpNa57eM/O++knxDIrHaV6REYRHGwA8VzJORvbAldL1/s/0y4SKrLEh
         3210uul/mIyEUvmswz8YL4UyuNLsHMonHtLREvjUhmCbSL5njZgXeqda6i9sfQ20tPaM
         DOEIbxtw0R+Cc3TkUY+iWtY03Ng+vam705caKHM1VgmBiWr72GqOik8ocyk7amkqvuhE
         E4qw==
X-Gm-Message-State: APzg51CeiZ9J+OEPuwQW32dOYZADC9P6uHgW1a51DnFK9GnionigPZ4m
        oBDC3Jdjag+qJRkcIM2znIkqBeAk6z0=
X-Google-Smtp-Source: ANB0VdYF7Lyopp8bBaKHYeCJR6ZzchHHzBtLj9aNnEVctM+qZ2vHaBkri0znS/328tWNpyIjqS9n7Q==
X-Received: by 2002:a50:b702:: with SMTP id g2-v6mr61136789ede.139.1537390268127;
        Wed, 19 Sep 2018 13:51:08 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:51:07 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC 19/20] timens/selftest: Add procfs selftest
Date:   Wed, 19 Sep 2018 21:50:36 +0100
Message-Id: <20180919205037.9574-20-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only uptime check, but procfs checks for REALTIME might be
added in future.

Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |   1 +
 tools/testing/selftests/timens/Makefile   |   2 +-
 tools/testing/selftests/timens/procfs.c   | 145 ++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/procfs.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 9b6c8ddac2c8..94ffdd9cead7 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,3 +1,4 @@
 clock_nanosleep
+procfs
 timens
 timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 76a1dc891184..f96f50d1fef8 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd clock_nanosleep
+TEST_GEN_PROGS := timens timerfd clock_nanosleep procfs
 
 CFLAGS := -Wall -Werror
 
diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
new file mode 100644
index 000000000000..5067cbbddcc5
--- /dev/null
+++ b/tools/testing/selftests/timens/procfs.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <math.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
+#include <time.h>
+
+#include "log.h"
+
+#ifndef CLONE_NEWTIME
+# define CLONE_NEWTIME	0x00001000
+#endif
+
+/*
+ * Test shouldn't be run for a day, so add 10 days to child
+ * time and check parent's time to be in the same day.
+ */
+#define MAX_TEST_TIME_SEC		(60*5)
+#define DAY_IN_SEC			(60*60*24)
+#define TEN_DAYS_IN_SEC			(10*DAY_IN_SEC)
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+static int child_ns, parent_ns;
+
+static int switch_ns(int fd)
+{
+	if (setns(fd, CLONE_NEWTIME))
+		return pr_perror("setns()");
+
+	return 0;
+}
+
+static int init_namespaces(void)
+{
+	char path[] = "/proc/self/ns/time";
+	struct stat st1, st2;
+
+	parent_ns = open(path, O_RDONLY);
+	if (parent_ns <= 0)
+		return pr_perror("Unable to open %s", path);
+
+	if (fstat(parent_ns, &st1))
+		return pr_perror("Unable to stat the parent timens");
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("Can't unshare() timens");
+
+	child_ns = open(path, O_RDONLY);
+	if (child_ns <= 0)
+		return pr_perror("Unable to open %s", path);
+
+	if (fstat(child_ns, &st2))
+		return pr_perror("Unable to stat the timens");
+
+	if (st1.st_ino == st2.st_ino)
+		return pr_err("The same child_ns after CLONE_NEWTIME");
+
+	return 0;
+}
+
+static int read_proc_uptime(struct timespec *uptime)
+{
+	unsigned long up_sec, up_nsec;
+	FILE *proc;
+
+	proc = fopen("/proc/uptime", "r");
+	if (proc == NULL) {
+		pr_perror("Unable to open /proc/uptime");
+		return -1;
+	}
+
+	if (fscanf(proc, "%lu.%02lu", &up_sec, &up_nsec) != 2) {
+		if (errno) {
+			pr_perror("fscanf");
+			return -errno;
+		}
+		pr_err("failed to parse /proc/uptime");
+		return -1;
+	}
+	fclose(proc);
+
+	uptime->tv_sec = up_sec;
+	uptime->tv_nsec = up_nsec;
+	return 0;
+}
+
+static int check_uptime(void)
+{
+	struct timespec ts_btime, uptime_new, uptime_old;
+	time_t uptime_expected;
+	double prec = MAX_TEST_TIME_SEC;
+
+	if (switch_ns(parent_ns))
+		return pr_err("switch_ns(%d)", parent_ns);
+
+	if (clock_gettime(CLOCK_BOOTTIME, &ts_btime))
+		return pr_perror("clock_gettime()");
+
+	if (read_proc_uptime(&uptime_old))
+		return 1;
+
+	ts_btime.tv_sec += TEN_DAYS_IN_SEC;
+
+	if (switch_ns(child_ns))
+		return pr_err("switch_ns(%d)", child_ns);
+
+	if (clock_settime(CLOCK_BOOTTIME, &ts_btime))
+		return pr_perror("clock_settime()");
+
+	if (read_proc_uptime(&uptime_new))
+		return 1;
+
+	uptime_expected = uptime_old.tv_sec + TEN_DAYS_IN_SEC;
+	if (fabs(difftime(uptime_new.tv_sec, uptime_expected)) > prec) {
+		pr_fail("uptime in /proc/uptime: old %ld, new %ld [%ld]",
+			uptime_old.tv_sec, uptime_new.tv_sec,
+			uptime_old.tv_sec + TEN_DAYS_IN_SEC);
+		return 1;
+	}
+
+	pr_msg("Passed for /proc/uptime", "OK");
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = 0;
+
+	if (init_namespaces())
+		return 1;
+
+	ret |= check_uptime();
+
+	return ret;
+}
-- 
2.13.6

