Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD28EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791E6208EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791E6208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbeHWMhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:37:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56306 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbeHWMhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:37:47 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 05F8BBBF;
        Thu, 23 Aug 2018 09:09:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, keescook@google.com,
        aarcange@redhat.com, jgross@suse.com, jpoimboe@redhat.com,
        peterz@infradead.org, hughd@google.com,
        torvalds@linux-foundation.org, bp@alien8.de, luto@kernel.org,
        ak@linux.intel.com
Subject: [PATCH 4.17 303/324] mm: Allow non-direct-map arguments to free_reserved_area()
Date:   Thu, 23 Aug 2018 09:56:09 +0200
Message-Id: <20180823075011.230793746@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

commit 0d83432811f26871295a9bc24d3c387924da6071 upstream.

free_reserved_area() takes pointers as arguments to show which addresses
should be freed.  However, it does this in a somewhat ambiguous way.  If it
gets a kernel direct map address, it always works.  However, if it gets an
address that is part of the kernel image alias mapping, it can fail.

It fails if all of the following happen:
 * The specified address is part of the kernel image alias
 * Poisoning is requested (forcing a memset())
 * The address is in a read-only portion of the kernel image

The memset() fails on the read-only mapping, of course.
free_reserved_area() *is* called both on the direct map and on kernel image
alias addresses.  We've just lucked out thus far that the kernel image
alias areas it gets used on are read-write.  I'm fairly sure this has been
just a happy accident.

It is quite easy to make free_reserved_area() work for all cases: just
convert the address to a direct map address before doing the memset(), and
do this unconditionally.  There is little chance of a regression here
because we previously did a virt_to_page() on the address for the memset,
so we know these are not highmem pages for which virt_to_page() would fail.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: keescook@google.com
Cc: aarcange@redhat.com
Cc: jgross@suse.com
Cc: jpoimboe@redhat.com
Cc: gregkh@linuxfoundation.org
Cc: peterz@infradead.org
Cc: hughd@google.com
Cc: torvalds@linux-foundation.org
Cc: bp@alien8.de
Cc: luto@kernel.org
Cc: ak@linux.intel.com
Cc: Kees Cook <keescook@google.com>
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
Link: https://lkml.kernel.org/r/20180802225826.1287AE3E@viggo.jf.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/page_alloc.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6933,9 +6933,21 @@ unsigned long free_reserved_area(void *s
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
+		direct_map_addr = page_address(page);
 		if ((unsigned int)poison <= 0xFF)
-			memset(pos, poison, PAGE_SIZE);
-		free_reserved_page(virt_to_page(pos));
+			memset(direct_map_addr, poison, PAGE_SIZE);
+
+		free_reserved_page(page);
 	}
 
 	if (pages && s)


