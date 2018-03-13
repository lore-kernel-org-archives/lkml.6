Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeCMGWf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:22:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:52838 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751402AbeCMGWd (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:22:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,464,1515484800";
   d="scan'208";a="25162161"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 0/4] perf annotate: Create a new '--tui-dump' option
Date: Tue, 13 Mar 2018 22:16:50 +0800
Message-Id: <1520950614-22082-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a requirement to let perf annotate support displaying the IPC/Cycle.
In previous patch, this is supported in TUI mode. While it's not convenient
for users since they have to take screen shots and copy/paste data.

This patch series introduces a new option '--tui-dump' in perf annotate to
dump the TUI output to stdio.

User can easily use the command line like:
'perf annotate --tui-dump > /tmp/log.txt' 
 
For example:
    $ perf annotate compute_flag --tui-dump

    Percent  IPC Cycle

                            Disassembly of section .text:

                            0000000000400640 <compute_flag>:
                            compute_flag():
                            volatile int count;
                            static unsigned int s_randseed;

                            __attribute__((noinline))
                            int compute_flag()
                            {
     23.00  1.16              sub    $0x8,%rsp
                                    int i;

                                    i = rand() % 2;
     23.06  1.16     1        callq  rand@plt

                                    return i;
     27.01  3.38              mov    %eax,%edx
                            }
            3.38              add    $0x8,%rsp
                            {
                                    int i;

                                    i = rand() % 2;

                                    return i;
            3.38              shr    $0x1f,%edx
            3.38              add    %edx,%eax
            3.38              and    $0x1,%eax
            3.38              sub    %edx,%eax
                            }
     26.93  3.38     2        retq

The '--stdio' option is still kept now. Maybe in future, we can only
maintain the TUI routines and drop the lagacy stdio code. But right
now we'd better keep it until the '--tui-dump' option is good enough.

Jin Yao (4):
  perf browser: Add a new 'dump' flag
  perf browser: bypass ui_init if in tui dump mode
  perf annotate: Process the new switch flag tui_dump
  perf annotate: Enable the '--tui-dump' mode

 tools/perf/Documentation/perf-annotate.txt |  3 +++
 tools/perf/builtin-annotate.c              | 12 +++++++--
 tools/perf/builtin-c2c.c                   |  2 +-
 tools/perf/builtin-report.c                |  2 +-
 tools/perf/builtin-top.c                   |  2 +-
 tools/perf/ui/browser.c                    | 38 +++++++++++++++++++++++----
 tools/perf/ui/browser.h                    |  1 +
 tools/perf/ui/browsers/annotate.c          | 41 +++++++++++++++++++++---------
 tools/perf/ui/browsers/hists.c             |  2 +-
 tools/perf/ui/setup.c                      |  9 +++++--
 tools/perf/ui/ui.h                         |  2 +-
 tools/perf/util/annotate.h                 |  6 +++--
 tools/perf/util/hist.h                     | 11 +++++---
 13 files changed, 99 insertions(+), 32 deletions(-)

-- 
2.7.4
