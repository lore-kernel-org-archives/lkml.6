Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58792C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AB22147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550712401;
	bh=n5BnDo9ciRcP3uVIgJmpIUriqGrStRcEkcGnxSWKOcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VwTWjs/bIrLjwBZ9JVjD+R0kYRdr1H0rUWi59Oa1WFwmJywaY14PAgX+vvf/H17KJ
	 78EXbYhBEnjMIM/17ZDu1iynspk8W8qCngLit1YcB+d0eQiXeBJxZuS5Wyf75KXNlq
	 KxRM4Z67ndVLPHNjLPnHe3crdCDxYL1JA/i/araM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfBUB0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:26:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:59422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbfBUB0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:26:38 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.102.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FC662089F;
        Thu, 21 Feb 2019 01:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550712397;
        bh=n5BnDo9ciRcP3uVIgJmpIUriqGrStRcEkcGnxSWKOcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHD4rAlob5BQ6nztCvPCWiNpXEVzhN1QdmVrSzocmV7wRep4kuvkjIL+nxyknvHt3
         j0ylYqso9NPNjKKe3Tc/GVP8/a9EeKmvkMHyyqklhsbJ8LlY9i+X3h1scc4XEY8fH3
         1ej1UpcOUXQLQtEj1whjIiGQvpz5yrI2S+ncsp2o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 10/17] perf bpf: Add bpf_map dumper
Date:   Wed, 20 Feb 2019 22:25:42 -0300
Message-Id: <20190221012549.4069-11-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

At some point I'll suggest moving this to libbpf, for now I'll
experiment with ways to dump BPF maps set by events in 'perf trace',
starting with a very basic dumper for the current very limited needs
of the augmented_raw_syscalls code: dumping booleans.

Having functions that apply to the map keys and values and do table
lookup in things like syscall id to string tables should come next.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-lz14w0esqyt1333aon05jpwc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build     |  1 +
 tools/perf/util/bpf_map.c | 72 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/bpf_map.h | 22 ++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 tools/perf/util/bpf_map.c
 create mode 100644 tools/perf/util/bpf_map.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 3008d49fa587..8dd3102301ea 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -115,6 +115,7 @@ perf-y += branch.o
 perf-y += mem2node.o
 
 perf-$(CONFIG_LIBBPF) += bpf-loader.o
+perf-$(CONFIG_LIBBPF) += bpf_map.o
 perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
 perf-$(CONFIG_LIBELF) += symbol-elf.o
 perf-$(CONFIG_LIBELF) += probe-file.o
diff --git a/tools/perf/util/bpf_map.c b/tools/perf/util/bpf_map.c
new file mode 100644
index 000000000000..eb853ca67cf4
--- /dev/null
+++ b/tools/perf/util/bpf_map.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+#include "util/bpf_map.h"
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+static bool bpf_map_def__is_per_cpu(const struct bpf_map_def *def)
+{
+	return def->type == BPF_MAP_TYPE_PERCPU_HASH ||
+	       def->type == BPF_MAP_TYPE_PERCPU_ARRAY ||
+	       def->type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+	       def->type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE;
+}
+
+static void *bpf_map_def__alloc_value(const struct bpf_map_def *def)
+{
+	if (bpf_map_def__is_per_cpu(def))
+		return malloc(round_up(def->value_size, 8) * sysconf(_SC_NPROCESSORS_CONF));
+
+	return malloc(def->value_size);
+}
+
+int bpf_map__fprintf(struct bpf_map *map, FILE *fp)
+{
+	const struct bpf_map_def *def = bpf_map__def(map);
+	void *prev_key = NULL, *key, *value;
+	int fd = bpf_map__fd(map), err;
+	int printed = 0;
+
+	if (fd < 0)
+		return fd;
+
+	if (IS_ERR(def))
+		return PTR_ERR(def);
+
+	err = -ENOMEM;
+	key = malloc(def->key_size);
+	if (key == NULL)
+		goto out;
+
+	value = bpf_map_def__alloc_value(def);
+	if (value == NULL)
+		goto out_free_key;
+
+	while ((err = bpf_map_get_next_key(fd, prev_key, key) == 0)) {
+		int intkey = *(int *)key;
+
+		if (!bpf_map_lookup_elem(fd, key, value)) {
+			bool boolval = *(bool *)value;
+			if (boolval)
+				printed += fprintf(fp, "[%d] = %d,\n", intkey, boolval);
+		} else {
+			printed += fprintf(fp, "[%d] = ERROR,\n", intkey);
+		}
+
+		prev_key = key;
+	}
+
+	if (err == ENOENT)
+		err = printed;
+
+	free(value);
+out_free_key:
+	free(key);
+out:
+	return err;
+}
diff --git a/tools/perf/util/bpf_map.h b/tools/perf/util/bpf_map.h
new file mode 100644
index 000000000000..d6abd5e47af8
--- /dev/null
+++ b/tools/perf/util/bpf_map.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#ifndef __PERF_BPF_MAP_H
+#define __PERF_BPF_MAP_H 1
+
+#include <stdio.h>
+#include <linux/compiler.h>
+struct bpf_map;
+
+#ifdef HAVE_LIBBPF_SUPPORT
+
+int bpf_map__fprintf(struct bpf_map *map, FILE *fp);
+
+#else
+
+static inline int bpf_map__fprintf(struct bpf_map *map __maybe_unused, FILE *fp __maybe_unused)
+{
+	return 0;
+}
+
+#endif // HAVE_LIBBPF_SUPPORT
+
+#endif // __PERF_BPF_MAP_H
-- 
2.19.1

