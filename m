Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFA5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2FE21477
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2FE21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbeHPXRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:17:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:43390 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeHPXRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:17:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 13:16:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,248,1531810800"; 
   d="scan'208";a="225248274"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2018 13:16:33 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 0/6] perf/core and x86/intel_rdt: Fix lack of coordination with perf
Date:   Thu, 16 Aug 2018 13:16:03 -0700
Message-Id: <cover.1534450299.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainers,

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
  x86/intel_rdt: Remove local register variables
  x86/intel_rdt: Create required perf event attributes
  x86/intel_rdt: Add helper to obtain performance counter index
  x86/intel_rdt: Use perf infrastructure for measurements
  x86/intel_rdt: Re-enable pseudo-lock measurements

 Documentation/x86/intel_rdt_ui.txt          |  22 +-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 419 ++++++++++++++------
 kernel/events/core.c                        |   6 +
 3 files changed, 310 insertions(+), 137 deletions(-)

-- 
2.17.0

