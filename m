Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4162EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A760206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="si2bkdMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBUOVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:21:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42750 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfBUOVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:21:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id b2so8030117pgl.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iI1RJ0SSXxDh0vlZLQrOFO/u2FUJ4ENpS3Ludw9bPw8=;
        b=si2bkdMJebBvPM0GwIvEO3/Amyao38zKAiijR3TpjprMmoqFKum3Njget2unbrFOug
         Ga5QS8HL9rNhN0+nYuT7Z1Uu30vuTxz/7QrYSi00fO0cXe2GxPw1/zwMWmVyWJcYa23o
         f+J45gf8vblmxl80YXo1DP1ukP8rOkDYFLlVRZ93Vepj3O8V/WlhKysqFYJtQLEkXXvu
         Oh7ZRasJOIPvqvl9oLSXVqrMRxLiDcJW4Jr6wY7G8ezbvntovYIWEP4ik7Idb5ominp4
         8zG9C/Wqm3T7mqY/Z7xn00SZ3SrtBhrBwMG6aS/sCofVD/oqCyNYjTc3pB0OZzOpXqXf
         7Dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iI1RJ0SSXxDh0vlZLQrOFO/u2FUJ4ENpS3Ludw9bPw8=;
        b=BHU0G4dXYJGqyzDcf5VYe2lY/wRQk6wQPwpmVcifsmw2GjK9I7zI5s29AXU7l08PHK
         qfxaQ3FvZC8DFJR8HPlUtLZ4Dt64inrYnVdRj7JrfeIo1APVRQaSnGQ0Jyxx9aSVKH2a
         cyeLFcaksy5iMP8vPxSURRrrlU69+shuArBop0we1GRyRabGY5X0fHZM/g6XmukPtDjd
         Fwg/YZWay9fn+hegFWbL/Qoi0HS+IHS52CWUhwoMrUd0To2CBr5HiJFueKMUUwU9OUWL
         QLju/KdCHHWnBMLvKTBD4gRU4dD72lCcTlWUR7kBQYkLEmyz0sXBUvlDPm45KmeC5J8y
         jk9w==
X-Gm-Message-State: AHQUAuZGoKWpnPMaMk+1fB6R8BJYTi5YDI+p+DrJ6XZcY16w9d+Hs+4r
        vEy8WoC8XszMJwlD4ZwR6mQNrw==
X-Google-Smtp-Source: AHgI3IZIRxhWmHk+uI4fyRE/obuhbmXUG2L9nLu0JhpIBnQ04LtmbdtCF/YGn8UplGAT9XruNQ0UOA==
X-Received: by 2002:a63:68c9:: with SMTP id d192mr35656895pgc.264.1550758891142;
        Thu, 21 Feb 2019 06:21:31 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id o2sm31440498pfa.76.2019.02.21.06.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 06:21:30 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 662E6301708; Thu, 21 Feb 2019 17:21:26 +0300 (+03)
Date:   Thu, 21 Feb 2019 17:21:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v2 02/13] x86/mm: Add p?d_large() definitions
Message-ID: <20190221142126.k54vqaacrc2ekeff@kshutemo-mobl1>
References: <20190221113502.54153-1-steven.price@arm.com>
 <20190221113502.54153-3-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221113502.54153-3-steven.price@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 11:34:51AM +0000, Steven Price wrote:
> Exposing the pud/pgd levels of the page tables to walk_page_range() means
> we may come across the exotic large mappings that come with large areas
> of contiguous memory (such as the kernel's linear map).
> 
> Expose p?d_large() from each architecture to detect these large mappings.
> 
> x86 already has these defined as inline functions, add a macro of the
> same name so we don't end up with the generic version too.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/x86/include/asm/pgtable.h | 3 +++
>  arch/x86/mm/dump_pagetables.c  | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 2779ace16d23..3695f6acb6af 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -234,6 +234,7 @@ static inline int pmd_large(pmd_t pte)
>  {
>  	return pmd_flags(pte) & _PAGE_PSE;
>  }
> +#define pmd_large(x)	pmd_large(x)
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static inline int pmd_trans_huge(pmd_t pmd)
> @@ -873,6 +874,7 @@ static inline int pud_large(pud_t pud)
>  	return 0;
>  }
>  #endif	/* CONFIG_PGTABLE_LEVELS > 2 */
> +#define pud_large(x)	pud_large(x)

Nit: we usually do this in form of

#define pud_large pud_large

and before body of the inline function.

-- 
 Kirill A. Shutemov
