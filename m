Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeC0KBd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 06:01:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751185AbeC0KBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 06:01:32 -0400
Date: Tue, 27 Mar 2018 12:01:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com,
        pmorel@linux.vnet.ibm.com
Subject: Re: [PATCH 2/4] vfio: ccw: refactor and improve
 pfn_array_alloc_pin()
Message-ID: <20180327120127.16f7884f.cohuck@redhat.com>
In-Reply-To: <20180327030026.GI12194@bjsdjshi@linux.vnet.ibm.com>
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
        <20180321020822.86255-3-bjsdjshi@linux.vnet.ibm.com>
        <20180326152846.2ef1ae07.cohuck@redhat.com>
        <20180327030026.GI12194@bjsdjshi@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018 11:00:26 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cohuck@redhat.com> [2018-03-26 15:28:46 +0200]:
> 
> > On Wed, 21 Mar 2018 03:08:20 +0100
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> >   
> > > This refactors pfn_array_alloc_pin() and also improves it by adding
> > > defensive code in error handling so that calling pfn_array_unpin_free()
> > > after error return won't lead to problem. This mains does:
> > > 1. Merge pfn_array_pin() into pfn_array_alloc_pin(), since there is no
> > >    other user of pfn_array_pin(). As a result, also remove kernel-doc
> > >    for pfn_array_pin() and add kernel-doc for pfn_array_alloc_pin().
> > > 2. For a vfio_pin_pages() failure, set pa->pa_nr to zero to indicate
> > >    zero pages were pinned.
> > > 3. Set pa->pa_iova_pfn to NULL right after it was freed.
> > > 
> > > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > ---
> > >  drivers/s390/cio/vfio_ccw_cp.c | 84 ++++++++++++++++++------------------------
> > >  1 file changed, 36 insertions(+), 48 deletions(-)
> > > 
> > > diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> > > index 2be114db02f9..3abc9770910a 100644
> > > --- a/drivers/s390/cio/vfio_ccw_cp.c
> > > +++ b/drivers/s390/cio/vfio_ccw_cp.c
> > > @@ -46,65 +46,32 @@ struct ccwchain {
> > >  };
> > >  
> > >  /*
> > > - * pfn_array_pin() - pin user pages in memory
> > > + * pfn_array_alloc_pin() - alloc memory for PFNs, then pin user pages in memory
> > >   * @pa: pfn_array on which to perform the operation
> > >   * @mdev: the mediated device to perform pin/unpin operations
> > > + * @iova: target guest physical address
> > > + * @len: number of bytes that should be pinned from @iova
> > >   *
> > > - * Attempt to pin user pages in memory.
> > > + * Attempt to allocate memory for PFNs, and pin user pages in memory.
> > >   *
> > >   * Usage of pfn_array:
> > > - * @pa->pa_iova     starting guest physical I/O address. Assigned by caller.
> > > + * @pa->pa_iova     starting guest physical I/O address. Assigned by callee.
> > >   * @pa->pa_iova_pfn array that stores PFNs of the pages need to pin. Allocated
> > > - *                  by caller.
> > > + *                  by callee.
> > >   * @pa->pa_pfn      array that receives PFNs of the pages pinned. Allocated by
> > > - *                  caller.
> > > - * @pa->pa_nr       number of pages from @pa->pa_iova to pin. Assigned by
> > > - *                  caller.
> > > - *                  number of pages pinned. Assigned by callee.
> > > + *                  callee.
> > > + * @pa->pa_nr       initiated as 0 by caller.  
> > 
> > s/initiated/initialized/  
> Ok.
> 
> > 
> > but see below
> >   
> > > + *                  number of pages pinned from @pa->pa_iova. Assigned by callee.  
> > 
> > So, basically everything is filled by pfn_array_alloc_pin()?  
> Yes.
> 
> > Should we expect a clean struct pfn_array handed in by the caller,
> > then (not just pa_nr == 0)?  
> The current idea is:
> - It is a clean struct that pfn_array_alloc_pin() expects from its
>   caller.
> - pfn_array_alloc_pin() and pfn_array_unpin_free() should be used in
>   pair. They are the only functions those change the values of the
>   elements of a pfn_array struct.
> - Caller of pfn_array_alloc_pin() should either hand in a new allocated
>   pfn_array (zeroed out), or a freed-after-used one.
> - So using pa_nr == 0, is enough to identify all the good cases.
>   [We set pa_nr to 0 in pfn_array_unpin_free().]
> 
> Validating all of the elements only helps when there is case that a
> caller breaks the usage rule of these interfaces - the caller itself
> assigns values for pfn_pa elements directly... I don't think we allow
> this to happen.
> 
> So I think the current logic is fine.

Yes, I think it is fine -- I was mainly wondering whether we wanted
more sanity checks.

> 
> > 
> > Would it make sense to describe the contents of the struct pfn_array
> > fields at the struct's definition instead? You could then shorten the
> > description here to "we expect pa_nr == 0, any field in this structure
> > will be filled in by this function".  
> Sounds good!
> Do you want a separated patch for this, or I do this change on this
> patch? Either will be ok with me.

Perhaps as an additional patch in front of this one?
