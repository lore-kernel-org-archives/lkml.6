Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AEEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 11:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A73020815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 11:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bgfLMctW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A73020815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeKRVjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 16:39:05 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46534 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeKRVjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 16:39:05 -0500
Received: by mail-pf1-f196.google.com with SMTP id s9-v6so13450910pfm.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 03:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sr/YAS5A8nbnT6moa52OmOireUJYzp13AdRqM/U1tAw=;
        b=bgfLMctWkDLMW7Pg0mkk8ui4LovwK/Q168HKPhnsOliKxBKI5sKBOY6yu9zMA6aKtU
         uFa9zHK82osPG8X5SvM9qN/NkcMtrYyfqRAZd32HngPxdmw4iE9TAJT2YzWxv32XoOsx
         Aux7JvtY1+b5olHKUQmSyw98+ArlYekGeOkWH1jp+BP6UYaAItMUHxsKM9j5rMsms0bd
         0Rs7fNexmqMqeFZC1iXTepcZmUEa+kBTsZnAD1UfjBfPRYafBCgXr7/L6ZXbEv2dMLI7
         +Caf8cjc4lZFN9MJp/aSjnMiJKqvkig764IOegRF3yC4nRlpfK5RxwtuUWwt359yNJXx
         PgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sr/YAS5A8nbnT6moa52OmOireUJYzp13AdRqM/U1tAw=;
        b=bRxZ4n551NyLUknmAr6/eWsigkH4QoUO4UFcFhTsJlCWzAl3KQXfjbE7KG7nIDsLGW
         fSjqX9rn/ia62cIvANhvODipEjg0EWQoOlIjYpNCrqhvef3rchlZkXN2e0HFA88JMMFn
         EIH9BJNmq/U9ejdjsrVvjacfUS8RYLrUBA6RwpCPXRjU6W/0us+JyTuwTuuJ7X4/tb+s
         Uxh5PtbLFOPDGs7IA5/xIGS4RnkPYUcdtzL9gMVMVuJiqctTyGk9xs3IYNckBMN7N08w
         rfdqWdSClcWjcPgRWkDNPt+1mCFy3lqt1rJv9WZdE6CsPBgZsVG3oLm9sRe+LBwPweLB
         uiIQ==
X-Gm-Message-State: AGRZ1gKJaRju55rvkP9S0de/P+zTiaJuBQHsvVnvGfepsORy+wxoSX70
        TE8GJQb0Fopmpl3+c6tyaOf7hA==
X-Google-Smtp-Source: AJdET5ftoTeSf1SWrTAXdOsws8AEXagw8SrRidqpe77304ei0vTon/DNX2zUlpAyTW4TqT7R8YBPrw==
X-Received: by 2002:a63:561b:: with SMTP id k27mr16369642pgb.271.1542539940831;
        Sun, 18 Nov 2018 03:19:00 -0800 (PST)
Received: from localhost.localdomain ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id b5-v6sm46554380pfe.60.2018.11.18.03.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 03:18:59 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] proc: allow killing processes via file descriptors
Date:   Sun, 18 Nov 2018 12:17:51 +0100
Message-Id: <20181118111751.6142-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch an open() call on /proc/<pid> will give userspace a handle
to struct pid of the process associated with /proc/<pid>. This allows to
maintain a stable handle on a process.
I have been discussing various approaches extensively during technical
conferences this year culminating in a long argument with Eric at Linux
Plumbers. The general consensus was that having a handle on a process
will be something that is very simple and easy to maintain with the
option of being extensible via a more advanced api if the need arises. I
believe that this patch is the most simple, dumb, and therefore
maintainable solution.

The need for this has arisen in order to reliably kill a process without
running into issues of the pid being recycled as has been described in the
rejected patch [1]. To fulfill the need described in that patchset a new
ioctl() PROC_FD_SIGNAL is added. It can be used to send signals to a
process via a file descriptor:

int fd = open("/proc/1234", O_DIRECTORY | O_CLOEXEC);
ioctl(fd, PROC_FD_SIGNAL, SIGKILL);
close(fd);

Note, the stable handle will allow us to carefully extend this feature in
the future.

[1]: https://lkml.org/lkml/2018/10/30/118

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
 fs/proc/base.c              | 33 +++++++++++++++++++++++++++++++++
 include/uapi/linux/procfd.h | 11 +++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 include/uapi/linux/procfd.h

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ce3465479447..dfde564a21eb 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -88,6 +88,7 @@
 #include <linux/fs_struct.h>
 #include <linux/slab.h>
 #include <linux/sched/autogroup.h>
+#include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/coredump.h>
 #include <linux/sched/debug.h>
@@ -95,6 +96,7 @@
 #include <linux/flex_array.h>
 #include <linux/posix-timers.h>
 #include <trace/events/oom.h>
+#include <uapi/linux/procfd.h>
 #include "internal.h"
 #include "fd.h"
 
@@ -3032,10 +3034,41 @@ static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
 				   tgid_base_stuff, ARRAY_SIZE(tgid_base_stuff));
 }
 
+static int proc_tgid_open(struct inode *inode, struct file *file)
+{
+	/* grab reference to struct pid */
+	file->private_data = get_pid(proc_pid(inode));
+	return 0;
+}
+
+static int proc_tgid_release(struct inode *inode, struct file *file)
+{
+	struct pid *pid = file->private_data;
+	/* drop reference to struct pid */
+	put_pid(pid);
+	return 0;
+}
+
+static long proc_tgid_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct pid *pid = file->private_data;
+
+	switch (cmd) {
+	case PROC_FD_SIGNAL:
+		return kill_pid(pid, arg, 1);
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct file_operations proc_tgid_base_operations = {
+	.open		= proc_tgid_open,
 	.read		= generic_read_dir,
 	.iterate_shared	= proc_tgid_base_readdir,
 	.llseek		= generic_file_llseek,
+	.release	= proc_tgid_release,
+	.unlocked_ioctl	= proc_tgid_ioctl,
 };
 
 static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
diff --git a/include/uapi/linux/procfd.h b/include/uapi/linux/procfd.h
new file mode 100644
index 000000000000..8e4c07a9f3a3
--- /dev/null
+++ b/include/uapi/linux/procfd.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __LINUX_PROCFD_H
+#define __LINUX_PROCFD_H
+
+#include <linux/ioctl.h>
+
+/* Returns a file descriptor that refers to a struct pid */
+#define PROC_FD_SIGNAL		_IOW('p', 1, __s32)
+
+#endif /* __LINUX_PROCFD_H */
+
-- 
2.19.1

