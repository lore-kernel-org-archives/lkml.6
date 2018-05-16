Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750759AbeEPOti (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751467AbeEPOtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:49:35 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 04/11] perf bpf: Add 'examples' directories
Date: Wed, 16 May 2018 11:49:01 -0300
Message-Id: <20180516144908.22212-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180516144908.22212-1-acme@kernel.org>
References: <20180516144908.22212-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The first one is the bare minimum that bpf infrastructure accepts before
it expects actual events to be set up:

  $ cat tools/perf/examples/bpf/empty.c
  char _license[] __attribute__((section("license"), used)) = "GPL";
  int _version __attribute__((section("version"), used)) = LINUX_VERSION_CODE;
  $

If you remove that "version" line, then it will be refused with:

  # perf trace -e tools/perf/examples/bpf/empty.c
  event syntax error: 'tools/perf/examples/bpf/empty.c'
                       \___ Failed to load tools/perf/examples/bpf/empty.c from source: 'version' section incorrect or lost

  (add -v to see detail)
  Run 'perf list' for a list of valid events

   Usage: perf trace [<options>] [<command>]
      or: perf trace [<options>] -- <command> [<options>]
      or: perf trace record [<options>] [<command>]
      or: perf trace record [<options>] -- <command> [<options>]

      -e, --event <event>   event/syscall selector. use 'perf list' to list available events
  #

The next ones will, step by step, show simple filters, then the needs
for headers will be made clear, it will be put in place and tested with
new examples, rinse, repeat.

Back to using this first one to test the perf+bpf infrastructure:

If we run it will fail, as no functions are present connecting with,
say, a tracepoint or a function using the kprobes or uprobes
infrastructure:

  # perf trace -e tools/perf/examples/bpf/empty.c
  WARNING: event parser found nothing
  invalid or unsupported event: 'tools/perf/examples/bpf/empty.c'
  Run 'perf list' for a list of valid events

   Usage: perf trace [<options>] [<command>]
      or: perf trace [<options>] -- <command> [<options>]
      or: perf trace record [<options>] [<command>]
      or: perf trace record [<options>] -- <command> [<options>]

      -e, --event <event>   event/syscall selector. use 'perf list' to list available events
  #

But, if we set things up to dump the generated object file to a file,
and do this after having run 'make install', still on the developer's
$HOME directory:

  # cat ~/.perfconfig
  [llvm]

	dump-obj = true
  #
  # perf trace -e ~acme/lib/examples/perf/bpf/empty.c
  LLVM: dumping /home/acme/lib/examples/perf/bpf/empty.o
  WARNING: event parser found nothing
  invalid or unsupported event: '/home/acme/lib/examples/perf/bpf/empty.c'
  <SNIP>
  #

We can look at the dumped object file:

  # ls -la ~acme/lib/examples/perf/bpf/empty.o
  -rw-r--r--. 1 root root 576 May  4 12:10 /home/acme/lib/examples/perf/bpf/empty.o
  # file ~acme/lib/examples/perf/bpf/empty.o
  /home/acme/lib/examples/perf/bpf/empty.o: ELF 64-bit LSB relocatable, *unknown arch 0xf7* version 1 (SYSV), not stripped
  # readelf -sw ~acme/lib/examples/perf/bpf/empty.o

  Symbol table '.symtab' contains 3 entries:
     Num:    Value          Size Type    Bind   Vis      Ndx Name
       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
       1: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    3 _license
       2: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    4 _version
  #
  # tools/bpf/bpftool/bpftool --pretty ~acme/lib/examples/perf/bpf/empty.o
  null
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-y7dkhakejz3013o0w21n98xd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config      | 7 +++++++
 tools/perf/Makefile.perf        | 3 +++
 tools/perf/examples/bpf/empty.c | 2 ++
 3 files changed, 12 insertions(+)
 create mode 100644 tools/perf/examples/bpf/empty.c

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 3bca9a733f0e..b5ac356ba323 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -886,6 +886,7 @@ endif
 # Among the variables below, these:
 #   perfexecdir
 #   perf_include_dir
+#   perf_examples_dir
 #   template_dir
 #   mandir
 #   infodir
@@ -906,6 +907,7 @@ mandir = share/man
 infodir = share/info
 perfexecdir = libexec/perf-core
 perf_include_dir = lib/include/perf
+perf_examples_dir = lib/examples/perf
 sharedir = $(prefix)/share
 template_dir = share/perf-core/templates
 STRACE_GROUPS_DIR = share/perf-core/strace/groups
@@ -937,6 +939,7 @@ mandir_SQ = $(subst ','\'',$(mandir))
 infodir_SQ = $(subst ','\'',$(infodir))
 perfexecdir_SQ = $(subst ','\'',$(perfexecdir))
 perf_include_dir_SQ = $(subst ','\'',$(perf_include_dir))
+perf_examples_dir_SQ = $(subst ','\'',$(perf_examples_dir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_SQ = $(subst ','\'',$(htmldir))
 tipdir_SQ = $(subst ','\'',$(tipdir))
@@ -948,16 +951,19 @@ srcdir_SQ = $(subst ','\'',$(srcdir))
 ifneq ($(filter /%,$(firstword $(perfexecdir))),)
 perfexec_instdir = $(perfexecdir)
 perf_include_instdir = $(perf_include_dir)
+perf_examples_instdir = $(perf_examples_dir)
 STRACE_GROUPS_INSTDIR = $(STRACE_GROUPS_DIR)
 tip_instdir = $(tipdir)
 else
 perfexec_instdir = $(prefix)/$(perfexecdir)
 perf_include_instdir = $(prefix)/$(perf_include_dir)
+perf_examples_instdir = $(prefix)/$(perf_examples_dir)
 STRACE_GROUPS_INSTDIR = $(prefix)/$(STRACE_GROUPS_DIR)
 tip_instdir = $(prefix)/$(tipdir)
 endif
 perfexec_instdir_SQ = $(subst ','\'',$(perfexec_instdir))
 perf_include_instdir_SQ = $(subst ','\'',$(perf_include_instdir))
+perf_examples_instdir_SQ = $(subst ','\'',$(perf_examples_instdir))
 STRACE_GROUPS_INSTDIR_SQ = $(subst ','\'',$(STRACE_GROUPS_INSTDIR))
 tip_instdir_SQ = $(subst ','\'',$(tip_instdir))
 
@@ -1006,6 +1012,7 @@ $(call detected_var,STRACE_GROUPS_DIR_SQ)
 $(call detected_var,prefix_SQ)
 $(call detected_var,perfexecdir_SQ)
 $(call detected_var,perf_include_dir_SQ)
+$(call detected_var,perf_examples_dir_SQ)
 $(call detected_var,tipdir_SQ)
 $(call detected_var,srcdir_SQ)
 $(call detected_var,LIBDIR)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d9663b1cf43e..9343b7d945bb 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -770,6 +770,9 @@ endif
 ifndef NO_LIBBPF
 	$(call QUIET_INSTALL, lib) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
+	$(call QUIET_INSTALL, lib) \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
+		$(INSTALL) examples/bpf/*.c '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
 endif
 	$(call QUIET_INSTALL, perf-archive) \
 		$(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
diff --git a/tools/perf/examples/bpf/empty.c b/tools/perf/examples/bpf/empty.c
new file mode 100644
index 000000000000..78754df53ac1
--- /dev/null
+++ b/tools/perf/examples/bpf/empty.c
@@ -0,0 +1,2 @@
+char _license[] __attribute__((section("license"), used)) = "GPL";
+int _version __attribute__((section("version"), used)) = LINUX_VERSION_CODE;
-- 
2.14.3
