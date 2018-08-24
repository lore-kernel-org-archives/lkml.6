Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0034FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11542064E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw6bDEBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11542064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeHXV6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 17:58:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43088 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeHXV6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 17:58:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id x6-v6so1425569plv.10;
        Fri, 24 Aug 2018 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LKjL7Uum9lg+ahAgM/gAx1+JH37Bdv6fdw/kIZU8xa0=;
        b=fw6bDEBtKBKedL4rkCuShpiMS/v1EAjBsWD7fcgu17jkRHcBbIAhnSF/R6cu2OxU8T
         u3xI23DXTwWkAkSKXcKT+TkX7EjdTofwGQ4bbrE0+YHd6M5RSEQq87xC5YkizCgGDte4
         foMe6xnMGmnJh/Qc2xCVP5ooftlg/Qc2VydYqXaKWFfpTaRUmmt3SPoZ2b4Vjt+C5gfS
         MtAMfPIIfJoNeVnZmAEB6uUuMY6bc+pPaEbrUGldzqRY6qEAYJSNyecjolY16yXmojdU
         kgMnd0B8Z+/9hRJrg2IRtydisp1DtyBV116eRQAcb3RF88R8Nq+hsLglZHOyo5xvZLVp
         M8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LKjL7Uum9lg+ahAgM/gAx1+JH37Bdv6fdw/kIZU8xa0=;
        b=guAOPt+iO32/+yVu+Y1Ex2mUDQGl2eriFZoetBNq8KDcxso7hcuujAPqvxZPo6x275
         t32C/TPedPRig16kEVW3qQhBLYG25q3gfS228qKCxVsG+r49YJIMqf9n0TTUIVj+uRYF
         cPgXAUiJDc/R7iITaEg2jv6INjD3ggnTKk/45RPsknbTCSeFp2T43+7ziGfAQ33wmjEC
         PL0y3y+moqJ9UtkJIlsiZJumZItwN9UUK8qsWcQSBYKi/gcprHyI5P4L+4usFlhEDwk6
         +Fg0GN4YP/XSH11kSAHnvtuU7jBC2ExZNAot+r0nxrHNoxxc2geAmhBSUiyL8qRtBBa2
         iCRw==
X-Gm-Message-State: APzg51Bn9hNb3cRNa5GygC0bJ0tQ1Gx8waIsGq8ogKv0Mb2Wfh1hkdM9
        l3ORE7zkbTJY3PSU/WVSMU8=
X-Google-Smtp-Source: ANB0VdbHS0yKIuUYtg2qxC8TU0cHWF26yxfl1JatZ8T5rbJjNyrSNFZUNnhTpIctlbgsksG9l7OD4A==
X-Received: by 2002:a17:902:74ca:: with SMTP id f10-v6mr2737461plt.260.1535134981090;
        Fri, 24 Aug 2018 11:23:01 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c1-v6sm15650102pfg.25.2018.08.24.11.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 11:23:00 -0700 (PDT)
Date:   Fri, 24 Aug 2018 11:22:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, riel@surriel.com, jannh@google.com,
        ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH 2/2] mm: mmu_notifier fix for tlb_end_vma (build
 failures)
Message-ID: <20180824182259.GA18477@roeck-us.net>
References: <20180823084709.19717-1-npiggin@gmail.com>
 <20180823084709.19717-3-npiggin@gmail.com>
 <20180824130722.GA31409@roeck-us.net>
 <20180824131026.GB11868@brain-police>
 <20180824132419.GA9983@roeck-us.net>
 <20180824133427.GC11868@brain-police>
 <20180824135048.GF11868@brain-police>
 <7d0111f4-c369-43a8-72c6-1a7390cdebdd@roeck-us.net>
 <20180824142532.GG11868@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824142532.GG11868@brain-police>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 03:25:33PM +0100, Will Deacon wrote:
> On Fri, Aug 24, 2018 at 07:06:51AM -0700, Guenter Roeck wrote:
> > On 08/24/2018 06:50 AM, Will Deacon wrote:
> > 
> > >>-#include <asm-generic/tlb.h>
> > >>+struct mmu_gather;
> > >>  static inline void tlb_flush(struct mmu_gather *tlb)
> > >>  {
> > >>  	flush_tlb_mm(tlb->mm);
> > >
> > >Bah, didn't spot the dereference so this won't work either. You basically
> > >just need to copy what I did for arm64 in d475fac95779.
> > >
> > 
> > Yes, this seems to work. It doesn't really need "struct mmu_gather;" -
> > I assume that is included from elsewhere - but I added it to be safe.
> 
> struct mmu_gather comes in via asm-generic/tlb.h.
> 
From linux/mm.h, really, which happens to be included before
asm/tlb.h is included (see arch/riscv/include/asm/pgalloc.h).
I kept it to be future-proof.

> > Can you send a full patch, or do you want me to do it ?
> 
> I'm evidently incapable of writing code today, so please go ahead :)
> 
Done. We'll see if I am any better.

Guenter
