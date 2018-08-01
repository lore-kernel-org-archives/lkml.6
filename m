Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686EDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29863208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29863208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbeHATr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:47:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:6229 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbeHATr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:47:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 11:01:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,432,1526367600"; 
   d="scan'208";a="61592987"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga008.jf.intel.com with ESMTP; 01 Aug 2018 11:01:04 -0700
Subject: [PATCH 2/5] mm: allow non-direct-map arguments to free_reserved_area()
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, keescook@google.com,
        tglx@linutronix.de, mingo@kernel.org, aarcange@redhat.com,
        jgross@suse.com, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, hughd@google.com,
        torvalds@linux-foundation.org, bp@alien8.de, luto@kernel.org,
        ak@linux.intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 01 Aug 2018 11:01:01 -0700
References: <20180801180058.EC46D963@viggo.jf.intel.com>
In-Reply-To: <20180801180058.EC46D963@viggo.jf.intel.com>
Message-Id: <20180801180101.2A388EF8@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

free_reserved_area() takes pointers as arguments to show which
addresses should be freed.  However, it does this in a
somewhat ambiguous way.  If it gets a kernel direct map address,
it always works.  However, if it gets an address that is
part of the kernel image alias mapping, it can fail.

It fails if all of the following happen:
 * The specified address is part of the kernel image alias
 * Poisoning is requested (forcing a memset())
 * The address is in a read-only portion of the kernel image

The memset() fails on the read-only mapping, of course.
free_reserved_area() *is* called both on the direct map and
on kernel image alias addresses.  We've just lucked out thus
far that the kernel image alias areas it gets used on are
read-write.  I'm fairly sure this has been just a happy
accident.

It is quite easy to make free_reserved_area() work for all
cases: just convert the address to a direct map address before
doing the memset(), and do this unconditionally.  There is
little chance of a regression here because we previously
did a virt_to_page() on the address for the memset, so we
know these are no highmem pages for which virt_to_page()
would fail.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
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
---

 b/mm/page_alloc.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff -puN mm/page_alloc.c~x86-mm-init-handle-non-linear-map-ranges-free_init_pages mm/page_alloc.c
--- a/mm/page_alloc.c~x86-mm-init-handle-non-linear-map-ranges-free_init_pages	2018-07-30 09:53:13.259915693 -0700
+++ b/mm/page_alloc.c	2018-07-30 09:53:13.264915693 -0700
@@ -6934,9 +6934,21 @@ unsigned long free_reserved_area(void *s
 	start = (void *)PAGE_ALIGN((unsigned long)start);
 	end = (void *)((unsigned long)end & PAGE_MASK);
 	for (pos = start; pos < end; pos += PAGE_SIZE, pages++) {
+		struct page *page = virt_to_page(pos);
+		void *direct_map_addr;
+
+		/*
+		 * 'direct_map_addr' might be different from 'pos'
+		 * because some architectures' virt_to_page()
+		 * work with aliases.  Getting the direct map
+		 * address ensures that we get a _writeable_
+		 * alias for the memset().
+		 */
+	       	direct_map_addr = page_address(page);
 		if ((unsigned int)poison <= 0xFF)
-			memset(pos, poison, PAGE_SIZE);
-		free_reserved_page(virt_to_page(pos));
+			memset(direct_map_addr, poison, PAGE_SIZE);
+
+		free_reserved_page(page);
 	}
 
 	if (pages && s)
_
