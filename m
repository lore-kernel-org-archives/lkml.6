Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F587C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AB42086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AB42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbeKGGgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:36:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:32232 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbeKGGgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:36:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 13:09:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="102068217"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2018 13:08:58 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH V2 0/3] perf tools: Fix for cases where cpumode is incorrect or insufficient
Date:   Tue,  6 Nov 2018 23:07:09 +0200
Message-Id: <20181106210712.12098-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is V2:
These patches probably deal with most cases except the one fixed by David
Miller's "perf callchain: Honour the ordering of
PERF_CONTEXT_{USER,KERNEL,etc}" patch, and also cat_backtrace() which looks
like it has the same problem, and the cs-etm fix.


Changes in V2:
      perf tools: Add fallback functions for cases where cpumode is insufficient
	Rename fallback functions to both end in _fb
	Add and use  variable  machine->single_address_space

      perf tools: Use fallback for sample_addr_correlates_sym() cases
      perf tools: Use fallbacks for branch stacks
	Adjusted for the re-naming above

      perf intel-pt: Insert callchain context into synthesized callchains
      perf intel-pt/bts: Calculate cpumode for synthesized samples
	Dropped because they have been applied


Adrian Hunter (3):
      perf tools: Add fallback functions for cases where cpumode is insufficient
      perf tools: Use fallback for sample_addr_correlates_sym() cases
      perf tools: Use fallbacks for branch stacks

 tools/perf/arch/common.c                           | 10 ++++++++
 tools/perf/arch/common.h                           |  1 +
 tools/perf/builtin-script.c                        | 12 ++++-----
 tools/perf/util/event.c                            | 29 +++++++++++++++++++++-
 tools/perf/util/machine.c                          | 27 ++++++++++++++++++++
 tools/perf/util/machine.h                          |  3 +++
 .../util/scripting-engines/trace-event-python.c    | 16 ++++++------
 tools/perf/util/session.c                          |  4 +++
 tools/perf/util/thread.h                           |  4 +++
 9 files changed, 91 insertions(+), 15 deletions(-)


Regards
Adrian
