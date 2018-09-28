Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31953C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D1E20666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D1E20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbeI1Wdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:33:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:8612 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbeI1Wdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:33:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 09:09:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,315,1534834800"; 
   d="scan'208";a="76900409"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga007.jf.intel.com with ESMTP; 28 Sep 2018 09:06:02 -0700
Subject: [PATCH 0/8] [v2] x86/mm: page fault handling cleanups
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        sean.j.christopherson@intel.com, peterz@infradead.org,
        tglx@linutronix.de, luto@kernel.org, jannh@google.com,
        x86@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 28 Sep 2018 09:02:19 -0700
Message-Id: <20180928160219.3402F0AA@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:
 * Take "space_" out of do_kern/user_addr_fault()
 * Make "bad fault" comment in do_kern_addr_fault() less scary
 * Add clarifying comment for the conditions under which 
   do_kern_addr_fault() is called.
 * Remove mention of hw_error_code in search_exception_tables()
   comment.
 * Clarify that the exception tables spell out individual
   instructions, not larger sections of code.
 * Use PAGE_MASK in is_vsyscall_vaddr()
 * Add some additional reasoning behind the code move when
   moving the vsyscall handling to user address space handler
 * Remove hard-coded ~0xfff and replace with PAGE_MASK

---

I went trying to clean up the spurious protection key checks.
But, I got distracted by some other warts in the code.  I hope this
makes things more comprehendable with some improved structure,
commenting and naming.

We come out the other side of it with a new warning in for pkey
faults in the kernel portion of the address space, and removal
of some dead pkeys code, but no other functional changes.

There is a potential impact from moving the vsyscall emulation.
But, this does pass the x86 selftests without any fuss.

Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: x86@kernel.org
