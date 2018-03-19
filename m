Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970835AbeCSTCa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969787AbeCSTCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:02:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD45217D6
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
Subject: [PATCH 11/14] perf annotate: Use ops->target.name when available for unresolved call targets
Date: Mon, 19 Mar 2018 16:01:33 -0300
Message-Id: <20180319190136.7441-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180319190136.7441-1-acme@kernel.org>
References: <20180319190136.7441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 
-- 
2.14.3
