Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4FEC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F1D222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403983AbfBMLry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:47:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:61125 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfBMLrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:47:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 03:47:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="146480025"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2019 03:47:50 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v0 0/2] perf: Allow forcing high-order allocation for AUX buffers
Date:   Wed, 13 Feb 2019 13:47:14 +0200
Message-Id: <20190213114716.63972-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Arnaldo,

It turns out that using high-order allocations for AUX buffers reduces the
run-time performance penalty, for example, with Intel PT. The assumption is
that this comes from not having to fetch the next page's address at every
page boundary. Given a workload that does a lot of indirect branches (thus
generating more PT data with addresses of branch targets), it takes around
6% longer to complete under PT in snapshot mode than without PT, but only
around 4% if we use high-order output regions instead of single page output
regions. This is measured on an Atom CPU.

We already use high-order allocations for PMUs that don't do HW SG (like
Intel PT on BDW). This patchset adds an attribute bit that enables the
same for the PMUs that do have HW SG, and a command line option for perf
record to set this bit.

Alexander Shishkin (2):
  perf: Add an option to ask for high order allocations for AUX buffers
  perf record: Add --aux-highorder

 include/uapi/linux/perf_event.h       | 3 ++-
 kernel/events/core.c                  | 3 +++
 kernel/events/ring_buffer.c           | 3 ++-
 tools/include/uapi/linux/perf_event.h | 3 ++-
 tools/perf/builtin-record.c           | 2 ++
 tools/perf/perf.h                     | 1 +
 tools/perf/util/evsel.c               | 9 +++++++++
 7 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.20.1

