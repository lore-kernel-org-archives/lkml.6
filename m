Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51BAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9DB2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfBRIaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:30:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbfBRIaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:30:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F24FC02C68F;
        Mon, 18 Feb 2019 08:30:16 +0000 (UTC)
Received: from localhost (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A09DE26E5A;
        Mon, 18 Feb 2019 08:30:15 +0000 (UTC)
Date:   Mon, 18 Feb 2019 16:30:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Mike Travis <travis@sgi.com>,
        Thomas Garnier <thgarnie@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 4/6] x86/mm/KASLR: Fix the wrong calculation of memory
 region initial size
Message-ID: <20190218083013.GI14858@MiWiFi-R3L-srv>
References: <20190216140008.28671-1-bhe@redhat.com>
 <20190216140008.28671-5-bhe@redhat.com>
 <CAGXu5jKRRj9Hb5b=vnnrSuVpA+6U5mk1+16HsV=ZrPv-zgjPNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKRRj9Hb5b=vnnrSuVpA+6U5mk1+16HsV=ZrPv-zgjPNA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 18 Feb 2019 08:30:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/17/19 at 08:53am, Kees Cook wrote:
> On Sat, Feb 16, 2019 at 6:03 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > In memory region KASLR, __PHYSICAL_MASK_SHIFT is taken to calculate
> > the initial size of the direct mapping region. This is correct in
> > the old code where __PHYSICAL_MASK_SHIFT was equal to MAX_PHYSMEM_BITS,
> > 46 bits, and only 4-level mode was supported.
> >
> > Later, in commit b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT
> > always 52"), __PHYSICAL_MASK_SHIFT was changed to be always 52 bits, no
> > matter it's 5-level or 4-level. This is wrong for 4-level paging. Then
> > when we adapt physical memory region size based on available memory, it
> > will overflow if the amount of system RAM and the padding is bigger
> > than 64 TB.
> >
> > In fact, here MAX_PHYSMEM_BITS should be used instead. Fix it by
> > replacing __PHYSICAL_MASK_SHIFT with MAX_PHYSMEM_BITS.
> >
> > Fixes: b83ce5ee9147 ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52")
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Thomas Garnier <thgarnie@google.com>
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> Nice catch! I wish I had a system with >64TB RAM. ;)
> 
> Acked-by: Kees Cook <keescook@chromium.org>

Thanks for reviewing and ack-ing. I don't have system with 64 TB RAM
either. This fix is from code reading. In patch 0006, the UV system
issue is a serious regression when I introduced KASLR into RHEL, now
even though a RHEL-only fix has been merged in our distros, the tracker
bug which tracks upstream fix will go to me during planning stage of
each RHEL version. After Kirill pushed 5-level code, SGI UV dev said the
old bug can't be reproduced any more in upstream kernel, I read code
and found that the code bug fixed in this patch will hide the SGI UV
issue :-).

> 
> > ---
> >  arch/x86/mm/kaslr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> > index bf680929fe26..97768df923e3 100644
> > --- a/arch/x86/mm/kaslr.c
> > +++ b/arch/x86/mm/kaslr.c
> > @@ -137,7 +137,7 @@ void __init kernel_randomize_memory(void)
> >         if (!kaslr_memory_enabled())
> >                 return;
> >
> > -       kaslr_regions[0].size_tb = 1 << (__PHYSICAL_MASK_SHIFT - TB_SHIFT);
> > +       kaslr_regions[0].size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
> >         kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
> >
> >         /*
> > --
> > 2.17.2
> >
> 
> 
> -- 
> Kees Cook
