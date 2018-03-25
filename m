Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeCYW0Z (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:26:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36903 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeCYW0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:26:08 -0400
Date: Sun, 25 Mar 2018 15:24:53 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-aiys0a0bsgm3e00hbi6fg7yy@git.kernel.org>
Cc: mingo@kernel.org, dsahern@gmail.com, acme@redhat.com,
        yao.jin@linux.intel.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, hpa@zytor.com,
        wangnan0@huawei.com, namhyung@kernel.org, ak@linux.intel.com,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, namhyung@kernel.org, ak@linux.intel.com,
        wangnan0@huawei.com, hpa@zytor.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        yao.jin@linux.intel.com, acme@redhat.com, dsahern@gmail.com,
        mingo@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Mark jumps to outher functions with
 the call arrow
Git-Commit-ID: 751b1783da784299b0509adb6a9cd3024cc4f837
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

Commit-ID:  751b1783da784299b0509adb6a9cd3024cc4f837
Gitweb:     https://git.kernel.org/tip/751b1783da784299b0509adb6a9cd3024cc4f837
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 20 Mar 2018 17:20:43 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Mar 2018 16:19:55 -0300

perf annotate: Mark jumps to outher functions with the call arrow

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
