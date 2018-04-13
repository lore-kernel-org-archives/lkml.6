Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754675AbeDMOBo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753859AbeDMOBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:01:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA42B21795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 04/17] perf annotate: Allow showing offsets in more than just jump targets
Date: Fri, 13 Apr 2018 11:00:58 -0300
Message-Id: <20180413140111.25313-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180413140111.25313-1-acme@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Jesper wanted to see offsets at callq sites when doing some performance
investigation related to retpolines, so save him some time by providing
an 'struct annotation_options' to control where offsets should appear:
just on jump targets? That + call instructions? All?

This puts in place the logic to show the offsets, now we need to wire
this up in the TUI browser (next patch) and on the 'perf annotate --stdio2"
interface, where we need a more general mechanism to setup the
'annotation_options' struct from the command line.

Suggested-by: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-m3jc9c3swobye9tj08gnh5i7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 11 +++++++++--
 tools/perf/util/annotate.h |  9 +++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index fbad8dfbb186..5edc565d86c4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -46,6 +46,7 @@
 struct annotation_options annotation__default_options = {
 	.use_offset     = true,
 	.jump_arrows    = true,
+	.offset_level	= ANNOTATION__OFFSET_JUMP_TARGETS,
 };
 
 const char 	*disassembler_style;
@@ -2512,7 +2513,8 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		if (!notes->options->use_offset) {
 			printed = scnprintf(bf, sizeof(bf), "%" PRIx64 ": ", addr);
 		} else {
-			if (al->jump_sources) {
+			if (al->jump_sources &&
+			    notes->options->offset_level >= ANNOTATION__OFFSET_JUMP_TARGETS) {
 				if (notes->options->show_nr_jumps) {
 					int prev;
 					printed = scnprintf(bf, sizeof(bf), "%*d ",
@@ -2523,9 +2525,14 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 					obj__printf(obj, bf);
 					obj__set_color(obj, prev);
 				}
-
+print_addr:
 				printed = scnprintf(bf, sizeof(bf), "%*" PRIx64 ": ",
 						    notes->widths.target, addr);
+			} else if (ins__is_call(&disasm_line(al)->ins) &&
+				   notes->options->offset_level >= ANNOTATION__OFFSET_CALL) {
+				goto print_addr;
+			} else if (notes->options->offset_level == ANNOTATION__MAX_OFFSET_LEVEL) {
+				goto print_addr;
 			} else {
 				printed = scnprintf(bf, sizeof(bf), "%-*s  ",
 						    notes->widths.addr, " ");
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index db8d09bea07e..f28a9e43421d 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -70,8 +70,17 @@ struct annotation_options {
 	     show_nr_jumps,
 	     show_nr_samples,
 	     show_total_period;
+	u8   offset_level;
 };
 
+enum {
+	ANNOTATION__OFFSET_JUMP_TARGETS = 1,
+	ANNOTATION__OFFSET_CALL,
+	ANNOTATION__MAX_OFFSET_LEVEL,
+};
+
+#define ANNOTATION__MIN_OFFSET_LEVEL ANNOTATION__OFFSET_JUMP_TARGETS
+
 extern struct annotation_options annotation__default_options;
 
 struct annotation;
-- 
2.14.3
