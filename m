Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeFBO7t (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 10:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751508AbeFBO7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 10:59:41 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 1/4] perf trace beauty prctl: Default header_dir to cwd to work without parms
Date: Sat,  2 Jun 2018 11:59:24 -0300
Message-Id: <20180602145927.23307-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180602145927.23307-1-acme@kernel.org>
References: <20180602145927.23307-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Useful when checking the effects of header synchs for the files it uses
as a input to generate string tables, in retrospect this is how it
should've been done from day 1, not requiring the header_dir to be set
on the Makefile, will change everything later, so that the only parm,
common to all generators will be $(srctree) and $(beauty_outdir).

So, to see what it generates, just call it without any parameters:

  $ tools/perf/trace/beauty/prctl_option.sh
  static const char *prctl_options[] = {
	  [1] = "SET_PDEATHSIG",
	  [2] = "GET_PDEATHSIG",
	  [3] = "GET_DUMPABLE",
	  [4] = "SET_DUMPABLE",
	  [5] = "GET_UNALIGN",
	  [6] = "SET_UNALIGN",
	  [7] = "GET_KEEPCAPS",
	  [8] = "SET_KEEPCAPS",
	  [9] = "GET_FPEMU",
	  [10] = "SET_FPEMU",
	  [11] = "GET_FPEXC",
	  [12] = "SET_FPEXC",
	  [13] = "GET_TIMING",
	  [14] = "SET_TIMING",
	  [15] = "SET_NAME",
	  [16] = "GET_NAME",
	  [19] = "GET_ENDIAN",
	  [20] = "SET_ENDIAN",
	  [21] = "GET_SECCOMP",
	  [22] = "SET_SECCOMP",
	  [25] = "GET_TSC",
	  [26] = "SET_TSC",
	  [27] = "GET_SECUREBITS",
	  [28] = "SET_SECUREBITS",
	  [29] = "SET_TIMERSLACK",
	  [30] = "GET_TIMERSLACK",
	  [35] = "SET_MM",
	  [36] = "SET_CHILD_SUBREAPER",
	  [37] = "GET_CHILD_SUBREAPER",
	  [38] = "SET_NO_NEW_PRIVS",
	  [39] = "GET_NO_NEW_PRIVS",
	  [40] = "GET_TID_ADDRESS",
	  [41] = "SET_THP_DISABLE",
	  [42] = "GET_THP_DISABLE",
	  [45] = "SET_FP_MODE",
	  [46] = "GET_FP_MODE",
  };
  static const char *prctl_set_mm_options[] = {
	  [1] = "START_CODE",
	  [2] = "END_CODE",
	  [3] = "START_DATA",
	  [4] = "END_DATA",
	  [5] = "START_STACK",
	  [6] = "START_BRK",
	  [7] = "BRK",
	  [8] = "ARG_START",
	  [9] = "ARG_END",
	  [10] = "ENV_START",
	  [11] = "ENV_END",
	  [12] = "AUXV",
	  [13] = "EXE_FILE",
	  [14] = "MAP",
	  [15] = "MAP_SIZE",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-qtotspuztydjttxi7k6mec6h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/prctl_option.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/prctl_option.sh b/tools/perf/trace/beauty/prctl_option.sh
index 0be4138fbe71..f24722146ebe 100755
--- a/tools/perf/trace/beauty/prctl_option.sh
+++ b/tools/perf/trace/beauty/prctl_option.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *prctl_options[] = {\n"
 regex='^#define[[:space:]]+PR_([GS]ET\w+)[[:space:]]*([[:xdigit:]]+).*'
-- 
2.14.3
