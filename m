Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D66C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89B12184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oXldOYtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfBZAU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:20:59 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44416 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729420AbfBZAUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:20:54 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q0IvEK016659
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:20:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=AmMeb9lNmeUW+Yk265uXKmQCiKz9zKuyk5xO5T+zo2c=;
 b=oXldOYtZdYUrr6cNH/tKBT5OMo2/oGvrOfxCOlBdrKuteGt2NEu2dYnLl7sWYt9w2x6n
 0Fwa1uZ79q6gMzA01we3/1gB4eNluE+ckGR770sESRCjscx7FMRqtormH+1nXbkcETT5
 wuP8FoE1Mr+SsCRlmN8V0Jg4qjgRMV3vFR8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qvtg2r25k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:20:52 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 25 Feb 2019 16:20:51 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 35F0562E1F7B; Mon, 25 Feb 2019 16:20:51 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 perf,bpf 12/15] perf, bpf: enable annotation of bpf program
Date:   Mon, 25 Feb 2019 16:20:16 -0800
Message-ID: <20190226002019.3748539-13-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226002019.3748539-1-songliubraving@fb.com>
References: <20190226002019.3748539-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the annotation of bpf program.

A new dso type DSO_BINARY_TYPE__BPF_PROG_INFO is introduced to for BPF
programs. In symbol__disassemble(), DSO_BINARY_TYPE__BPF_PROG_INFO dso
calls into a new function symbol__disassemble_bpf(), where annotation
line information is filled based bpf_prog_info and btf saved in given
perf_env.

symbol__disassemble_bpf() uses libbfd to disassemble bpf programs.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/build/Makefile.feature |   6 +-
 tools/perf/Makefile.config   |   4 +
 tools/perf/util/annotate.c   | 149 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/dso.c        |   1 +
 tools/perf/util/dso.h        |  33 +++++---
 tools/perf/util/header.c     |   7 +-
 tools/perf/util/symbol.c     |   1 +
 tools/perf/util/util.c       |  10 +++
 tools/perf/util/util.h       |   2 +
 9 files changed, 193 insertions(+), 20 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 5467c6bf9ceb..4f35e9ff1e00 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -71,7 +71,8 @@ FEATURE_TESTS_BASIC :=                  \
         sdt				\
         setns				\
         libopencsd			\
-        libaio
+        libaio				\
+        disassembler-four-args
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
@@ -118,7 +119,8 @@ FEATURE_DISPLAY ?=              \
          lzma                   \
          get_cpuid              \
          bpf			\
-         libaio
+         libaio			\
+         disassembler-four-args
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e0bafbc273af..ab223239f1fb 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -796,6 +796,10 @@ ifdef HAVE_KVM_STAT_SUPPORT
     CFLAGS += -DHAVE_KVM_STAT_SUPPORT
 endif
 
+ifeq ($(feature-disassembler-four-args), 1)
+    CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
+endif
+
 ifeq (${IS_64_BIT}, 1)
   ifndef NO_PERF_READ_VDSO32
     $(call feature_check,compile-32)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 70de8f6b3aee..716fdb07f45e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -9,6 +9,10 @@
 
 #include <errno.h>
 #include <inttypes.h>
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+#include <linux/btf.h>
 #include "util.h"
 #include "ui/ui.h"
 #include "sort.h"
@@ -22,6 +26,7 @@
 #include "annotate.h"
 #include "evsel.h"
 #include "evlist.h"
+#include "bpf-event.h"
 #include "block-range.h"
 #include "string2.h"
 #include "arch/common.h"
@@ -29,6 +34,9 @@
 #include <pthread.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
+#include <bfd.h>
+#include <dis-asm.h>
+#include <bpf/libbpf.h>
 
 /* FIXME: For the HE_COLORSET */
 #include "ui/browser.h"
@@ -1672,6 +1680,143 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	return 0;
 }
 
+static int symbol__disassemble_bpf(struct symbol *sym,
+				   struct annotate_args *args)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	struct annotation_options *opts = args->options;
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_linfo *prog_linfo = NULL;
+	struct bpf_prog_info_node *info_node;
+	int len = sym->end - sym->start;
+	disassembler_ftype disassemble;
+	struct map *map = args->ms.map;
+	struct disassemble_info info;
+	struct dso *dso = map->dso;
+	int pc = 0, count, sub_id;
+	struct btf *btf = NULL;
+	char tpath[PATH_MAX];
+	size_t buf_size;
+	int nr_skip = 0;
+	int ret = -1;
+	char *buf;
+	bfd *bfdf;
+	FILE *s;
+
+	if (dso->binary_type != DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return -1;
+
+	pr_debug("%s: handling sym %s addr %lx len %lx\n", __func__,
+		 sym->name, sym->start, sym->end - sym->start);
+
+	memset(tpath, 0, sizeof(tpath));
+	get_exec_path(tpath, sizeof(tpath));
+
+	bfdf = bfd_openr(tpath, NULL);
+	assert(bfdf);
+	assert(bfd_check_format(bfdf, bfd_object));
+
+	s = open_memstream(&buf, &buf_size);
+	if (!s)
+		goto out;
+	init_disassemble_info(&info, s,
+			      (fprintf_ftype) fprintf);
+
+	info.arch = bfd_get_arch(bfdf);
+	info.mach = bfd_get_mach(bfdf);
+
+	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
+						 dso->bpf_prog.id);
+	if (!info_node)
+		goto out;
+	info_linear = info_node->info_linear;
+	sub_id = dso->bpf_prog.sub_id;
+
+	info.buffer = (void *)(info_linear->info.jited_prog_insns);
+	info.buffer_length = info_linear->info.jited_prog_len;
+
+	if (info_linear->info.nr_line_info)
+		prog_linfo = bpf_prog_linfo__new(&info_linear->info);
+
+	if (info_linear->info.btf_id) {
+		struct btf_node *node;
+
+		node = perf_env__find_btf(dso->bpf_prog.env,
+					  info_linear->info.btf_id);
+		if (node)
+			btf = btf__new((__u8 *)(node->data),
+				       node->data_size);
+	}
+
+	disassemble_init_for_target(&info);
+
+#ifdef DISASM_FOUR_ARGS_SIGNATURE
+	disassemble = disassembler(info.arch,
+				   bfd_big_endian(bfdf),
+				   info.mach,
+				   bfdf);
+#else
+	disassemble = disassembler(bfdf);
+#endif
+	assert(disassemble);
+
+	fflush(s);
+	do {
+		const struct bpf_line_info *linfo = NULL;
+		struct disasm_line *dl;
+		size_t prev_buf_size;
+		const char *srcline;
+		u64 addr;
+
+		addr = pc + ((u64 *)(info_linear->info.jited_ksyms))[sub_id];
+		count = disassemble(pc, &info);
+
+		if (prog_linfo)
+			linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
+								addr, sub_id,
+								nr_skip);
+
+		if (linfo && btf) {
+			srcline = btf__name_by_offset(btf, linfo->line_off);
+			nr_skip++;
+		} else
+			srcline = NULL;
+
+		fprintf(s, "\n");
+		prev_buf_size = buf_size;
+		fflush(s);
+
+		if (!opts->hide_src_code && srcline) {
+			args->offset = -1;
+			args->line = strdup(srcline);
+			args->line_nr = 0;
+			args->ms.sym  = sym;
+			dl = disasm_line__new(args);
+			if (dl)
+				annotation_line__add(&dl->al,
+						     &notes->src->source);
+		}
+
+		args->offset = pc;
+		args->line = buf + prev_buf_size;
+		args->line_nr = 0;
+		args->ms.sym  = sym;
+		dl = disasm_line__new(args);
+		if (dl)
+			annotation_line__add(&dl->al, &notes->src->source);
+
+		pc += count;
+	} while (count > 0 && pc < len);
+
+	ret = 0;
+out:
+	free(prog_linfo);
+	free(btf);
+	fclose(s);
+	bfd_close(bfdf);
+	return ret;
+}
+
 static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
 	struct annotation_options *opts = args->options;
@@ -1699,7 +1844,9 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	pr_debug("annotating [%p] %30s : [%p] %30s\n",
 		 dso, dso->long_name, sym, sym->name);
 
-	if (dso__is_kcore(dso)) {
+	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO) {
+		return symbol__disassemble_bpf(sym, args);
+	} else if (dso__is_kcore(dso)) {
 		kce.kcore_filename = symfs_filename;
 		kce.addr = map__rip_2objdump(map, sym->start);
 		kce.offs = sym->start;
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 62c8cf622607..1798192bf0f9 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -181,6 +181,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 	case DSO_BINARY_TYPE__KALLSYMS:
 	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
 	case DSO_BINARY_TYPE__JAVA_JIT:
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 		ret = -1;
 		break;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 8c8a7abe809d..f20d319463f1 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -14,6 +14,8 @@
 #include "namespaces.h"
 #include "build-id.h"
 
+struct perf_env;
+
 enum dso_binary_type {
 	DSO_BINARY_TYPE__KALLSYMS = 0,
 	DSO_BINARY_TYPE__GUEST_KALLSYMS,
@@ -34,6 +36,7 @@ enum dso_binary_type {
 	DSO_BINARY_TYPE__KCORE,
 	DSO_BINARY_TYPE__GUEST_KCORE,
 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
+	DSO_BINARY_TYPE__BPF_PROG_INFO,
 	DSO_BINARY_TYPE__NOT_FOUND,
 };
 
@@ -177,17 +180,25 @@ struct dso {
 	struct auxtrace_cache *auxtrace_cache;
 	int		 comp;
 
-	/* dso data file */
-	struct {
-		struct rb_root	 cache;
-		int		 fd;
-		int		 status;
-		u32		 status_seen;
-		size_t		 file_size;
-		struct list_head open_entry;
-		u64		 debug_frame_offset;
-		u64		 eh_frame_hdr_offset;
-	} data;
+	union {
+		/* dso data file */
+		struct {
+			struct rb_root	 cache;
+			int		 fd;
+			int		 status;
+			u32		 status_seen;
+			size_t		 file_size;
+			struct list_head open_entry;
+			u64		 debug_frame_offset;
+			u64		 eh_frame_hdr_offset;
+		} data;
+		/* bpf prog information */
+		struct {
+			u32		id;
+			u32		sub_id;
+			struct perf_env	*env;
+		} bpf_prog;
+	};
 
 	union { /* Tool specific area */
 		void	 *priv;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index ce5402101468..c39e107ac5b8 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -533,12 +533,7 @@ static int write_cmdline(struct feat_fd *ff,
 	int i, ret;
 
 	/* actual path to perf binary */
-	ret = readlink("/proc/self/exe", buf, sizeof(buf) - 1);
-	if (ret <= 0)
-		return -1;
-
-	/* readlink() does not add null termination */
-	buf[ret] = '\0';
+	get_exec_path(buf, sizeof(buf));
 
 	/* account for binary path */
 	n = perf_env.nr_cmdline + 1;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 48efad6d0f90..33ae59e89da2 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1441,6 +1441,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
 		return true;
 
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 	default:
 		return false;
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 093352e93d50..0bc9ec69f38a 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -506,3 +506,13 @@ const char *perf_tip(const char *dirpath)
 
 	return tip;
 }
+
+void get_exec_path(char *tpath, size_t size)
+{
+	const char *path = "/proc/self/exe";
+	ssize_t len;
+
+	len = readlink(path, tpath, size - 1);
+	assert(len > 0);
+	tpath[len] = 0;
+}
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index ece040b799f6..8d0a88eb8685 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -76,6 +76,8 @@ extern bool perf_singlethreaded;
 void perf_set_singlethreaded(void);
 void perf_set_multithreaded(void);
 
+void get_exec_path(char *tpath, size_t size);
+
 #ifndef O_CLOEXEC
 #ifdef __sparc__
 #define O_CLOEXEC      0x400000
-- 
2.17.1

