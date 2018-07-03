Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A565C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CA52475E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1CA52475E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753203AbeGCVK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:10:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:23019 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752960AbeGCVKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:10:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 14:10:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,305,1526367600"; 
   d="scan'208";a="242390613"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jul 2018 14:10:54 -0700
Subject: [PATCH] x86/numa_emulation: Fix uniform size build failure
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@kernel.org
Cc:     David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        kbuild test robot <lkp@intel.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 03 Jul 2018 14:00:57 -0700
Message-ID: <153065162801.12250.4860144566061573514.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The calculation of a uniform numa-node size attempted to perform
division with a 64-bit diviser leading to the following failure on
32-bit:

    arch/x86/mm/numa_emulation.o: In function `split_nodes_size_interleave_uniform':
    arch/x86/mm/numa_emulation.c:239: undefined reference to `__udivdi3'

Convert the implementation to do the division in terms of pages and then
shift the result back to an absolute physical address.

Fixes: 93e738834fcc ("x86/numa_emulation: Introduce uniform split capability")
Cc: David Rientjes <rientjes@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Yang <richard.weiyang@gmail.com>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

    Applies to tip/x86/cpu for 4.19.

 arch/x86/mm/numa_emulation.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 039db00541b7..cc7523e45926 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -198,6 +198,14 @@ static u64 __init find_end_of_node(u64 start, u64 max_addr, u64 size)
 	return end;
 }
 
+static u64 uniform_size(u64 max_addr, u64 base, int nr_nodes)
+{
+	unsigned long max_pfn = PHYS_PFN(max_addr);
+	unsigned long base_pfn = PHYS_PFN(base);
+
+	return PFN_PHYS((max_pfn - base_pfn) / nr_nodes);
+}
+
 /*
  * Sets up fake nodes of `size' interleaved over physical nodes ranging from
  * `addr' to `max_addr'.
@@ -236,7 +244,7 @@ static int __init split_nodes_size_interleave_uniform(struct numa_meminfo *ei,
 	}
 
 	if (uniform) {
-		min_size = (max_addr - addr) / nr_nodes;
+		min_size = uniform_size(max_addr, addr, nr_nodes);
 		size = min_size;
 	} else {
 		/*

