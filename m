Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F258DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80BE20891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80BE20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965400AbeFOCKA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:10:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:54467 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965072AbeFOCJ7 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:09:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 19:09:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,225,1526367600"; 
   d="scan'208";a="49141578"
Received: from skl.sh.intel.com ([10.239.161.125])
  by orsmga007.jf.intel.com with ESMTP; 14 Jun 2018 19:09:56 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        me@kylehuey.com
Cc:     Linux-kernel@vger.kernel.org, vincent.weaver@maine.edu,
        will.deacon@arm.com, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 0/2] perf: Drop leaked kernel samples
Date:   Fri, 15 Jun 2018 18:03:21 +0800
Message-Id: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On workloads that do a lot of kernel entry/exits we see kernel
samples, even though :u is specified. This is due to skid existing.

This might be a security issue because it can leak kernel addresses even
though kernel sampling support is disabled.

One patch "perf/core: Drop kernel samples even though :u is specified"
was posted in last year but it was reverted because it introduced a
regression issue that broke the rr-project.

Now this patch set uses sysctl to control the dropping of leaked
kernel samples.

/sys/devices/cpu/perf_allow_sample_leakage:

0 - default, drop the leaked kernel samples.
1 - don't drop the leaked kernel samples.

For rr it can write 1 to /sys/devices/cpu/perf_allow_sample_leakage to
keep original system behavior.

Jin Yao (2):
  perf/core: Use sysctl to turn on/off dropping leaked kernel samples
  perf Documentation: Introduce the sysctl perf_allow_sample_leakage

 kernel/events/core.c                     | 58 ++++++++++++++++++++++++++++++++
 tools/perf/Documentation/perf-record.txt | 14 ++++++++
 2 files changed, 72 insertions(+)

-- 
2.7.4

