Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932621AbeCMMIG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752330AbeCMMHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:07:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499BC217A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/31] perf llvm: Display eBPF compiling command in debug output
Date: Tue, 13 Mar 2018 09:05:05 -0300
Message-Id: <20180313120508.29327-29-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

In addition to template, display also the real compile command line with
all the variables substituted.

  llvm compiling command template: $CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS ...
  llvm compiling command : /usr/bin/clang -D__KERNEL__ -D__NR_CPUS__=24 -DLINUX_VERSION_CODE=0x41000 ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180312094313.18738-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.3
