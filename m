Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932365AbeCLJnZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:43:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752342AbeCLJnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:43:23 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 04/13] perf tools: Add bpf__compile function
Date: Mon, 12 Mar 2018 10:43:04 +0100
Message-Id: <20180312094313.18738-5-jolsa@kernel.org>
In-Reply-To: <20180312094313.18738-1-jolsa@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding bpf__compile function to have interface for
ebpf object compilation.

Link: http://lkml.kernel.org/n/tip-3kus9vjbiven8par9j1ju9u5@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/bpf-loader.c | 46 +++++++++++++++++++++++++++++++++-----------
 tools/perf/util/bpf-loader.h |  2 ++
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index af7ad814b2c3..e59168153375 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -74,6 +74,38 @@ bpf__prepare_load_buffer(void *obj_buf, size_t obj_buf_sz, const char *name)
 	return obj;
 }
 
+static int compile(const char *filename, void *obj_buf, size_t *obj_buf_sz)
+{
+	int err;
+
+	perf_clang__init();
+	err = perf_clang__compile_bpf(filename, obj_buf, obj_buf_sz);
+	perf_clang__cleanup();
+	if (err) {
+		pr_debug("bpf: builtin compilation failed: %d, try external compiler\n", err);
+		err = llvm__compile_bpf(filename, obj_buf, obj_buf_sz);
+		if (err)
+			return -1;
+	} else {
+		pr_debug("bpf: successfull builtin compilation\n");
+	}
+
+	return 0;
+}
+
+int bpf__compile(const char *filename)
+{
+	void *obj_buf;
+	size_t obj_buf_sz;
+
+	if (compile(filename, &obj_buf, &obj_buf_sz))
+		return -1;
+
+	/* make llvm__dump_obj to return error value */
+	llvm__dump_obj(filename, obj_buf, obj_buf_sz);
+	return 0;
+}
+
 struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 {
 	struct bpf_object *obj;
@@ -86,20 +118,12 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 	}
 
 	if (source) {
-		int err;
 		void *obj_buf;
 		size_t obj_buf_sz;
 
-		perf_clang__init();
-		err = perf_clang__compile_bpf(filename, &obj_buf, &obj_buf_sz);
-		perf_clang__cleanup();
-		if (err) {
-			pr_debug("bpf: builtin compilation failed: %d, try external compiler\n", err);
-			err = llvm__compile_bpf(filename, &obj_buf, &obj_buf_sz);
-			if (err)
-				return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
-		} else
-			pr_debug("bpf: successfull builtin compilation\n");
+		if (compile(filename, &obj_buf, &obj_buf_sz))
+			return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
+
 		obj = bpf_object__open_buffer(obj_buf, obj_buf_sz, filename);
 
 		if (!IS_ERR(obj) && llvm_param.dump_obj)
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 5d3aefd6fae7..8c2a494cab53 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -58,6 +58,8 @@ int bpf__strerror_prepare_load(const char *filename, bool source,
 struct bpf_object *bpf__prepare_load_buffer(void *obj_buf, size_t obj_buf_sz,
 					    const char *name);
 
+int bpf__compile(const char *filename);
+
 void bpf__clear(void);
 
 int bpf__probe(struct bpf_object *obj);
-- 
2.13.6
