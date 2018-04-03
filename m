Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbeDCVEu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 17:04:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752639AbeDCVEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 17:04:49 -0400
Date: Tue, 3 Apr 2018 17:04:45 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: David Rientjes <rientjes@google.com>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
        mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
Subject: Re: [PATCH v9 06/24] mm: make pte_unmap_same compatible with SPF
Message-ID: <20180403210445.GF5935@redhat.com>
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1520963994-28477-7-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180403191005.GC5935@redhat.com>
 <alpine.DEB.2.20.1804031338260.172772@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.20.1804031338260.172772@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 01:40:18PM -0700, David Rientjes wrote:
> On Tue, 3 Apr 2018, Jerome Glisse wrote:
> 
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 21b1212a0892..4bc7b0bdcb40 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -2309,21 +2309,29 @@ static bool pte_map_lock(struct vm_fault *vmf)
> > >   * parts, do_swap_page must check under lock before unmapping the pte and
> > >   * proceeding (but do_wp_page is only called after already making such a check;
> > >   * and do_anonymous_page can safely check later on).
> > > + *
> > > + * pte_unmap_same() returns:
> > > + *	0			if the PTE are the same
> > > + *	VM_FAULT_PTNOTSAME	if the PTE are different
> > > + *	VM_FAULT_RETRY		if the VMA has changed in our back during
> > > + *				a speculative page fault handling.
> > >   */

[...]

> > >  
> > 
> > This change what do_swap_page() returns ie before it was returning 0
> > when locked pte lookup was different from orig_pte. After this patch
> > it returns VM_FAULT_PTNOTSAME but this is a new return value for
> > handle_mm_fault() (the do_swap_page() return value is what ultimately
> > get return by handle_mm_fault())
> > 
> > Do we really want that ? This might confuse some existing user of
> > handle_mm_fault() and i am not sure of the value of that information
> > to caller.
> > 
> > Note i do understand that you want to return retry if anything did
> > change from underneath and thus need to differentiate from when the
> > pte value are not the same.
> > 
> 
> I think VM_FAULT_RETRY should be handled appropriately for any user of 
> handle_mm_fault() already, and would be surprised to learn differently.  
> Khugepaged has the appropriate handling.  I think the concern is whether a 
> user is handling anything other than VM_FAULT_RETRY and VM_FAULT_ERROR 
> (which VM_FAULT_PTNOTSAME is not set in)?  I haven't done a full audit of 
> the users.

I am not worried about VM_FAULT_RETRY and barely have any worry about
VM_FAULT_PTNOTSAME either as they are other comparable new return value
(VM_FAULT_NEEDDSYNC for instance which is quite recent).

I wonder if adding a new value is really needed here. I don't see any
value to it for caller of handle_mm_fault() except for stats.

Note that I am not oppose, but while today we have free bits, maybe
tomorrow we will run out, i am always worried about thing like that :)

Cheers,
Jérôme
