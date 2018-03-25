Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeCYW0v (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:26:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51757 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbeCYW0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:26:49 -0400
Date: Sun, 25 Mar 2018 15:26:40 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-j0t5hagnphoz9xw07bh3ha3g@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, ak@linux.intel.com, hpa@zytor.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        yao.jin@linux.intel.com, wangnan0@huawei.com, mingo@kernel.org,
        dsahern@gmail.com, acme@redhat.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, ak@linux.intel.com, hpa@zytor.com,
        jolsa@kernel.org, namhyung@kernel.org, yao.jin@linux.intel.com,
        adrian.hunter@intel.com, wangnan0@huawei.com, dsahern@gmail.com,
        mingo@kernel.org, acme@redhat.com, tglx@linutronix.de
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Defer searching for comma in raw
 line till it is needed
Git-Commit-ID: c448234cfe46ec5abc0014dca8b3b49989bffe9e
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

Commit-ID:  c448234cfe46ec5abc0014dca8b3b49989bffe9e
Gitweb:     https://git.kernel.org/tip/c448234cfe46ec5abc0014dca8b3b49989bffe9e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 23 Mar 2018 10:57:08 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 23 Mar 2018 16:46:19 -0300

perf annotate: Defer searching for comma in raw line till it is needed

That strchr() in jump__scnprintf() needs to be nuked somehow, as it,
IIRC is already done in jump__parse() and if needed at scnprintf() time,
should be stashed in the struct filled in parse() time.

For now jus defer it to just before where it is used.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-j0t5hagnphoz9xw07bh3ha3g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 5fa270b24eea..f730e0cf8a26 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -350,7 +350,7 @@ static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *op
 static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops)
 {
-	const char *c = strchr(ops->raw, ',');
+	const char *c;
 
 	if (!ops->target.addr || ops->target.offset < 0)
 		return ins__raw_scnprintf(ins, bf, size, ops);
@@ -358,6 +358,7 @@ static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 	if (ops->target.outside && ops->target.sym != NULL)
 		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.sym->name);
 
+	c = strchr(ops->raw, ',');
 	if (c != NULL) {
 		const char *c2 = strchr(c + 1, ',');
 
