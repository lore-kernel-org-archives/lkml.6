Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1612DC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5632086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5632086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeIKWPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:15:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:31116 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbeIKWPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:15:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 10:14:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,361,1531810800"; 
   d="scan'208";a="79642201"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2018 10:14:57 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 0/6] perf/core and x86/intel_rdt: Fix lack of coordination with perf
Date:   Tue, 11 Sep 2018 10:14:31 -0700
Message-Id: <cover.1536685533.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainers,

This new series fixing the lack of coordination between the
pseudo-locking measurement code and perf addresses all feedback received
for V2.

Changes since V2:
- Move the helper to obtain the performance counter index to
  include/linux/perf_event.h. The request was actually to move this helper
  to arch/x86/include/asm/perf_event.h - but doing so would be more
  involved since this header file does not know about struct perf_event
  that is used by this helper. There was no response for further
  clarification of the request to move this helper so I proceeded to move it
  to include/linux/perf_event.h instead.
- Change name of helper to obtain the index to perf_rdpmc_index() - the
  original request was to name it x86_perf_rdpmc_index() but this seems to
  be tied to the suggested header location. With the header location of
  include/linux/perf_event.h the name perf_rdpmc_index() seems to fit
  better with the new destination. There was no response for further
  clarification of the naming change request so I proceeded with the change.
- Replace all local register variables used in the measurement routines
  with local variables using READ_ONCE().
- The removal of local register variables also enable us to replace the
  direct __wrmsr() with wrmsr().
- Merge the L2 and L3 measurement routines following Peter's suggested
  framework.
- Do not copy the text from SDM that refers to serializing instructions.
- Include another LFENCE call after loop reading pseudo-locked memory.

The above addresses all feedback received for V2. The one unanswered
question that remains following the review is why the memory reading
was done with asm: the reason I did so was to avoid any compiler
optimizations while constraining the code exactly to what needed to be
measured. By using the asm instruction I am able to use a single instruction
to read a cache line into a register. To me this seemed the most constrained
way to measure if a cache line is in the cache.

- Below is verbatim from V2 submission (except for diffstat below) -

This is the second attempt at fixing the lack of coordination between the
pseudo-locking measurement code and perf. Thank you very much for your
feedback on the first version. The entire solution, including the cover
letter, has been reworked based on your feedback, while submitted as a V2,
none of the patches from V1 remained.

Changes since V1:
- Use in-kernel interface to perf.
- Do not write directly to PMU registers.
- Do not introduce another PMU owner. perf maintains role as performing
  resource arbitration for PMU.
- User space is able to use perf and resctrl at the same time.
- event_base_rdpmc is accessed and used only within an interrupts
  disabled section.
- Internals of events are never accessed directly, inline function used.
- Due to "pinned" usage the scheduling of event may have failed.  Error
  state is checked in recommended way and have a credible error
  handling.
- use X86_CONFIG

This code is based on the x86/cache branch of tip.git

The success of Cache Pseudo-Locking, as measured by how many cache lines
from a physical memory region has been locked to cache, can be measured
via the use of hardware performance events. Specifically, the number of
cache hits and misses reading a memory region after it has been
pseudo-locked to cache. This measurement is triggered via the resctrl
debugfs interface.

The current solution accesses performance counters and their configuration
registers directly without coordination with other performance event users
(perf).
Two of the issues that exist with the current solution:
- By writing to the performance monitoring registers directly a new owner
  for these resources is introduced. The perf infrastructure already exist
  to perform resource arbitration and the in-kernel infrastructure should
  be used to do so.
- The current lack of coordination with perf will have consequences any time
  two users, for example perf and cache pseudo-locking, attempt to do any
  kind of measurement at the same time.

In this series the measurement of Cache Pseudo-Lock regions is moved to use
the in-kernel interface to perf. During the rework of the measurement
function the L2 and L3 cache measurements are separated to avoid the
additional code needed to decide on which measurement causing unrelated
cache hits and misses.

Your feedback on this work will be greatly appreciated.

Reinette

Reinette Chatre (6):
  perf/core: Add sanity check to deal with pinned event failure
  perf/core: Add helper to obtain performance counter index
  x86/intel_rdt: Remove local register variables
  x86/intel_rdt: Create required perf event attributes
  x86/intel_rdt: Use perf infrastructure for measurements
  x86/intel_rdt: Re-enable pseudo-lock measurements

 Documentation/x86/intel_rdt_ui.txt          |  22 +-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 365 +++++++++++---------
 include/linux/perf_event.h                  |  26 +-
 kernel/events/core.c                        |   6 +
 4 files changed, 255 insertions(+), 164 deletions(-)

-- 
2.17.0

