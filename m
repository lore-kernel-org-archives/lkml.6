Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751621AbeEBSBG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:01:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46687 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbeEBSBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:01:00 -0400
Date: Wed, 2 May 2018 11:00:51 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-mrjjc87a4tpf896j5u4sql4e@git.kernel.org>
Cc: tglx@linutronix.de, dsahern@gmail.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        namhyung@kernel.org, hpa@zytor.com, wangnan0@huawei.com,
        jolsa@kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        acme@redhat.com, hpa@zytor.com, wangnan0@huawei.com, jolsa@kernel.org,
        tglx@linutronix.de, dsahern@gmail.com, adrian.hunter@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf map: Use map->prot in place of
 type==MAP__FUNCTION
Git-Commit-ID: d183b2614fcd6d0a10c792891fd09bb254594ad4
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

Commit-ID:  d183b2614fcd6d0a10c792891fd09bb254594ad4
Gitweb:     https://git.kernel.org/tip/d183b2614fcd6d0a10c792891fd09bb254594ad4
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 26 Apr 2018 16:08:38 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 16:08:38 -0300

perf map: Use map->prot in place of type==MAP__FUNCTION

Equivalent, one step more in ditching enum map_type.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-mrjjc87a4tpf896j5u4sql4e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index ab12f2bc7669..a164e1ed5462 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -173,7 +173,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		map->flags = flags;
 		nsi = nsinfo__get(thread->nsinfo);
 
-		if ((anon || no_dso) && nsi && type == MAP__FUNCTION) {
+		if ((anon || no_dso) && nsi && (prot & PROT_EXEC)) {
 			snprintf(newfilename, sizeof(newfilename),
 				 "/tmp/perf-%d.map", nsi->pid);
 			filename = newfilename;
@@ -213,7 +213,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			 * functions still return NULL, and we avoid the
 			 * unnecessary map__load warning.
 			 */
-			if (type != MAP__FUNCTION)
+			if (!(prot & PROT_EXEC))
 				dso__set_loaded(dso, map->type);
 		}
 		dso->nsinfo = nsi;
