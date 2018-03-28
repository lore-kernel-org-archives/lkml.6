Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbeC1Sti (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752090AbeC1Stc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:49:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07212217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/8] perf build: Fix check-headers.sh opts assignment
Date: Wed, 28 Mar 2018 15:49:12 -0300
Message-Id: <20180328184919.32287-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180328184919.32287-1-acme@kernel.org>
References: <20180328184919.32287-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Currently the "opts" variable is not zero-ed and we keep on adding to
it, ending up with:

  $ check-headers.sh 2>&1
  + opts=' "-B"'
  + opts=' "-B" "-B"'
  + opts=' "-B" "-B" "-B"'
  + opts=' "-B" "-B" "-B" "-B"'
  + opts=' "-B" "-B" "-B" "-B" "-B"'
  + opts=' "-B" "-B" "-B" "-B" "-B" "-B"'

Fix this by initializing it in the check() function, right before
starting the loop.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180321140515.2252-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/check-headers.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index bf206ffe5c45..9aff89bc7535 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -59,6 +59,7 @@ check () {
   file=$1
 
   shift
+  opts=
   while [ -n "$*" ]; do
     opts="$opts \"$1\""
     shift
-- 
2.14.3
