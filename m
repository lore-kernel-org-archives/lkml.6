Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A856C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F6D20684
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F6D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbeI1Waj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:30:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:3595 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbeI1Wai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:30:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 09:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,315,1534834800"; 
   d="scan'208";a="90428787"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga002.fm.intel.com with ESMTP; 28 Sep 2018 09:06:08 -0700
Subject: [PATCH 4/8] x86/mm: add clarifying comments for user addr space
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        sean.j.christopherson@intel.com, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, luto@kernel.org,
        jannh@google.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 28 Sep 2018 09:02:25 -0700
References: <20180928160219.3402F0AA@viggo.jf.intel.com>
In-Reply-To: <20180928160219.3402F0AA@viggo.jf.intel.com>
Message-Id: <20180928160225.FFD44B8D@viggo.jf.intel.com>
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
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
---

 b/arch/x86/mm/fault.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN arch/x86/mm/fault.c~pkeys-fault-warnings-02 arch/x86/mm/fault.c
--- a/arch/x86/mm/fault.c~pkeys-fault-warnings-02	2018-09-27 10:17:22.992343568 -0700
+++ b/arch/x86/mm/fault.c	2018-09-27 10:17:22.996343568 -0700
@@ -1278,9 +1278,17 @@ void do_user_addr_fault(struct pt_regs *
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
