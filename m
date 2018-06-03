Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbeFCRQk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 13:16:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37917 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbeFCRQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 13:16:39 -0400
Date: Sun, 3 Jun 2018 10:16:27 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-zztsptwhc264r8wg44tqh5gp@git.kernel.org>
Cc: wangnan0@huawei.com, adrian.hunter@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, dsahern@gmail.com,
        namhyung@kernel.org
Reply-To: wangnan0@huawei.com, adrian.hunter@intel.com, mingo@kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, hpa@zytor.com, dsahern@gmail.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers: Synchronize prctl.h ABI header
Git-Commit-ID: 63b89a19cc9ef911dcc64d41b60930c346eee0c0
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

Commit-ID:  63b89a19cc9ef911dcc64d41b60930c346eee0c0
Gitweb:     https://git.kernel.org/tip/63b89a19cc9ef911dcc64d41b60930c346eee0c0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 1 Jun 2018 10:42:31 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 1 Jun 2018 16:13:15 -0300

tools headers: Synchronize prctl.h ABI header

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
