Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeCLJnW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:43:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752342AbeCLJnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:43:20 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 02/13] perf tools: Display ebpf compiling command in debug output
Date: Mon, 12 Mar 2018 10:43:02 +0100
Message-Id: <20180312094313.18738-3-jolsa@kernel.org>
In-Reply-To: <20180312094313.18738-1-jolsa@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to template, display also the real compile
command line with all the variables substituted.

llvm compiling command template: $CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS ...
llvm compiling command : /usr/bin/clang -D__KERNEL__ -D__NR_CPUS__=24 -DLINUX_VERSION_CODE=0x41000 ...

Link: http://lkml.kernel.org/n/tip-mygjr5z3c77x9ephks7n06oc@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/llvm-utils.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 4952b429caa7..1cca0a2fa641 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -433,6 +433,7 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 	char serr[STRERR_BUFSIZE];
 	char *kbuild_dir = NULL, *kbuild_include_opts = NULL;
 	const char *template = llvm_param.clang_bpf_cmd_template;
+	char *command_echo, *command_out;
 
 	if (path[0] != '-' && realpath(path, abspath) == NULL) {
 		err = errno;
@@ -487,6 +488,16 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 		      (path[0] == '-') ? path : abspath);
 
 	pr_debug("llvm compiling command template: %s\n", template);
+
+	if (asprintf(&command_echo, "echo -n \"%s\"", template) < 0)
+		goto errout;
+
+	err = read_from_pipe(command_echo, (void **) &command_out, NULL);
+	if (err)
+		goto errout;
+
+	pr_debug("llvm compiling command : %s\n", command_out);
+
 	err = read_from_pipe(template, &obj_buf, &obj_buf_sz);
 	if (err) {
 		pr_err("ERROR:\tunable to compile %s\n", path);
@@ -497,6 +508,8 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 		goto errout;
 	}
 
+	free(command_echo);
+	free(command_out);
 	free(kbuild_dir);
 	free(kbuild_include_opts);
 
@@ -509,6 +522,7 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 		*p_obj_buf_sz = obj_buf_sz;
 	return 0;
 errout:
+	free(command_echo);
 	free(kbuild_dir);
 	free(kbuild_include_opts);
 	free(obj_buf);
-- 
2.13.6
