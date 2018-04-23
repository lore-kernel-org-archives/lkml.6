Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754566AbeDWJIj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:08:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754352AbeDWJI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:08:29 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 2/9] perf check-headers.sh: Add support to check 2 independent files
Date: Mon, 23 Apr 2018 11:08:16 +0200
Message-Id: <20180423090823.32309-3-jolsa@kernel.org>
In-Reply-To: <20180423090823.32309-1-jolsa@kernel.org>
References: <20180423090823.32309-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding check_2 function to check 2 different files,
the check function stays to check files that differs
only in the prefix path.

In upcoming changes we need to check on header files
in locations which don't follow the prefix logic.

Link: http://lkml.kernel.org/n/tip-p1o7jpx53236fgzgezdylu50@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/check-headers.sh | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 88c5f9449809..10f333e2e825 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -55,17 +55,26 @@ include/uapi/asm-generic/ioctls.h
 include/uapi/asm-generic/mman-common.h
 '
 
-check () {
-  file=$1
+check_2 () {
+  file1=$1
+  file2=$2
 
   shift
+  shift
 
-  cmd="diff $* ../$file ../../$file > /dev/null"
+  cmd="diff $* $file1 $file2 > /dev/null"
 
-  test -f ../../$file &&
+  test -f $file2 &&
   eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
 }
 
+check () {
+  file=$1
+
+  shift
+
+  check_2 ../$file ../../$file $*
+}
 
 # Check if we have the kernel headers (tools/perf/../../include), else
 # we're probably on a detached tarball, so no point in trying to check
-- 
2.13.6
