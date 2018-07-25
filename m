Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA75C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DAC20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DAC20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbeGYWno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:43:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58074 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731174AbeGYWno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:43:44 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DF877BBF;
        Wed, 25 Jul 2018 21:30:08 +0000 (UTC)
Date:   Wed, 25 Jul 2018 14:30:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>, bhe@redhat.com,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org,
        osalvador@techadventures.net, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH 2/3] mm: calculate deferred pages after skipping
 mirrored memory
Message-Id: <20180725143007.25d5bff352872aba90ca731b@linux-foundation.org>
In-Reply-To: <CAGM2reb4vT59uUkMkJVBx9-GEYQs287oTG08aRwKtjfJ1BVrjA@mail.gmail.com>
References: <20180724235520.10200-1-pasha.tatashin@oracle.com>
        <20180724235520.10200-3-pasha.tatashin@oracle.com>
        <20180724183142.d20798b43fd1215f6165649c@linux-foundation.org>
        <CAGM2reb4vT59uUkMkJVBx9-GEYQs287oTG08aRwKtjfJ1BVrjA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 21:46:25 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> > > +static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
> > >  {
> > > +     static unsigned long prev_end_pfn, nr_initialised;
> >
> > So answer me quick, what happens with a static variable in an inlined
> > function?  Is there one copy kernel-wide?  One copy per invocation
> > site?  One copy per compilation unit?
> >
> > Well I didn't know so I wrote a little test.  One copy per compilation
> > unit (.o file), it appears.
> >
> > It's OK in this case because the function is in .c (and has only one
> > call site).  But if someone moves it into a header and uses it from a
> > different .c file, they have problems.
> >
> > So it's dangerous, and poor practice.  I'll make this non-static
> > __meminit.
> 
> I agree, it should not be moved to header it is dangerous.
> 
> But, on the other hand this is a hot-path. memmap_init_zone() might
> need to go through billions of struct pages early in boot, and I did
> not want us to waste time on function calls. With defer_init() this is
> not a problem, because if CONFIG_DEFERRED_STRUCT_PAGE_INIT is set
> memmap_init_zone() won't have much work to do, but for
> overlap_memmap_init() this is a problem, especially because I expect
> compiler to optimize the pfn dereference usage in inline function.

Well.  The compiler will just go and inline defer_init() anwyay - it
has a single callsite and is in the same __meminint section as its
calling function.  My gcc-7.2.0 does this.  Marking it noninline
__meminit is basically syntactic fluff designed to encourage people to
think twice.

> >
> > --- a/mm/page_alloc.c~mm-calculate-deferred-pages-after-skipping-mirrored-memory-fix
> > +++ a/mm/page_alloc.c
> > @@ -309,7 +309,8 @@ static inline bool __meminit early_page_
> >   * Returns true when the remaining initialisation should be deferred until
> >   * later in the boot cycle when it can be parallelised.
> >   */
> > -static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
> > +static bool __meminit
> > +defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
> >  {
> >         static unsigned long prev_end_pfn, nr_initialised;
> >
> >
> > Also, what locking protects these statics?  Our knowledge that this
> > code is single-threaded, presumably?
> 
> Correct, this is called only from "context == MEMMAP_EARLY", way
> before smp_init().

Might be worth a little comment to put readers minds at ease.
