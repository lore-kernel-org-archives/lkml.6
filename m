Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE04C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5ED20989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfBYFwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 00:52:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:8861 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbfBYFwD (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 00:52:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2019 21:52:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,410,1544515200"; 
   d="scan'208";a="149671598"
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2019 21:52:00 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 0/3] perf diff: Add new filter options
Date:   Mon, 25 Feb 2019 21:42:41 +0800
Message-Id: <1551102164-3443-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series creates following new filter options for perf diff.

--time:
    It supports time percent with multipe time ranges. Time string is
    'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.

    For example:

    Select the second 10% time slice to diff:
    perf diff --time 10%/2

    Select from 0% to 10% time slice to diff:
    perf diff --time 0%-10%

    Select the first and the second 10% time slices to diff:
    perf diff --time 10%/1,10%/2

    Select from 0% to 10% and 30% to 40% slices to diff:
    perf diff --time 0%-10%,30%-40%

    It also supports to analyze samples within given time window as:
    <start>,<stop>. Times have the format seconds.microseconds. If start
    is not given (i.e., time string is ',x.y') then analysis starts at
    the beginning of the file. If stop time is not given (i.e, time
    string is 'x.y,') then analysis goes to end of file. Time string is
    'a1.b1,c1.d1:a2.b2,c2.d2'. Use ':' to separate timestamps for different
    perf.data files.

    For example, we get the timestamp information from perf script.

    perf script -i perf.data.old
      mgen 13940 [000]  3946.361400: ...

    perf script -i perf.data
      mgen 13940 [000]  3971.150589 ...

    perf diff --time 3946.361400,:3971.150589,

    It analyzes the perf.data.old from the timestamp 3946.361400 to
    the end of perf.data.old and analyzes the perf.data from the
    timestamp 3971.150589 to the end of perf.data.

--cpu:
    Only diff samples for the list of CPUs provided. Multiple CPUs can
    be provided as a comma-separated list with no space: 0,1. Ranges of
    CPUs are specified with -: 0-2. Default is to report samples on all
    CPUs.

    For example:
    perf diff --cpu 0,1

    It only diff the samples for CPU0 and CPU1.

--pid:
    Only diff samples for given process ID (comma separated list).

--tid:
    Only diff samples for given thread ID (comma separated list).

    For example,
    perf diff --tid 13965

    It only diff the samples for thread 13965.

Jin Yao (3):
  perf diff: Support --time filter option
  perf diff: Support --cpu filter option
  perf diff: Support --pid/--tid filter options

 tools/perf/Documentation/perf-diff.txt |  52 ++++++++++
 tools/perf/builtin-diff.c              | 174 ++++++++++++++++++++++++++++++---
 2 files changed, 213 insertions(+), 13 deletions(-)

-- 
2.7.4

