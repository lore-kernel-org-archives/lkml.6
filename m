Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934143AbeCGP55 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:57:57 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933897AbeCGPu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:50:28 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 02/19] perf report: Display perf.data header info
Date: Wed,  7 Mar 2018 16:50:03 +0100
Message-Id: <20180307155020.32613-3-jolsa@kernel.org>
In-Reply-To: <20180307155020.32613-1-jolsa@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display more header info from perf.data file,
following values:

  $ perf report -i perf.data --header-only
  ...
  # header version : 1
  # data offset    : 424
  # data size      : 3364280
  # feat offset    : 3364704

It's handy for debuging.

Link: http://lkml.kernel.org/n/tip-bdfzdy1xv8ocs6ukk31sgxsw@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
-- 
2.13.6
