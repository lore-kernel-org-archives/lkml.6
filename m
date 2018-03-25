Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeCYWZ7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:25:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41069 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeCYWZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:25:56 -0400
Date: Sun, 25 Mar 2018 15:25:46 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-3cwx39u3h66dfw9xjrlt7ca2@git.kernel.org>
Cc: hpa@zytor.com, adrian.hunter@intel.com, acme@redhat.com,
        jolsa@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, yao.jin@linux.intel.com, wangnan0@huawei.com,
        ak@linux.intel.com, dsahern@gmail.com, namhyung@kernel.org
Reply-To: acme@redhat.com, adrian.hunter@intel.com, hpa@zytor.com,
        jolsa@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        wangnan0@huawei.com, namhyung@kernel.org, dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Add "_local" to jump/offset
 validation routines
Git-Commit-ID: 2eff061162819e00ec6379874ceb47caef17bcba
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

Commit-ID:  2eff061162819e00ec6379874ceb47caef17bcba
Gitweb:     https://git.kernel.org/tip/2eff061162819e00ec6379874ceb47caef17bcba
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 23 Mar 2018 10:12:33 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 23 Mar 2018 16:46:16 -0300

perf annotate: Add "_local" to jump/offset validation routines

Because they all really check if we can access data structures/visual
constructs where a "jump" instruction targets code in the same function,
i.e. things like:

  __pthread_mutex_lock  /usr/lib64/libpthread-2.26.so
  1.95 │       mov    __pthread_force_elision,%ecx
       │    ┌──test   %ecx,%ecx
  0.07 │    ├──je     60
       │    │  test   $0x300,%esi
       │    │↓ jne    60
       │    │  or     $0x100,%esi
       │    │  mov    %esi,0x10(%rdi)
       │ 42:│  mov    %esi,%edx
       │    │  lea    0x16(%r8),%rsi
       │    │  mov    %r8,%rdi
       │    │  and    $0x80,%edx
       │    │  add    $0x8,%rsp
       │    │→ jmpq   __lll_lock_elision
       │    │  nop
  0.29 │ 60:└─→and    $0x80,%esi
  0.07 │       mov    $0x1,%edi
  0.29 │       xor    %eax,%eax
  2.53 │       lock   cmpxchg %edi,(%r8)

And not things like that "jmpq __lll_lock_elision", that instead should behave
like a "call" instruction and "jump" to the disassembly of "___lll_lock_elision".

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-3cwx39u3h66dfw9xjrlt7ca2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c |  2 +-
 tools/perf/util/annotate.c        |  9 ++++-----
 tools/perf/util/annotate.h        | 14 +++++++++++---
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 3834b264ba41..d77896a99570 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -155,7 +155,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	if (strstr(sym->name, "@plt"))
 		return;
 
-	if (!disasm_line__is_valid_jump(cursor, sym))
+	if (!disasm_line__is_valid_local_jump(cursor, sym))
 		return;
 
 	/*
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c299881c640a..9524f322f597 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1409,7 +1409,7 @@ static int symbol__parse_objdump_line(struct symbol *sym, FILE *file,
 	if (dl == NULL)
 		return -1;
 
-	if (!disasm_line__has_offset(dl)) {
+	if (!disasm_line__has_local_offset(dl)) {
 		dl->ops.target.offset = dl->ops.target.addr -
 					map__rip_2objdump(map, sym->start);
 		dl->ops.target.offset_avail = true;
@@ -2176,11 +2176,10 @@ size_t disasm__fprintf(struct list_head *head, FILE *fp)
 	return printed;
 }
 
-
-bool disasm_line__is_valid_jump(struct disasm_line *dl, struct symbol *sym)
+bool disasm_line__is_valid_local_jump(struct disasm_line *dl, struct symbol *sym)
 {
 	if (!dl || !dl->ins.ops || !ins__is_jump(&dl->ins) ||
-	    !disasm_line__has_offset(dl) || dl->ops.target.offset < 0 ||
+	    !disasm_line__has_local_offset(dl) || dl->ops.target.offset < 0 ||
 	    dl->ops.target.offset >= (s64)symbol__size(sym))
 		return false;
 
@@ -2201,7 +2200,7 @@ void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 
 		dl = disasm_line(al);
 
-		if (!disasm_line__is_valid_jump(dl, sym))
+		if (!disasm_line__is_valid_local_jump(dl, sym))
 			continue;
 
 		al = notes->offsets[dl->ops.target.offset];
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index ad8baafaf9f9..ff7e3df31efa 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -117,12 +117,20 @@ static inline struct disasm_line *disasm_line(struct annotation_line *al)
 	return al ? container_of(al, struct disasm_line, al) : NULL;
 }
 
-static inline bool disasm_line__has_offset(const struct disasm_line *dl)
+/*
+ * Is this offset in the same function as the line it is used?
+ * asm functions jump to other functions, for instance.
+ */
+static inline bool disasm_line__has_local_offset(const struct disasm_line *dl)
 {
-	return dl->ops.target.offset_avail;
+	return dl->ops.target.offset_avail && !dl->ops.target.outside;
 }
 
-bool disasm_line__is_valid_jump(struct disasm_line *dl, struct symbol *sym);
+/*
+ * Can we draw an arrow from the jump to its target, for instance? I.e.
+ * is the jump and its target in the same function?
+ */
+bool disasm_line__is_valid_local_jump(struct disasm_line *dl, struct symbol *sym);
 
 void disasm_line__free(struct disasm_line *dl);
 struct annotation_line *
