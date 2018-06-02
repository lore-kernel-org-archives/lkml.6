Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeFBPAh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 11:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbeFBO7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 10:59:44 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 2/4] tools headers: Synchronize prctl.h ABI header
Date: Sat,  2 Jun 2018 11:59:25 -0300
Message-Id: <20180602145927.23307-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180602145927.23307-1-acme@kernel.org>
References: <20180602145927.23307-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up changes from:

  $ git log --oneline -2 -i include/uapi/linux/prctl.h
  356e4bfff2c5 prctl: Add force disable speculation
  b617cfc85816 prctl: Add speculation control prctls

  $ tools/perf/trace/beauty/prctl_option.sh > before.c
  $ cp include/uapi/linux/prctl.h tools/include/uapi/linux/prctl.h
  $ tools/perf/trace/beauty/prctl_option.sh > after.c
  $ diff -u before.c after.c
  --- before.c	2018-06-01 10:39:53.834073962 -0300
  +++ after.c	2018-06-01 10:42:11.307985394 -0300
  @@ -35,6 +35,8 @@
          [42] = "GET_THP_DISABLE",
          [45] = "SET_FP_MODE",
          [46] = "GET_FP_MODE",
  +       [52] = "GET_SPECULATION_CTRL",
  +       [53] = "SET_SPECULATION_CTRL",
   };
   static const char *prctl_set_mm_options[] = {
 	  [1] = "START_CODE",
  $

This will be used by 'perf trace' to show these strings when beautifying
the prctl syscall args. At some point we'll be able to say something
like:

	'perf trace --all-cpus -e prctl(option=*SPEC*)'

To filter by arg by name.

  This silences this warning when building tools/perf:

    Warning: Kernel ABI header at 'tools/include/uapi/linux/prctl.h' differs from latest version at 'include/uapi/linux/prctl.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zztsptwhc264r8wg44tqh5gp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/prctl.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index af5f8c2df87a..db9f15f5db04 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -207,4 +207,16 @@ struct prctl_mm_map {
 # define PR_SVE_VL_LEN_MASK		0xffff
 # define PR_SVE_VL_INHERIT		(1 << 17) /* inherit across exec */
 
+/* Per task speculation control */
+#define PR_GET_SPECULATION_CTRL		52
+#define PR_SET_SPECULATION_CTRL		53
+/* Speculation control variants */
+# define PR_SPEC_STORE_BYPASS		0
+/* Return and control values for PR_SET/GET_SPECULATION_CTRL */
+# define PR_SPEC_NOT_AFFECTED		0
+# define PR_SPEC_PRCTL			(1UL << 0)
+# define PR_SPEC_ENABLE			(1UL << 1)
+# define PR_SPEC_DISABLE		(1UL << 2)
+# define PR_SPEC_FORCE_DISABLE		(1UL << 3)
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.14.3
