Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB99FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F47208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F47208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbeHATsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:48:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:58990 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731955AbeHATsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:48:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 11:01:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,432,1526367600"; 
   d="scan'208";a="61270676"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga007.jf.intel.com with ESMTP; 01 Aug 2018 11:01:06 -0700
Subject: [PATCH 3/5] x86/mm/init: pass unconverted symbol addresses to free_init_pages()
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, keescook@google.com,
        tglx@linutronix.de, mingo@kernel.org, aarcange@redhat.com,
        jgross@suse.com, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, hughd@google.com,
        torvalds@linux-foundation.org, bp@alien8.de, luto@kernel.org,
        ak@linux.intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 01 Aug 2018 11:01:02 -0700
References: <20180801180058.EC46D963@viggo.jf.intel.com>
In-Reply-To: <20180801180058.EC46D963@viggo.jf.intel.com>
Message-Id: <20180801180102.9B58A341@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The x86 code has several places where it frees parts of kernel image:

 1. Unused SMP alternative
 2. __init code
 3. The hole between text and rodata
 4. The hole between rodata and data

We call free_init_pages() to do this.  Strangely, we convert the
symbol addresses to kernel direct map addresses in some cases
(#3, #4) but not others (#1, #2).

The virt_to_page() and the other code in free_reserved_area() now
works fine for for symbol addresses on x86, so don't bother
converting the addresses to direct map addresses before freeing
them.

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

 b/arch/x86/mm/init_64.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff -puN arch/x86/mm/init_64.c~x86-init-do-not-convert-symbol-addresses arch/x86/mm/init_64.c
--- a/arch/x86/mm/init_64.c~x86-init-do-not-convert-symbol-addresses	2018-07-30 09:53:13.778915692 -0700
+++ b/arch/x86/mm/init_64.c	2018-07-30 09:53:13.782915692 -0700
@@ -1283,12 +1283,8 @@ void mark_rodata_ro(void)
 	set_memory_ro(start, (end-start) >> PAGE_SHIFT);
 #endif
 
-	free_init_pages("unused kernel",
-			(unsigned long) __va(__pa_symbol(text_end)),
-			(unsigned long) __va(__pa_symbol(rodata_start)));
-	free_init_pages("unused kernel",
-			(unsigned long) __va(__pa_symbol(rodata_end)),
-			(unsigned long) __va(__pa_symbol(_sdata)));
+	free_init_pages("unused kernel", text_end, rodata_start);
+	free_init_pages("unused kernel", rodata_end, _sdata);
 
 	debug_checkwx();
 
_
