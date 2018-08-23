Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C3BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA790208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA790208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388544AbeHWMhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:37:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56328 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbeHWMhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:37:50 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 27F01C9E;
        Thu, 23 Aug 2018 09:09:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, keescook@google.com,
        aarcange@redhat.com, jgross@suse.com, jpoimboe@redhat.com,
        peterz@infradead.org, hughd@google.com,
        torvalds@linux-foundation.org, bp@alien8.de, luto@kernel.org,
        ak@linux.intel.com
Subject: [PATCH 4.17 304/324] x86/mm/init: Pass unconverted symbol addresses to free_init_pages()
Date:   Thu, 23 Aug 2018 09:56:10 +0200
Message-Id: <20180823075011.277184066@linuxfoundation.org>
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

commit 9f515cdb411ef34f1aaf4c40bb0c932cf6db5de1 upstream.

The x86 code has several places where it frees parts of kernel image:

 1. Unused SMP alternative
 2. __init code
 3. The hole between text and rodata
 4. The hole between rodata and data

We call free_init_pages() to do this.  Strangely, we convert the symbol
addresses to kernel direct map addresses in some cases (#3, #4) but not
others (#1, #2).

The virt_to_page() and the other code in free_reserved_area() now works
fine for for symbol addresses on x86, so don't bother converting the
addresses to direct map addresses before freeing them.

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
Link: https://lkml.kernel.org/r/20180802225828.89B2D0E2@viggo.jf.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/init_64.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
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
 


