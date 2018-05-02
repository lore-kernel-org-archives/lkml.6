Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeEBPUU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751687AbeEBPUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:20:16 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/52] perf check-headers.sh: Simplify arguments passing
Date: Wed,  2 May 2018 12:18:53 -0300
Message-Id: <20180502151942.20542-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Passing whole string instead of parsing them after.  It simplifies
things for the next patches, that adds another function call, which
makes it hard to pass arguments in the correct shape.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180423090823.32309-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.3
