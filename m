Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbeCXUFH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752748AbeCXUFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:05:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E176A2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 39/44] perf annotate: Mark jumps to outher functions with the call arrow
Date: Sat, 24 Mar 2018 17:02:06 -0300
Message-Id: <20180324200211.21326-40-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Things like this in _cpp_lex_token (gcc's cc1 program):

     cpp_named_operator2name@@Base+0xa72

Point to a place that is after the cpp_named_operator2name boundaries,
i.e.  in the ELF symbol table for cc1 cpp_named_operator2name is marked
as being 32-bytes long, but it in fact is much larger than that, so we
seem to need a symbols__find() routine that looks for >= current->start
and  < next_symbol->start, possibly just for C++ objects?

For now lets just make some progress by marking jumps to outside the
current function as call like.

Actual navigation will come next, with further understanding of how the
symbol searching and disassembly should be done.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-aiys0a0bsgm3e00hbi6fg7yy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 55 +++++++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/annotate.h |  1 +
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3ff829d89178..c299881c640a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -273,11 +273,27 @@ bool ins__is_call(const struct ins *ins)
 	return ins->ops == &call_ops || ins->ops == &s390_call_ops;
 }
 
-static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map_symbol *ms __maybe_unused)
+static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map_symbol *ms)
 {
+	struct map *map = ms->map;
+	struct symbol *sym = ms->sym;
+	struct addr_map_symbol target = {
+		.map = map,
+	};
 	const char *s = strchr(ops->raw, '+');
 	const char *c = strchr(ops->raw, ',');
-
+	u64 start, end;
+	/*
+	 * Examples of lines to parse for the _cpp_lex_token@@Base
+	 * function:
+	 *
+	 * 1159e6c: jne    115aa32 <_cpp_lex_token@@Base+0xf92>
+	 * 1159e8b: jne    c469be <cpp_named_operator2name@@Base+0xa72>
+	 *
+	 * The first is a jump to an offset inside the same function,
+	 * the second is to another function, i.e. that 0xa72 is an
+	 * offset in the cpp_named_operator2name@@base function.
+	 */
 	/*
 	 * skip over possible up to 2 operands to get to address, e.g.:
 	 * tbnz	 w0, #26, ffff0000083cd190 <security_file_permission+0xd0>
@@ -293,6 +309,35 @@ static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *op
 		ops->target.addr = strtoull(ops->raw, NULL, 16);
 	}
 
+	target.addr = map__objdump_2mem(map, ops->target.addr);
+	start = map->unmap_ip(map, sym->start),
+	end = map->unmap_ip(map, sym->end);
+
+	ops->target.outside = target.addr < start || target.addr > end;
+
+	/*
+	 * FIXME: things like this in _cpp_lex_token (gcc's cc1 program):
+
+		cpp_named_operator2name@@Base+0xa72
+
+	 * Point to a place that is after the cpp_named_operator2name
+	 * boundaries, i.e.  in the ELF symbol table for cc1
+	 * cpp_named_operator2name is marked as being 32-bytes long, but it in
+	 * fact is much larger than that, so we seem to need a symbols__find()
+	 * routine that looks for >= current->start and  < next_symbol->start,
+	 * possibly just for C++ objects?
+	 *
+	 * For now lets just make some progress by marking jumps to outside the
+	 * current function as call like.
+	 *
+	 * Actual navigation will come next, with further understanding of how
+	 * the symbol searching and disassembly should be done.
+
+	if (map_groups__find_ams(&target) == 0 &&
+	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
+		ops->target.sym = target.sym;
+	 */
+
 	if (s++ != NULL) {
 		ops->target.offset = strtoull(s, NULL, 16);
 		ops->target.offset_avail = true;
@@ -2355,11 +2400,15 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 {
 	if (dl->ins.ops && dl->ins.ops->scnprintf) {
 		if (ins__is_jump(&dl->ins)) {
-			bool fwd = dl->ops.target.offset > dl->al.offset;
+			bool fwd;
 
+			if (dl->ops.target.outside)
+				goto call_like;
+			fwd = dl->ops.target.offset > dl->al.offset;
 			obj__write_graph(obj, fwd ? DARROW_CHAR : UARROW_CHAR);
 			obj__printf(obj, " ");
 		} else if (ins__is_call(&dl->ins)) {
+call_like:
 			obj__write_graph(obj, RARROW_CHAR);
 			obj__printf(obj, " ");
 		} else if (ins__is_ret(&dl->ins)) {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index c0bf0554a9ea..ad8baafaf9f9 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -28,6 +28,7 @@ struct ins_operands {
 		u64	addr;
 		s64	offset;
 		bool	offset_avail;
+		bool	outside;
 	} target;
 	union {
 		struct {
-- 
2.14.3
