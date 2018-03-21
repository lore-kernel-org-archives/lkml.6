Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeCURAY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:00:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751644AbeCURAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:00:21 -0400
Date: Wed, 21 Mar 2018 18:00:19 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Quentin Monnet <quentin.monnet@netronome.com>,
        Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: [PATCHv2 2/2] bpftool: Adjust to new print_bpf_insn interface
Message-ID: <20180321170019.GE2707@krava>
References: <20180321150212.5586-1-jolsa@kernel.org>
 <20180321150212.5586-2-jolsa@kernel.org>
 <c27c5c1c-79ee-3ed2-d1c3-a011ead4edea@netronome.com>
 <20180321164324.GD2707@krava>
 <774f0eca-72cf-1c70-e025-beea2084ebe0@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <774f0eca-72cf-1c70-e025-beea2084ebe0@iogearbox.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 05:44:52PM +0100, Daniel Borkmann wrote:

SNIP

> >> Hi Jiri, this code has changed in the tree. It was moved to
> >> tools/bpf/bpftool/xlated_dumper.c, and there is now a third function to
> >> update: print_insn_for_graph(). Could you please rebase the patch?
> > 
> > sure.. I was over perf tree, I'll check on bpf tree
> 
> Just to be sure, it should be bpf-next. bpf is for fixes only.

v2 attached

thanks,
jirka


---
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
