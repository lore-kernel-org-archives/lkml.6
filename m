Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeCIIiR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:38:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40747 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeCIIiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:38:16 -0500
Date: Fri, 9 Mar 2018 00:38:10 -0800
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-4b5ea3bd674f707180b0e8c4f514d30e49f293b3@git.kernel.org>
Cc: adrian.hunter@intel.com, acme@redhat.com, jolsa@redhat.com,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, mingo@kernel.org, jolsa@redhat.com,
        tglx@linutronix.de, adrian.hunter@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <1520327598-1317-2-git-send-email-adrian.hunter@intel.com>
References: <1520327598-1317-2-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Combine some auxtrace initialization
 into a single function
Git-Commit-ID: 4b5ea3bd674f707180b0e8c4f514d30e49f293b3
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

Commit-ID:  4b5ea3bd674f707180b0e8c4f514d30e49f293b3
Gitweb:     https://git.kernel.org/tip/4b5ea3bd674f707180b0e8c4f514d30e49f293b3
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Mar 2018 11:13:12 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 7 Mar 2018 10:22:26 -0300

perf record: Combine some auxtrace initialization into a single function

In preparation for adding AUX area sampling support, combine some
auxtrace initialization into a single function.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520327598-1317-2-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 12230ddb6506..14d82f0fe5cc 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -274,6 +274,24 @@ static void record__read_auxtrace_snapshot(struct record *rec)
 	}
 }
 
+static int record__auxtrace_init(struct record *rec)
+{
+	int err;
+
+	if (!rec->itr) {
+		rec->itr = auxtrace_record__init(rec->evlist, &err);
+		if (err)
+			return err;
+	}
+
+	err = auxtrace_parse_snapshot_options(rec->itr, &rec->opts,
+					      rec->opts.auxtrace_snapshot_opts);
+	if (err)
+		return err;
+
+	return auxtrace_parse_filters(rec->evlist);
+}
+
 #else
 
 static inline
@@ -294,6 +312,11 @@ int auxtrace_record__snapshot_start(struct auxtrace_record *itr __maybe_unused)
 	return 0;
 }
 
+static int record__auxtrace_init(struct record *rec __maybe_unused)
+{
+	return 0;
+}
+
 #endif
 
 static int record__mmap_evlist(struct record *rec,
@@ -1727,17 +1750,6 @@ int cmd_record(int argc, const char **argv)
 		alarm(rec->switch_output.time);
 	}
 
-	if (!rec->itr) {
-		rec->itr = auxtrace_record__init(rec->evlist, &err);
-		if (err)
-			goto out;
-	}
-
-	err = auxtrace_parse_snapshot_options(rec->itr, &rec->opts,
-					      rec->opts.auxtrace_snapshot_opts);
-	if (err)
-		goto out;
-
 	/*
 	 * Allow aliases to facilitate the lookup of symbols for address
 	 * filters. Refer to auxtrace_parse_filters().
@@ -1746,7 +1758,7 @@ int cmd_record(int argc, const char **argv)
 
 	symbol__init(NULL);
 
-	err = auxtrace_parse_filters(rec->evlist);
+	err = record__auxtrace_init(rec);
 	if (err)
 		goto out;
 
