Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753350AbeDUHyJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:54:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42899 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbeDUHyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:54:08 -0400
Date: Sat, 21 Apr 2018 00:53:53 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-eccb1b936363c62544bccb5bbb75afec9536f7e3@git.kernel.org>
Cc: jolsa@kernel.org, dsahern@gmail.com, mingo@kernel.org,
        namhyung@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, adrian.hunter@intel.com,
        linux@dominikbrodowski.net, rostedt@goodmis.org, acme@redhat.com,
        wangnan0@huawei.com
Reply-To: adrian.hunter@intel.com, linux@dominikbrodowski.net,
        rostedt@goodmis.org, acme@redhat.com, wangnan0@huawei.com,
        dsahern@gmail.com, jolsa@kernel.org, namhyung@kernel.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-y24nmn70cs2am8jh4i344dng@git.kernel.org>
References: <tip-y24nmn70cs2am8jh4i344dng@git.kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test BPF: Fixup BPF test using epoll_pwait
 syscall function probe
Git-Commit-ID: eccb1b936363c62544bccb5bbb75afec9536f7e3
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

Commit-ID:  eccb1b936363c62544bccb5bbb75afec9536f7e3
Gitweb:     https://git.kernel.org/tip/eccb1b936363c62544bccb5bbb75afec9536f7e3
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 18 Apr 2018 12:59:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 18 Apr 2018 15:35:53 -0300

perf test BPF: Fixup BPF test using epoll_pwait syscall function probe

Since e145242ea0df ("syscalls/core, syscalls/x86: Clean up syscall stub
naming convention") changed the main syscall function for 'epoll_pwait'
to something other than the expected 'SyS_epoll_pwait the' 'perf test
BPF' entries started failing, fix it by using something called from the
main syscall function instead, 'epoll_wait', which should keep this test
working in older kernels too.

Before:

  # perf test BPF
  40: BPF filter                           :
  40.1: Basic BPF filtering                : FAILED!
  40.2: BPF pinning                        : Skip
  40.3: BPF prologue generation            : Skip
  40.4: BPF relocation checker             : Skip

If we use -v for that test we see the problem:

    Probe point 'SyS_epoll_pwait' not found.

After:

  # perf test BPF
  40: BPF filter                           :
  40.1: Basic BPF filtering                : Ok
  40.2: BPF pinning                        : Ok
  40.3: BPF prologue generation            : Ok
  40.4: BPF relocation checker             : Ok
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/r/tip-y24nmn70cs2am8jh4i344dng@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bpf-script-example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/bpf-script-example.c b/tools/perf/tests/bpf-script-example.c
index e4123c1b0e88..1ca5106df5f1 100644
--- a/tools/perf/tests/bpf-script-example.c
+++ b/tools/perf/tests/bpf-script-example.c
@@ -31,7 +31,7 @@ struct bpf_map_def SEC("maps") flip_table = {
 	.max_entries = 1,
 };
 
-SEC("func=SyS_epoll_pwait")
+SEC("func=do_epoll_wait")
 int bpf_func__SyS_epoll_pwait(void *ctx)
 {
 	int ind =0;
