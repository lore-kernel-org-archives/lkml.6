Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92610C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521D620844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521D620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbeHATsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:48:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:1770 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbeHATsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:48:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 11:01:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,432,1526367600"; 
   d="scan'208";a="77895722"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga001.jf.intel.com with ESMTP; 01 Aug 2018 11:01:01 -0700
Subject: [PATCH 0/5] x86/mm/pti: close two Meltdown leaks with Global kernel mapping
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, keescook@google.com,
        tglx@linutronix.de, mingo@kernel.org, aarcange@redhat.com,
        jgross@suse.com, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, hughd@google.com,
        torvalds@linux-foundation.org, bp@alien8.de, luto@kernel.org,
        ak@linux.intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 01 Aug 2018 11:00:58 -0700
Message-Id: <20180801180058.EC46D963@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This applies to 4.17 and 4.18.

Thanks to Hugh Dickins for initially finding the r/w kernel text
issue and coming up with an initial fix.  I found the "unused
hole" part and came up with different approach for fixing the
mess.

--

Background:

Process Context IDentifiers (PCIDs) are a hardware feature that
allows TLB entries to survive page table switches (CR3 writes).
As an optimization, the PTI code currently allows the kernel image
to be Global when running on hardware without PCIDs.  This results
in fewer TLB misses, especially upon entry.

The downside is that these Global areas are theoretically
susceptible to Meltdown.  The logic is that there are no secrets
in the kernel image, so why pay the cost of TLB misses.

Problem:

The current PTI code leaves the entire area of the kernel binary
between '_text' and '_end' as Global (on non-PCID hardware).
However, that range contains both read-write kernel data, and two
"unused" holes in addition to text.  The areas which are not text
or read-only might contain secrets once they are freed back into
the allocator.

This issue affects systems which are susceptible to Meltdown, do not
have PCIDs and which are using the default PTI_AUTO mode (no
pti=on/off on the cmdline).

PCIDs became generally available for servers in ~2010 (Westmere)
and desktop (client) parts in roughly 2011 (Sandybridge).  This
is not expected to affect anything newer than that.

Solution:

The solution for the read-write area is to clear the global bit
for the area (patch #1).

The "unused" holes need a bit more work since we free them in a
bit of an ad-hoc way, but we fix this up in patches 2-5.

Cc: Kees Cook <keescook@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
