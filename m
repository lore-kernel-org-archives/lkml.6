Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91047C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AFF20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsyBZtlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AFF20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbeHAXZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732307AbeHAXZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:11 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6798120844;
        Wed,  1 Aug 2018 21:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533159443;
        bh=ezWhaO3A2zHSUHs3sJKkicWobRuqr8Cv7LGB/zh0xuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gsyBZtlbPzOjloh0FJiN0KGYjfmhAPdVhqjSfTUuUFLY0TdZOu3NHp9YErXhHTNWx
         BK2qcyxzk1oFHaGAHFeRaPSjCZq+ikvt2VxYMX9KB9VNsSV31SfiaICXhTgFYN114y
         FniAB4YiOV/QkRIl72ix7f/Y48NRosoEKLSVhe9Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 07/21] perf trace beauty: Add beautifiers for 'socket''s 'protocol' arg
Date:   Wed,  1 Aug 2018 18:36:34 -0300
Message-Id: <20180801213648.4814-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It'll be wired to 'perf trace' in the next cset.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2i9vkvm1ik8yu4hgjmxhsyjv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf         | 10 ++++++++++
 tools/perf/trace/beauty/Build    |  1 +
 tools/perf/trace/beauty/beauty.h |  3 +++
 tools/perf/trace/beauty/socket.c | 28 ++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+)
 create mode 100644 tools/perf/trace/beauty/socket.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ecc9fc952655..b3d1b12a5081 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -384,6 +384,8 @@ export INSTALL SHELL_PATH
 
 SHELL = $(SHELL_PATH)
 
+linux_uapi_dir := $(srctree)/tools/include/uapi/linux
+
 beauty_outdir := $(OUTPUT)trace/beauty/generated
 beauty_ioctl_outdir := $(beauty_outdir)/ioctl
 drm_ioctl_array := $(beauty_ioctl_outdir)/drm_ioctl_array.c
@@ -431,6 +433,12 @@ kvm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/kvm_ioctl.sh
 $(kvm_ioctl_array): $(kvm_hdr_dir)/kvm.h $(kvm_ioctl_tbl)
 	$(Q)$(SHELL) '$(kvm_ioctl_tbl)' $(kvm_hdr_dir) > $@
 
+socket_ipproto_array := $(beauty_outdir)/socket_ipproto_array.c
+socket_ipproto_tbl := $(srctree)/tools/perf/trace/beauty/socket_ipproto.sh
+
+$(socket_ipproto_array): $(linux_uapi_dir)/in.h $(socket_ipproto_tbl)
+	$(Q)$(SHELL) '$(socket_ipproto_tbl)' $(linux_uapi_dir) > $@
+
 vhost_virtio_ioctl_array := $(beauty_ioctl_outdir)/vhost_virtio_ioctl_array.c
 vhost_virtio_hdr_dir := $(srctree)/tools/include/uapi/linux
 vhost_virtio_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
@@ -566,6 +574,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(sndrv_ctl_ioctl_array) \
 	$(kcmp_type_array) \
 	$(kvm_ioctl_array) \
+	$(socket_ipproto_array) \
 	$(vhost_virtio_ioctl_array) \
 	$(madvise_behavior_array) \
 	$(perf_ioctl_array) \
@@ -860,6 +869,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(sndrv_pcm_ioctl_array) \
 		$(OUTPUT)$(kvm_ioctl_array) \
 		$(OUTPUT)$(kcmp_type_array) \
+		$(OUTPUT)$(socket_ipproto_array) \
 		$(OUTPUT)$(vhost_virtio_ioctl_array) \
 		$(OUTPUT)$(perf_ioctl_array) \
 		$(OUTPUT)$(prctl_option_array) \
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index 66330d4b739b..f528ba35e140 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -7,4 +7,5 @@ endif
 libperf-y += kcmp.o
 libperf-y += pkey_alloc.o
 libperf-y += prctl.o
+libperf-y += socket.o
 libperf-y += statx.o
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 984a504d335c..9615af5d412b 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -106,6 +106,9 @@ size_t syscall_arg__scnprintf_prctl_arg2(char *bf, size_t size, struct syscall_a
 size_t syscall_arg__scnprintf_prctl_arg3(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PRCTL_ARG3 syscall_arg__scnprintf_prctl_arg3
 
+size_t syscall_arg__scnprintf_socket_protocol(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_SK_PROTO syscall_arg__scnprintf_socket_protocol
+
 size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STATX_FLAGS syscall_arg__scnprintf_statx_flags
 
diff --git a/tools/perf/trace/beauty/socket.c b/tools/perf/trace/beauty/socket.c
new file mode 100644
index 000000000000..65227269384b
--- /dev/null
+++ b/tools/perf/trace/beauty/socket.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * trace/beauty/socket.c
+ *
+ *  Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ */
+
+#include "trace/beauty/beauty.h"
+#include <sys/types.h>
+#include <sys/socket.h>
+
+static size_t socket__scnprintf_ipproto(int protocol, char *bf, size_t size)
+{
+#include "trace/beauty/generated/socket_ipproto_array.c"
+	static DEFINE_STRARRAY(socket_ipproto);
+
+	return strarray__scnprintf(&strarray__socket_ipproto, bf, size, "%d", protocol);
+}
+
+size_t syscall_arg__scnprintf_socket_protocol(char *bf, size_t size, struct syscall_arg *arg)
+{
+	int domain = syscall_arg__val(arg, 0);
+
+	if (domain == AF_INET || domain == AF_INET6)
+		return socket__scnprintf_ipproto(arg->val, bf, size);
+
+	return syscall_arg__scnprintf_int(bf, size, arg);
+}
-- 
2.14.4

