Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A1AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30B221486
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30B221486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbeHWMHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:07:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34361 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbeHWMHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:07:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7N8c7Qt3187958
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Aug 2018 01:38:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7N8c6xm3187955;
        Thu, 23 Aug 2018 01:38:06 -0700
Date:   Thu, 23 Aug 2018 01:38:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-0lrwmrip4dru1651rm8xa7tq@git.kernel.org>
Cc:     namhyung@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        yhs@fb.com, daniel@iogearbox.net, ast@fb.com, kafai@fb.com,
        jolsa@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com,
          namhyung@kernel.org, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, jolsa@kernel.org, kafai@fb.com, ast@fb.com,
          daniel@iogearbox.net, yhs@fb.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf llvm: Allow passing options to llc in
 addition to clang
Git-Commit-ID: cb76371441d0984824a6e66f8f3d369f037edb34
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cb76371441d0984824a6e66f8f3d369f037edb34
Gitweb:     https://git.kernel.org/tip/cb76371441d0984824a6e66f8f3d369f037edb34
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 15 Aug 2018 17:07:01 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 20 Aug 2018 08:54:58 -0300

perf llvm: Allow passing options to llc in addition to clang

The newly added 'llvm.opts' variable allows passing options directly to
llc, like needed to get sane DWARF in BPF ELF debug sections:

With:

  [root@seventh perf]# cat ~/.perfconfig
  [llvm]
	  dump-obj = true
	clang-opt = -g
  [root@seventh perf]#

We get:

  [root@seventh perf]# perf trace -e tools/perf/examples/bpf/hello.c cat /etc/passwd > /dev/null
  LLVM: dumping tools/perf/examples/bpf/hello.o
       0.000 __bpf_stdout__:Hello, world
       0.015 __bpf_stdout__:Hello, world
       0.187 __bpf_stdout__:Hello, world
  [root@seventh perf]# pahole tools/perf/examples/bpf/hello.o
  struct clang version 8.0.0 (http://llvm.org/git/clang.git 8587270a739ee30c926a76d5657e65e85b560f6e) (http://llvm.org/git/llvm.git 0566eefef9c3777bd780ec4cbb9efa764633b76c) {
	  clang version 8.0.0 (http://llvm.org/git/clang.git 8587270a739ee30c926a76d5657e65e85b560f6e) (http://llvm.org/git/llvm.git 0566e.org clang version 8.0.0 (http://llvm.org/git/clang.git 8587270a739ee30c926a76d5657e65e85b560f6e) (http://llvm.org/git/llvm.git 0566eefef9c3777bd780ec4cbb9efa764633b76c); /*     0     4 */
	  clang version 8.0.0 (http://llvm.org/git/clang.git 8587270a739ee30c926a76d5657e65e85b560f6e) (http://llvm.org/git/llvm.git 0566e.org clang version 8.0.0 (http://llvm.org/git/clang.git 8587270a739ee30c926a76d5657e65e85b560f6e) (http://llvm.org/git/llvm.git 0566eefef9c3777bd780ec4cbb9efa764633b76c); /*     4     4 */
	  clang version 8.0.0 (http://llvm.org/git/clang.git 8587270a739ee30c926a76d5657e65e85b560f6e) (http://llvm.org/git/llvm.git 0566e.org clang version 8.0.0 (http://llvm.org/git/clang.git 8587270a739ee30c926a76d5657e65e85b560f6e) (http://llvm.org/git/llvm.git 0566eefef9c3777bd780ec4cbb9efa764633b76c); /*     8     4 */
	  clang version 8.0.0 (http://llvm.org/git/clang.git 8587270a739ee30c926a76d5657e65e85b560f6e) (http://llvm.org/git/llvm.git 0566e.org clang version 8.0.0 (http://llvm.org/git/clang.git 8587270a739ee30c926a76d5657e65e85b560f6e) (http://llvm.org/git/llvm.git 0566eefef9c3777bd780ec4cbb9efa764633b76c); /*    12     4 */
	  clang version 8.0.0 (http://llvm.org/git/clang.git 8587270a739ee30c926a76d5657e65e85b560f6e) (http://llvm.org/git/llvm.git 0566e.org clang version 8.0.0 (http://llvm.org/git/clang.git 8587270a739ee30c926a76d5657e65e85b560f6e) (http://llvm.org/git/llvm.git 0566eefef9c3777bd780ec4cbb9efa764633b76c); /*    16     4 */
	  clang version 8.0.0 (http://llvm.org/git/clang.git 8587270a739ee30c926a76d5657e65e85b560f6e) (http://llvm.org/git/llvm.git 0566e.org clang version 8.0.0 (http://llvm.org/git/clang.git 8587270a739ee30c926a76d5657e65e85b560f6e) (http://llvm.org/git/llvm.git 0566eefef9c3777bd780ec4cbb9efa764633b76c); /*    20     4 */
	  clang version 8.0.0 (http://llvm.org/git/clang.git 8587270a739ee30c926a76d5657e65e85b560f6e) (http://llvm.org/git/llvm.git 0566e.org clang version 8.0.0 (http://llvm.org/git/clang.git 8587270a739ee30c926a76d5657e65e85b560f6e) (http://llvm.org/git/llvm.git 0566eefef9c3777bd780ec4cbb9efa764633b76c); /*    24     4 */

	  /* size: 28, cachelines: 1, members: 7 */
	  /* last cacheline: 28 bytes */
  };
  [root@seventh perf]#

Adding these options to be passed to llvm's llc:

  [root@seventh perf]# cat ~/.perfconfig
  [llvm]
	  dump-obj = true
	  clang-opt = -g
	  opts = -mattr=dwarfris
  [root@seventh perf]#

We get sane output:

  [root@seventh perf]# perf trace -e tools/perf/examples/bpf/hello.c cat /etc/passwd > /dev/null
  LLVM: dumping tools/perf/examples/bpf/hello.o
       0.000 __bpf_stdout__:Hello, world
       0.015 __bpf_stdout__:Hello, world
       0.185 __bpf_stdout__:Hello, world
  [root@seventh perf]# pahole tools/perf/examples/bpf/hello.o
  struct bpf_map {
	  unsigned int               type;                 /*     0     4 */
	  unsigned int               key_size;             /*     4     4 */
	  unsigned int               value_size;           /*     8     4 */
	  unsigned int               max_entries;          /*    12     4 */
	  unsigned int               map_flags;            /*    16     4 */
	  unsigned int               inner_map_idx;        /*    20     4 */
	  unsigned int               numa_node;            /*    24     4 */

	  /* size: 28, cachelines: 1, members: 7 */
	  /* last cacheline: 28 bytes */
  };
  [root@seventh perf]#

Cc: Alexei Starovoitov <ast@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>,
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-0lrwmrip4dru1651rm8xa7tq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/llvm-utils.c | 31 +++++++++++++++++++++++++++++--
 tools/perf/util/llvm-utils.h |  9 +++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 5e94857dfca2..19262f98cd4e 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -22,12 +22,14 @@
 		"$CLANG_OPTIONS $KERNEL_INC_OPTIONS $PERF_BPF_INC_OPTIONS " \
 		"-Wno-unused-value -Wno-pointer-sign "		\
 		"-working-directory $WORKING_DIR "		\
-		"-c \"$CLANG_SOURCE\" -target bpf -O2 -o -"
+		"-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
 
 struct llvm_param llvm_param = {
 	.clang_path = "clang",
+	.llc_path = "llc",
 	.clang_bpf_cmd_template = CLANG_BPF_CMD_DEFAULT_TEMPLATE,
 	.clang_opt = NULL,
+	.opts = NULL,
 	.kbuild_dir = NULL,
 	.kbuild_opts = NULL,
 	.user_set_param = false,
@@ -51,6 +53,8 @@ int perf_llvm_config(const char *var, const char *value)
 		llvm_param.kbuild_opts = strdup(value);
 	else if (!strcmp(var, "dump-obj"))
 		llvm_param.dump_obj = !!perf_config_bool(var, value);
+	else if (!strcmp(var, "opts"))
+		llvm_param.opts = strdup(value);
 	else {
 		pr_debug("Invalid LLVM config option: %s\n", value);
 		return -1;
@@ -430,11 +434,13 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 	unsigned int kernel_version;
 	char linux_version_code_str[64];
 	const char *clang_opt = llvm_param.clang_opt;
-	char clang_path[PATH_MAX], abspath[PATH_MAX], nr_cpus_avail_str[64];
+	char clang_path[PATH_MAX], llc_path[PATH_MAX], abspath[PATH_MAX], nr_cpus_avail_str[64];
 	char serr[STRERR_BUFSIZE];
 	char *kbuild_dir = NULL, *kbuild_include_opts = NULL,
 	     *perf_bpf_include_opts = NULL;
 	const char *template = llvm_param.clang_bpf_cmd_template;
+	char *pipe_template = NULL;
+	const char *opts = llvm_param.opts;
 	char *command_echo = NULL, *command_out;
 	char *perf_include_dir = system_path(PERF_INCLUDE_DIR);
 
@@ -484,6 +490,26 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 	force_set_env("PERF_BPF_INC_OPTIONS", perf_bpf_include_opts);
 	force_set_env("WORKING_DIR", kbuild_dir ? : ".");
 
+	if (opts) {
+		err = search_program(llvm_param.llc_path, "llc", llc_path);
+		if (err) {
+			pr_err("ERROR:\tunable to find llc.\n"
+			       "Hint:\tTry to install latest clang/llvm to support BPF. Check your $PATH\n"
+			       "     \tand 'llc-path' option in [llvm] section of ~/.perfconfig.\n");
+			version_notice();
+			goto errout;
+		}
+
+		if (asprintf(&pipe_template, "%s -emit-llvm | %s -march=bpf %s -filetype=obj -o -",
+			      template, llc_path, opts) < 0) {
+			pr_err("ERROR:\tnot enough memory to setup command line\n");
+			goto errout;
+		}
+
+		template = pipe_template;
+
+	}
+
 	/*
 	 * Since we may reset clang's working dir, path of source file
 	 * should be transferred into absolute path, except we want
@@ -535,6 +561,7 @@ errout:
 	free(obj_buf);
 	free(perf_bpf_include_opts);
 	free(perf_include_dir);
+	free(pipe_template);
 	if (p_obj_buf)
 		*p_obj_buf = NULL;
 	if (p_obj_buf_sz)
diff --git a/tools/perf/util/llvm-utils.h b/tools/perf/util/llvm-utils.h
index d3ad8deb5db4..bf3f3f4c4fe2 100644
--- a/tools/perf/util/llvm-utils.h
+++ b/tools/perf/util/llvm-utils.h
@@ -11,6 +11,8 @@
 struct llvm_param {
 	/* Path of clang executable */
 	const char *clang_path;
+	/* Path of llc executable */
+	const char *llc_path;
 	/*
 	 * Template of clang bpf compiling. 5 env variables
 	 * can be used:
@@ -23,6 +25,13 @@ struct llvm_param {
 	const char *clang_bpf_cmd_template;
 	/* Will be filled in $CLANG_OPTIONS */
 	const char *clang_opt;
+	/*
+	 * If present it'll add -emit-llvm to $CLANG_OPTIONS to pipe
+	 * the clang output to llc, useful for new llvm options not
+	 * yet selectable via 'clang -mllvm option', such as -mattr=dwarfris
+	 * in clang 6.0/llvm 7
+	 */
+	const char *opts;
 	/* Where to find kbuild system */
 	const char *kbuild_dir;
 	/*
