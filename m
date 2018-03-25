Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeCYWYm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:24:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37953 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeCYWYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:24:37 -0400
Date: Sun, 25 Mar 2018 15:24:27 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ris0ioziyp469pofpzix2atb@git.kernel.org>
Cc: jolsa@kernel.org, adrian.hunter@intel.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        hpa@zytor.com, dsahern@gmail.com, namhyung@kernel.org, acme@redhat.com
Reply-To: namhyung@kernel.org, acme@redhat.com, dsahern@gmail.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        jolsa@kernel.org, adrian.hunter@intel.com, mingo@kernel.org,
        tglx@linutronix.de
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Pass function descriptor to its
 instruction parsing routines
Git-Commit-ID: 85a84e4f813912ab77d872ff6882dd7b435fbf4e
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

Commit-ID:  85a84e4f813912ab77d872ff6882dd7b435fbf4e
Gitweb:     https://git.kernel.org/tip/85a84e4f813912ab77d872ff6882dd7b435fbf4e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 20 Mar 2018 16:19:08 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Mar 2018 16:19:41 -0300

perf annotate: Pass function descriptor to its instruction parsing routines

We need that to figure out if jumps have targets in a different
function.

E.g. _cpp_lex_token(), in /usr/libexec/gcc/x86_64-redhat-linux/5.3.1/cc1
has a line like this:

  jne    c469be <cpp_named_operator2name@@Base+0xa72>

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ris0ioziyp469pofpzix2atb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/annotate/instructions.c |  5 +++--
 tools/perf/util/annotate.c                   | 30 ++++++++++++++++------------
 tools/perf/util/annotate.h                   |  2 +-
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 46c21831f2ac..cee4e2f7c057 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -2,9 +2,10 @@
 #include <linux/compiler.h>
 
 static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
-			    struct map *map)
+			    struct map_symbol *ms)
 {
 	char *endptr, *tok, *name;
+	struct map *map = ms->map;
 	struct addr_map_symbol target = {
 		.map = map,
 	};
@@ -54,7 +55,7 @@ static struct ins_ops s390_call_ops = {
 
 static int s390_mov__parse(struct arch *arch __maybe_unused,
 			   struct ins_operands *ops,
-			   struct map *map __maybe_unused)
+			   struct map_symbol *ms __maybe_unused)
 {
 	char *s = strchr(ops->raw, ','), *target, *endptr;
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 666f62c58e1a..3ff829d89178 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -202,9 +202,10 @@ bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2)
 	return arch->ins_is_fused(arch, ins1, ins2);
 }
 
-static int call__parse(struct arch *arch, struct ins_operands *ops, struct map *map)
+static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms)
 {
 	char *endptr, *tok, *name;
+	struct map *map = ms->map;
 	struct addr_map_symbol target = {
 		.map = map,
 	};
@@ -272,7 +273,7 @@ bool ins__is_call(const struct ins *ins)
 	return ins->ops == &call_ops || ins->ops == &s390_call_ops;
 }
 
-static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map *map __maybe_unused)
+static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map_symbol *ms __maybe_unused)
 {
 	const char *s = strchr(ops->raw, '+');
 	const char *c = strchr(ops->raw, ',');
@@ -365,7 +366,7 @@ static int comment__symbol(char *raw, char *comment, u64 *addrp, char **namep)
 	return 0;
 }
 
-static int lock__parse(struct arch *arch, struct ins_operands *ops, struct map *map)
+static int lock__parse(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms)
 {
 	ops->locked.ops = zalloc(sizeof(*ops->locked.ops));
 	if (ops->locked.ops == NULL)
@@ -380,7 +381,7 @@ static int lock__parse(struct arch *arch, struct ins_operands *ops, struct map *
 		goto out_free_ops;
 
 	if (ops->locked.ins.ops->parse &&
-	    ops->locked.ins.ops->parse(arch, ops->locked.ops, map) < 0)
+	    ops->locked.ins.ops->parse(arch, ops->locked.ops, ms) < 0)
 		goto out_free_ops;
 
 	return 0;
@@ -423,7 +424,7 @@ static struct ins_ops lock_ops = {
 	.scnprintf = lock__scnprintf,
 };
 
-static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map *map __maybe_unused)
+static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms __maybe_unused)
 {
 	char *s = strchr(ops->raw, ','), *target, *comment, prev;
 
@@ -484,7 +485,7 @@ static struct ins_ops mov_ops = {
 	.scnprintf = mov__scnprintf,
 };
 
-static int dec__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map *map __maybe_unused)
+static int dec__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map_symbol *ms __maybe_unused)
 {
 	char *target, *comment, *s, prev;
 
@@ -923,14 +924,14 @@ int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *samp
 	return symbol__inc_addr_samples(he->ms.sym, he->ms.map, evidx, ip, sample);
 }
 
-static void disasm_line__init_ins(struct disasm_line *dl, struct arch *arch, struct map *map)
+static void disasm_line__init_ins(struct disasm_line *dl, struct arch *arch, struct map_symbol *ms)
 {
 	dl->ins.ops = ins__find(arch, dl->ins.name);
 
 	if (!dl->ins.ops)
 		return;
 
-	if (dl->ins.ops->parse && dl->ins.ops->parse(arch, &dl->ops, map) < 0)
+	if (dl->ins.ops->parse && dl->ins.ops->parse(arch, &dl->ops, ms) < 0)
 		dl->ins.ops = NULL;
 }
 
@@ -967,7 +968,7 @@ out_free_name:
 struct annotate_args {
 	size_t			 privsize;
 	struct arch		*arch;
-	struct map		*map;
+	struct map_symbol	 ms;
 	struct perf_evsel	*evsel;
 	s64			 offset;
 	char			*line;
@@ -1049,7 +1050,7 @@ static struct disasm_line *disasm_line__new(struct annotate_args *args)
 			if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
 				goto out_free_line;
 
-			disasm_line__init_ins(dl, args->arch, args->map);
+			disasm_line__init_ins(dl, args->arch, &args->ms);
 		}
 	}
 
@@ -1307,7 +1308,7 @@ static int symbol__parse_objdump_line(struct symbol *sym, FILE *file,
 				      struct annotate_args *args,
 				      int *line_nr)
 {
-	struct map *map = args->map;
+	struct map *map = args->ms.map;
 	struct annotation *notes = symbol__annotation(sym);
 	struct disasm_line *dl;
 	char *line = NULL, *parsed_line, *tmp, *tmp2;
@@ -1354,6 +1355,7 @@ static int symbol__parse_objdump_line(struct symbol *sym, FILE *file,
 	args->offset  = offset;
 	args->line    = parsed_line;
 	args->line_nr = *line_nr;
+	args->ms.sym  = sym;
 
 	dl = disasm_line__new(args);
 	free(line);
@@ -1506,7 +1508,7 @@ fallback:
 
 static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
-	struct map *map = args->map;
+	struct map *map = args->ms.map;
 	struct dso *dso = map->dso;
 	char *command;
 	FILE *file;
@@ -1705,7 +1707,6 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 {
 	struct annotate_args args = {
 		.privsize	= privsize,
-		.map		= map,
 		.evsel		= evsel,
 	};
 	struct perf_env *env = perf_evsel__env(evsel);
@@ -1731,6 +1732,9 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 		}
 	}
 
+	args.ms.map = map;
+	args.ms.sym = sym;
+
 	return symbol__disassemble(sym, &args);
 }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 365e9df888cf..c0bf0554a9ea 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -46,7 +46,7 @@ struct arch;
 
 struct ins_ops {
 	void (*free)(struct ins_operands *ops);
-	int (*parse)(struct arch *arch, struct ins_operands *ops, struct map *map);
+	int (*parse)(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms);
 	int (*scnprintf)(struct ins *ins, char *bf, size_t size,
 			 struct ins_operands *ops);
 };
