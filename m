Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeEBRlK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:41:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56429 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEBRlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:41:06 -0400
Date: Wed, 2 May 2018 10:40:46 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-15019e9815a06b84870bfaf9ee1e8b75bf7ef6a6@git.kernel.org>
Cc: namhyung@kernel.org, jolsa@kernel.org, hpa@zytor.com, mingo@kernel.org,
        dsahern@gmail.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        tglx@linutronix.de
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, hpa@zytor.com, mingo@kernel.org,
        namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, acme@redhat.com
In-Reply-To: <20180423090823.32309-2-jolsa@kernel.org>
References: <20180423090823.32309-2-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf check-headers.sh: Simplify arguments passing
Git-Commit-ID: 15019e9815a06b84870bfaf9ee1e8b75bf7ef6a6
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

Commit-ID:  15019e9815a06b84870bfaf9ee1e8b75bf7ef6a6
Gitweb:     https://git.kernel.org/tip/15019e9815a06b84870bfaf9ee1e8b75bf7ef6a6
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 23 Apr 2018 11:08:15 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 09:30:26 -0300

perf check-headers.sh: Simplify arguments passing

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
