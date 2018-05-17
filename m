Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeEQHEw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:04:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:58279 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbeEQHEv (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:04:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,409,1520924400";
   d="scan'208";a="224944261"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 0/2] perf annotate: add max/min cycles
Date: Thu, 17 May 2018 22:58:36 +0800
Message-Id: <1526569118-14217-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf has a feature to account cycles for LBRs

For example, on skylake,

perf record -b ...
perf report or
perf annotate

And then browsing the annotate browser gives average cycle counts
for program blocks.

For some analysis it would be useful if we could know not only
the average cycles but also the max and min cycles.

Now, for example, when press 'c', the annotate view is:

Percent│ IPC     Cycle(max/min)
       │
       │
       │                             Disassembly of section .text:
       │
       │                             000000000003aab0 <random@@GLIBC_2.2.5>:
  8.22 │3.92                           sub    $0x18,%rsp
       │3.92                           mov    $0x1,%esi
       │3.92                           xor    %eax,%eax
       │3.92                           cmpl   $0x0,argp_program_version_hook@@G
       │3.92             1(2/1)      ↓ je     20
       │                               lock   cmpxchg %esi,__abort_msg@@GLIBC_P
       │                             ↓ jne    29
       │                             ↓ jmp    43
       │1.10                     20:   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+
  8.93 │1.10             1(5/1)      ↓ je     43

When press 'c' again, the annotate view is switched back:

Percent│ IPC Cycle
       │
       │
       │                Disassembly of section .text:
       │
       │                000000000003aab0 <random@@GLIBC_2.2.5>:
  8.22 │3.92              sub    $0x18,%rsp
       │3.92              mov    $0x1,%esi
       │3.92              xor    %eax,%eax
       │3.92              cmpl   $0x0,argp_program_version_hook@@GLIBC_2.2.5+0x
       │3.92     1      ↓ je     20
       │                  lock   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+0x8a0
       │                ↓ jne    29
       │                ↓ jmp    43
       │1.10        20:   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+0x8a0
  8.93 │1.10     1      ↓ je     43

Jin Yao (2):
  perf annotate: Record the max/min cycles
  perf annotate: Create hotkey 'c' to show max/min cycles

 tools/perf/ui/browsers/annotate.c |  8 ++++++
 tools/perf/util/annotate.c        | 51 +++++++++++++++++++++++++++++++++------
 tools/perf/util/annotate.h        | 11 ++++++++-
 3 files changed, 62 insertions(+), 8 deletions(-)

-- 
2.7.4
