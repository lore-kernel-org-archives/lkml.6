Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCF3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E7920651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="UAiSTzN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393115AbfAPNTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:19:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38640 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731240AbfAPNTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:19:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so6897390wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 05:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TBgI0/G3+ypI3YCZeUDVPUzIoSqUrcTSJaTWmjXaKf4=;
        b=UAiSTzN+DQpjLxdd5pTmsvdHOU7RJ6lkSDr8aGnQ9IscfbPuVmjO3E8KxFxZA+82rW
         Jb8ddpqP/lyRgsznYMWzIeeW2KpGjJvSUCYTUtjSdcfR4L7z0bwvEaXXq9jnnc4NFwBk
         s39MfTEZVU8XJLbe4wMKU8dhhI0xhu8xtvdfZkqjSh6PtS52iEhR9hrkDI3AeBee93Mz
         LExv6mtTqrsKxGWIR4eZabjb49QCZ1OeHRjwlS3d33L4gQOYvvLqMnX80QxcY0jsbVte
         1b7K/GJwaUF6l2/IDB2w6jBo7uEXybiGxkZaZAtDYedxF2BROArciGYX1qizezk1AZ0w
         V4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TBgI0/G3+ypI3YCZeUDVPUzIoSqUrcTSJaTWmjXaKf4=;
        b=mzN6pa8r21DcbDbpoYp4vWlTxZ/+6ekSZkiunvgtU4vWAhWNB39RWONzCIMaKVjqe8
         Lui9TbZvU1P53cAiM070NrMZ4MxIQgouiQsI2NiQ5cdI8Zw3Q8jsR3hlYs3RUfevpR0n
         KhvoLqj36lSp8zWVbqmoyl4ARY1+XxBH5GQM2Cchpaq4igVQ6aKTU+4HdQbg2vUlpLTp
         GX9bikeB0I4Uwb++yGrQU+c00q9iW7TLSqVfQeTlVstjaGB1aM1DuI8uYfjtkeROaGUS
         AQUt2v8ZXMWB9xdiCfZlMBvpoYBqUkVUjMgF/g2u0j57TYwz4A95vsQEGVOikPSbbSs9
         Lu8Q==
X-Gm-Message-State: AJcUukdLRuEzQ9uzQ6lAapFidnTeoO/GXI0dbNN9xIYviMUtaAkkAeAG
        HkF/Z+u/vBL8i4PS0iaCcaPMXw==
X-Google-Smtp-Source: ALg8bN5C6v13mgL7u4YTr4EmzwqBpzhrtdonpaLqLd/Xjdw4Z3ZI/oWaP+AndykrjQx2nTCuNcxpZg==
X-Received: by 2002:adf:b307:: with SMTP id j7mr8057788wrd.46.1547644754318;
        Wed, 16 Jan 2019 05:19:14 -0800 (PST)
Received: from localhost.localdomain ([154.119.33.254])
        by smtp.gmail.com with ESMTPSA id x10sm96423440wrn.29.2019.01.16.05.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:19:13 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH] selftests: add binderfs selftests
Date:   Wed, 16 Jan 2019 14:19:03 +0100
Message-Id: <20190116131903.8515-1-christian@brauner.io>
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
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/binderfs/.gitignore |   1 +
 .../selftests/filesystems/binderfs/Makefile   |   6 +
 .../filesystems/binderfs/binderfs_test.c      | 120 ++++++++++++++++++
 .../selftests/filesystems/binderfs/config     |   3 +
 5 files changed, 131 insertions(+)
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
index 000000000000..ca4d9b616e84
--- /dev/null
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -0,0 +1,120 @@
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
+	if (ret < 0)
+		ksft_exit_fail_msg("%s - Failed to mount binderfs\n",
+				   strerror(errno));
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

