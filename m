Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754870AbeDMOCY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:02:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754858AbeDMOCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:02:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08333217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 15/17] perf report: Fix switching to another perf.data file
Date: Fri, 13 Apr 2018 11:01:09 -0300
Message-Id: <20180413140111.25313-16-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180413140111.25313-1-acme@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
