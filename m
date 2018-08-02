Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F034BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14FB21571
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14FB21571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbeHCAwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:52:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:44452 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbeHCAwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:52:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 15:58:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="59287685"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga007.fm.intel.com with ESMTP; 02 Aug 2018 15:58:43 -0700
Subject: [PATCH 7/7] x86/mm/pageattr: Remove implicit NX behavior
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, keescook@google.com,
        tglx@linutronix.de, mingo@kernel.org, aarcange@redhat.com,
        jgross@suse.com, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, hughd@google.com,
        torvalds@linux-foundation.org, bp@alien8.de, luto@kernel.org,
        ak@linux.intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 02 Aug 2018 15:58:35 -0700
References: <20180802225823.4711C55B@viggo.jf.intel.com>
In-Reply-To: <20180802225823.4711C55B@viggo.jf.intel.com>
Message-Id: <20180802225835.2A460569@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

This is a cleanup.  There should be functional changes in this patch.

The pageattr code has the ability to find and change aliases
mappings.  It does this for requests by default unless the
page protections being modified contain only the NX bit.

But, this behavior is rather obscure and buried very deep
within the infrastructure.  Rather than doing it implicitly
from NX, use the new CPA_NO_CHECK_ALIAS to do it more
explicitly from the call site where NX is set.

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

 b/arch/x86/mm/pageattr.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff -puN arch/x86/mm/pageattr.c~x86-pageattr-nx arch/x86/mm/pageattr.c
--- a/arch/x86/mm/pageattr.c~x86-pageattr-nx	2018-08-02 15:04:48.032475796 -0700
+++ b/arch/x86/mm/pageattr.c	2018-08-02 15:04:48.036475796 -0700
@@ -1485,8 +1485,6 @@ static int change_page_attr_set_clr(unsi
 	if (in_flag & (CPA_ARRAY | CPA_PAGES_ARRAY))
 		cpa.flags |= in_flag;
 
-	/* No alias checking for _NX bit modifications */
-	checkalias = (pgprot_val(mask_set) | pgprot_val(mask_clr)) != _PAGE_NX;
 	/* Never check aliases if the caller asks for it explicitly: */
 	if (checkalias && (in_flag & CPA_NO_CHECK_ALIAS))
 		checkalias = 0;
@@ -1750,7 +1748,9 @@ int set_memory_x(unsigned long addr, int
 	if (!(__supported_pte_mask & _PAGE_NX))
 		return 0;
 
-	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_NX), 0);
+	/* NX is not required to be consistent across aliases. */
+	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_NX),
+				      CPA_NO_CHECK_ALIAS);
 }
 EXPORT_SYMBOL(set_memory_x);
 
@@ -1759,7 +1759,9 @@ int set_memory_nx(unsigned long addr, in
 	if (!(__supported_pte_mask & _PAGE_NX))
 		return 0;
 
-	return change_page_attr_set(&addr, numpages, __pgprot(_PAGE_NX), 0);
+	/* NX is not required to be consistent across aliases. */
+	return change_page_attr_set(&addr, numpages, __pgprot(_PAGE_NX),
+				    CPA_NO_CHECK_ALIAS);
 }
 EXPORT_SYMBOL(set_memory_nx);
 
_
