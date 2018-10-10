Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0F1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CFC214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CFC214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJKBCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:02:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:45152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726789AbeJKBCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:02:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7B64AA7C;
        Wed, 10 Oct 2018 17:38:58 +0000 (UTC)
Date:   Wed, 10 Oct 2018 19:38:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        abdhalee@linux.vnet.ibm.com, joel@jms.id.au,
        Kees Cook <keescook@chromium.org>, jasone@google.com,
        davidtgoldblatt@gmail.com, trasz@freebsd.org,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Daniel Micay <danielmicay@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: don't clobber partially overlapping VMA with
 MAP_FIXED_NOREPLACE
Message-ID: <20181010173857.GM5873@dhcp22.suse.cz>
References: <20181010152736.99475-1-jannh@google.com>
 <20181010171944.GJ5873@dhcp22.suse.cz>
 <CAG48ez04KK62doMwsTVN4nN8y_wmv7hn+4my2jk5VXKL0wP7Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez04KK62doMwsTVN4nN8y_wmv7hn+4my2jk5VXKL0wP7Lg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-10-18 19:26:50, Jann Horn wrote:
[...]
> As you can see, the first page of the mapping at 0x10001000 was clobbered.
> 
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 5f2b2b184c60..f7cd9cb966c0 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1410,7 +1410,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> > >       if (flags & MAP_FIXED_NOREPLACE) {
> > >               struct vm_area_struct *vma = find_vma(mm, addr);
> > >
> > > -             if (vma && vma->vm_start <= addr)
> > > +             if (vma && vma->vm_start < addr + len)
> >
> > find_vma is documented to - Look up the first VMA which satisfies addr <
> > vm_end, NULL if none.
> > This means that the above check guanratees that
> >         vm_start <= addr < vm_end
> > so an overlap is guanrateed. Why should we care how much we overlap?
> 
> "an overlap is guaranteed"? I have no idea what you're trying to say.

I have misread your changelog and the patch. Sorry about that. I thought
you meant a false possitive but you in fact meant false negative. Now it
makes complete sense.

Acked-by: Michal Hocko <mhocko@suse.com>

And thanks a lot for catching that!

-- 
Michal Hocko
SUSE Labs
