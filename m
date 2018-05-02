Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeEBPeI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:34:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751690AbeEBPUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:20:19 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/52] perf check-headers.sh: Add support to check 2 independent files
Date: Wed,  2 May 2018 12:18:54 -0300
Message-Id: <20180502151942.20542-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add 'check_2' function to check 2 different files, the 'check' function
stays to check files that differs only in the prefix path.

In upcoming changes we need to check header files in locations which
don't follow the prefix logic.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180423090823.32309-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
 
+  shift
   shift
 
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
2.14.3
