Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D236C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD82120843
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ddz5Kkpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD82120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbeKABoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbeKABob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:44:31 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0710C2082E;
        Wed, 31 Oct 2018 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541004344;
        bh=QZ1sLdc8fd/P0agjc4T51rjMm2UNH1T++cLYurZu2IE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ddz5KkpwqBtJWvYWqoHP7VYZ8wyjOQhKN6nT9PTsYfSSQqPv2+s+dR6xdmn/sA1+V
         3b5ry+nWFVwl/TO36xpwocQJ5vo3Jg/JeRZVH0o+Ui3Cb5lXmfb+YCWe5kGgY+ybTj
         gV/CXZ8woGqr9YyKl98P9M3vM8lRxNqvPqmox03w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Benjamin Peterson <benjamin@python.org>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 06/28] perf trace beauty: Beautify mount/umount's 'flags' argument
Date:   Wed, 31 Oct 2018 13:44:46 -0300
Message-Id: <20181031164508.4784-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  # trace -e mount mount -o ro -t debugfs nodev /mnt
     0.000 ( 1.040 ms): mount/27235 mount(dev_name: 0x5601cc8c64e0, dir_name: 0x5601cc8c6500, type: 0x5601cc8c6480, flags: RDONLY) = 0
  # trace -e mount mount -o remount,relatime -t debugfs nodev /mnt
     0.000 ( 2.946 ms): mount/27262 mount(dev_name: 0x55f4a73d64e0, dir_name: 0x55f4a73d6500, type: 0x55f4a73d6480, flags: REMOUNT|RELATIME) = 0
  # trace -e mount mount -o remount,strictatime -t debugfs nodev /mnt
     0.000 ( 2.934 ms): mount/27265 mount(dev_name: 0x5617f71d94e0, dir_name: 0x5617f71d9500, type: 0x5617f71d9480, flags: REMOUNT|STRICTATIME) = 0
  # trace -e mount mount -o remount,suid,silent -t debugfs nodev /mnt
     0.000 ( 0.049 ms): mount/27273 mount(dev_name: 0x55ad65df24e0, dir_name: 0x55ad65df2500, type: 0x55ad65df2480, flags: REMOUNT|SILENT) = 0
  # trace -e mount mount -o remount,rw,sync,lazytime -t debugfs nodev /mnt
     0.000 ( 2.684 ms): mount/27281 mount(dev_name: 0x561216055530, dir_name: 0x561216055550, type: 0x561216055510, flags: SYNCHRONOUS|REMOUNT|LAZYTIME) = 0
  # trace -e mount mount -o remount,dirsync -t debugfs nodev /mnt
     0.000 ( 3.512 ms): mount/27314 mount(dev_name: 0x55c4e7188480, dir_name: 0x55c4e7188530, type: 0x55c4e71884a0, flags: REMOUNT|DIRSYNC, data: 0x55c4e71884e0) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Benjamin Peterson <benjamin@python.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-i5ncao73c0bd02qprgrq6wb9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf              |  8 +++++++
 tools/perf/builtin-trace.c            |  3 +++
 tools/perf/trace/beauty/Build         |  1 +
 tools/perf/trace/beauty/beauty.h      |  6 +++++
 tools/perf/trace/beauty/mount_flags.c | 43 +++++++++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+)
 create mode 100644 tools/perf/trace/beauty/mount_flags.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2f3bf025e305..a31c5c29d53a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -460,6 +460,12 @@ madvise_behavior_tbl := $(srctree)/tools/perf/trace/beauty/madvise_behavior.sh
 $(madvise_behavior_array): $(madvise_hdr_dir)/mman-common.h $(madvise_behavior_tbl)
 	$(Q)$(SHELL) '$(madvise_behavior_tbl)' $(madvise_hdr_dir) > $@
 
+mount_flags_array := $(beauty_outdir)/mount_flags_array.c
+mount_flags_tbl := $(srctree)/tools/perf/trace/beauty/mount_flags.sh
+
+$(mount_flags_array): $(linux_uapi_dir)/fs.h $(mount_flags_tbl)
+	$(Q)$(SHELL) '$(mount_flags_tbl)' $(linux_uapi_dir) > $@
+
 prctl_option_array := $(beauty_outdir)/prctl_option_array.c
 prctl_hdr_dir := $(srctree)/tools/include/uapi/linux/
 prctl_option_tbl := $(srctree)/tools/perf/trace/beauty/prctl_option.sh
@@ -577,6 +583,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(socket_ipproto_array) \
 	$(vhost_virtio_ioctl_array) \
 	$(madvise_behavior_array) \
+	$(mount_flags_array) \
 	$(perf_ioctl_array) \
 	$(prctl_option_array) \
 	$(arch_errno_name_array)
@@ -863,6 +870,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
 		$(OUTPUT)pmu-events/pmu-events.c \
 		$(OUTPUT)$(madvise_behavior_array) \
+		$(OUTPUT)$(mount_flags_array) \
 		$(OUTPUT)$(drm_ioctl_array) \
 		$(OUTPUT)$(pkey_alloc_access_rights_array) \
 		$(OUTPUT)$(sndrv_ctl_ioctl_array) \
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 14fb63e17de5..76c14c0129fc 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -726,6 +726,9 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* addr */ },
 		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
 		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ }, }, },
+	{ .name	    = "mount",
+	  .arg = { [3] = { .scnprintf = SCA_MOUNT_FLAGS, /* flags */
+			   .mask_val  = SCAMV_MOUNT_FLAGS, /* flags */ }, }, },
 	{ .name	    = "mprotect",
 	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* start */ },
 		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ }, }, },
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index c3b0afd67760..304313073242 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -5,6 +5,7 @@ ifeq ($(SRCARCH),$(filter $(SRCARCH),x86))
 libperf-y += ioctl.o
 endif
 libperf-y += kcmp.o
+libperf-y += mount_flags.o
 libperf-y += pkey_alloc.o
 libperf-y += prctl.o
 libperf-y += sockaddr.o
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index a1806c4f3ccd..039c29039b2c 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -123,6 +123,12 @@ size_t syscall_arg__scnprintf_kcmp_type(char *bf, size_t size, struct syscall_ar
 size_t syscall_arg__scnprintf_kcmp_idx(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_KCMP_IDX syscall_arg__scnprintf_kcmp_idx
 
+unsigned long syscall_arg__mask_val_mount_flags(struct syscall_arg *arg, unsigned long flags);
+#define SCAMV_MOUNT_FLAGS syscall_arg__mask_val_mount_flags
+
+size_t syscall_arg__scnprintf_mount_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_MOUNT_FLAGS syscall_arg__scnprintf_mount_flags
+
 size_t syscall_arg__scnprintf_pkey_alloc_access_rights(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PKEY_ALLOC_ACCESS_RIGHTS syscall_arg__scnprintf_pkey_alloc_access_rights
 
diff --git a/tools/perf/trace/beauty/mount_flags.c b/tools/perf/trace/beauty/mount_flags.c
new file mode 100644
index 000000000000..712935c6620a
--- /dev/null
+++ b/tools/perf/trace/beauty/mount_flags.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * trace/beauty/mount_flags.c
+ *
+ *  Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ */
+
+#include "trace/beauty/beauty.h"
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <sys/mount.h>
+
+static size_t mount__scnprintf_flags(unsigned long flags, char *bf, size_t size)
+{
+#include "trace/beauty/generated/mount_flags_array.c"
+	static DEFINE_STRARRAY(mount_flags);
+
+	return strarray__scnprintf_flags(&strarray__mount_flags, bf, size, flags);
+}
+
+unsigned long syscall_arg__mask_val_mount_flags(struct syscall_arg *arg __maybe_unused, unsigned long flags)
+{
+	// do_mount in fs/namespace.c:
+	/*
+	 * Pre-0.97 versions of mount() didn't have a flags word.  When the
+	 * flags word was introduced its top half was required to have the
+	 * magic value 0xC0ED, and this remained so until 2.4.0-test9.
+	 * Therefore, if this magic number is present, it carries no
+	 * information and must be discarded.
+	 */
+	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
+		flags &= ~MS_MGC_MSK;
+
+	return flags;
+}
+
+size_t syscall_arg__scnprintf_mount_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned long flags = arg->val;
+
+	return mount__scnprintf_flags(flags, bf, size);
+}
-- 
2.14.4

