Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5927FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B6D21571
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B6D21571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbeHCAvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:51:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:37019 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731697AbeHCAvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:51:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 15:58:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="61641442"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga007.jf.intel.com with ESMTP; 02 Aug 2018 15:58:35 -0700
Subject: [PATCH 2/7] mm: allow non-direct-map arguments to free_reserved_area()
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, keescook@google.com,
        tglx@linutronix.de, mingo@kernel.org, aarcange@redhat.com,
        jgross@suse.com, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, hughd@google.com,
        torvalds@linux-foundation.org, bp@alien8.de, luto@kernel.org,
        ak@linux.intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 02 Aug 2018 15:58:26 -0700
References: <20180802225823.4711C55B@viggo.jf.intel.com>
In-Reply-To: <20180802225823.4711C55B@viggo.jf.intel.com>
Message-Id: <20180802225826.1287AE3E@viggo.jf.intel.com>
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
--- a/mm/page_alloc.c~x86-mm-init-handle-non-linear-map-ranges-free_init_pages	2018-08-02 14:14:47.860483278 -0700
+++ b/mm/page_alloc.c	2018-08-02 14:14:47.865483278 -0700
@@ -6939,9 +6939,21 @@ unsigned long free_reserved_area(void *s
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
