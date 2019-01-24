Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B34C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4D621855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfAXH1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 02:27:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726014AbfAXH1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 02:27:19 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0O7PVQo069433
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 02:27:18 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q78dpsg07-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 02:27:18 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 24 Jan 2019 07:27:16 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 24 Jan 2019 07:27:11 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0O7RAfT28966922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 07:27:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD7124C044;
        Thu, 24 Jan 2019 07:27:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09F784C040;
        Thu, 24 Jan 2019 07:27:09 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.172])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 24 Jan 2019 07:27:08 +0000 (GMT)
Date:   Thu, 24 Jan 2019 09:27:07 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 07/24] userfaultfd: wp: add the writeprotect API to
 userfaultfd ioctl
References: <20190121075722.7945-1-peterx@redhat.com>
 <20190121075722.7945-8-peterx@redhat.com>
 <20190121104232.GA26461@rapoport-lnx>
 <20190124045551.GD18231@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124045551.GD18231@xz-x1>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012407-0016-0000-0000-00000249AABC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012407-0017-0000-0000-000032A3ED11
Message-Id: <20190124072706.GA3179@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901240053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 12:56:15PM +0800, Peter Xu wrote:
> On Mon, Jan 21, 2019 at 12:42:33PM +0200, Mike Rapoport wrote:
> 
> [...]
> 
> > > @@ -1343,7 +1344,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > > 
> > >  		/* check not compatible vmas */
> > >  		ret = -EINVAL;
> > > -		if (!vma_can_userfault(cur))
> > > +		if (!vma_can_userfault(cur, vm_flags))
> > >  			goto out_unlock;
> > > 
> > >  		/*
> > > @@ -1371,6 +1372,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > >  			if (end & (vma_hpagesize - 1))
> > >  				goto out_unlock;
> > >  		}
> > > +		if ((vm_flags & VM_UFFD_WP) && !(cur->vm_flags & VM_WRITE))
> > > +			goto out_unlock;
> > 
> > This is problematic for the non-cooperative use-case. Way may still want to
> > monitor a read-only area because it may eventually become writable, e.g. if
> > the monitored process runs mprotect().
> 
> Firstly I think I should be able to change it to VM_MAYWRITE which
> seems to suite more.
> 
> Meanwhile, frankly speaking I didn't think a lot about how to nest the
> usages of uffd-wp and mprotect(), so far I was only considering it as
> a replacement of mprotect().  But indeed it can happen that the
> monitored process calls mprotect().  Is there an existing scenario of
> such usage?
> 
> The problem is I'm uncertain about whether this scenario can work
> after all.  Say, the monitor process A write protected process B's
> page P, so logically A will definitely receive a message before B
> writes to page P.  However here if we allow process B to do
> mprotect(PROT_WRITE) upon page P and grant write permission to it on
> its own, then A will not be able to capture the write operation at
> all?  Then I don't know how it can work here... or whether we should
> fail the mprotect() at least upon uffd-wp ranges?

The use-case we've discussed a while ago was to use uffd-wp instead of
soft-dirty for tracking memory changes in CRIU for pre-copy migration.
Currently, we enable soft-dirty for the migrated process and monitor
/proc/pid/pagemap between memory dump iterations to see what memory pages
have been changed.
With uffd-wp we thought to register all the process memory with uffd-wp and
then track changes with uffd-wp notifications. Back then it was considered
only at the very general level without paying much attention to details.

So my initial thought was that we do register the entire memory with
uffd-wp. If an area changes from RO to RW at some point, uffd-wp will
generate notifications to the monitor, it would be able to notice the
change and the write will continue normally.

If we are to limit uffd-wp register only to VMAs with VM_WRITE and even
VM_MAYWRITE, we'd need a way to handle the possible changes of VMA
protection and an ability to add monitoring for areas that changed from RO
to RW.

Can't say I have a clear picture in mind at the moment, will continue to
think about it.

> > Particularity, for using uffd-wp as a replacement for soft-dirty would
> > require it.
> > 
> > > 
> > >  		/*
> > >  		 * Check that this vma isn't already owned by a
> > > @@ -1400,7 +1403,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > >  	do {
> > >  		cond_resched();
> > > 
> > > -		BUG_ON(!vma_can_userfault(vma));
> > > +		BUG_ON(!vma_can_userfault(vma, vm_flags));
> > >  		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
> > >  		       vma->vm_userfaultfd_ctx.ctx != ctx);
> > >  		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
> > > @@ -1535,7 +1538,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> > >  		 * provides for more strict behavior to notice
> > >  		 * unregistration errors.
> > >  		 */
> > > -		if (!vma_can_userfault(cur))
> > > +		if (!vma_can_userfault(cur, cur->vm_flags))
> > >  			goto out_unlock;
> > > 
> > >  		found = true;
> > > @@ -1549,7 +1552,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> > >  	do {
> > >  		cond_resched();
> > > 
> > > -		BUG_ON(!vma_can_userfault(vma));
> > > +		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
> > >  		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
> > > 
> > >  		/*
> > > @@ -1760,6 +1763,46 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
> > >  	return ret;
> > >  }
> > > 
> > > +static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
> > > +				    unsigned long arg)
> > > +{
> > > +	int ret;
> > > +	struct uffdio_writeprotect uffdio_wp;
> > > +	struct uffdio_writeprotect __user *user_uffdio_wp;
> > > +	struct userfaultfd_wake_range range;
> > > +
> > 
> > In the non-cooperative mode the userfaultfd_writeprotect() may race with VM
> > layout changes, pretty much as uffdio_copy() [1]. My solution for uffdio_copy()
> > was to return -EAGAIN if such race is encountered. I think the same would
> > apply here.
> 
> I tried to understand the problem at [1] but failed... could you help
> to clarify it a bit more?
> 
> I'm quoting some of the discussions from [1] here directly between you
> and Pavel:
> 
>   > Since the monitor cannot assume that the process will access all its memory
>   > it has to copy some pages "in the background". A simple monitor may look
>   > like:
>   > 
>   > 	for (;;) {
>   > 		wait_for_uffd_events(timeout);
>   > 		handle_uffd_events();
>   > 		uffd_copy(some not faulted pages);
>   > 	}
>   > 
>   > Then, if the "background" uffd_copy() races with fork, the pages we've
>   > copied may be already present in parent's mappings before the call to
>   > copy_page_range() and may be not.
>   > 
>   > If the pages were not present, uffd_copy'ing them again to the child's
>   > memory would be ok.
>   >
>   > But if uffd_copy() was first to catch mmap_sem, and we would uffd_copy them
>   > again, child process will get memory corruption.
> 
> Here I don't understand why the child process will get memory
> corruption if uffd_copy() caught the mmap_sem first.
> 
> If it did it, then IMHO when uffd_copy() copies the page again it'll
> simply get a -EEXIST showing that the page has already been copied.
> Could you explain on why there will be a data corruption?

Let's say we do post-copy migration of a process A with CRIU and its page at
address 0x1000 is already copied. Now it modifies the contents of this
page. At this point the contents of the page at 0x1000 is different on the
source and the destination.
Next, process A forks process B. The CRIU's uffd monitor gets
UFFD_EVENT_FORK, and starts filling process B memory with UFFDIO_COPY.
It may happen, that UFFDIO_COPY to 0x1000 of the process B will occur
*before* fork() completes and it may race with copy_page_range().
If UFFDIO_COPY wins the race, it will fill the page with the contents from
the source, although the correct data is what process A set in that page.

Hope it helps.

> Thanks in advance,
> 
> >  
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df2cc96e77011cf7989208b206da9817e0321028
> >
> 
> -- 
> Peter Xu
> 

-- 
Sincerely yours,
Mike.

