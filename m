Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033853AbeCASQw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:16:52 -0500
Received: from mail-pl0-f46.google.com ([209.85.160.46]:44879 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033321AbeCASQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:16:51 -0500
X-Google-Smtp-Source: AG47ELu9+7Hzr7J3IjfDHD7u72pTvaGEh+hlQ7WMKWD2Ph9AQfLGKRgLnQlQilXEJ1epC/L6bnOJVA==
Message-ID: <1519928208.11375.3.camel@gmail.com>
Subject: Re: Use higher-order pages in vmalloc
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Michal Hocko <mhocko@kernel.org>, Andy Lutomirski <luto@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Thu, 01 Mar 2018 10:16:48 -0800
In-Reply-To: <20180223121300.GU30681@dhcp22.suse.cz>
References: <151670492223.658225.4605377710524021456.stgit@buzz>
         <151670493255.658225.2881484505285363395.stgit@buzz>
         <20180221154214.GA4167@bombadil.infradead.org>
         <fff58819-d39d-3a8a-f314-690bcb2f95d7@intel.com>
         <20180221170129.GB27687@bombadil.infradead.org>
         <20180222065943.GA30681@dhcp22.suse.cz>
         <20180222122254.GA22703@bombadil.infradead.org>
         <20180222133643.GJ30681@dhcp22.suse.cz>
         <CALCETrU2c=SzWJCwuqqFuBVkC=nN27_ce4GxweCQXEwPAqnz7A@mail.gmail.com>
         <20180223121300.GU30681@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-23 at 13:13 +0100, Michal Hocko wrote:
> On Thu 22-02-18 19:01:35, Andy Lutomirski wrote:
> > On Thu, Feb 22, 2018 at 1:36 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > > On Thu 22-02-18 04:22:54, Matthew Wilcox wrote:
> > > > On Thu, Feb 22, 2018 at 07:59:43AM +0100, Michal Hocko wrote:
> > > > > On Wed 21-02-18 09:01:29, Matthew Wilcox wrote:
> > > > > > Right.  It helps with fragmentation if we can keep higher-order
> > > > > > allocations together.
> > > > > 
> > > > > Hmm, wouldn't it help if we made vmalloc pages migrateable instead? That
> > > > > would help the compaction and get us to a lower fragmentation longterm
> > > > > without playing tricks in the allocation path.
> > > > 
> > > > I was wondering about that possibility.  If we want to migrate a page
> > > > then we have to shoot down the PTE across all CPUs, copy the data to the
> > > > new page, and insert the new PTE.  Copying 4kB doesn't take long; if you
> > > > have 12GB/s (current example on Wikipedia: dual-channel memory and one
> > > > DDR2-800 module per channel gives a theoretical bandwidth of 12.8GB/s)
> > > > then we should be able to copy a page in 666ns).  So there's no problem
> > > > holding a spinlock for it.
> > > > 
> > > > But we can't handle a fault in vmalloc space today.  It's handled in
> > > > arch-specific code, see vmalloc_fault() in arch/x86/mm/fault.c
> > > > If we're going to do this, it'll have to be something arches opt into
> > > > because I'm not taking on the job of fixing every architecture!
> > > 
> > > yes.
> > 
> > On x86, if you shoot down the PTE for the current stack, you're dead.
> > vmalloc_fault() might not even be called.  Instead we hit
> > do_double_fault(), and the manual warns extremely strongly against
> > trying to recover, and, in this case, I agree with the SDM.  If you
> > actually want this to work, there needs to be a special IPI broadcast
> > to the task in question (with appropriate synchronization) that calls
> > magic arch code that does the switcheroo.
> 
> Why cannot we use the pte swap entry trick also for vmalloc migration.
> I haven't explored this path at all, to be honest.
> 
> > Didn't someone (Christoph?) have a patch to teach the page allocator
> > to give high-order allocations if available and otherwise fall back to
> > low order?
> 
> Do you mean kvmalloc?


I sent something last year but had not finished the patch series :/

https://marc.info/?l=linux-kernel&m=148233423610544&w=2
