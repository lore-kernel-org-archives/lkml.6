Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756107AbeCWKlp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 06:41:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756308AbeCWKle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 06:41:34 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH 2/2] bpftool: Adjust to new print_bpf_insn interface
Date: Fri, 23 Mar 2018 11:41:29 +0100
Message-Id: <20180323104129.14989-3-jolsa@kernel.org>
In-Reply-To: <20180323104129.14989-1-jolsa@kernel.org>
References: <20180323104129.14989-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change bpftool to skip the removed struct bpf_verifier_env
argument in print_bpf_insn. It was passed as NULL anyway.

No functional change intended.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/xlated_dumper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 20da835e9e38..7a3173b76c16 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -114,7 +114,7 @@ static struct kernel_sym *kernel_syms_search(struct dump_data *dd,
 		       sizeof(*dd->sym_mapping), kernel_syms_cmp) : NULL;
 }
 
-static void print_insn(struct bpf_verifier_env *env, const char *fmt, ...)
+static void print_insn(void *private_data, const char *fmt, ...)
 {
 	va_list args;
 
@@ -124,7 +124,7 @@ static void print_insn(struct bpf_verifier_env *env, const char *fmt, ...)
 }
 
 static void
-print_insn_for_graph(struct bpf_verifier_env *env, const char *fmt, ...)
+print_insn_for_graph(void *private_data, const char *fmt, ...)
 {
 	char buf[64], *p;
 	va_list args;
@@ -154,7 +154,7 @@ print_insn_for_graph(struct bpf_verifier_env *env, const char *fmt, ...)
 	printf("%s", buf);
 }
 
-static void print_insn_json(struct bpf_verifier_env *env, const char *fmt, ...)
+static void print_insn_json(void *private_data, const char *fmt, ...)
 {
 	unsigned int l = strlen(fmt);
 	char chomped_fmt[l];
@@ -248,7 +248,7 @@ void dump_xlated_json(struct dump_data *dd, void *buf, unsigned int len,
 
 		jsonw_start_object(json_wtr);
 		jsonw_name(json_wtr, "disasm");
-		print_bpf_insn(&cbs, NULL, insn + i, true);
+		print_bpf_insn(&cbs, insn + i, true);
 
 		if (opcodes) {
 			jsonw_name(json_wtr, "opcodes");
@@ -302,7 +302,7 @@ void dump_xlated_plain(struct dump_data *dd, void *buf, unsigned int len,
 		double_insn = insn[i].code == (BPF_LD | BPF_IMM | BPF_DW);
 
 		printf("% 4d: ", i);
-		print_bpf_insn(&cbs, NULL, insn + i, true);
+		print_bpf_insn(&cbs, insn + i, true);
 
 		if (opcodes) {
 			printf("       ");
@@ -331,7 +331,7 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
 
 	for (; cur <= insn_end; cur++) {
 		printf("% 4d: ", (int)(cur - insn_start + start_idx));
-		print_bpf_insn(&cbs, NULL, cur, true);
+		print_bpf_insn(&cbs, cur, true);
 		if (cur != insn_end)
 			printf(" | ");
 	}
-- 
2.13.6
