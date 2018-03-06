Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbeCFGp2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:45:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37307 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeCFGp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:45:26 -0500
Date: Mon, 5 Mar 2018 22:45:16 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-hz04f296zccknnb5at06a6q0@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, wangnan0@huawei.com, mingo@kernel.org,
        acme@redhat.com, adrian.hunter@intel.com, dsahern@gmail.com,
        namhyung@kernel.org
Reply-To: jolsa@kernel.org, mingo@kernel.org, wangnan0@huawei.com,
        acme@redhat.com, adrian.hunter@intel.com, dsahern@gmail.com,
        namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Allow asking for the maximum allowed
 sample rate
Git-Commit-ID: 7831bf236505bcb2a0a1255e7f3e902a0cb732d6
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

Commit-ID:  7831bf236505bcb2a0a1255e7f3e902a0cb732d6
Gitweb:     https://git.kernel.org/tip/7831bf236505bcb2a0a1255e7f3e902a0cb732d6
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 1 Mar 2018 14:25:56 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 09:58:44 -0300

perf top: Allow asking for the maximum allowed sample rate

Add the handy '-F max' shortcut, just introduced to 'perf record', to
reading and using the kernel.perf_event_max_sample_rate value as the
user supplied sampling frequency:

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-hz04f296zccknnb5at06a6q0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 4 +++-
 tools/perf/builtin-top.c              | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 8a32cc77bead..a039407d63b8 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -55,7 +55,9 @@ Default is to monitor all CPUS.
 
 -F <freq>::
 --freq=<freq>::
-	Profile at this frequency.
+	Profile at this frequency. Use 'max' to use the currently maximum
+	allowed frequency, i.e. the value in the kernel.perf_event_max_sample_rate
+	sysctl.
 
 -i::
 --inherit::
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 35ac016fcb98..bb4f9fafd11d 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1307,7 +1307,9 @@ int cmd_top(int argc, const char **argv)
 	OPT_STRING(0, "sym-annotate", &top.sym_filter, "symbol name",
 		    "symbol to annotate"),
 	OPT_BOOLEAN('z', "zero", &top.zero, "zero history across updates"),
-	OPT_UINTEGER('F', "freq", &opts->user_freq, "profile at this frequency"),
+	OPT_CALLBACK('F', "freq", &top.record_opts, "freq or 'max'",
+		     "profile at this frequency",
+		      record__parse_freq),
 	OPT_INTEGER('E', "entries", &top.print_entries,
 		    "display this many functions"),
 	OPT_BOOLEAN('U', "hide_user_symbols", &top.hide_user_symbols,
