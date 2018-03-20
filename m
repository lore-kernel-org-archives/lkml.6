Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbeCTGiJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:38:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57903 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbeCTGiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:38:06 -0400
Date: Mon, 19 Mar 2018 23:35:49 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-nkktz6355rhqtq7o8atr8f8r@git.kernel.org>
Cc: dsahern@gmail.com, jolsa@kernel.org, mingo@kernel.org, acme@redhat.com,
        wangnan0@huawei.com, adrian.hunter@intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, ak@linux.intel.com,
        yao.jin@linux.intel.com, hpa@zytor.com
Reply-To: wangnan0@huawei.com, adrian.hunter@intel.com, namhyung@kernel.org,
        mingo@kernel.org, dsahern@gmail.com, jolsa@kernel.org, acme@redhat.com,
        hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        yao.jin@linux.intel.com, ak@linux.intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Use ops->target.name when available
 for unresolved call targets
Git-Commit-ID: 4c9cb2c2b4b5530717f74b2252f8cc4c45b2a918
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

Commit-ID:  4c9cb2c2b4b5530717f74b2252f8cc4c45b2a918
Gitweb:     https://git.kernel.org/tip/4c9cb2c2b4b5530717f74b2252f8cc4c45b2a918
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 16 Mar 2018 13:28:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Mar 2018 13:51:52 -0300

perf annotate: Use ops->target.name when available for unresolved call targets

There is a bug where when using 'perf annotate timerqueue_add' the
target for its only routine called with the 'callq' instruction,
'rb_insert_color', doesn't get resolved from its address when parsing
that 'callq' instruction.

That symbol resolution works when using 'perf report --tui' and then
doing annotation for 'timerqueue_add' from there, the vmlinux
dso->symbols rb_tree somehow gets in a state that we can't find that
address, that is a bug that has to be further investigated.

But since the objdump output has the function name, i.e. the raw objdump
disassembled line looks like:

So, before:

  # perf annotate timerqueue_add

              │      mov    %rbx,%rdi
              │      mov    %rbx,(%rdx)
              │    → callq  *ffffffff8184dc80
              │      mov    0x8(%rbp),%rdx
              │      test   %rdx,%rdx
              │    ↓ je     67

  # perf report

              │      mov    %rbx,%rdi
              │      mov    %rbx,(%rdx)
              │    → callq  rb_insert_color
              │      mov    0x8(%rbp),%rdx
              │      test   %rdx,%rdx
              │    ↓ je     67

And after both look the same:

  # perf annotate timerqueue_add

              │      mov    %rbx,%rdi
              │      mov    %rbx,(%rdx)
              │    → callq  rb_insert_color
              │      mov    0x8(%rbp),%rdx
              │      test   %rdx,%rdx
              │    ↓ je     67

>From 'perf report' one can annotate and navigate to that 'rb_insert_color'
function, but not directly from 'perf annotate timerqueue_add', that
remains to be investigated and fixed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-nkktz6355rhqtq7o8atr8f8r@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ddad87f34a68..535357c6ce02 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -238,6 +238,9 @@ static int call__scnprintf(struct ins *ins, char *bf, size_t size,
 	if (ops->target.addr == 0)
 		return ins__raw_scnprintf(ins, bf, size, ops);
 
+	if (ops->target.name)
+		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.name);
+
 	return scnprintf(bf, size, "%-6s *%" PRIx64, ins->name, ops->target.addr);
 }
 
