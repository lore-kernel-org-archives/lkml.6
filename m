Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeC1H6Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:58:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751903AbeC1H6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:58:14 -0400
Date: Wed, 28 Mar 2018 09:58:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com,
        pmorel@linux.vnet.ibm.com
Subject: Re: [PATCH 2/4] vfio: ccw: refactor and improve
 pfn_array_alloc_pin()
Message-ID: <20180328095810.24807263.cohuck@redhat.com>
In-Reply-To: <20180328023638.GL12194@bjsdjshi@linux.vnet.ibm.com>
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
        <20180321020822.86255-3-bjsdjshi@linux.vnet.ibm.com>
        <20180326152846.2ef1ae07.cohuck@redhat.com>
        <20180327030026.GI12194@bjsdjshi@linux.vnet.ibm.com>
        <20180327120127.16f7884f.cohuck@redhat.com>
        <20180328023638.GL12194@bjsdjshi@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018 10:36:38 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cohuck@redhat.com> [2018-03-27 12:01:27 +0200]:
> 
> [...]
> 
> > > > 
> > > > So, basically everything is filled by pfn_array_alloc_pin()?    
> > > Yes.
> > >   
> > > > Should we expect a clean struct pfn_array handed in by the caller,
> > > > then (not just pa_nr == 0)?    
> > > The current idea is:
> > > - It is a clean struct that pfn_array_alloc_pin() expects from its
> > >   caller.
> > > - pfn_array_alloc_pin() and pfn_array_unpin_free() should be used in
> > >   pair. They are the only functions those change the values of the
> > >   elements of a pfn_array struct.
> > > - Caller of pfn_array_alloc_pin() should either hand in a new allocated
> > >   pfn_array (zeroed out), or a freed-after-used one.
> > > - So using pa_nr == 0, is enough to identify all the good cases.
> > >   [We set pa_nr to 0 in pfn_array_unpin_free().]
> > > 
> > > Validating all of the elements only helps when there is case that a
> > > caller breaks the usage rule of these interfaces - the caller itself
> > > assigns values for pfn_pa elements directly... I don't think we allow
> > > this to happen.
> > > 
> > > So I think the current logic is fine.  
> > 
> > Yes, I think it is fine -- I was mainly wondering whether we wanted
> > more sanity checks.
> >   
> Ok.
> Check on (pa->pa_iova_pfn != NULL) could be added. It's easy to do so.
> Check on pa->pa_iova doesn't make sense, since its value will be
> re-assigned anyway.
> Check on pa->pa_pfn doesn't make sense, since we treat it as a pointer
> that points to part of the memory area that was pointed by
> pa->pa_iova_pfn. And we will re-assign it with new pa->pa_iova_pfn
> value.

Yeah, so additional checks are probably not very useful.

> 
> > >   
> > > > 
> > > > Would it make sense to describe the contents of the struct pfn_array
> > > > fields at the struct's definition instead? You could then shorten the
> > > > description here to "we expect pa_nr == 0, any field in this structure
> > > > will be filled in by this function".    
> > > Sounds good!
> > > Do you want a separated patch for this, or I do this change on this
> > > patch? Either will be ok with me.  
> > 
> > Perhaps as an additional patch in front of this one?
> >   
> It's doable. I will do that.
> 

Cool, thx!
