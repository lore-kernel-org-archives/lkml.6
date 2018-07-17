Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F75ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533C020841
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533C020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeGQBVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:21:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:28705 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbeGQBVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:21:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 17:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,363,1526367600"; 
   d="scan'208";a="72893464"
Received: from unknown (HELO yhuang6-ux31a.sh.intel.com) ([10.239.197.184])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2018 17:51:44 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 0/7] swap: THP optimizing refactoring
Date:   Tue, 17 Jul 2018 08:51:46 +0800
Message-Id: <20180717005153.29483-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on 2018-07-13 head of mmotm tree.

Now the THP (Transparent Huge Page) swap optimizing is implemented in
the way like below,

#ifdef CONFIG_THP_SWAP
huge_function(...)
{
}
#else
normal_function(...)
{
}
#endif

general_function(...)
{
	if (huge)
		return thp_function(...);
	else
		return normal_function(...);
}

As pointed out by Dave Hansen, this will,

1. Created a new, wholly untested code path for huge page
2. Created two places to patch bugs
3. Are not reusing code when possible

This patchset is to address these problems via merging huge/normal
code path/functions if possible.

One concern is that this may cause code size to dilate when
!CONFIG_TRANSPARENT_HUGEPAGE.  The data shows that most refactoring
will only cause quite slight code size increase.

Best Regards,
Huang, Ying
