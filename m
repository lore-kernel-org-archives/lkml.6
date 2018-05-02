Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeEBRnj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:43:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40171 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeEBRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:43:36 -0400
Date: Wed, 2 May 2018 10:43:11 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-rn8pexelsxpx92ce3elu3wiw@git.kernel.org>
Cc: dsahern@gmail.com, jolsa@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        namhyung@kernel.org
Reply-To: adrian.hunter@intel.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        acme@redhat.com, wangnan0@huawei.com, namhyung@kernel.org,
        dsahern@gmail.com, jolsa@kernel.org, tglx@linutronix.de,
        mingo@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Use __map__is_kernel()
Git-Commit-ID: 68766bfa56476ee07217fc7f24a1d93f43125036
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

Commit-ID:  68766bfa56476ee07217fc7f24a1d93f43125036
Gitweb:     https://git.kernel.org/tip/68766bfa56476ee07217fc7f24a1d93f43125036
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 23 Apr 2018 16:40:02 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 09:30:27 -0300

perf top: Use __map__is_kernel()

Shorter form to figure out if a given map is the kernel one and also
reduces the number of code accessing MAP__{FUNCTION,VARIABLE}, that
should go away at some point.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-rn8pexelsxpx92ce3elu3wiw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f39bd60d2708..4e975f3ee3be 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -750,7 +750,7 @@ static void perf_event__process_sample(struct perf_tool *tool,
 		machine->kptr_restrict_warned = true;
 	}
 
-	if (al.sym == NULL) {
+	if (al.sym == NULL && al.map != NULL) {
 		const char *msg = "Kernel samples will not be resolved.\n";
 		/*
 		 * As we do lazy loading of symtabs we only will know if the
@@ -764,7 +764,7 @@ static void perf_event__process_sample(struct perf_tool *tool,
 		 * invalid --vmlinux ;-)
 		 */
 		if (!machine->kptr_restrict_warned && !top->vmlinux_warned &&
-		    al.map == machine->vmlinux_maps[MAP__FUNCTION] &&
+		    __map__is_kernel(al.map) &&
 		    RB_EMPTY_ROOT(&al.map->dso->symbols[MAP__FUNCTION])) {
 			if (symbol_conf.vmlinux_name) {
 				char serr[256];
