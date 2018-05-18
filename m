Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeERIGt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:06:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:54340 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbeERIGr (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:06:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="scan'208";a="56375262"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 0/3] perf annotate: Support '--group' option
Date: Sat, 19 May 2018 00:00:31 +0800
Message-Id: <1526659234-1556-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For non-explicit group, perf report has already supported a option
'--group' which can enable group output.

This patch-set will support perf annotate with the same '--group'.

For example,

    perf record -e cycles,branches ./div
    perf annotate main --stdio --group

                     :            Disassembly of section .text:
                     :
                     :            00000000004004b0 <main>:
                     :            main():
                     :
                     :                    return i;
                     :            }
                     :
                     :            int main(void)
                     :            {
        0.00    0.00 :   4004b0:       push   %rbx
                     :                    int i;
                     :                    int flag;
                     :                    volatile double x = 1212121212, y = 121212;
                     :
                     :                    s_randseed = time(0);
        0.00    0.00 :   4004b1:       xor    %edi,%edi
                     :                    srand(s_randseed);
        0.00    0.00 :   4004b3:       mov    $0x77359400,%ebx
                     :
                     :                    return i;
                     :            }
                     :

v3:
---------
Move the comment which was on setup_forced_leader() to the
new function perf_evlist_forced_leader().

Impact
------
  perf evlist: Create a new function perf_evlist_forced_leader
  perf report: Use perf_evlist_forced_leader to support '--group'

 
v2:
---------
Arnaldo points out that it should be done the way it is for
perf report --group. v2 refers to this way and the patch is
totally rewritten.


Init post:
----------
Post the patch 'perf annotate: Support multiple events without group'

Jin Yao (3):
  perf evlist: Create a new function perf_evlist_forced_leader
  perf report: Use perf_evlist_forced_leader to support '--group'
  perf annotate: Support '--group' option

 tools/perf/builtin-annotate.c |  7 +++++++
 tools/perf/builtin-report.c   | 13 ++-----------
 tools/perf/util/evlist.c      | 15 +++++++++++++++
 tools/perf/util/evlist.h      |  3 +++
 4 files changed, 27 insertions(+), 11 deletions(-)

-- 
2.7.4
