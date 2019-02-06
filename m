Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B70C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502DF2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="isj724TP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfBFALs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:11:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36776 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfBFALp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:45 -0500
Received: by mail-ed1-f66.google.com with SMTP id d12so3445559edy.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WNAadzlGShFp88tN5oZN8oGMjlN0KV8n9+OjpGdbo7U=;
        b=isj724TPBuwVcGNGGsL6SA9D84/N7TBxjk5m2YYcRtblCx/ZL96WaKbvF4h+sg5Z7e
         JUYWDhwtk/HAeYFTWwoP90OGvNsazFHZzEghdEjqiFnnRAwLHLnzvDPdxjk1dV29t959
         OBO4pxKVQCYUzee1tBrgr8vEQQkqlf9giiY32cTxUIU3wAt81M4O4GgYOft6ZdnEJX4N
         b9cyfWxCmIXmcOpcoRMswFaxGCgZjeSv8mpPNS8/VcnOigk0jV/iFum7Xk0XWSgL2vt1
         WjKKyc41uUA3yQOYbIKbIwYgdXZIX3AA1bkKVyJD4p6C02OIufQ/k2czvcrJEVbtyY4c
         UBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNAadzlGShFp88tN5oZN8oGMjlN0KV8n9+OjpGdbo7U=;
        b=fSgJdh103OhHDbWzfsvH/EicYOwZFsTsWku8lEVnVgjto9n2A6hjbtHd/oFTOnav+l
         kzMpdAcUMaaXoQKDxpP5NsuVGvv6nL+CQ7YW19QsjTJY6btSntjAyjdpDSS1MYmevLNs
         i8EnZ+yA6efggRmLGa90Kaeh87LmdHIdyiNNbMiFQIqX396qgSIrg0DxMwlS5UXtM+UU
         zodb4FdwSCFNB3Uq5Q3JYS0P1w/cOzEbhbhVkrt6X8OrOO5OzYX9z1C2EPYgC3D5DWGh
         z49FF3dzX4rMvlKuZ58IV2xA/cegbD+tlb+tSvoF/AwFxgAAjOYC9wZHmStTmfV5exBr
         1lPw==
X-Gm-Message-State: AHQUAuahSPD9i/GCAkBPFkFN4xNHG3Z27MFPG/wzfWef78Ts7CLJVkhZ
        DVfmyjq8B3iK59g2V4jr4keckv1bY+Y=
X-Google-Smtp-Source: AHgI3IZFRg8BVjaBxLWqszGq7OO6RkLtWyivl3GrM8Dhg7IWgKTuQDOWQdQPyQjr4BjzB8ajMULZ9g==
X-Received: by 2002:aa7:c88e:: with SMTP id p14mr3990134eds.51.1549411903060;
        Tue, 05 Feb 2019 16:11:43 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:42 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 25/32] selftest/timens: Add a test for timerfd
Date:   Wed,  6 Feb 2019 00:10:59 +0000
Message-Id: <20190206001107.16488-26-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Check that timerfd_create() takes into account clock offsets.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |   1 +
 tools/testing/selftests/timens/Makefile   |   2 +-
 tools/testing/selftests/timens/timerfd.c  | 119 ++++++++++++++++++++++
 3 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/timerfd.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 27a693229ce1..b609f6ee9fb9 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1 +1,2 @@
 timens
+timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index b877efb78974..66b90cd28e5c 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens
+TEST_GEN_PROGS := timens timerfd
 
 CFLAGS := -Wall -Werror
 
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
new file mode 100644
index 000000000000..8ec2604d26c9
--- /dev/null
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <sys/timerfd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+
+#include "log.h"
+#include "timens.h"
+
+int run_test(int clockid, struct timespec now)
+{
+	struct itimerspec new_value;
+	long long elapsed;
+	int fd, i;
+
+	if (clock_gettime(clockid, &now))
+		return pr_perror("clock_gettime");
+
+	for (i = 0; i < 2; i++) {
+		int flags = 0;
+
+		new_value.it_value.tv_sec = 3600;
+		new_value.it_value.tv_nsec = 0;
+		new_value.it_interval.tv_sec = 1;
+		new_value.it_interval.tv_nsec = 0;
+
+		if (i == 1) {
+			new_value.it_value.tv_sec += now.tv_sec;
+			new_value.it_value.tv_nsec += now.tv_nsec;
+		}
+
+		fd = timerfd_create(clockid, 0);
+		if (fd == -1)
+			return pr_perror("timerfd_create");
+
+		if (i == 1)
+			flags |= TFD_TIMER_ABSTIME;
+
+		if (timerfd_settime(fd, flags, &new_value, NULL))
+			return pr_perror("timerfd_settime");
+
+		if (timerfd_gettime(fd, &new_value))
+			return pr_perror("timerfd_gettime");
+
+		elapsed = new_value.it_value.tv_sec;
+		if (abs(elapsed - 3600) > 60) {
+			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
+					      clockid, elapsed);
+			return 1;
+		}
+
+		close(fd);
+	}
+
+	ksft_test_result_pass("clockid=%d\n", clockid);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, status, len, fd;
+	char buf[4096];
+	pid_t pid;
+	struct timespec btime_now, mtime_now;
+
+	nscheck();
+
+	clock_gettime(CLOCK_MONOTONIC, &mtime_now);
+	clock_gettime(CLOCK_BOOTTIME, &btime_now);
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("unshare");
+
+	len = snprintf(buf, sizeof(buf), "%d %d 0\n%d %d 0",
+			CLOCK_MONOTONIC, 70 * 24 * 3600,
+			CLOCK_BOOTTIME, 9 * 24 * 3600);
+	fd = open("/proc/self/timens_offsets", O_WRONLY);
+	if (fd < 0)
+		return pr_perror("/proc/self/timens_offsets");
+
+	if (write(fd, buf, len) != len)
+		return pr_perror("/proc/self/timens_offsets");
+
+	close(fd);
+	mtime_now.tv_sec += 70 * 24 * 3600;
+	btime_now.tv_sec += 9 * 24 * 3600;
+
+	pid = fork();
+	if (pid < 0)
+		return pr_perror("Unable to fork");
+	if (pid == 0) {
+		ret = 0;
+		ret |= run_test(CLOCK_BOOTTIME, btime_now);
+		ret |= run_test(CLOCK_MONOTONIC, mtime_now);
+
+		if (ret)
+			ksft_exit_fail();
+		ksft_exit_pass();
+		return ret;
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Unable to wait the child process");
+
+	if (WIFEXITED(status))
+		return WEXITSTATUS(status);
+
+	return 1;
+}
+
-- 
2.20.1

