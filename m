Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeDPGoS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:44:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40409 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbeDPGoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:44:16 -0400
Date: Sun, 15 Apr 2018 23:42:35 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-m3jc9c3swobye9tj08gnh5i7@git.kernel.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        yao.jin@linux.intel.com, ak@linux.intel.com, namhyung@kernel.org,
        ravi.bangoria@linux.vnet.ibm.com, daniel@iogearbox.net,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, tglx@linutronix.de,
        jolsa@kernel.org, brouer@redhat.com, mliska@suse.cz,
        wangnan0@huawei.com, tmricht@linux.vnet.ibm.com, acme@redhat.com,
        adrian.hunter@intel.com, alexei.starovoitov@gmail.com
Reply-To: acme@redhat.com, adrian.hunter@intel.com,
        alexei.starovoitov@gmail.com, wangnan0@huawei.com,
        tmricht@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, brouer@redhat.com, jolsa@kernel.org,
        tglx@linutronix.de, mliska@suse.cz, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, ravi.bangoria@linux.vnet.ibm.com,
        namhyung@kernel.org, daniel@iogearbox.net
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Allow showing offsets in more than
 just jump targets
Git-Commit-ID: 592c10e217f3edb35c7e0deba161fef69ad1a336
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

Commit-ID:  592c10e217f3edb35c7e0deba161fef69ad1a336
Gitweb:     https://git.kernel.org/tip/592c10e217f3edb35c7e0deba161fef69ad1a336
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 11 Apr 2018 10:30:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 12 Apr 2018 10:32:39 -0300

perf annotate: Allow showing offsets in more than just jump targets

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
