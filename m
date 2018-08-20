Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1949C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BF021735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6d6qUt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BF021735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeHTTck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeHTTck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:32:40 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FAB62172F;
        Mon, 20 Aug 2018 16:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534781783;
        bh=IfwPS9TO7tylJ0wAmiaw6qH+53ZNotn8ELb8sT+2XHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6d6qUt6MR3XocvYTU5jMlzxteYfoH2lG/SNX4I7kP7EUvDmX5pRBsH6T+pxPmagT
         igLT976UIL+kGoZtpBqa+GCoO8RrWcZTIodSAoukNFANr09FlzKdTq6Ir4zO5XGgoR
         lB6eP2pyYTZJ8fw7X3j04ZZclS0+wA0qkIHrLzyg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 03/21] perf llvm: Allow passing options to llc in addition to clang
Date:   Mon, 20 Aug 2018 13:15:44 -0300
Message-Id: <20180820161602.6830-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
@@ -535,6 +561,7 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
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
-- 
2.14.4

