Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F049C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5711B217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfBRJuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:50:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729174AbfBRJuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:50:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26A39AD89E;
        Mon, 18 Feb 2019 09:50:15 +0000 (UTC)
Received: from localhost (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B5E6360F93;
        Mon, 18 Feb 2019 09:50:12 +0000 (UTC)
Date:   Mon, 18 Feb 2019 17:50:10 +0800
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
Subject: Re: [PATCH v3 5/6] x86/mm/KASLR: Calculate the actual size of
 vmemmap region
Message-ID: <20190218095010.GJ14858@MiWiFi-R3L-srv>
References: <20190216140008.28671-1-bhe@redhat.com>
 <20190216140008.28671-6-bhe@redhat.com>
 <CAGXu5jJjed2yS1OZ2+rKuMiPr7HTXLx5qMSV+xWHJs-DJGT4-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJjed2yS1OZ2+rKuMiPr7HTXLx5qMSV+xWHJs-DJGT4-A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 18 Feb 2019 09:50:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/17/19 at 09:25am, Kees Cook wrote:
> On Sat, Feb 16, 2019 at 6:04 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > Vmemmap region has different maximum size depending on paging mode.
> > Now its size is hardcoded as 1TB in memory KASLR, this is not
> > right for 5-level paging mode. It will cause overflow if vmemmap
> > region is randomized to be adjacent to cpu_entry_area region and
> > its actual size is bigger than 1TB.
> >
> > So here calculate how many TB by the actual size of vmemmap region
> > and align up to 1TB boundary.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/x86/mm/kaslr.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> > index 97768df923e3..ca12ed4e5239 100644
> > --- a/arch/x86/mm/kaslr.c
> > +++ b/arch/x86/mm/kaslr.c
> > @@ -101,7 +101,7 @@ static __initdata struct kaslr_memory_region {
> >  } kaslr_regions[] = {
> >         { &page_offset_base, 0 },
> >         { &vmalloc_base, 0 },
> > -       { &vmemmap_base, 1 },
> > +       { &vmemmap_base, 0 },
> >  };
> >
> >  /*
> > @@ -121,6 +121,7 @@ void __init kernel_randomize_memory(void)
> >         unsigned long rand, memory_tb;
> >         struct rnd_state rand_state;
> >         unsigned long remain_entropy;
> > +       unsigned long vmemmap_size;
> >
> >         vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
> >         vaddr = vaddr_start;
> > @@ -152,6 +153,14 @@ void __init kernel_randomize_memory(void)
> >         if (memory_tb < kaslr_regions[0].size_tb)
> >                 kaslr_regions[0].size_tb = memory_tb;
> >
> > +       /*
> > +        * Calculate how many TB vmemmap region needs, and align to
> > +        * 1TB boundary.
> 
> Can you describe why this is the right calculation? (This will help
> explain why 4-level is different from 5-level here.)

In the old code, the size of vmemmap is hardcoded as 1 TB. This is true
in 4-level paging mode, 64 TB RAM supported at most, and usually
sizeof(struct page) is 64 Bytes, it happens to be 1 TB.

However, in 5-level paging mode, 4 PB is the biggest RAM size we can
support, it's (4 PB)/64 == 1<<48, namely 256 TB area needed for vmemmap,
assuming sizeof(struct page) is 64 Bytes here.

So, the hardcoding of 1 TB is not correct for 5-level paging mode. 

Thanks
Baoquan

> 
> > +        */
> > +       vmemmap_size = (kaslr_regions[0].size_tb << (TB_SHIFT - PAGE_SHIFT)) *
> > +               sizeof(struct page);
> > +       kaslr_regions[2].size_tb = DIV_ROUND_UP(vmemmap_size, 1UL << TB_SHIFT);
> > +
