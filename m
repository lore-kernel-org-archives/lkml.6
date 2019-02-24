Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72B9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0C4206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfBXPhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:37:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:49091 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfBXPhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 10:37:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2019 07:37:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,407,1544515200"; 
   d="scan'208";a="118688380"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga006.jf.intel.com with ESMTP; 24 Feb 2019 07:37:30 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 80D68300309; Sun, 24 Feb 2019 07:37:30 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com
Subject: Support sample context in perf report
Date:   Sun, 24 Feb 2019 07:37:11 -0800
Message-Id: <20190224153722.27020-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently have two ways to look at sample data in perf:
either use perf report to aggregate everything, or use
perf script to look at all individual samples.

Both ways are useful. Of course aggregation is useful
to quickly find the most expensive part of the code.

But sometimes a single sample is not good enough to
determine the problem and we need to look at context, either
through branch contexts, or other previous samples (e.g. for
correlating different micro architecture events or computing
metrics)

This can be done through perf script today, but it can
be rather cumbersome to find the right samples to look
at.

Another problem with perf report is that it aggregates
the whole measurement period. But many real workloads
have phases where they behave quite differently, and it is
often not useful to combine them into a single histogram.

While this can be worked around with the --time option
to report, it can be quite cumbersome.

This patch kit attempts to address some of these
problems in perf report by making it time aware.

- It adds a new time sort key that allows perf report
to separate samples from different regions. The time
regions can be defined with a new --time-quantum option.

- Then it extends the perf script support in the
tui record browser to allow browsing samples for 
different time regions from within a perf report
session.

- Finally it extends the report browser script display
support to automatically select sensible defaults
based on what was recorded. For example it will
automatically show branch contexts with -b.

There could be probably be done more to make
perf report even better for such use cases (e.g. a real
time line display), but this basic support is good
enough for many useful usages.

Also available in
git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git perf/streams-1

