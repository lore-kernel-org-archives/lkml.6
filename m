Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754518AbeDWJId (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:08:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754397AbeDWJI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:08:27 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 1/9] perf check-headers.sh: Simplify arguments passing
Date: Mon, 23 Apr 2018 11:08:15 +0200
Message-Id: <20180423090823.32309-2-jolsa@kernel.org>
In-Reply-To: <20180423090823.32309-1-jolsa@kernel.org>
References: <20180423090823.32309-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing whole string instead of parsing them after.
It simplifies things for the next patches, that adds
another function call, which makes it hard to pass
arguments in the correct shape.

Link: http://lkml.kernel.org/n/tip-7sxkyhuktvxiepem60d6451b@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/check-headers.sh | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 9aff89bc7535..88c5f9449809 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -59,13 +59,8 @@ check () {
   file=$1
 
   shift
-  opts=
-  while [ -n "$*" ]; do
-    opts="$opts \"$1\""
-    shift
-  done
 
-  cmd="diff $opts ../$file ../../$file > /dev/null"
+  cmd="diff $* ../$file ../../$file > /dev/null"
 
   test -f ../../$file &&
   eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
@@ -83,7 +78,7 @@ for i in $HEADERS; do
 done
 
 # diff with extra ignore lines
-check arch/x86/lib/memcpy_64.S        -I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"
-check arch/x86/lib/memset_64.S        -I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"
-check include/uapi/asm-generic/mman.h -I "^#include <\(uapi/\)*asm-generic/mman-common.h>"
-check include/uapi/linux/mman.h       -I "^#include <\(uapi/\)*asm/mman.h>"
+check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"'
+check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"'
+check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common.h>"'
+check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
-- 
2.13.6
