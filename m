Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932484AbeCLJpS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:45:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752611AbeCLJn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:43:29 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 08/13] libbpf: Collect begin/end .text functions
Date: Mon, 12 Mar 2018 10:43:08 +0100
Message-Id: <20180312094313.18738-9-jolsa@kernel.org>
In-Reply-To: <20180312094313.18738-1-jolsa@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Collect begin/end functions from .text section,
so they could be executed before/after probes.

Link: http://lkml.kernel.org/n/tip-hj1hwb7fshdwco706j22ela3@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 07a6d8f5e5ab..26231e278bb8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -225,6 +225,10 @@ struct bpf_object {
 	struct bpf_map *maps;
 	size_t nr_maps;
 
+	struct bpf_program *text;
+	struct bpf_insn *insn_begin;
+	struct bpf_insn *insn_end;
+
 	bool loaded;
 
 	/*
@@ -440,6 +444,68 @@ bpf_object__init_prog_names(struct bpf_object *obj)
 	return 0;
 }
 
+static int
+bpf_object__init_text(struct bpf_object *obj)
+{
+	Elf_Data *symbols = obj->efile.symbols;
+	struct bpf_program *prog;
+	size_t pi, si;
+
+	if (obj->efile.text_shndx == -1)
+		return 0;
+
+	for (pi = 0; pi < obj->nr_programs; pi++) {
+		prog = &obj->programs[pi];
+		if (prog->idx != obj->efile.text_shndx)
+			continue;
+
+		obj->text = prog;
+
+		for (si = 0; si < symbols->d_size / sizeof(GElf_Sym); si++) {
+			bool is_end = false, is_begin = false;
+			struct bpf_insn *insn;
+			const char *name = NULL;
+			unsigned int insn_idx;
+			GElf_Sym sym;
+
+			if (!gelf_getsym(symbols, si, &sym))
+				continue;
+			if (sym.st_shndx != prog->idx)
+				continue;
+			if (GELF_ST_BIND(sym.st_info) != STB_GLOBAL)
+				continue;
+
+			name = elf_strptr(obj->efile.elf,
+					  obj->efile.strtabidx,
+					  sym.st_name);
+			if (!name) {
+				pr_warning("failed to get sym name string for prog %s\n",
+					   prog->section_name);
+				return -LIBBPF_ERRNO__LIBELF;
+			}
+
+			is_begin = !strcmp(name, "BEGIN");
+			is_end   = !strcmp(name, "END");
+
+			if (!is_begin && !is_end)
+				continue;
+
+			insn_idx = sym.st_value / sizeof(struct bpf_insn);
+			insn = &prog->insns[insn_idx];
+
+			pr_debug("set %s to %p\n", name, insn);
+
+			if (is_begin)
+				obj->insn_begin = insn;
+			else
+				obj->insn_end   = insn;
+		}
+	}
+
+	return 0;
+}
+
+
 static struct bpf_object *bpf_object__new(const char *path,
 					  void *obj_buf,
 					  size_t obj_buf_sz)
@@ -464,6 +530,7 @@ static struct bpf_object *bpf_object__new(const char *path,
 	obj->efile.obj_buf = obj_buf;
 	obj->efile.obj_buf_sz = obj_buf_sz;
 	obj->efile.maps_shndx = -1;
+	obj->efile.text_shndx = -1;
 
 	obj->loaded = false;
 
@@ -890,6 +957,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			goto out;
 	}
 	err = bpf_object__init_prog_names(obj);
+	if (err)
+		goto out;
+	err = bpf_object__init_text(obj);
 out:
 	return err;
 }
-- 
2.13.6
