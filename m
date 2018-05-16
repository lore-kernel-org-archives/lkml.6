Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeEPSCX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:02:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55389 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751110AbeEPSCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:02:21 -0400
Date: Wed, 16 May 2018 11:01:27 -0700
From: tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-d8ed87bc171946313b2e6d26e1fec494da9154bc@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        mingo@kernel.org, acme@redhat.com, namhyung@kernel.org,
        jolsa@redhat.com, hpa@zytor.com, ravi.bangoria@linux.ibm.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com,
        mhiramat@kernel.org, mingo@kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, hpa@zytor.com, ravi.bangoria@linux.ibm.com
In-Reply-To: <20180510043651.12189-1-ravi.bangoria@linux.ibm.com>
References: <20180510043651.12189-1-ravi.bangoria@linux.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf buildid-cache: Warn --purge-all failures
Git-Commit-ID: d8ed87bc171946313b2e6d26e1fec494da9154bc
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

Commit-ID:  d8ed87bc171946313b2e6d26e1fec494da9154bc
Gitweb:     https://git.kernel.org/tip/d8ed87bc171946313b2e6d26e1fec494da9154bc
Author:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate: Thu, 10 May 2018 10:06:51 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 15 May 2018 10:32:16 -0300

perf buildid-cache: Warn --purge-all failures

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
