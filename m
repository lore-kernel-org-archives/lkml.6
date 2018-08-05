Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F9EC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE2B21991
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE2B21991
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeHEWiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:38:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34435 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbeHEWiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:38:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w75KVNOG590190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 5 Aug 2018 13:31:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w75KVN4t590187;
        Sun, 5 Aug 2018 13:31:23 -0700
Date:   Sun, 5 Aug 2018 13:31:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-0d83432811f26871295a9bc24d3c387924da6071@git.kernel.org>
Cc:     luto@kernel.org, hughd@google.com, hpa@zytor.com, bp@alien8.de,
        aarcange@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, mingo@kernel.org, dave.hansen@linux.intel.com,
        jgross@suse.com, keescook@google.com
Reply-To: hughd@google.com, luto@kernel.org, gregkh@linuxfoundation.org,
          tglx@linutronix.de, jpoimboe@redhat.com,
          torvalds@linux-foundation.org, peterz@infradead.org,
          bp@alien8.de, aarcange@redhat.com, hpa@zytor.com,
          ak@linux.intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, keescook@google.com, jgross@suse.com,
          dave.hansen@linux.intel.com
In-Reply-To: <20180802225826.1287AE3E@viggo.jf.intel.com>
References: <20180802225826.1287AE3E@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] mm: Allow non-direct-map arguments to
 free_reserved_area()
Git-Commit-ID: 0d83432811f26871295a9bc24d3c387924da6071
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

Commit-ID:  0d83432811f26871295a9bc24d3c387924da6071
Gitweb:     https://git.kernel.org/tip/0d83432811f26871295a9bc24d3c387924da6071
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Thu, 2 Aug 2018 15:58:26 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 5 Aug 2018 22:21:02 +0200

mm: Allow non-direct-map arguments to free_reserved_area()

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

---
 mm/page_alloc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a790ef4be74e..3222193c46c6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6939,9 +6939,21 @@ unsigned long free_reserved_area(void *start, void *end, int poison, char *s)
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
