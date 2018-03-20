Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeCTGav (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:30:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52287 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbeCTGas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:30:48 -0400
Date: Mon, 19 Mar 2018 23:29:27 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5eab5a7ee032acaab3da8fc95a3614fec14687ac@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        jolsa@kernel.org, acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
        peterz@infradead.org, dsahern@gmail.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org, mingo@kernel.org,
        dsahern@gmail.com, peterz@infradead.org, acme@redhat.com,
        hpa@zytor.com, alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        jolsa@kernel.org
In-Reply-To: <20180312094313.18738-3-jolsa@kernel.org>
References: <20180312094313.18738-3-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf llvm: Display eBPF compiling command in debug
 output
Git-Commit-ID: 5eab5a7ee032acaab3da8fc95a3614fec14687ac
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5eab5a7ee032acaab3da8fc95a3614fec14687ac
Gitweb:     https://git.kernel.org/tip/5eab5a7ee032acaab3da8fc95a3614fec14687ac
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 12 Mar 2018 10:43:02 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:56:12 -0300

perf llvm: Display eBPF compiling command in debug output

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
