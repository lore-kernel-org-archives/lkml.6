Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeC2N6W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:58:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44757 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbeC2N6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:58:21 -0400
Date: Thu, 29 Mar 2018 06:57:56 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b4c786e5aa69c5a75ac3932f81fdf8e8c120c03b@git.kernel.org>
Cc: peterz@infradead.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, dsahern@gmail.com, acme@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        acme@redhat.com, peterz@infradead.org, hpa@zytor.com,
        dsahern@gmail.com, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20180321140515.2252-1-jolsa@kernel.org>
References: <20180321140515.2252-1-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf build: Fix check-headers.sh opts assignment
Git-Commit-ID: b4c786e5aa69c5a75ac3932f81fdf8e8c120c03b
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

Commit-ID:  b4c786e5aa69c5a75ac3932f81fdf8e8c120c03b
Gitweb:     https://git.kernel.org/tip/b4c786e5aa69c5a75ac3932f81fdf8e8c120c03b
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 21 Mar 2018 15:05:15 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 27 Mar 2018 13:13:38 -0300

perf build: Fix check-headers.sh opts assignment

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
