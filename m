Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753489AbeCXUFN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752748AbeCXUFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:05:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7B92178B
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
Subject: [PATCH 41/44] perf annotate: Add "_local" to jump/offset validation routines
Date: Sat, 24 Mar 2018 17:02:08 -0300
Message-Id: <20180324200211.21326-42-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
