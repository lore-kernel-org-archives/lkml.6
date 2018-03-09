Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeCIIwr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:52:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52257 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeCIIwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:52:46 -0500
Date: Fri, 9 Mar 2018 00:52:26 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-e971a5a8399a5e84164239a5c2d59b8a51314241@git.kernel.org>
Cc: jolsa@kernel.org, linux-kernel@vger.kernel.org, dsahern@gmail.com,
        peterz@infradead.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
        acme@redhat.com, tglx@linutronix.de
Reply-To: dsahern@gmail.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        mingo@kernel.org, alexander.shishkin@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, namhyung@kernel.org, acme@redhat.com,
        tglx@linutronix.de
In-Reply-To: <20180307155020.32613-3-jolsa@kernel.org>
References: <20180307155020.32613-3-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Display perf.data header info
Git-Commit-ID: e971a5a8399a5e84164239a5c2d59b8a51314241
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

Commit-ID:  e971a5a8399a5e84164239a5c2d59b8a51314241
Gitweb:     https://git.kernel.org/tip/e971a5a8399a5e84164239a5c2d59b8a51314241
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 7 Mar 2018 16:50:03 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 11:30:41 -0300

perf report: Display perf.data header info

Display more header info from perf.data file, following values:

  $ perf report -i perf.data --header-only
  ...
  # header version : 1
  # data offset    : 424
  # data size      : 3364280
  # feat offset    : 3364704

It's handy for debuging.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307155020.32613-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a326e0d8b5b6..e0c3cad0fd8d 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2318,7 +2318,12 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 	if (ret == -1)
 		return -1;
 
-	fprintf(fp, "# captured on: %s", ctime(&st.st_ctime));
+	fprintf(fp, "# captured on    : %s", ctime(&st.st_ctime));
+
+	fprintf(fp, "# header version : %u\n", header->version);
+	fprintf(fp, "# data offset    : %" PRIu64 "\n", header->data_offset);
+	fprintf(fp, "# data size      : %" PRIu64 "\n", header->data_size);
+	fprintf(fp, "# feat offset    : %" PRIu64 "\n", header->feat_offset);
 
 	perf_header__process_sections(header, fd, &hd,
 				      perf_file_section__fprintf_info);
