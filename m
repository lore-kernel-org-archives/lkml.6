Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeCHUHr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:07:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751058AbeCHTuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:50:50 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD67F2177C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 03/54] perf cgroup: Introduce cgroup__delete()
Date: Thu,  8 Mar 2018 16:49:38 -0300
Message-Id: <20180308195029.14991-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just to make this code look more like other places in tools/perf.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-j3j72vvn2d5j7tenlghdy195@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 6ce291f45f2d..4dd52feb1ae6 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -144,12 +144,17 @@ static int add_cgroup(struct perf_evlist *evlist, char *str)
 	return 0;
 }
 
+static void cgroup__delete(struct cgroup *cgroup)
+{
+	close(cgroup->fd);
+	zfree(&cgroup->name);
+	free(cgroup);
+}
+
 void close_cgroup(struct cgroup *cgrp)
 {
 	if (cgrp && refcount_dec_and_test(&cgrp->refcnt)) {
-		close(cgrp->fd);
-		zfree(&cgrp->name);
-		free(cgrp);
+		cgroup__delete(cgrp);
 	}
 }
 
-- 
2.14.3
