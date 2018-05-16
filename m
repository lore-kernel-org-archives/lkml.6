Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeEPOtj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbeEPOtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:49:32 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 03/11] perf llvm-utils: Add bpf include path to clang command line
Date: Wed, 16 May 2018 11:49:00 -0300
Message-Id: <20180516144908.22212-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180516144908.22212-1-acme@kernel.org>
References: <20180516144908.22212-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'll start putting headers for helpers to be used in eBPF proggies in
there:

  # perf trace -v --no-syscalls -e empty.c |& grep "llvm compiling command : "
  llvm compiling command : /usr/lib64/ccache/clang -D__KERNEL__ -D__NR_CPUS__=4 -DLINUX_VERSION_CODE=0x41100   -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h  -I/home/acme/lib/include/perf/bpf -Wno-unused-value -Wno-pointer-sign -working-directory /lib/modules/4.17.0-rc3-00034-gf4ef6a438cee/build -c /home/acme/bpf/empty.c -target bpf -O2 -o -
  #

Notice the "-I/home/acme/lib/include/perf/bpf"

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6xq94xro8xlb5s9urznh3f9k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config   |  7 +++++++
 tools/perf/Makefile.perf     |  4 ++++
 tools/perf/util/Build        |  2 ++
 tools/perf/util/llvm-utils.c | 19 ++++++++++++++-----
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index ae7dc46e8f8a..3bca9a733f0e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -885,6 +885,7 @@ endif
 
 # Among the variables below, these:
 #   perfexecdir
+#   perf_include_dir
 #   template_dir
 #   mandir
 #   infodir
@@ -904,6 +905,7 @@ bindir = $(abspath $(prefix)/$(bindir_relative))
 mandir = share/man
 infodir = share/info
 perfexecdir = libexec/perf-core
+perf_include_dir = lib/include/perf
 sharedir = $(prefix)/share
 template_dir = share/perf-core/templates
 STRACE_GROUPS_DIR = share/perf-core/strace/groups
@@ -934,6 +936,7 @@ bindir_SQ = $(subst ','\'',$(bindir))
 mandir_SQ = $(subst ','\'',$(mandir))
 infodir_SQ = $(subst ','\'',$(infodir))
 perfexecdir_SQ = $(subst ','\'',$(perfexecdir))
+perf_include_dir_SQ = $(subst ','\'',$(perf_include_dir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_SQ = $(subst ','\'',$(htmldir))
 tipdir_SQ = $(subst ','\'',$(tipdir))
@@ -944,14 +947,17 @@ srcdir_SQ = $(subst ','\'',$(srcdir))
 
 ifneq ($(filter /%,$(firstword $(perfexecdir))),)
 perfexec_instdir = $(perfexecdir)
+perf_include_instdir = $(perf_include_dir)
 STRACE_GROUPS_INSTDIR = $(STRACE_GROUPS_DIR)
 tip_instdir = $(tipdir)
 else
 perfexec_instdir = $(prefix)/$(perfexecdir)
+perf_include_instdir = $(prefix)/$(perf_include_dir)
 STRACE_GROUPS_INSTDIR = $(prefix)/$(STRACE_GROUPS_DIR)
 tip_instdir = $(prefix)/$(tipdir)
 endif
 perfexec_instdir_SQ = $(subst ','\'',$(perfexec_instdir))
+perf_include_instdir_SQ = $(subst ','\'',$(perf_include_instdir))
 STRACE_GROUPS_INSTDIR_SQ = $(subst ','\'',$(STRACE_GROUPS_INSTDIR))
 tip_instdir_SQ = $(subst ','\'',$(tip_instdir))
 
@@ -999,6 +1005,7 @@ $(call detected_var,ETC_PERFCONFIG_SQ)
 $(call detected_var,STRACE_GROUPS_DIR_SQ)
 $(call detected_var,prefix_SQ)
 $(call detected_var,perfexecdir_SQ)
+$(call detected_var,perf_include_dir_SQ)
 $(call detected_var,tipdir_SQ)
 $(call detected_var,srcdir_SQ)
 $(call detected_var,LIBDIR)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 83e453de36f8..d9663b1cf43e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -767,6 +767,10 @@ ifndef NO_JVMTI
 endif
 	$(call QUIET_INSTALL, libexec) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
+ifndef NO_LIBBPF
+	$(call QUIET_INSTALL, lib) \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
+endif
 	$(call QUIET_INSTALL, perf-archive) \
 		$(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 	$(call QUIET_INSTALL, perf-with-kcore) \
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8052373bcd6a..5d4c45b76895 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -152,6 +152,8 @@ libperf-y += perf-hooks.o
 libperf-$(CONFIG_CXX) += c++/
 
 CFLAGS_config.o   += -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
+CFLAGS_llvm-utils.o += -DPERF_INCLUDE_DIR="BUILD_STR($(perf_include_dir_SQ))"
+
 # avoid compiler warnings in 32-bit mode
 CFLAGS_genelf_debug.o  += -Wno-packed
 
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 1cca0a2fa641..976e658e38dc 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -14,11 +14,12 @@
 #include "config.h"
 #include "util.h"
 #include <sys/wait.h>
+#include <subcmd/exec-cmd.h>
 
 #define CLANG_BPF_CMD_DEFAULT_TEMPLATE				\
 		"$CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS "\
 		"-DLINUX_VERSION_CODE=$LINUX_VERSION_CODE "	\
-		"$CLANG_OPTIONS $KERNEL_INC_OPTIONS "		\
+		"$CLANG_OPTIONS $KERNEL_INC_OPTIONS $PERF_BPF_INC_OPTIONS " \
 		"-Wno-unused-value -Wno-pointer-sign "		\
 		"-working-directory $WORKING_DIR "		\
 		"-c \"$CLANG_SOURCE\" -target bpf -O2 -o -"
@@ -212,7 +213,7 @@ version_notice(void)
 "     \t\thttp://llvm.org/apt\n\n"
 "     \tIf you are using old version of clang, change 'clang-bpf-cmd-template'\n"
 "     \toption in [llvm] section of ~/.perfconfig to:\n\n"
-"     \t  \"$CLANG_EXEC $CLANG_OPTIONS $KERNEL_INC_OPTIONS \\\n"
+"     \t  \"$CLANG_EXEC $CLANG_OPTIONS $KERNEL_INC_OPTIONS $PERF_BPF_INC_OPTIONS \\\n"
 "     \t     -working-directory $WORKING_DIR -c $CLANG_SOURCE \\\n"
 "     \t     -emit-llvm -o - | /path/to/llc -march=bpf -filetype=obj -o -\"\n"
 "     \t(Replace /path/to/llc with path to your llc)\n\n"
@@ -431,9 +432,11 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 	const char *clang_opt = llvm_param.clang_opt;
 	char clang_path[PATH_MAX], abspath[PATH_MAX], nr_cpus_avail_str[64];
 	char serr[STRERR_BUFSIZE];
-	char *kbuild_dir = NULL, *kbuild_include_opts = NULL;
+	char *kbuild_dir = NULL, *kbuild_include_opts = NULL,
+	     *perf_bpf_include_opts = NULL;
 	const char *template = llvm_param.clang_bpf_cmd_template;
-	char *command_echo, *command_out;
+	char *command_echo = NULL, *command_out;
+	char *perf_include_dir = system_path(PERF_INCLUDE_DIR);
 
 	if (path[0] != '-' && realpath(path, abspath) == NULL) {
 		err = errno;
@@ -471,12 +474,14 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 
 	snprintf(linux_version_code_str, sizeof(linux_version_code_str),
 		 "0x%x", kernel_version);
-
+	if (asprintf(&perf_bpf_include_opts, "-I%s/bpf", perf_include_dir) < 0)
+		goto errout;
 	force_set_env("NR_CPUS", nr_cpus_avail_str);
 	force_set_env("LINUX_VERSION_CODE", linux_version_code_str);
 	force_set_env("CLANG_EXEC", clang_path);
 	force_set_env("CLANG_OPTIONS", clang_opt);
 	force_set_env("KERNEL_INC_OPTIONS", kbuild_include_opts);
+	force_set_env("PERF_BPF_INC_OPTIONS", perf_bpf_include_opts);
 	force_set_env("WORKING_DIR", kbuild_dir ? : ".");
 
 	/*
@@ -512,6 +517,8 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 	free(command_out);
 	free(kbuild_dir);
 	free(kbuild_include_opts);
+	free(perf_bpf_include_opts);
+	free(perf_include_dir);
 
 	if (!p_obj_buf)
 		free(obj_buf);
@@ -526,6 +533,8 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 	free(kbuild_dir);
 	free(kbuild_include_opts);
 	free(obj_buf);
+	free(perf_bpf_include_opts);
+	free(perf_include_dir);
 	if (p_obj_buf)
 		*p_obj_buf = NULL;
 	if (p_obj_buf_sz)
-- 
2.14.3
