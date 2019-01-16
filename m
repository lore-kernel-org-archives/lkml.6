Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1503DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C562620652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="F4vXE/WU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733194AbfAPW2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:28:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45402 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730972AbfAPW2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:28:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so8766035wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 14:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4DHCkv2lu1CPlpTJrlHIOhL8OGBKrQypMFbimNXXGE=;
        b=F4vXE/WU9IfPz2F6f/BEMChmW7sAluWtkpCXpO7EmcmzNcfL2IwYRVExLFJ+ioULEI
         bJnqJNQPOPm7Oc7zEA1IaW5p6i4P5iUqiH7R+NBtSNvf1+9r2MDTGaexWKHoH2GO+Fqm
         RZqGxyKj+IdzLkpvOKsso4wvF/FaDEo6IcHDza8HIhkM+Okn73HmZR+KKr/21W1X71mi
         gob79aCJUQIiCRgTfaj1nCSAn0W0nySUIqGhKUTlWiKITvn+TSSCVh+ebGHVNqFn+E4C
         BHvP2gcwuUTOQIg7p6IrLQ5UGGijMnP8Qi+9HS62JCe0FQUgk8T5V6CZHO+MRqyKDjaE
         CNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4DHCkv2lu1CPlpTJrlHIOhL8OGBKrQypMFbimNXXGE=;
        b=cOxcyW+oDI5L80alRz7dM0el2j+O5WhipapcNfw5q0YWIcmMfuwxqyMdP7QeRSr2vU
         j7RR6c81fX2fl1Iq0Tor9YUUpJ3BtjBS4dOgFm5CK1Fp9J73rXMoB+xcgLQ55TpXIMXj
         PHASA4NGt+S9WxxZyFzUBME80QiTkDRhFa0jhc63YwRoKKxKKKb2ScPJEU8nVrA5X5i9
         Hii6BC/1BbJH4ozEa8VwiaD85RLNT79EpGzynTzx5y45r1HiUyunLR7X8+U8C5vcFqFN
         79eu8j5I2J7my6IRSRJC6TBOpu5O4HmXt5VGD5w+QFSCFlqHuiYZI0mBZoo8FtSOwNi2
         VNZg==
X-Gm-Message-State: AJcUukc28vxWgnXLJlaBBtsu0Ds3zi1HUviYji2AhfF+Vrad5GhBDUjV
        ntxVmydgAsPwzoxT9qtKziUE74UXXo07Ag==
X-Google-Smtp-Source: ALg8bN7YU3GdBt9L/LNm88Tib8RnYGxdHmF3XXufcMjlFgiNgzrvZczt17HKWdwQ0OA5/p674LrrMw==
X-Received: by 2002:a5d:42ce:: with SMTP id t14mr9461741wrr.51.1547677682753;
        Wed, 16 Jan 2019 14:28:02 -0800 (PST)
Received: from localhost.localdomain ([154.119.55.246])
        by smtp.gmail.com with ESMTPSA id a18sm98332964wrp.13.2019.01.16.14.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 14:28:02 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, shuah@kernel.org,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1] selftests: add binderfs selftests
Date:   Wed, 16 Jan 2019 23:27:45 +0100
Message-Id: <20190116222745.26217-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the promised selftest for binderfs. It will verify the following
things:
- binderfs mounting works
- binder device allocation works
- performing a binder ioctl() request through a binderfs device works
- binder device removal works
- binder-control removal fails
- binderfs unmounting works

Cc: Todd Kjos <tkjos@google.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* Changelog */

v1:
- check for ENODEV on mount failure to detect whether binderfs is
  available
  If it is not, skip the test and exit with success.
---
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/binderfs/.gitignore |   1 +
 .../selftests/filesystems/binderfs/Makefile   |   6 +
 .../filesystems/binderfs/binderfs_test.c      | 126 ++++++++++++++++++
 .../selftests/filesystems/binderfs/config     |   3 +
 5 files changed, 137 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/binderfs/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/binderfs/Makefile
 create mode 100644 tools/testing/selftests/filesystems/binderfs/binderfs_test.c
 create mode 100644 tools/testing/selftests/filesystems/binderfs/config

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 1a2bd15c5b6e..400ee81a3043 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -10,6 +10,7 @@ TARGETS += drivers/dma-buf
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += filesystems
+TARGETS += filesystems/binderfs
 TARGETS += firmware
 TARGETS += ftrace
 TARGETS += futex
diff --git a/tools/testing/selftests/filesystems/binderfs/.gitignore b/tools/testing/selftests/filesystems/binderfs/.gitignore
new file mode 100644
index 000000000000..8a5d9bf63dd4
--- /dev/null
+++ b/tools/testing/selftests/filesystems/binderfs/.gitignore
@@ -0,0 +1 @@
+binderfs_test
diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile b/tools/testing/selftests/filesystems/binderfs/Makefile
new file mode 100644
index 000000000000..58cb659b56b4
--- /dev/null
+++ b/tools/testing/selftests/filesystems/binderfs/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -I../../../../../usr/include/
+TEST_GEN_PROGS := binderfs_test
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
new file mode 100644
index 000000000000..34361efcb9c8
--- /dev/null
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <linux/android/binder.h>
+#include <linux/android/binderfs.h>
+#include "../../kselftest.h"
+
+int main(int argc, char *argv[])
+{
+	int fd, ret, saved_errno;
+	size_t len;
+	struct binderfs_device device = { 0 };
+	struct binder_version version = { 0 };
+
+	ret = unshare(CLONE_NEWNS);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s - Failed to unshare mount namespace\n",
+				   strerror(errno));
+
+	ret = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s - Failed to mount / as private\n",
+				   strerror(errno));
+
+	ret = mkdir("/dev/binderfs", 0755);
+	if (ret < 0 && errno != EEXIST)
+		ksft_exit_fail_msg(
+			"%s - Failed to create binderfs mountpoint\n",
+			strerror(errno));
+
+	ret = mount(NULL, "/dev/binderfs", "binder", 0, 0);
+	if (ret < 0) {
+		if (errno != ENODEV)
+			ksft_exit_fail_msg("%s - Failed to mount binderfs\n",
+					   strerror(errno));
+
+		ksft_test_result_skip(
+			"The Android binderfs filesystem is not available\n");
+		ksft_exit_pass();
+	}
+
+	/* binderfs mount test passed */
+	ksft_inc_pass_cnt();
+
+	memcpy(device.name, "my-binder", strlen("my-binder"));
+
+	fd = open("/dev/binderfs/binder-control", O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		ksft_exit_fail_msg(
+			"%s - Failed to open binder-control device\n",
+			strerror(errno));
+
+	ret = ioctl(fd, BINDER_CTL_ADD, &device);
+	saved_errno = errno;
+	close(fd);
+	errno = saved_errno;
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s - Failed to allocate new binder device\n",
+			strerror(errno));
+
+	printf("Allocated new binder device with major %d, minor %d, and name %s\n",
+	       device.major, device.minor, device.name);
+
+	/* binder device allocation test passed */
+	ksft_inc_pass_cnt();
+
+	fd = open("/dev/binderfs/my-binder", O_CLOEXEC | O_RDONLY);
+	if (fd < 0)
+		ksft_exit_fail_msg("%s - Failed to open my-binder device\n",
+				   strerror(errno));
+
+	ret = ioctl(fd, BINDER_VERSION, &version);
+	saved_errno = errno;
+	close(fd);
+	errno = saved_errno;
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s - Failed to open perform BINDER_VERSION request\n",
+			strerror(errno));
+
+	printf("Detected binder version: %d\n", version.protocol_version);
+
+	/* binder transaction with binderfs binder device passed */
+	ksft_inc_pass_cnt();
+
+	ret = unlink("/dev/binderfs/my-binder");
+	if (ret < 0)
+		ksft_exit_fail_msg("%s - Failed to delete binder device\n",
+				   strerror(errno));
+
+	/* binder device removal passed */
+	ksft_inc_pass_cnt();
+
+	ret = unlink("/dev/binderfs/binder-control");
+	if (!ret)
+		ksft_exit_fail_msg("Managed to delete binder-control device\n");
+	else if (errno != EPERM)
+		ksft_exit_fail_msg(
+			"%s - Failed to delete binder-control device but exited with unexpected error code\n",
+			strerror(errno));
+
+	/* binder-control device removal failed as expected */
+	ksft_inc_xfail_cnt();
+
+	ret = umount2("/dev/binderfs", MNT_DETACH);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s - Failed to unmount binderfs\n",
+				   strerror(errno));
+
+	/* binderfs unmount test passed */
+	ksft_inc_pass_cnt();
+
+	ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/filesystems/binderfs/config b/tools/testing/selftests/filesystems/binderfs/config
new file mode 100644
index 000000000000..02dd6cc9cf99
--- /dev/null
+++ b/tools/testing/selftests/filesystems/binderfs/config
@@ -0,0 +1,3 @@
+CONFIG_ANDROID=y
+CONFIG_ANDROID_BINDERFS=y
+CONFIG_ANDROID_BINDER_IPC=y
-- 
2.19.1

