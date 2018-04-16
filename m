Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbeDPGsY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:48:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40755 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752496AbeDPGsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:48:23 -0400
Date: Sun, 15 Apr 2018 23:48:08 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ogppdtpzfax7y1h6gjdv5s6u@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, jolsa@kernel.org, acme@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mliska@suse.cz,
        adrian.hunter@intel.com, yao.jin@linux.intel.com, dsahern@gmail.com,
        wangnan0@huawei.com, namhyung@kernel.org,
        ravi.bangoria@linux.vnet.ibm.com, ak@linux.intel.com,
        tmricht@linux.vnet.ibm.com
Reply-To: namhyung@kernel.org, wangnan0@huawei.com, ak@linux.intel.com,
        ravi.bangoria@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
        mingo@kernel.org, hpa@zytor.com, jolsa@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mliska@suse.cz,
        yao.jin@linux.intel.com, adrian.hunter@intel.com, dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Fix switching to another perf.data
 file
Git-Commit-ID: 7b366142a50ad79e48de8e67c5b3e8cfb9fa82dd
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

Commit-ID:  7b366142a50ad79e48de8e67c5b3e8cfb9fa82dd
Gitweb:     https://git.kernel.org/tip/7b366142a50ad79e48de8e67c5b3e8cfb9fa82dd
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 12 Apr 2018 14:58:24 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 13 Apr 2018 10:00:04 -0300

perf report: Fix switching to another perf.data file

In the TUI the 's' hotkey can be used to switch to another perf.data
file in the current directory, but that got broken in Fixes:
b01141f4f59c ("perf annotate: Initialize the priv are in symbol__new()"),
that would show this once another file was chosen:

    ┌─Fatal Error─────────────────────────────────────┐
    │Annotation needs to be init before symbol__init()│
    │                                                 │
    │                                                 │
    │Press any key...                                 │
    └─────────────────────────────────────────────────┘

Fix it by just silently bailing out if symbol__annotation_init() was already
called, just like is done with symbol__init(), i.e. they are done just once at
session start, not when switching to a new perf.data file.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: b01141f4f59c ("perf annotate: Initialize the priv are in symbol__new()")
Link: https://lkml.kernel.org/n/tip-ogppdtpzfax7y1h6gjdv5s6u@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 62b2dd2253eb..1466814ebada 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2091,16 +2091,14 @@ static bool symbol__read_kptr_restrict(void)
 
 int symbol__annotation_init(void)
 {
+	if (symbol_conf.init_annotation)
+		return 0;
+
 	if (symbol_conf.initialized) {
 		pr_err("Annotation needs to be init before symbol__init()\n");
 		return -1;
 	}
 
-	if (symbol_conf.init_annotation) {
-		pr_warning("Annotation being initialized multiple times\n");
-		return 0;
-	}
-
 	symbol_conf.priv_size += sizeof(struct annotation);
 	symbol_conf.init_annotation = true;
 	return 0;
