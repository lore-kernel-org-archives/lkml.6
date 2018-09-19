Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7002C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17134206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17134206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbeITCkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:40:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:60272 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbeITCkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:40:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 14:01:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,395,1531810800"; 
   d="scan'208";a="71344731"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by fmsmga007.fm.intel.com with ESMTP; 19 Sep 2018 14:01:01 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 0/7] mm: faster get user pages
Date:   Wed, 19 Sep 2018 15:02:43 -0600
Message-Id: <20180919210250.28858-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinning user pages out of nvdimm dax memory is significantly slower
compared to system ram. Analysis points to software overhead incurred
from a radix tree lookup. This patch series fixes that by removing the
relatively costly dev_pagemap lookup that was repeated for each page,
significantly increasing gup time.

The first 5 patches are just updating the benchmark to help test and
demonstrate the value of the last 2 patches.

The results were compared with following benchmark command for device
DAX memory:

  # gup_benchmark -m $((12*1024)) -n 512 -L -f /dev/dax0.0

  Before: 1037581 usec
  After:   375786 usec

Not bad; the after is the same time as using baseline anonymous system
RAM after this patch set, where before was nearly 3x longer.

Keith Busch (7):
  mm/gup_benchmark: Time put_page
  mm/gup_benchmark: Add additional pinning methods
  tools/gup_benchmark: Fix 'write' flag usage
  tools/gup_benchmark: Allow user specified file
  tools/gup_benchmark: Add parameter for hugetlb
  mm/gup: Combine parameters into struct
  mm/gup: Cache dev_pagemap while pinning pages

 include/linux/huge_mm.h                    |  12 +-
 include/linux/hugetlb.h                    |   2 +-
 include/linux/mm.h                         |  27 ++-
 mm/gup.c                                   | 279 ++++++++++++++---------------
 mm/gup_benchmark.c                         |  36 +++-
 mm/huge_memory.c                           |  67 ++++---
 mm/nommu.c                                 |   6 +-
 tools/testing/selftests/vm/gup_benchmark.c |  40 ++++-
 8 files changed, 262 insertions(+), 207 deletions(-)

-- 
2.14.4

