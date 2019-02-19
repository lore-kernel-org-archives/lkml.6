Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849A9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58ECA21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfBSUA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:00:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:8744 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729710AbfBSUAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:00:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 12:00:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="139918040"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2019 12:00:54 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, acme@kernel.org,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, jolsa@redhat.com, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 00/10] perf: Multi-die/package support
Date:   Tue, 19 Feb 2019 12:00:01 -0800
Message-Id: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add Linux perf support for multi-die/package. The first product with
multi-die is Xeon Cascade Lake-AP (CLX-AP).
The code bases on the top of Len's multi-die/package support.
https://lkml.org/lkml/2019/2/18/1534

Patch 1-4: They are generic codes for previous platforms.
Perf supports miscellaneous modules, e.g cstate, RAPL and uncore.
Their counters have the same scope of effect (per package).
But they maintain their own scope information independently.
It's very useful to abstract several common topology related codes
for these modules to reduce the code redundancy, especially when
adding counters with new scope.

Patch 5-8: Support die scope counters on CLX-AP for uncore, RAPL
and cstate.

Patch 9-10: Support per-die aggregation for perf stat and header.

Kan Liang (10):
  perf/x86/intel: Introduce a concept "domain" as the scope of counters
  perf/x86/intel/cstate: Apply "domain" for cstate
  perf/x86/intel/uncore: Apply "domain" for uncore
  perf/x86/intel/rapl: Apply "domain" for RAPL
  perf/x86/intel/domain: Add new domain type for die
  perf/x86/intel/uncore: Support die scope counters on CLX-AP
  perf/x86/intel/rapl: Support die scope counters on CLX-AP
  perf/x86/intel/cstate: Support die scope counters on CLX-AP
  perf header: Add die information in cpu topology
  perf stat: Support per-die aggregation

 arch/x86/events/Makefile                           |   2 +-
 arch/x86/events/domain.c                           |  81 +++++
 arch/x86/events/domain.h                           |  26 ++
 arch/x86/events/intel/cstate.c                     | 364 ++++++++++++---------
 arch/x86/events/intel/rapl.c                       | 333 ++++++++++++++-----
 arch/x86/events/intel/uncore.c                     | 247 +++++++++-----
 arch/x86/events/intel/uncore.h                     |   9 +-
 arch/x86/events/intel/uncore_snbep.c               |   2 +-
 tools/perf/Documentation/perf-stat.txt             |  10 +
 tools/perf/Documentation/perf.data-file-format.txt |   9 +-
 tools/perf/builtin-stat.c                          |  73 ++++-
 tools/perf/util/cpumap.c                           |  55 +++-
 tools/perf/util/cpumap.h                           |  10 +-
 tools/perf/util/env.c                              |   1 +
 tools/perf/util/env.h                              |   3 +
 tools/perf/util/header.c                           | 185 ++++++++++-
 tools/perf/util/stat-display.c                     |  24 +-
 tools/perf/util/stat-shadow.c                      |   1 +
 tools/perf/util/stat.c                             |   1 +
 tools/perf/util/stat.h                             |   1 +
 20 files changed, 1082 insertions(+), 355 deletions(-)
 create mode 100644 arch/x86/events/domain.c
 create mode 100644 arch/x86/events/domain.h

-- 
2.7.4

