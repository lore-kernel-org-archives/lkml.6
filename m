Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969449AbeEXL4b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 07:56:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966843AbeEXL4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 07:56:25 -0400
Date: Thu, 24 May 2018 14:56:14 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrei Vagin <avagin@virtuozzo.com>
Subject: Re: [PATCH] userfaultfd: prevent non-cooperative events vs
 mcopy_atomic races
References: <1527061324-19949-1-git-send-email-rppt@linux.vnet.ibm.com>
 <0e1ce040-1beb-fd96-683c-1b18eb635fd6@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e1ce040-1beb-fd96-683c-1b18eb635fd6@virtuozzo.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18052411-0020-0000-0000-00000420CF12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052411-0021-0000-0000-000042B61242
Message-Id: <20180524115613.GA16908@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805240142
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 02:24:37PM +0300, Pavel Emelyanov wrote:
> On 05/23/2018 10:42 AM, Mike Rapoport wrote:
> > If a process monitored with userfaultfd changes it's memory mappings or
> > forks() at the same time as uffd monitor fills the process memory with
> > UFFDIO_COPY, the actual creation of page table entries and copying of the
> > data in mcopy_atomic may happen either before of after the memory mapping
> > modifications and there is no way for the uffd monitor to maintain
> > consistent view of the process memory layout.
> > 
> > For instance, let's consider fork() running in parallel with
> > userfaultfd_copy():
> > 
> > process        		         |	uffd monitor
> > ---------------------------------+------------------------------
> > fork()        		         | userfaultfd_copy()
> > ...        		         | ...
> >     dup_mmap()        	         |     down_read(mmap_sem)
> >     down_write(mmap_sem)         |     /* create PTEs, copy data */
> >         dup_uffd()               |     up_read(mmap_sem)
> >         copy_page_range()        |
> >         up_write(mmap_sem)       |
> >         dup_uffd_complete()      |
> >             /* notify monitor */ |
> > 
> > If the userfaultfd_copy() takes the mmap_sem first, the new page(s) will be
> > present by the time copy_page_range() is called and they will appear in the
> > child's memory mappings. However, if the fork() is the first to take the
> > mmap_sem, the new pages won't be mapped in the child's address space.
> 
> But in this case child should get an entry, that emits a message to uffd when step upon!
> And uffd will just userfaultfd_copy() it again. No?
 
There will be a message, indeed. But there is no way for monitor to tell
whether the pages it copied are present or not in the child.

Since the monitor cannot assume that the process will access all its memory
it has to copy some pages "in the background". A simple monitor may look
like:

	for (;;) {
		wait_for_uffd_events(timeout);
		handle_uffd_events();
		uffd_copy(some not faulted pages);
	}

Then, if the "background" uffd_copy() races with fork, the pages we've
copied may be already present in parent's mappings before the call to
copy_page_range() and may be not.

If the pages were not present, uffd_copy'ing them again to the child's
memory would be ok.

But if uffd_copy() was first to catch mmap_sem, and we would uffd_copy them
again, child process will get memory corruption.

> -- Pavel
> 
> > Since userfaultfd monitor has no way to determine what was the order, let's
> > disallow userfaultfd_copy in parallel with the non-cooperative events. In
> > such case we return -EAGAIN and the uffd monitor can understand that
> > userfaultfd_copy() clashed with a non-cooperative event and take an
> > appropriate action.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: Pavel Emelyanov <xemul@virtuozzo.com>
> > Cc: Andrei Vagin <avagin@virtuozzo.com>
> > ---
> >  fs/userfaultfd.c              | 22 ++++++++++++++++++++--
> >  include/linux/userfaultfd_k.h |  6 ++++--
> >  mm/userfaultfd.c              | 22 +++++++++++++++++-----
> >  3 files changed, 41 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index cec550c8468f..123bf7d516fc 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -62,6 +62,8 @@ struct userfaultfd_ctx {
> >  	enum userfaultfd_state state;
> >  	/* released */
> >  	bool released;
> > +	/* memory mappings are changing because of non-cooperative event */
> > +	bool mmap_changing;
> >  	/* mm with one ore more vmas attached to this userfaultfd_ctx */
> >  	struct mm_struct *mm;
> >  };
> > @@ -641,6 +643,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
> >  	 * already released.
> >  	 */
> >  out:
> > +	WRITE_ONCE(ctx->mmap_changing, false);
> >  	userfaultfd_ctx_put(ctx);
> >  }
> >  
> > @@ -686,10 +689,12 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
> >  		ctx->state = UFFD_STATE_RUNNING;
> >  		ctx->features = octx->features;
> >  		ctx->released = false;
> > +		ctx->mmap_changing = false;
> >  		ctx->mm = vma->vm_mm;
> >  		mmgrab(ctx->mm);
> >  
> >  		userfaultfd_ctx_get(octx);
> > +		WRITE_ONCE(octx->mmap_changing, true);
> >  		fctx->orig = octx;
> >  		fctx->new = ctx;
> >  		list_add_tail(&fctx->list, fcs);
> > @@ -732,6 +737,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
> >  	if (ctx && (ctx->features & UFFD_FEATURE_EVENT_REMAP)) {
> >  		vm_ctx->ctx = ctx;
> >  		userfaultfd_ctx_get(ctx);
> > +		WRITE_ONCE(ctx->mmap_changing, true);
> >  	}
> >  }
> >  
> > @@ -772,6 +778,7 @@ bool userfaultfd_remove(struct vm_area_struct *vma,
> >  		return true;
> >  
> >  	userfaultfd_ctx_get(ctx);
> > +	WRITE_ONCE(ctx->mmap_changing, true);
> >  	up_read(&mm->mmap_sem);
> >  
> >  	msg_init(&ewq.msg);
> > @@ -815,6 +822,7 @@ int userfaultfd_unmap_prep(struct vm_area_struct *vma,
> >  			return -ENOMEM;
> >  
> >  		userfaultfd_ctx_get(ctx);
> > +		WRITE_ONCE(ctx->mmap_changing, true);
> >  		unmap_ctx->ctx = ctx;
> >  		unmap_ctx->start = start;
> >  		unmap_ctx->end = end;
> > @@ -1653,6 +1661,10 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
> >  
> >  	user_uffdio_copy = (struct uffdio_copy __user *) arg;
> >  
> > +	ret = -EAGAIN;
> > +	if (READ_ONCE(ctx->mmap_changing))
> > +		goto out;
> > +
> >  	ret = -EFAULT;
> >  	if (copy_from_user(&uffdio_copy, user_uffdio_copy,
> >  			   /* don't copy "copy" last field */
> > @@ -1674,7 +1686,7 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
> >  		goto out;
> >  	if (mmget_not_zero(ctx->mm)) {
> >  		ret = mcopy_atomic(ctx->mm, uffdio_copy.dst, uffdio_copy.src,
> > -				   uffdio_copy.len);
> > +				   uffdio_copy.len, &ctx->mmap_changing);
> >  		mmput(ctx->mm);
> >  	} else {
> >  		return -ESRCH;
> > @@ -1705,6 +1717,10 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
> >  
> >  	user_uffdio_zeropage = (struct uffdio_zeropage __user *) arg;
> >  
> > +	ret = -EAGAIN;
> > +	if (READ_ONCE(ctx->mmap_changing))
> > +		goto out;
> > +
> >  	ret = -EFAULT;
> >  	if (copy_from_user(&uffdio_zeropage, user_uffdio_zeropage,
> >  			   /* don't copy "zeropage" last field */
> > @@ -1721,7 +1737,8 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
> >  
> >  	if (mmget_not_zero(ctx->mm)) {
> >  		ret = mfill_zeropage(ctx->mm, uffdio_zeropage.range.start,
> > -				     uffdio_zeropage.range.len);
> > +				     uffdio_zeropage.range.len,
> > +				     &ctx->mmap_changing);
> >  		mmput(ctx->mm);
> >  	} else {
> >  		return -ESRCH;
> > @@ -1900,6 +1917,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
> >  	ctx->features = 0;
> >  	ctx->state = UFFD_STATE_WAIT_API;
> >  	ctx->released = false;
> > +	ctx->mmap_changing = false;
> >  	ctx->mm = current->mm;
> >  	/* prevent the mm struct to be freed */
> >  	mmgrab(ctx->mm);
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index f2f3b68ba910..e091f0a11b11 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -31,10 +31,12 @@
> >  extern int handle_userfault(struct vm_fault *vmf, unsigned long reason);
> >  
> >  extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
> > -			    unsigned long src_start, unsigned long len);
> > +			    unsigned long src_start, unsigned long len,
> > +			    bool *mmap_changing);
> >  extern ssize_t mfill_zeropage(struct mm_struct *dst_mm,
> >  			      unsigned long dst_start,
> > -			      unsigned long len);
> > +			      unsigned long len,
> > +			      bool *mmap_changing);
> >  
> >  /* mm helpers */
> >  static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 39791b81ede7..5029f241908f 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -404,7 +404,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
> >  					      unsigned long dst_start,
> >  					      unsigned long src_start,
> >  					      unsigned long len,
> > -					      bool zeropage)
> > +					      bool zeropage,
> > +					      bool *mmap_changing)
> >  {
> >  	struct vm_area_struct *dst_vma;
> >  	ssize_t err;
> > @@ -431,6 +432,15 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
> >  	down_read(&dst_mm->mmap_sem);
> >  
> >  	/*
> > +	 * If memory mappings are changing because of non-cooperative
> > +	 * operation (e.g. mremap) running in parallel, bail out and
> > +	 * request the user to retry later
> > +	 */
> > +	err = -EAGAIN;
> > +	if (mmap_changing && READ_ONCE(*mmap_changing))
> > +		goto out_unlock;
> > +
> > +	/*
> >  	 * Make sure the vma is not shared, that the dst range is
> >  	 * both valid and fully within a single existing vma.
> >  	 */
> > @@ -563,13 +573,15 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
> >  }
> >  
> >  ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
> > -		     unsigned long src_start, unsigned long len)
> > +		     unsigned long src_start, unsigned long len,
> > +		     bool *mmap_changing)
> >  {
> > -	return __mcopy_atomic(dst_mm, dst_start, src_start, len, false);
> > +	return __mcopy_atomic(dst_mm, dst_start, src_start, len, false,
> > +			      mmap_changing);
> >  }
> >  
> >  ssize_t mfill_zeropage(struct mm_struct *dst_mm, unsigned long start,
> > -		       unsigned long len)
> > +		       unsigned long len, bool *mmap_changing)
> >  {
> > -	return __mcopy_atomic(dst_mm, start, 0, len, true);
> > +	return __mcopy_atomic(dst_mm, start, 0, len, true, mmap_changing);
> >  }
> > 
> 

-- 
Sincerely yours,
Mike.
