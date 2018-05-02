Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeEBRqq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:46:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38163 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeEBRqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:46:44 -0400
Date: Wed, 2 May 2018 10:46:33 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-03nx3aod955yqnf9l06im28j@git.kernel.org>
Cc: acme@redhat.com, jolsa@kernel.org, eranian@google.com,
        tglx@linutronix.de, wangnan0@huawei.com, mingo@kernel.org,
        hpa@zytor.com, adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, dsahern@gmail.com
Reply-To: dsahern@gmail.com, adrian.hunter@intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com, hpa@zytor.com,
        mingo@kernel.org, acme@redhat.com, jolsa@kernel.org,
        eranian@google.com, tglx@linutronix.de
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script: Use thread__find_symbol() instead of
 ad-hoc equivalent
Git-Commit-ID: cc5f02f2be8d3354986bad5703ee8a983872f140
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

Commit-ID:  cc5f02f2be8d3354986bad5703ee8a983872f140
Gitweb:     https://git.kernel.org/tip/cc5f02f2be8d3354986bad5703ee8a983872f140
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 24 Apr 2018 11:32:30 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:08 -0300

perf script: Use thread__find_symbol() instead of ad-hoc equivalent

In dc323ce8e72d ("perf script: Enable printing of branch stack") it
first tries to find the map for an address, then the symbol in the DSO
backing that map, for that address, well, this is what
thread__find_symbol() does, so just use it and make the code shorter.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-03nx3aod955yqnf9l06im28j@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 5ec1c73bbfaf..ffd02faee87b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -764,13 +764,8 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 		from = br->entries[i].from;
 		to   = br->entries[i].to;
 
-		thread__find_map(thread, sample->cpumode, from, &alf);
-		if (alf.map)
-			alf.sym = map__find_symbol(alf.map, alf.addr);
-
-		thread__find_map(thread, sample->cpumode, to, &alt);
-		if (alt.map)
-			alt.sym = map__find_symbol(alt.map, alt.addr);
+		thread__find_symbol(thread, sample->cpumode, from, &alf);
+		thread__find_symbol(thread, sample->cpumode, to, &alt);
 
 		printed += symbol__fprintf_symname_offs(alf.sym, &alf, fp);
 		if (PRINT_FIELD(DSO)) {
