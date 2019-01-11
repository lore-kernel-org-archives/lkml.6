Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9DCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9339A2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Co4XwMqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbfAKNlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:41:11 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42335 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbfAKNlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:41:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id y20so13105274edw.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 05:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1umRdh9piMshUzKmNMUk5PrC5PY0/mUY/eZpS9XG6U0=;
        b=Co4XwMqiADoxVdJdwEd5GRwt7nX7YyxmjawClKKPfKsbZeWWZ6aqT6JNmaMME02xQa
         jei/KeZFlhJiAHkZu64WDPxskhWlBJUrraK0+eT0isTOKXNQsPAjp9SO53Xit1gE6sUB
         TFwW41xnp8WnCPiSpjXocVAWPL+dnEWxrsk09hnBYXA6CjM95/H8ZzwC5T6vhxcjEG3Q
         zBzmRXy+xS54IiP4nOIzARKDKjvfGp34tGeS6aO8Y2UfY3K+Jm75j2PTvAkde/32NCLj
         kVIXMhDCWuJk8FXt8PRPRaFDFHt5+s3PGyHFfvTfbjcXg6c+mFFIvBBqIZZKgjVoEzPb
         7dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1umRdh9piMshUzKmNMUk5PrC5PY0/mUY/eZpS9XG6U0=;
        b=dcN35LAOItLtbaLjGBeg/ukok7l7OqLg9Fbym3mTOeieDRyeQuenszR8p2lMjeJFZ7
         jSkjlLlarmm3HuJgfweODC5M605DLy9av35GQLldUDIz+aEL/6sjBF8PVgQxBvflH0em
         M9FikQWt2iXMp/6B+6t1qo1pvcnsg63m6IgfxJvLIjXwE4qZTCVOykuET2aaPZ2ExVx2
         c4uD+RAOvTUDXJ63haROKt7+476O1mxCVoLhWG+wm8jpoMkig0s80azE/U8QDWn2nm7M
         Iv1/lw48jYBS8TtzLul+5fIycHZXnACc4UzcTUyrecJA/BVibhykGcHHZz3Qha+SFe41
         cTxg==
X-Gm-Message-State: AJcUukesJGE/wOH32pHaZ7KBeyPl6wuxURmq0pxspkLKqoBmpA1d5WQi
        lfXJ/3tgSx18uHv1fYEmgUuK6EXodoP6eA==
X-Google-Smtp-Source: ALg8bN4bRXesRD6972GHiQzasQNPy/lEEvqwOsrNgqXJxYSzs0nmBJZTPUAHi/0UUViR/fLUg8ZSNg==
X-Received: by 2002:a17:906:6308:: with SMTP id p8-v6mr11907660ejk.100.1547214066122;
        Fri, 11 Jan 2019 05:41:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6c0:d6c:2520:8b:922b:4c43])
        by smtp.gmail.com with ESMTPSA id a38sm2312070edd.44.2019.01.11.05.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 05:41:05 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 2/2] samples: add binderfs sample program
Date:   Fri, 11 Jan 2019 14:41:00 +0100
Message-Id: <20190111134100.24095-2-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111134100.24095-1-christian@brauner.io>
References: <20190111134100.24095-1-christian@brauner.io>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a simple sample program mounting binderfs and adding, then
removing a binder device.  Hopefully, it will be helpful to users who want
to know how binderfs is supposed to be used.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* Changelog */
v1:
- patch introduced

v0:
- patch not present
---
 samples/Kconfig                     |  7 +++
 samples/Makefile                    |  2 +-
 samples/binderfs/Makefile           |  1 +
 samples/binderfs/binderfs_example.c | 83 +++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 samples/binderfs/Makefile
 create mode 100644 samples/binderfs/binderfs_example.c

diff --git a/samples/Kconfig b/samples/Kconfig
index ad1ec7016d4c..d19754ccad08 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -147,6 +147,13 @@ config SAMPLE_VFIO_MDEV_MBOCHS
 	  Specifically it does *not* include any legacy vga stuff.
 	  Device looks a lot like "qemu -device secondary-vga".
 
+config SAMPLE_ANDROID_BINDERFS
+	bool "Build Android binderfs example"
+	depends on CONFIG_ANDROID_BINDERFS
+	help
+	  Builds a sample program to illustrate the use of the Android binderfs
+	  filesystem.
+
 config SAMPLE_STATX
 	bool "Build example extended-stat using code"
 	depends on BROKEN
diff --git a/samples/Makefile b/samples/Makefile
index bd601c038b86..b1142a958811 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
 			   configfs/ connector/ v4l/ trace_printk/ \
-			   vfio-mdev/ statx/ qmi/
+			   vfio-mdev/ statx/ qmi/ binderfs/
diff --git a/samples/binderfs/Makefile b/samples/binderfs/Makefile
new file mode 100644
index 000000000000..01ca9f2529a7
--- /dev/null
+++ b/samples/binderfs/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SAMPLE_ANDROID_BINDERFS) += binderfs_example.o
diff --git a/samples/binderfs/binderfs_example.c b/samples/binderfs/binderfs_example.c
new file mode 100644
index 000000000000..5bbd2ebc0aea
--- /dev/null
+++ b/samples/binderfs/binderfs_example.c
@@ -0,0 +1,83 @@
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
+
+int main(int argc, char *argv[])
+{
+	int fd, ret, saved_errno;
+	size_t len;
+	struct binderfs_device device = { 0 };
+
+	ret = unshare(CLONE_NEWNS);
+	if (ret < 0) {
+		fprintf(stderr, "%s - Failed to unshare mount namespace\n",
+			strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	ret = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
+	if (ret < 0) {
+		fprintf(stderr, "%s - Failed to mount / as private\n",
+			strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	ret = mkdir("/dev/binderfs", 0755);
+	if (ret < 0 && errno != EEXIST) {
+		fprintf(stderr, "%s - Failed to create binderfs mountpoint\n",
+			strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	ret = mount(NULL, "/dev/binderfs", "binder", 0, 0);
+	if (ret < 0) {
+		fprintf(stderr, "%s - Failed to mount binderfs\n",
+			strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	memcpy(device.name, "my-binder", strlen("my-binder"));
+
+	fd = open("/dev/binderfs/binder-control", O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		fprintf(stderr, "%s - Failed to open binder-control device\n",
+			strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	ret = ioctl(fd, BINDER_CTL_ADD, &device);
+	saved_errno = errno;
+	close(fd);
+	errno = saved_errno;
+	if (ret < 0) {
+		fprintf(stderr, "%s - Failed to allocate new binder device\n",
+			strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	printf("Allocated new binder device with major %d, minor %d, and name %s\n",
+	       device.major, device.minor, device.name);
+
+	ret = unlink("/dev/binderfs/my-binder");
+	if (ret < 0) {
+		fprintf(stderr, "%s - Failed to delete binder device\n",
+			strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	/* Cleanup happens when the mount namespace dies. */
+	exit(EXIT_SUCCESS);
+}
-- 
2.19.1

