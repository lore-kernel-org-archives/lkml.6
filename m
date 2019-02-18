Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA45C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A4C218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfBRIHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:07:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbfBRIHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:07:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6911259458;
        Mon, 18 Feb 2019 08:07:30 +0000 (UTC)
Received: from localhost (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B24355F9C0;
        Mon, 18 Feb 2019 08:07:29 +0000 (UTC)
Date:   Mon, 18 Feb 2019 16:07:27 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 3/6] mm: Add build time sanity check for struct page
 size
Message-ID: <20190218080727.GH14858@MiWiFi-R3L-srv>
References: <20190216140008.28671-1-bhe@redhat.com>
 <20190216140008.28671-4-bhe@redhat.com>
 <CAGXu5jLVYC8QZ9xo_=JxODQAPVTJMvnWwUb+aZKO-X-Luz+S0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLVYC8QZ9xo_=JxODQAPVTJMvnWwUb+aZKO-X-Luz+S0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 18 Feb 2019 08:07:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/17/19 at 08:50am, Kees Cook wrote:
> On Sat, Feb 16, 2019 at 6:02 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > Size of struct page might be larger than 64 bytes if debug options
> > enabled, or fields added for debugging intentionally. Yet an upper
> > limit need be added at build time to trigger an alert in case the
> > size is too big to boot up system, warning people to check if it's
> > be done on purpose in advance.
> >
> > Here 1/4 of PAGE_SIZE is chosen since system must have been insane
> > with this value. For those systems with PAGE_SIZE larger than 4KB,
> > 1KB is simply taken.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/page_alloc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 35fdde041f5c..eb6c8e22333b 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -67,6 +67,7 @@
> >  #include <linux/lockdep.h>
> >  #include <linux/nmi.h>
> >  #include <linux/psi.h>
> > +#include <linux/sizes.h>
> >
> >  #include <asm/sections.h>
> >  #include <asm/tlbflush.h>
> > @@ -7084,6 +7085,7 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
> >         unsigned long start_pfn, end_pfn;
> >         int i, nid;
> >
> > +       BUILD_BUG_ON(sizeof(struct page) > min_t(size_t, SZ_1K, PAGE_SIZE));
> 
> Are there systems with PAGE_SIZE < 1K? Maybe this should just be a
> direct SZ_1K check?

This check was suggested by Kirill, I forgot adding his "Suggested-by",
sorry abou that.

Originally he suggested to add code in generic place like this:

	BUILD_BUG_ON(sizeof(struct page) < min(SZ_1K, PAGE_SIZE/4));

In later post, the kbuild test robot reported an build error on i386
ARCH,

http://lkml.kernel.org/r/20180911074733.GX1740@192.168.1.3

From the report hint, I thought 'PAGE_SIZE/4' also related to the macro
expansion, so change it as min_t(size_t, SZ_1K, PAGE_SIZE).

Just now I tried the build again, changing it back to 'PAGE_SIZE/4' also
works.

	BUILD_BUG_ON(sizeof(struct page) > min_t(size_t, SZ_1K, PAGE_SIZE/4));

I guess Kirill wants to make it as self explanatory for this check by
suggesting it as min(SZ_1K, PAGE_SIZE/4), to stress the 'PAGE_SIZE/4'.
As he said in mail thread, "If struct page is more than 1/4 of PAGE_SIZE
something is horribly broken".

lkml.kernel.org/r/20180903102642.rmzawwqsqjvh2mkb@kshutemo-mobl1

Just try to give more details about this adding, not defend. I am
fine to take any of them.


> (Also, perhaps this should use the new static_assert where struct page
> is defined?)

I searched with 'git grep', didn't find static_assert macro or function.
And also no finding in include/linux/mm_types.h. Could you please be
more specific?

Thanks
Baoquan
> 
> >         /* Record where the zone boundaries are */
> >         memset(arch_zone_lowest_possible_pfn, 0,
> >                                 sizeof(arch_zone_lowest_possible_pfn));
> > --
> > 2.17.2
> >
> 
> 
> -- 
> Kees Cook
