Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755423AbeDTOdq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755409AbeDTOdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:33:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351E92183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 16/17] perf test BPF: Fixup BPF test using epoll_pwait syscall function probe
Date: Fri, 20 Apr 2018 11:32:26 -0300
Message-Id: <20180420143227.16030-17-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180420143227.16030-1-acme@kernel.org>
References: <20180420143227.16030-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
