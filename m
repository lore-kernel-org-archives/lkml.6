Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeDLJgv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:36:51 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:33933 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeDLJgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:36:50 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Peter Zijlstra <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 0/6] MIPS: perf: MT fixes and improvements
Date: Thu, 12 Apr 2018 10:36:20 +0100
Message-ID: <1523525786-29153-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1523525780-298552-14027-32435-1
X-BESS-VER: 2018.4-r1804052328
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191914
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses a few issues with how the MIPS performance
counters code supports the hardware multithreading MT ASE.

Firstly, implementations of the MT ASE may implement performance counters
per core or per thread(TC). MIPS Techologies implementations signal this
via a bit in the implmentation specific CONFIG7 register. Since this
register is implementation specific, checking it should be guarded by a
PRID check. This also replaces a bit defined by a magic number.

Secondly, the code currently uses vpe_id(), defined as
smp_processor_id(), divided by 2, to share core performance counters
between VPEs. This relies on a couple of assumptions of the hardware
implementation to function correctly (always 2 VPEs per core, and the
hardware reading only the least significant bit).

Finally, the method of sharing core performance counters between VPEs is
suboptimal since it does not allow one process running on a VPE to use
all of the performance counters available to it, because the kernel will
reserve half of the coutners for the other VPE even if it may never use
them. This reservation at counter probe is replaced with an allocation
on use strategy.

Tested on a MIPS Creator CI40 (2C2T MIPS InterAptiv with per-TC
counters, though for the purposes of testing the per-TC availability was
hardcoded to allow testing both paths).

Series applies to v4.16-rc7


Changes in v2:
Fix mipsxx_pmu_enable_event for !#ifdef CONFIG_MIPS_MT_SMP
- Fix !#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS build
- re-use cpuc variable in mipsxx_pmu_alloc_counter,
  mipsxx_pmu_free_counter rather than having sibling_ version.
Since BMIPS5000 does not implement per TC counters, we can remove the
check on cpu_has_mipsmt_pertccounters.
New patch to fix BMIPS5000 system mode perf.

Matt Redfearn (6):
  MIPS: perf: More robustly probe for the presence of per-tc counters
  MIPS: perf: Use correct VPE ID when setting up VPE tracing
  MIPS: perf: Fix perf with MT counting other threads
  MIPS: perf: Allocate per-core counters on demand
  MIPS: perf: Fold vpe_id() macro into it's one last usage
  MIPS: perf: Fix BMIPS5000 system mode counting

 arch/mips/include/asm/mipsregs.h     |   6 +
 arch/mips/kernel/perf_event_mipsxx.c | 257 +++++++++++++++++++++--------------
 2 files changed, 158 insertions(+), 105 deletions(-)

-- 
2.7.4
