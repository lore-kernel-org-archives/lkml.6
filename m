Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeEGMXw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 08:23:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeEGMXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 08:23:49 -0400
Date: Mon, 7 May 2018 05:23:46 -0700
From: Matthew Wilcox <willy@infradead.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andy Lutomirski <luto@amacapital.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Proof-of-concept: better(?) page-table manipulation API
Message-ID: <20180507122346.GE18116@bombadil.infradead.org>
References: <20180424154355.mfjgkf47kdp2by4e@black.fi.intel.com>
 <CALCETrVzD8oPv=h2q91AMdCHn3S782GmvsY-+mwoaPUw=5N7HQ@mail.gmail.com>
 <20180507113124.ewpbrfd3anyg7pli@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507113124.ewpbrfd3anyg7pli@kshutemo-mobl1>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 02:31:25PM +0300, Kirill A. Shutemov wrote:
> > Also, what does lvl == 0 mean?  Is it the top or the bottom?  I think a
> > comment would be helpful.
> 
> It is bottom. But it should be up to architecture to decide.

That's not true because ...

> > > +static inline void ptp_walk(ptp_t *ptp, unsigned long addr)
> > > +{
> > > +       ptp->ptr = (unsigned long *)ptp_page_vaddr(ptp);
> > > +       ptp->ptr += __pt_index(addr, --ptp->lvl);
> > > +}
> > 
> > Can you add a comment that says what this function does?
> 
> Okay, I will.
> 
> > Why does it not change the level?
> 
> It does. --ptp->lvl.

... you've hardcoded that walking down decrements the level by 1.

I don't see that as a defect; it's just part of the API that needs
documenting.
