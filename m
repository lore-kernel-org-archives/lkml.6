Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F55C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB72720844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB72720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeIHAd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:33:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:2878 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbeIHAd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:33:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 12:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,343,1531810800"; 
   d="scan'208";a="88584859"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga001.jf.intel.com with ESMTP; 07 Sep 2018 12:51:29 -0700
Subject: [RFC][PATCH 4/8] x86/mm: add clarifying comments for user addr space
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        sean.j.christopherson@intel.com, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, luto@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 07 Sep 2018 12:48:58 -0700
References: <20180907194852.3C351B82@viggo.jf.intel.com>
In-Reply-To: <20180907194852.3C351B82@viggo.jf.intel.com>
Message-Id: <20180907194858.FD74A39F@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The SMAP and Reserved checking do not have nice comments.  Add
some to clarify and make it match everything else.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
---

 b/arch/x86/mm/fault.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN arch/x86/mm/fault.c~pkeys-fault-warnings-02 arch/x86/mm/fault.c
--- a/arch/x86/mm/fault.c~pkeys-fault-warnings-02	2018-09-07 11:21:47.182751900 -0700
+++ b/arch/x86/mm/fault.c	2018-09-07 11:21:47.185751900 -0700
@@ -1274,9 +1274,17 @@ void do_user_addr_space_fault(struct pt_
 	if (unlikely(kprobes_fault(regs)))
 		return;
 
+	/*
+	 * Reserved bits are never expected to be set on
+	 * entries in the user portion of the page tables.
+	 */
 	if (unlikely(hw_error_code & X86_PF_RSVD))
 		pgtable_bad(regs, hw_error_code, address);
 
+	/*
+	 * Check for invalid kernel (supervisor) access to user
+	 * pages in the user address space.
+	 */
 	if (unlikely(smap_violation(hw_error_code, regs))) {
 		bad_area_nosemaphore(regs, hw_error_code, address, NULL);
 		return;
_
