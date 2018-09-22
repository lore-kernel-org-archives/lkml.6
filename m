Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABACC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB4221532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB4221532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeIVS1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 14:27:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41579 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeIVS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 14:27:33 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g3h6q-0000Qy-Q1; Sat, 22 Sep 2018 14:34:04 +0200
Subject: [GIT pull] perf fixes for 4.19
Message-ID: <153761963611.16056.11332619067486725953.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <153761963611.16056.1920566642543692525.tglx@nanos.tec.linutronix.de>
Date:   Sat, 22 Sep 2018 14:34:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus


Two small fixes for perf tools:

 - Provide a strerror_r wrapper so lib/bpf can be built on systems without
   _GNU_SOURCE

 - Unbreak the man page generator when building out of tree

Thanks,

	tglx

------------------>
Arnaldo Carvalho de Melo (1):
      tools lib bpf: Provide wrapper for strerror_r to build in !_GNU_SOURCE systems

Ben Hutchings (1):
      perf Documentation: Fix out-of-tree asciidoctor man page generation


 tools/lib/bpf/Build               |  2 +-
 tools/lib/bpf/libbpf.c            | 20 ++++++++++----------
 tools/lib/bpf/str_error.c         | 18 ++++++++++++++++++
 tools/lib/bpf/str_error.h         |  6 ++++++
 tools/perf/Documentation/Makefile |  2 +-
 5 files changed, 36 insertions(+), 12 deletions(-)
 create mode 100644 tools/lib/bpf/str_error.c
 create mode 100644 tools/lib/bpf/str_error.h

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index 13a861135127..6eb9bacd1948 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1 +1 @@
-libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o
+libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2abd0f112627..bdb94939fd60 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -50,6 +50,7 @@
 #include "libbpf.h"
 #include "bpf.h"
 #include "btf.h"
+#include "str_error.h"
 
 #ifndef EM_BPF
 #define EM_BPF 247
@@ -469,7 +470,7 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 		obj->efile.fd = open(obj->path, O_RDONLY);
 		if (obj->efile.fd < 0) {
 			char errmsg[STRERR_BUFSIZE];
-			char *cp = strerror_r(errno, errmsg, sizeof(errmsg));
+			char *cp = str_error(errno, errmsg, sizeof(errmsg));
 
 			pr_warning("failed to open %s: %s\n", obj->path, cp);
 			return -errno;
@@ -810,8 +811,7 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 						      data->d_size, name, idx);
 			if (err) {
 				char errmsg[STRERR_BUFSIZE];
-				char *cp = strerror_r(-err, errmsg,
-						      sizeof(errmsg));
+				char *cp = str_error(-err, errmsg, sizeof(errmsg));
 
 				pr_warning("failed to alloc program %s (%s): %s",
 					   name, obj->path, cp);
@@ -1140,7 +1140,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 
 		*pfd = bpf_create_map_xattr(&create_attr);
 		if (*pfd < 0 && create_attr.btf_key_type_id) {
-			cp = strerror_r(errno, errmsg, sizeof(errmsg));
+			cp = str_error(errno, errmsg, sizeof(errmsg));
 			pr_warning("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
 				   map->name, cp, errno);
 			create_attr.btf_fd = 0;
@@ -1155,7 +1155,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 			size_t j;
 
 			err = *pfd;
-			cp = strerror_r(errno, errmsg, sizeof(errmsg));
+			cp = str_error(errno, errmsg, sizeof(errmsg));
 			pr_warning("failed to create map (name: '%s'): %s\n",
 				   map->name, cp);
 			for (j = 0; j < i; j++)
@@ -1339,7 +1339,7 @@ load_program(enum bpf_prog_type type, enum bpf_attach_type expected_attach_type,
 	}
 
 	ret = -LIBBPF_ERRNO__LOAD;
-	cp = strerror_r(errno, errmsg, sizeof(errmsg));
+	cp = str_error(errno, errmsg, sizeof(errmsg));
 	pr_warning("load bpf program failed: %s\n", cp);
 
 	if (log_buf && log_buf[0] != '\0') {
@@ -1654,7 +1654,7 @@ static int check_path(const char *path)
 
 	dir = dirname(dname);
 	if (statfs(dir, &st_fs)) {
-		cp = strerror_r(errno, errmsg, sizeof(errmsg));
+		cp = str_error(errno, errmsg, sizeof(errmsg));
 		pr_warning("failed to statfs %s: %s\n", dir, cp);
 		err = -errno;
 	}
@@ -1690,7 +1690,7 @@ int bpf_program__pin_instance(struct bpf_program *prog, const char *path,
 	}
 
 	if (bpf_obj_pin(prog->instances.fds[instance], path)) {
-		cp = strerror_r(errno, errmsg, sizeof(errmsg));
+		cp = str_error(errno, errmsg, sizeof(errmsg));
 		pr_warning("failed to pin program: %s\n", cp);
 		return -errno;
 	}
@@ -1708,7 +1708,7 @@ static int make_dir(const char *path)
 		err = -errno;
 
 	if (err) {
-		cp = strerror_r(-err, errmsg, sizeof(errmsg));
+		cp = str_error(-err, errmsg, sizeof(errmsg));
 		pr_warning("failed to mkdir %s: %s\n", path, cp);
 	}
 	return err;
@@ -1770,7 +1770,7 @@ int bpf_map__pin(struct bpf_map *map, const char *path)
 	}
 
 	if (bpf_obj_pin(map->fd, path)) {
-		cp = strerror_r(errno, errmsg, sizeof(errmsg));
+		cp = str_error(errno, errmsg, sizeof(errmsg));
 		pr_warning("failed to pin map: %s\n", cp);
 		return -errno;
 	}
diff --git a/tools/lib/bpf/str_error.c b/tools/lib/bpf/str_error.c
new file mode 100644
index 000000000000..b8798114a357
--- /dev/null
+++ b/tools/lib/bpf/str_error.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: LGPL-2.1
+#undef _GNU_SOURCE
+#include <string.h>
+#include <stdio.h>
+#include "str_error.h"
+
+/*
+ * Wrapper to allow for building in non-GNU systems such as Alpine Linux's musl
+ * libc, while checking strerror_r() return to avoid having to check this in
+ * all places calling it.
+ */
+char *str_error(int err, char *dst, int len)
+{
+	int ret = strerror_r(err, dst, len);
+	if (ret)
+		snprintf(dst, len, "ERROR: strerror_r(%d)=%d", err, ret);
+	return dst;
+}
diff --git a/tools/lib/bpf/str_error.h b/tools/lib/bpf/str_error.h
new file mode 100644
index 000000000000..355b1db571d1
--- /dev/null
+++ b/tools/lib/bpf/str_error.h
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1
+#ifndef BPF_STR_ERROR
+#define BPF_STR_ERROR
+
+char *str_error(int err, char *dst, int len);
+#endif // BPF_STR_ERROR
diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 42261a9b280e..ac841bc5c35b 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -280,7 +280,7 @@ $(MAN_HTML): $(OUTPUT)%.html : %.txt
 	mv $@+ $@
 
 ifdef USE_ASCIIDOCTOR
-$(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : $(OUTPUT)%.txt
+$(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b manpage -d manpage \
 		$(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) -o $@+ $< && \

