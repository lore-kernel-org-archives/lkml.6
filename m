Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8786DC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF5F21765
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF5F21765
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeHUEec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 00:34:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:17761 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725733AbeHUEec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 00:34:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 18:16:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,267,1531810800"; 
   d="scan'208";a="74359128"
Received: from shbuild000.sh.intel.com (HELO byang_ol.sh.intel.com) ([10.239.144.215])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2018 18:16:34 -0700
From:   Bin Yang <bin.yang@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        dave.hansen@intel.com, mark.gross@intel.com, bin.yang@intel.com
Subject: [PATCH v3 0/5] x86/mm: fix cpu stuck issue in __change_page_attr_set_clr
Date:   Tue, 21 Aug 2018 01:16:21 +0000
Message-Id: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


One problem is found when optimizing the x86 kernel boot time, that sometimes
the free_initmem() will take about 600ms, which is way too much for fast boot.

When changing a 4K page attr inside the large page range,
__change_page_attr() will call try_preserve_large_page() to decide
to split the big page or not. And try_preserve_large_page() will
call static_protections() to check all 4K pages inside the large page
range one by one.

free_initmem()  <-- free N pages
  free_init_pages()
    set_memory_rw()
      change_page_attr_set()
        change_page_attr_set_clr()
	  __change_page_attr_set_clr()
	    __change_page_attr() <-- loop N times
	      try_preserve_large_page()
                static_protections() <-- worst case: loop (1G/4K = 262144) * N times

The problem is,  most of the  256K * N  times of call of static_proetections()
is _not_ necessary at all, as pointed out by Thomas Gleixner :

"The current code does the static_protection() check loop _before_ checking:

  1) Whether the new and the old pgprot are the same
  
  2) Whether the address range which needs to be changed is aligned to and
     covers the full large mapping

It does the static_protections() loop before #1 and #2 which can be
optimized."

The static_protections() check loop can be optimized to check for overlapping
ranges and then check explicitly for those without any looping.

Here are 5 patches for these optimizations:

Patch 1: check whether new pgprot is same as old pgprot first to avoid
	 unnecessary static_protection() checking.

Patch 2: check whether it is whole large page attr change first to avoid
	 unnecessary static_protection() checking.

Patch 3: add help function to check specific protection flags in range

Patch 4: Optimize the static_protection() by using overlap() check instead
	 of within()

Patch 5: Add a check for catching a case where the existing mapping is wrong
	 already

The approach and some of the comments came from Thomas's email example for how
to do this. Thanks again for Thomas's kind help.

Thanks,
Bin

Bin Yang (5):
  x86/mm: avoid redundant checking if pgprot has no change
  x86/mm: avoid static_protection() checking if not whole large page
    attr change
  x86/mm: add help function to check specific protection flags in range
  x86/mm: optimize static_protection() by using overlap()
  x86/mm: add WARN_ON_ONCE() for wrong large page mapping

 arch/x86/mm/pageattr.c | 127 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 86 insertions(+), 41 deletions(-)

-- 
2.7.4

