Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeEBRyP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:54:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50303 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeEBRyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:54:14 -0400
Date: Wed, 2 May 2018 10:53:55 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-9t3dqogher54owfl9o2mir52@git.kernel.org>
Cc: acme@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        wangnan0@huawei.com, namhyung@kernel.org, adrian.hunter@intel.com,
        dsahern@gmail.com, jolsa@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, acme@redhat.com, wangnan0@huawei.com,
        tglx@linutronix.de, namhyung@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@kernel.org,
        dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Use kallsyms__is_function()
Git-Commit-ID: e85e0e0ccc60e1bd82b33293088ce146f3eff632
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

Commit-ID:  e85e0e0ccc60e1bd82b33293088ce146f3eff632
Gitweb:     https://git.kernel.org/tip/e85e0e0ccc60e1bd82b33293088ce146f3eff632
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 25 Apr 2018 17:16:31 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:14 -0300

perf tools: Use kallsyms__is_function()

Replacing equivalent, the equivalent and longer variation:

	 symbol__is_a(type, MAP__FUNCTION);

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-9t3dqogher54owfl9o2mir52@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c   | 4 ++--
 tools/perf/util/event.c      | 2 +-
 tools/perf/util/symbol-elf.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index eaf1e10ae755..d056447520a2 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1679,7 +1679,7 @@ struct sym_args {
 static bool kern_sym_match(struct sym_args *args, const char *name, char type)
 {
 	/* A function with the same name, and global or the n'th found or any */
-	return symbol_type__is_a(type, MAP__FUNCTION) &&
+	return kallsyms__is_function(type) &&
 	       !strcmp(name, args->name) &&
 	       ((args->global && isupper(type)) ||
 		(args->selected && ++(args->cnt) == args->idx) ||
@@ -1784,7 +1784,7 @@ static int find_entire_kern_cb(void *arg, const char *name __maybe_unused,
 {
 	struct sym_args *args = arg;
 
-	if (!symbol_type__is_a(type, MAP__FUNCTION))
+	if (!kallsyms__is_function(type))
 		return 0;
 
 	if (!args->started) {
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index a8739cd0d8ca..241d3c827fae 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -868,7 +868,7 @@ static int find_symbol_cb(void *arg, const char *name, char type,
 	 * Must be a function or at least an alias, as in PARISC64, where "_text" is
 	 * an 'A' to the same address as "_stext".
 	 */
-	if (!(symbol_type__is_a(type, MAP__FUNCTION) ||
+	if (!(kallsyms__is_function(type) ||
 	      type == 'A') || strcmp(name, args->name))
 		return 0;
 
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 75f578f3ed8e..b6be6062cae0 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1413,7 +1413,7 @@ static int kcore_copy__process_kallsyms(void *arg, const char *name, char type,
 {
 	struct kcore_copy_info *kci = arg;
 
-	if (!symbol_type__is_a(type, MAP__FUNCTION))
+	if (!kallsyms__is_function(type))
 		return 0;
 
 	if (strchr(name, '[')) {
