Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752332AbeEPOwH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751307AbeEPOt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:49:29 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/11] perf buildid-cache: Warn --purge-all failures
Date: Wed, 16 May 2018 11:48:59 -0300
Message-Id: <20180516144908.22212-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180516144908.22212-1-acme@kernel.org>
References: <20180516144908.22212-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Warn perf buildid-cache --purge-all failures in non verbose mode.

Ex.:

  $ sudo chown root:root /home/ravi/.debug -R
  $ sudo chmod 700 /home/ravi/.debug/ -R
  $ ./perf buildid-cache -P
    Couldn't remove some caches. Error: Permission denied.

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20180510043651.12189-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-buildid-cache.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 7a7403913b57..115110a4796a 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -488,8 +488,12 @@ int cmd_buildid_cache(int argc, const char **argv)
 		}
 	}
 
-	if (purge_all)
-		ret = build_id_cache__purge_all();
+	if (purge_all) {
+		if (build_id_cache__purge_all()) {
+			pr_warning("Couldn't remove some caches. Error: %s.\n",
+				str_error_r(errno, sbuf, sizeof(sbuf)));
+		}
+	}
 
 	if (missing_filename)
 		ret = build_id_cache__fprintf_missing(session, stdout);
-- 
2.14.3
