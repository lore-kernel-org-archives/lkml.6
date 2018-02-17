Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeBQLj7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:39:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39445 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeBQLj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:39:58 -0500
Date: Sat, 17 Feb 2018 03:39:44 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-2k5kutwr4ds36adiakyb4yvy@git.kernel.org>
Cc: acme@redhat.com, jolsa@kernel.org, wangnan0@huawei.com,
        adrian.hunter@intel.com, hpa@zytor.com, tmricht@linux.vnet.ibm.com,
        dsahern@gmail.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, mhiramat@kernel.org
Reply-To: dsahern@gmail.com, tmricht@linux.vnet.ibm.com, hpa@zytor.com,
        wangnan0@huawei.com, adrian.hunter@intel.com, acme@redhat.com,
        jolsa@kernel.org, mhiramat@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, namhyung@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests shell lib: Use a wildcard to remove the
 vfs_getname probe
Git-Commit-ID: 21316ac6803d4a1aadd74b896db8d60a92cd1140
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

Commit-ID:  21316ac6803d4a1aadd74b896db8d60a92cd1140
Gitweb:     https://git.kernel.org/tip/21316ac6803d4a1aadd74b896db8d60a92cd1140
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 16 Feb 2018 15:26:51 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 15:31:12 -0300

perf tests shell lib: Use a wildcard to remove the vfs_getname probe

In some situations the vfs_getname is being added both as requested and
with a _1 suffix (inlines?):

  probe:vfs_getname_1  (on getname_flags:63@acme/git/linux/fs/namei.c with pathname)

This ends up making the cleanup to miss that one, as it removes just
'probe:vfs_getname', which makes the second test to use this probe point
to fail, since it finds that leftover from the first test, use a
wildcard to remove both.

Before:

  # perf test 60 61 62 63
  60: Use vfs_getname probe to get syscall args filenames   : FAILED!
  61: probe libc's inet_pton & backtrace it with ping       : Ok
  62: Check open filename arg using perf trace + vfs_getname: FAILED!
  63: Add vfs_getname probe to get syscall args filenames   : Ok

After:

  # perf test 60 61 62 63
  60: Use vfs_getname probe to get syscall args filenames   : Ok
  61: probe libc's inet_pton & backtrace it with ping       : Ok
  62: Check open filename arg using perf trace + vfs_getname: Ok
  63: Add vfs_getname probe to get syscall args filenames   : Ok
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2k5kutwr4ds36adiakyb4yvy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 30a950c..1c16e56 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -5,7 +5,7 @@ had_vfs_getname=$?
 
 cleanup_probe_vfs_getname() {
 	if [ $had_vfs_getname -eq 1 ] ; then
-		perf probe -q -d probe:vfs_getname
+		perf probe -q -d probe:vfs_getname*
 	fi
 }
 
