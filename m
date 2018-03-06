Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750944AbeCFGnS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:43:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53607 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbeCFGnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:43:17 -0500
Date: Mon, 5 Mar 2018 22:43:02 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-5tzvb875ep2sel03aeefgmud@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, kan.liang@intel.com, wangnan0@huawei.com,
        acme@redhat.com, yao.jin@intel.com, adrian.hunter@intel.com,
        tglx@linutronix.de, dsahern@gmail.com, hpa@zytor.com, jolsa@kernel.org,
        torvalds@linux-foundation.org, namhyung@kernel.org, mingo@kernel.org
Reply-To: mingo@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        torvalds@linux-foundation.org, dsahern@gmail.com, hpa@zytor.com,
        yao.jin@intel.com, tglx@linutronix.de, adrian.hunter@intel.com,
        wangnan0@huawei.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        kan.liang@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate browser: Be more robust when drawing
 jump arrows
Git-Commit-ID: 9c04409d7f5c325233961673356ea8aced6a4ef3
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

Commit-ID:  9c04409d7f5c325233961673356ea8aced6a4ef3
Gitweb:     https://git.kernel.org/tip/9c04409d7f5c325233961673356ea8aced6a4ef3
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 1 Mar 2018 11:33:59 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 09:57:57 -0300

perf annotate browser: Be more robust when drawing jump arrows

This first happened with a gcc function, _cpp_lex_token, that has the
usual jumps:

 │1159e6c: ↓ jne    115aa32 <_cpp_lex_token@@Base+0xf92>

I.e. jumps to a label inside that function (_cpp_lex_token), and those
works, but also this kind:

 │1159e8b: ↓ jne    c469be <cpp_named_operator2name@@Base+0xa72>

I.e. jumps to another function, outside _cpp_lex_token, which are not
being correctly handled generating as a side effect references to
ab->offset[] entries that are set to NULL, so to make this code more
robust, check that here.

A proper fix for will be put in place, looking at the function name
right after the '<' token and probably treating this like a 'call'
instruction.

For now just don't draw the arrow.

Reported-by: Ingo Molnar <mingo@kernel.org>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Link: https://lkml.kernel.org/n/tip-5tzvb875ep2sel03aeefgmud@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index e2f666391ac4..6ff6839558b0 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -328,7 +328,32 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	if (!disasm_line__is_valid_jump(cursor, sym))
 		return;
 
+	/*
+	 * This first was seen with a gcc function, _cpp_lex_token, that
+	 * has the usual jumps:
+	 *
+	 *  │1159e6c: ↓ jne    115aa32 <_cpp_lex_token@@Base+0xf92>
+	 *
+	 * I.e. jumps to a label inside that function (_cpp_lex_token), and
+	 * those works, but also this kind:
+	 *
+	 *  │1159e8b: ↓ jne    c469be <cpp_named_operator2name@@Base+0xa72>
+	 *
+	 *  I.e. jumps to another function, outside _cpp_lex_token, which
+	 *  are not being correctly handled generating as a side effect references
+	 *  to ab->offset[] entries that are set to NULL, so to make this code
+	 *  more robust, check that here.
+	 *
+	 *  A proper fix for will be put in place, looking at the function
+	 *  name right after the '<' token and probably treating this like a
+	 *  'call' instruction.
+	 */
 	target = ab->offsets[cursor->ops.target.offset];
+	if (target == NULL) {
+		ui_helpline__printf("WARN: jump target inconsistency, press 'o', ab->offsets[%#x] = NULL\n",
+				    cursor->ops.target.offset);
+		return;
+	}
 
 	bcursor = browser_line(&cursor->al);
 	btarget = browser_line(target);
