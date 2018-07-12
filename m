Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF808ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65E121486
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65E121486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387714AbeGLXse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:48:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:37430 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387610AbeGLXse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:48:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 16:36:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,345,1526367600"; 
   d="scan'208";a="57272226"
Received: from yongjuns-mobl2.ccr.corp.intel.com (HELO yhuang6-ux31a.ccr.corp.intel.com) ([10.254.213.67])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2018 16:36:41 -0700
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
Subject: [PATCH 0/6] swap: THP optimizing refactoring
Date:   Fri, 13 Jul 2018 07:36:30 +0800
Message-Id: <20180712233636.20629-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on 2018-07-10 head of mmotm tree.

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
