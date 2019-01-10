Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B56C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEA6213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="fDXMwTam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbfAJXNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:13:19 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40040 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfAJXNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:13:19 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so11591879edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 15:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HZd7aYmyoblkRUeGzG3dKNA8bmjh2OnCORdwspfF86k=;
        b=fDXMwTamTSL1+JQL/N3v84xbkkQT0Jd65cDFJ4DDCBU7brh2+dJlNy+oi0O+vZoQIm
         Ac754sgI1zCIg1EEurnB6lMqj62U9s5+4ugiAEqvBv8EeuwMEl/+qVsZU4i6ijW4gaPp
         W2XoCp2Nmus7JNTq+DarSeU+/Pyd5z6a9jpVc6+hx0SqpIP8N78s7TXrEjvPo63FgTJC
         aDCtVSFHhTgpxIKtu0bkiKqYjsJYgZ/nWoyGdRDpLQbLjXO4/nhV5s7Xv6c1Xx3+UO4F
         1fCRbFWXU2IldeKyHTvQA8NjTWx9T5NVzL2FcV0FRInhC4FXNNHw9Lf92KHQghRAyQnd
         2b7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HZd7aYmyoblkRUeGzG3dKNA8bmjh2OnCORdwspfF86k=;
        b=V3Kkvz9Q0DGQ1lZZQn42a/p83r9SoPOmsKBOtvReiYhKNv/pshiGF9fCbxnUZFx1xm
         O7hPUgrxZERiszuR7Bo1pyurvOLupQRV70gDzbjxDa5ouy2GbZAkRrktnU9D16GbXKFm
         K4C6Y46lCxq7l9KpbIswiOcLCWSpdaImZZJwVeXZRl6V0bTjr5FETJCfFtwcRGVyxqFt
         F58WcOC99ysc1v9OCTC0u2lp9ifAuTsJjelTtUzjDIQh0CeSFMekCHIsXO0UkhBF4J4D
         yq8+atuMeexl/SeIrBg/DI+xcyy7A6cZcHB/2ZP9sqkeGcgCAhO76syMYdYwFLiBHBW/
         sGoA==
X-Gm-Message-State: AJcUukfe0Zk2EQyLPycnjI3Amdy9GDOHxiFKiw2nM5dh90jrgs91SIFl
        aAWxWzryaxbV9g0f5c2R0Osp5A==
X-Google-Smtp-Source: ALg8bN71z3yyzbwgIOioHz0QWPVAqThmRgCiBMZFSXydGS/zycv0jXqTBOafLF4uCshTUkHI1Ygy2w==
X-Received: by 2002:a50:b902:: with SMTP id m2mr10812045ede.108.1547161996414;
        Thu, 10 Jan 2019 15:13:16 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6c0:d6c:c571:88:8aee:976c])
        by smtp.gmail.com with ESMTPSA id g21sm2342870edc.63.2019.01.10.15.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 15:13:15 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH] Documentation/filesystems: add binderfs
Date:   Fri, 11 Jan 2019 00:13:09 +0100
Message-Id: <20190110231309.12653-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents the Android binderfs filesystem used to dynamically add and
remove binder devices that are private to each instance.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 Documentation/filesystems/binderfs.txt | 109 +++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/filesystems/binderfs.txt

diff --git a/Documentation/filesystems/binderfs.txt b/Documentation/filesystems/binderfs.txt
new file mode 100644
index 000000000000..9c47eb33dd6a
--- /dev/null
+++ b/Documentation/filesystems/binderfs.txt
@@ -0,0 +1,109 @@
+
+The Android binderfs Filesystem
+===============================
+
+Android binderfs is a filesystem for the Android binder IPC mechanism.  It
+allows to dynamically add and remove binder devices at runtime.  Binder devices
+located in a new binderfs instance are independent of binder devices located in
+other binderfs instances.  Mounting a new binderfs instance makes it possible
+to get a set of private binder devices.
+
+Mounting binderfs
+-----------------
+
+Android binderfs can be mounted with:
+
+mkdir /dev/binderfs
+mount -t binder binder /dev/binderfs
+
+at which point a new instance of binderfs will show up at /dev/binderfs.  In a
+fresh instance of binderfs no binder devices will be present.  There will only
+be a binder-control device which serves as the request handler for binderfs.
+Mounting another binderfs instance at a different location will create a new
+and separate instance from all other binderfs mounts.  This is identical to the
+behavior of e.g. devpts and tmpfs.
+The Android binderfs filesystem can be mounted in user namespaces.
+
+Options
+-------
+
+Android binderfs does currently not support mount options.
+
+Allocating binder Devices
+-------------------------
+
+To allocate a new binder device in a binderfs instance a request needs to be
+sent through the binder-control device node.  A request is sent in the form of
+an ioctl(2).  Here’s an example program:
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <linux/android/binder_ctl.h>
+
+int main(int argc, char *argv[])
+{
+        int fd, ret, saved_errno;
+        size_t len;
+        struct binderfs_device device = { 0 };
+
+        if (argc != 3)
+                exit(EXIT_FAILURE);
+
+        len = strlen(argv[2]);
+        if (len > BINDERFS_MAX_NAME)
+                exit(EXIT_FAILURE);
+
+        memcpy(device.name, argv[2], len);
+
+        fd = open(argv[1], O_RDONLY | O_CLOEXEC);
+        if (fd < 0) {
+                printf("%s - Failed to open binder-control device\n",
+                       strerror(errno));
+                exit(EXIT_FAILURE);
+        }
+
+        ret = ioctl(fd, BINDER_CTL_ADD, &device);
+        saved_errno = errno;
+        close(fd);
+        errno = saved_errno;
+        if (ret < 0) {
+                printf("%s - Failed to allocate new binder device\n",
+                       strerror(errno));
+                exit(EXIT_FAILURE);
+        }
+
+        printf("Allocated new binder device with major %d, minor %d, and "
+               "name %s\n", device.major, device.minor,
+               device.name);
+
+        exit(EXIT_SUCCESS);
+}
+
+What this program simply does is to open the binder-control device node and
+sending a BINDER_CTL_ADD request to the kernel.  Users of binderfs need to tell
+the kernel which name the new binder device should get.  By default a name can
+only contain up to BINDERFS_MAX_NAME chars including the terminating zero byte.
+
+Once the request is made via an ioctl(2) passing a struct binder_device with
+the name to the kernel it will allocate a new binder device and return the
+major and minor number of the new device in the struct (This is necessary
+because binderfs allocates a major device number dynamically at boot.).  After
+the ioctl(2) returns there will be a new binder device located under
+/dev/binderfs with the chosen name.
+
+Deleting binder Devices
+-----------------------
+
+Binderfs binder devices can be deleted via unlink(2).  This means that the
+rm(1) tool can be used to delete them.
+Note that the binder-control device cannot be deleted since this would make the
+binderfs instance unuseable.  The binder-control device will be deleted when
+the binderfs instance is unmounted and all references to it have been dropped.
-- 
2.19.1

