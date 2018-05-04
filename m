Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeEDNzn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:55:43 -0400
Received: from foss.arm.com ([217.140.101.70]:53632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbeEDNzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:55:41 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org
Subject: [PATCH 0/3] kcov: fix unexpected faults
Date: Fri,  4 May 2018 14:55:32 +0100
Message-Id: <20180504135535.53744-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches fix a few issues where KCOV code could trigger recursive
faults, discovered while debugging a patch enabling KCOV for arch/arm:

* On CONFIG_PREEMPT kernels, there's a small race window where
  __sanitizer_cov_trace_pc() can see a bogus kcov_area.

* Lazy faulting of the vmalloc area can cause mutual recursion between
  fault handling code and __sanitizer_cov_trace_pc().

* During the context switch, switching the mm can cause the kcov_area to
  be transiently unmapped.

These are prerequisites for enabling KCOV on arm, but the issues
themsevles are generic -- we just happen to avoid them by chance rather
than design on x86-64 and arm64.

I've tested this on arm atop of v4.17-rc3, with KCOV enabled.

Thanks,
Mark.

Mark Rutland (3):
  kcov: ensure irq code sees a valid area
  kcov: prefault the kcov_area
  sched/core / kcov: avoid kcov_area during task switch

 include/linux/kcov.h  | 14 ++++++++++++++
 include/linux/sched.h |  2 +-
 kernel/kcov.c         | 17 +++++++++++++++--
 kernel/sched/core.c   |  4 ++++
 4 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.11.0
