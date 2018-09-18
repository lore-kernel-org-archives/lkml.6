Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB3DECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD3621502
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgK8YujN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD3621502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbeIRVLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729942AbeIRVLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:11:07 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1901214FE;
        Tue, 18 Sep 2018 15:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537285079;
        bh=FRxGZK9G+dh0mVzXU0ytZK/c0cczjrJQpJkxNx3pdcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgK8YujNoS4VuUXyCF3oUC+YoN2tqyKuftfafcm3NZGeDjg/e68lzAipj0CW5sgG2
         sFsBf43XVRSu1eI7hmPIDW/OwRp0A5GiqERY/Jx0dx9StqsMnzhb59zGney9UGlBwb
         S0aoV8fqg4PRZEzOYcwBoZ/dziadPC2s6HDsAZus=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 1/2] tools lib bpf: Provide wrapper for strerror_r to build in !_GNU_SOURCE systems
Date:   Tue, 18 Sep 2018 12:37:24 -0300
Message-Id: <20180918153725.7022-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180918153725.7022-1-acme@kernel.org>
References: <20180918153725.7022-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Same problem that got fixed in a similar fashion in tools/perf/ in
c8b5f2c96d1b ("tools: Introduce str_error_r()"), fix it in the same
way, licensing needs to be sorted out to libbpf to use libapi, so,
for this simple case, just get the same wrapper in tools/lib/bpf.

This makes libbpf and its users (bpftool, selftests, perf) to build
again in Alpine Linux 3.[45678] and edge.

Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Fixes: 1ce6a9fc1549 ("bpf: fix build error in libbpf with EXTRA_CFLAGS="-Wp, -D_FORTIFY_SOURCE=2 -O2"")
Link: https://lkml.kernel.org/r/20180917151636.GA21790@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/bpf/Build       |  2 +-
 tools/lib/bpf/libbpf.c    | 20 ++++++++++----------
 tools/lib/bpf/str_error.c | 18 ++++++++++++++++++
 tools/lib/bpf/str_error.h |  6 ++++++
 4 files changed, 35 insertions(+), 11 deletions(-)
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
-- 
2.14.4

