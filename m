Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682DDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104752054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104752054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeJaSJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:09:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:16408 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbeJaSJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:09:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 02:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="104759414"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by orsmga002.jf.intel.com with ESMTP; 31 Oct 2018 02:12:27 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 0/5] perf tools: Fix for cases where cpumode is incorrect or insufficient
Date:   Wed, 31 Oct 2018 11:10:38 +0200
Message-Id: <20181031091043.23465-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

These patches probably deal with most cases except the one fixed by David
Miller's "perf callchain: Honour the ordering of
PERF_CONTEXT_{USER,KERNEL,etc}" patch, and also cat_backtrace() which looks
like it has the same problem, and the cs-etm fix.


Adrian Hunter (5):
      perf tools: Add fallback functions for cases where cpumode is insufficient
      perf tools: Use fallback for sample_addr_correlates_sym() cases
      perf tools: Use fallbacks for branch stacks
      perf intel-pt: Insert callchain context into synthesized callchains
      perf intel-pt/bts: Calculate cpumode for synthesized samples

 tools/perf/builtin-script.c                        | 12 +++---
 tools/perf/util/event.c                            | 29 +++++++++++++-
 tools/perf/util/intel-bts.c                        | 17 ++++++---
 tools/perf/util/intel-pt.c                         | 28 ++++++++------
 tools/perf/util/machine.c                          | 40 ++++++++++++++++++++
 tools/perf/util/machine.h                          |  2 +
 .../util/scripting-engines/trace-event-python.c    | 16 ++++----
 tools/perf/util/thread-stack.c                     | 44 +++++++++++++++++-----
 tools/perf/util/thread-stack.h                     |  2 +-
 tools/perf/util/thread.h                           |  4 ++
 10 files changed, 153 insertions(+), 41 deletions(-)


Regards
Adrian
