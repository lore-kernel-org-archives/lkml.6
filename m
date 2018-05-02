Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeEBRnx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:43:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55377 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeEBRnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:43:51 -0400
Date: Wed, 2 May 2018 10:43:40 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-q90olng8sfkvrnsrwu7xnul6@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        dsahern@gmail.com, jolsa@kernel.org, adrian.hunter@intel.com,
        acme@redhat.com, mingo@kernel.org, namhyung@kernel.org,
        wangnan0@huawei.com
Reply-To: hpa@zytor.com, dsahern@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, wangnan0@huawei.com,
        jolsa@kernel.org, adrian.hunter@intel.com, mingo@kernel.org,
        acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Use __map__is_kernel() instead of
 ad-hoc equivalent code
Git-Commit-ID: efdd5c6b81185223e07452a2f8b5467f81b13d96
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

Commit-ID:  efdd5c6b81185223e07452a2f8b5467f81b13d96
Gitweb:     https://git.kernel.org/tip/efdd5c6b81185223e07452a2f8b5467f81b13d96
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 23 Apr 2018 16:43:47 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:00 -0300

perf symbols: Use __map__is_kernel() instead of ad-hoc equivalent code

Shorter, should be equivalent code, use it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-q90olng8sfkvrnsrwu7xnul6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1466814ebada..2b6292cff719 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1163,7 +1163,6 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 			   const char *kallsyms_filename)
 {
 	struct map_groups *kmaps = map__kmaps(map);
-	struct machine *machine;
 	struct kcore_mapfn_data md;
 	struct map *old_map, *new_map, *replacement_map = NULL;
 	bool is_64_bit;
@@ -1174,10 +1173,8 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	if (!kmaps)
 		return -EINVAL;
 
-	machine = kmaps->machine;
-
 	/* This function requires that the map is the kernel map */
-	if (map != machine->vmlinux_maps[map->type])
+	if (!__map__is_kernel(map))
 		return -EINVAL;
 
 	if (!filename_from_kallsyms_filename(kcore_filename, "kcore",
