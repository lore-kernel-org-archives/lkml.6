Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4A9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CB020870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CB020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbeGaVUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:20:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:3846 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732282AbeGaVUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:20:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 12:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,428,1526367600"; 
   d="scan'208";a="77594078"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga001.jf.intel.com with ESMTP; 31 Jul 2018 12:38:43 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, fenghua.yu@intel.com,
        tony.luck@intel.com, vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination with perf
Date:   Tue, 31 Jul 2018 12:38:27 -0700
Message-Id: <cover.1533064851.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainers,

The success of Cache Pseudo-Locking can be measured via the use of
performance events. Specifically, the number of cache hits and misses
reading a memory region after it has been pseudo-locked to cache. This
measurement is triggered via the resctrl debugfs interface.

To ensure most accurate results the performance counters and their
configuration registers are accessed directly. This is currently done
without coordination with other performance event users and will have
consequences any time two users, for example perf and cache
pseudo-locking, attempt to do any kind of measurement at the same time.

The performance counter reservation mechanism for individual counters is
available to cache pseudo-locking and could be used. That would require
duplicating the currently private reservation mechanism for all counters.
Instead in this work the reservation mechanism for all counters on the
system is exposed and subsequently used by the cache pseudo-locking
measurement code.

Your feedback on this work will be greatly appreciated.

Reinette

Reinette Chatre (2):
  perf/x86: Expose PMC hardware reservation
  x86/intel_rdt: Coordinate performance monitoring with perf

 Documentation/x86/intel_rdt_ui.txt          | 4 ----
 arch/x86/events/core.c                      | 6 ++++--
 arch/x86/kernel/cpu/intel_rdt.h             | 2 ++
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 8 ++++++++
 4 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.17.0

