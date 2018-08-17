Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFD1C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6936021A2D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SVi9Lp4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6936021A2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeHQTSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:18:01 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35533 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeHQTSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:18:01 -0400
Received: by mail-io0-f193.google.com with SMTP id w11-v6so7348677iob.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oa4cmjPQrZKTFjTXonq05ZB4+IBYrLhNjc4Bp42udZI=;
        b=SVi9Lp4nva62/9UBisiRPtG99QCZlfieTpEgrokWZGFLf5eHxFiunagkQuR8wHFEGp
         OSGbJwV1CnAxGyXRNx47WkPUBg06zFV2JNMSHnpGHfodtAFGPjafS7RKd+PfP92Hx9cb
         rlY6LwOkfgqeSyY9J2hbBM8jNx47XAB6V3fFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oa4cmjPQrZKTFjTXonq05ZB4+IBYrLhNjc4Bp42udZI=;
        b=lBUgdQi6dBOkNQbI/QZtm8HjybW/tvzHv56Q9pG/nZLaUUy7roXuGXZ2ff2bLwp7hI
         rwSOOMYAzQBV7qIAKLyIwBMHHUSRlg2gUA6N0qk4u3hmK/30dmrIPc+X7b2wqv35jxDV
         r/1GjiLHTP5BNOTl6B+Z0t7+rx/FHQAUCiTmOYVQdxNiQtE/ddvuDam4gCp7VdrHD9FN
         pu/Wa/h0VcF0wZX72fg0u/PfFtFoHrzmfgvf0qOhP/c57lA0c9REbRbFXWjTsBbOa4rb
         K7+CxVJiyVQTx+O+CFa0dnhopeDW1l2g2q1DY3sLvvOceRgG0dVqjohNRh+bqw/dTJ3t
         fCLg==
X-Gm-Message-State: AOUpUlHOZvYG51eQIuvIYbxuCb0tUjI6WtVEG3zJ+bnnJwB1nxcb0UJX
        V/oeKTuTJaeN9iayZDBZcZ4L+7sYlOuc5iLjAfk=
X-Google-Smtp-Source: AA+uWPzsHNrflpHc2NcFqlv5n1DR3W4rqY54dldKIibNhrxy4DsjsJdb9mrD3zyVcG7Vwln1OyLLLuVyL6qrRjoe9Gk=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr13713887ioh.259.1534522443366;
 Fri, 17 Aug 2018 09:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180816204638.4046-1-sean.j.christopherson@intel.com>
In-Reply-To: <20180816204638.4046-1-sean.j.christopherson@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Aug 2018 09:13:51 -0700
Message-ID: <CA+55aFweC_ja8pLOHv2dbokChaJej2bhhDyeO5ZxiQ+64C-Xog@mail.gmail.com>
Subject: Re: [PATCH] x86/speculation/l1tf: Exempt zeroed PTEs from XOR conversion
To:     sean.j.christopherson@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 1:47 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Fixes: 6b28baca9b1f ("x86/speculation/l1tf: Protect PROT_NONE PTEs against speculation")

This seems wrong.

That commit doesn't invert a cleared page table entry, because that
commit still required _PAGE_PROTNONE being set for a pte to be
inverted.

I'm assuming the real culprit is commit f22cc87f6c1f
("x86/speculation/l1tf: Invert all not present mappings") which made
it look at _just_ the present bit.

And yeah, that was wrong.

So I really think a much better patch would be the appended one-liner.

Note - it's whitespace-damaged by cut-and-paste, but it should be
obvious enough to apply by hand.

Can you test this one instead?

             Linus
---

 arch/x86/include/asm/pgtable-invert.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable-invert.h
b/arch/x86/include/asm/pgtable-invert.h
index 44b1203ece12..821438e91b77 100644
--- a/arch/x86/include/asm/pgtable-invert.h
+++ b/arch/x86/include/asm/pgtable-invert.h
@@ -6,7 +6,7 @@

 static inline bool __pte_needs_invert(u64 val)
 {
-       return !(val & _PAGE_PRESENT);
+       return val && !(val & _PAGE_PRESENT);
 }

 /* Get a mask to xor with the page table entry to get the correct pfn. */
