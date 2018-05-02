Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeEBSEC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:04:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38031 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeEBSD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:03:57 -0400
Date: Wed, 2 May 2018 11:03:46 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-u6p9hbonlqzpl6o1z9xzxd75@git.kernel.org>
Cc: mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, adrian.hunter@intel.com,
        namhyung@kernel.org, hpa@zytor.com, wangnan0@huawei.com,
        dsahern@gmail.com
Reply-To: acme@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, wangnan0@huawei.com,
        dsahern@gmail.com, jolsa@kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: kallsyms__delta() needs the kmap, not
 the map
Git-Commit-ID: 019c6820d540d67608018238d91e57447ca7060f
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

Commit-ID:  019c6820d540d67608018238d91e57447ca7060f
Gitweb:     https://git.kernel.org/tip/019c6820d540d67608018238d91e57447ca7060f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 27 Apr 2018 15:47:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 27 Apr 2018 15:47:13 -0300

perf symbols: kallsyms__delta() needs the kmap, not the map

It was only using the map to obtain its kmap, so do the validation in
its called, __dso__load_kallsyms() and pass the kmap, that will be used
in the following patches in similar simplifications.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-u6p9hbonlqzpl6o1z9xzxd75@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 2517f2c2454f..76de63cecf98 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1267,14 +1267,10 @@ out_err:
  * If the kernel is relocated at boot time, kallsyms won't match.  Compute the
  * delta based on the relocation reference symbol.
  */
-static int kallsyms__delta(struct map *map, const char *filename, u64 *delta)
+static int kallsyms__delta(struct kmap *kmap, const char *filename, u64 *delta)
 {
-	struct kmap *kmap = map__kmap(map);
 	u64 addr;
 
-	if (!kmap)
-		return -1;
-
 	if (!kmap->ref_reloc_sym || !kmap->ref_reloc_sym->name)
 		return 0;
 
@@ -1288,15 +1284,19 @@ static int kallsyms__delta(struct map *map, const char *filename, u64 *delta)
 int __dso__load_kallsyms(struct dso *dso, const char *filename,
 			 struct map *map, bool no_kcore)
 {
+	struct kmap *kmap = map__kmap(map);
 	u64 delta = 0;
 
 	if (symbol__restricted_filename(filename, "/proc/kallsyms"))
 		return -1;
 
+	if (!kmap || !kmap->kmaps)
+		return -1;
+
 	if (dso__load_all_kallsyms(dso, filename) < 0)
 		return -1;
 
-	if (kallsyms__delta(map, filename, &delta))
+	if (kallsyms__delta(kmap, filename, &delta))
 		return -1;
 
 	symbols__fixup_end(&dso->symbols);
