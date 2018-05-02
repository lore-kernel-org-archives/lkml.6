Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbeEBRlh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:41:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36061 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEBRlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:41:35 -0400
Date: Wed, 2 May 2018 10:41:15 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-58247297359326603d601451223e0da6a97bee3c@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@kernel.org,
        acme@redhat.com, peterz@infradead.org, namhyung@kernel.org,
        dsahern@gmail.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, hpa@zytor.com
Reply-To: alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        dsahern@gmail.com, namhyung@kernel.org, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        acme@redhat.com, peterz@infradead.org
In-Reply-To: <20180423090823.32309-3-jolsa@kernel.org>
References: <20180423090823.32309-3-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf check-headers.sh: Add support to check 2
 independent files
Git-Commit-ID: 58247297359326603d601451223e0da6a97bee3c
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

Commit-ID:  58247297359326603d601451223e0da6a97bee3c
Gitweb:     https://git.kernel.org/tip/58247297359326603d601451223e0da6a97bee3c
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 23 Apr 2018 11:08:16 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 09:30:26 -0300

perf check-headers.sh: Add support to check 2 independent files

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
