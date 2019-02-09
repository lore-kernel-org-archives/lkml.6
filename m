Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7F1C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 01:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9B721841
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 01:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DOEkI5/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfBIBVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 20:21:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40652 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbfBIBVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 20:21:52 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x191JcU6018969
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 17:21:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ZlHDyDscJcMq4t25JYH/h353LmNV5Oz+KZ0zDPPYtyw=;
 b=DOEkI5/uMPPDGN0Y6Mp4/bRhu0mm0SvLuDBqqLcgCHsBXcPfH/3KFno6bTpBe/VoPUZr
 lcKNty1J/4rHy5AqVDImXB6lTroMEPtJOCn3eRocenipIFJYvbsab3Tw3dNAQR8cXFlP
 zeQx/dOaI4yZDSRycPsgkkPhyyUuRmcBD9k= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qhmxf00xq-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 17:21:50 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Fri, 8 Feb 2019 17:21:49 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id E794C62E2A09; Fri,  8 Feb 2019 17:21:47 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 8/9] perf, bpf: enable annotation of bpf program
Date:   Fri, 8 Feb 2019 17:21:41 -0800
Message-ID: <20190209012142.2177204-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209012142.2177204-1-songliubraving@fb.com>
References: <20190209012142.2177204-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-09_01:,,
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
 tools/perf/Makefile.config  |   2 +-
 tools/perf/util/annotate.c  | 149 +++++++++++++++++++++++++++++++++++-
 tools/perf/util/bpf-event.c |  48 ++++++++++++
 tools/perf/util/bpf-event.h |   4 +
 tools/perf/util/dso.c       |   1 +
 tools/perf/util/dso.h       |  33 +++++---
 tools/perf/util/symbol.c    |   1 +
 7 files changed, 225 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b441c88cafa1..e0bafbc273af 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -701,7 +701,7 @@ else
 endif
 
 ifeq ($(feature-libbfd), 1)
-  EXTLIBS += -lbfd
+  EXTLIBS += -lbfd -lopcodes
 else
   # we are on a system that requires -liberty and (maybe) -lz
   # to link against -lbfd; test each case individually here
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 70de8f6b3aee..078017d31ca9 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -22,6 +22,7 @@
 #include "annotate.h"
 #include "evsel.h"
 #include "evlist.h"
+#include "bpf-event.h"
 #include "block-range.h"
 #include "string2.h"
 #include "arch/common.h"
@@ -29,6 +30,9 @@
 #include <pthread.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
+#include <bfd.h>
+#include <dis-asm.h>
+#include <bpf/libbpf.h>
 
 /* FIXME: For the HE_COLORSET */
 #include "ui/browser.h"
@@ -1672,6 +1676,147 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	return 0;
 }
 
+static void get_exec_path(char *tpath, size_t size)
+{
+	const char *path = "/proc/self/exe";
+	ssize_t len;
+
+	len = readlink(path, tpath, size - 1);
+	assert(len > 0);
+	tpath[len] = 0;
+}
+
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
+	__u64 arrays;
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
+	init_disassemble_info(&info, s,
+			      (fprintf_ftype) fprintf);
+
+	info.arch = bfd_get_arch(bfdf);
+	info.mach = bfd_get_mach(bfdf);
+
+	arrays = 1UL << BPF_PROG_INFO_JITED_INSNS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_KSYMS;
+	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
+
+	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
+						 dso->bpf_prog.id);
+	if (!info_node)
+		return -1;
+	info_linear = info_node->info_linear;
+	sub_id = dso->bpf_prog.sub_id;
+
+	info.buffer = (void *)(info_linear->info.jited_prog_insns);
+	info.buffer_length = info_linear->info.jited_prog_len;
+
+	if (info_linear->info.nr_line_info)
+		prog_linfo = bpf_prog_linfo__new(&info_linear->info);
+	prog_linfo = prog_linfo;
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
+		linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo, addr, sub_id,
+							nr_skip);
+
+		if (linfo) {
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
+			annotation_line__add(&dl->al, &notes->src->source);
+		}
+
+		args->offset = pc;
+		args->line = buf + prev_buf_size;
+		args->line_nr = 0;
+		args->ms.sym  = sym;
+		dl = disasm_line__new(args);
+		annotation_line__add(&dl->al, &notes->src->source);
+
+		pc += count;
+	} while (count > 0 && pc < len);
+
+	bfd_close(bfdf);
+	return 0;
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
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 37a5b8134e00..4f347d61ed96 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -21,12 +21,60 @@ static int snprintf_hex(char *buf, size_t size, unsigned char *data, size_t len)
 	return ret;
 }
 
+static int machine__process_bpf_event_load(struct machine *machine __maybe_unused,
+					   union perf_event *event,
+					   struct perf_sample *sample __maybe_unused)
+{
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_info_node *info_node;
+	struct perf_env *env = machine->env;
+	int id = event->bpf_event.id;
+	unsigned int i;
+
+	/* perf-record, no need to handle bpf-event */
+	if (env == NULL)
+		return 0;
+
+	info_node = perf_env__find_bpf_prog_info(env, id);
+	if (!info_node)
+		return 0;
+	info_linear = info_node->info_linear;
+
+	for (i = 0; i < info_linear->info.nr_jited_ksyms; i++) {
+		u64 *addrs = (u64 *)(info_linear->info.jited_ksyms);
+		u64 addr = addrs[i];
+		struct map *map;
+
+		map = map_groups__find(&machine->kmaps, addr);
+
+		if (map) {
+			map->dso->binary_type = DSO_BINARY_TYPE__BPF_PROG_INFO;
+			map->dso->bpf_prog.id = id;
+			map->dso->bpf_prog.sub_id = i;
+			map->dso->bpf_prog.env = env;
+		}
+	}
+	return 0;
+}
+
 int machine__process_bpf_event(struct machine *machine __maybe_unused,
 			       union perf_event *event,
 			       struct perf_sample *sample __maybe_unused)
 {
 	if (dump_trace)
 		perf_event__fprintf_bpf_event(event, stdout);
+
+	switch (event->bpf_event.type) {
+	case PERF_BPF_EVENT_PROG_LOAD:
+		return machine__process_bpf_event_load(machine, event, sample);
+
+	case PERF_BPF_EVENT_PROG_UNLOAD:
+		break;
+	default:
+		pr_debug("unexpected bpf_event type of %d\n",
+			 event->bpf_event.type);
+		break;
+	}
 	return 0;
 }
 
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 60ce24e4e5c6..c4f0f1395ea5 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -2,6 +2,10 @@
 #ifndef __PERF_BPF_EVENT_H
 #define __PERF_BPF_EVENT_H
 
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+#include <linux/btf.h>
 #include <linux/compiler.h>
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
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
-- 
2.17.1

