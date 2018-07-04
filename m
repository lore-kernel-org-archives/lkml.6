Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0F3C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E16219E7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E16219E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeGDQQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:16:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56335 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbeGDQQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:16:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w64GFwtK730807
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 4 Jul 2018 09:15:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w64GFv5U730804;
        Wed, 4 Jul 2018 09:15:57 -0700
Date:   Wed, 4 Jul 2018 09:15:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-94cc60b72f99006f6f2b9b5b7317805d6e5abddb@git.kernel.org>
Cc:     dan.j.williams@intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, rientjes@google.com,
        hpa@zytor.com, richard.weiyang@gmail.com, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
          rientjes@google.com, hpa@zytor.com, richard.weiyang@gmail.com,
          torvalds@linux-foundation.org, lkp@intel.com,
          linux-kernel@vger.kernel.org, dan.j.williams@intel.com
In-Reply-To: <153065162801.12250.4860144566061573514.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153065162801.12250.4860144566061573514.stgit@dwillia2-desk3.amr.corp.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/numa_emulation: Fix uniform size build failure
Git-Commit-ID: 94cc60b72f99006f6f2b9b5b7317805d6e5abddb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  94cc60b72f99006f6f2b9b5b7317805d6e5abddb
Gitweb:     https://git.kernel.org/tip/94cc60b72f99006f6f2b9b5b7317805d6e5abddb
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Tue, 3 Jul 2018 14:00:57 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 4 Jul 2018 18:12:20 +0200

x86/numa_emulation: Fix uniform size build failure

The calculation of a uniform numa-node size attempted to perform
division with a 64-bit diviser leading to the following failure on
32-bit:

    arch/x86/mm/numa_emulation.o: In function `split_nodes_size_interleave_uniform':
    arch/x86/mm/numa_emulation.c:239: undefined reference to `__udivdi3'

Convert the implementation to do the division in terms of pages and then
shift the result back to an absolute physical address.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org
Fixes: 93e738834fcc ("x86/numa_emulation: Introduce uniform split capability")
Link: http://lkml.kernel.org/r/153065162801.12250.4860144566061573514.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/numa_emulation.c | 10 +++++++++-
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
