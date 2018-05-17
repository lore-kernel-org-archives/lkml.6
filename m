Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeEQDXh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 23:23:37 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35277 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbeEQDXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 23:23:35 -0400
X-Google-Smtp-Source: AB8JxZp7jPlIPcDefyPudPfrfRSIxXxeFavLX8220efU4MX1bHkcH/+VQOJpqkZhH00whAr++fH0xw==
Date: Wed, 16 May 2018 20:23:33 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Minchan Kim <minchan.kernel@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Joe Perches <joe@perches.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v6] ANDROID: binder: change down_write to down_read
Message-ID: <20180517032333.GC151813@joelaf.mtv.corp.google.com>
References: <20180507141537.4855-1-minchan@kernel.org>
 <20180507172829.GA66161@joelaf.mtv.corp.google.com>
 <20180508105101.GB8209@rodete-desktop-imager.corp.google.com>
 <20180508230813.GA102094@joelaf.mtv.corp.google.com>
 <20180509064023.GD8209@rodete-desktop-imager.corp.google.com>
 <20180509231941.GA4790@joelaf.mtv.corp.google.com>
 <20180515062732.GA183759@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180515062732.GA183759@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 03:27:32PM +0900, Minchan Kim wrote:
> Hi Joel,
> 
> Sorry for the late response. I was off.
> 
> On Wed, May 09, 2018 at 04:19:41PM -0700, Joel Fernandes wrote:
> > On Wed, May 09, 2018 at 03:40:23PM +0900, Minchan Kim wrote:
> > > On Tue, May 08, 2018 at 04:08:13PM -0700, Joel Fernandes wrote:
> > > > On Tue, May 08, 2018 at 07:51:01PM +0900, Minchan Kim wrote:
> > > > > On Mon, May 07, 2018 at 10:28:29AM -0700, Joel Fernandes wrote:
> > > > > > On Mon, May 07, 2018 at 11:15:37PM +0900, Minchan Kim wrote:
> > > > > > > binder_update_page_range needs down_write of mmap_sem because
> > > > > > > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> > > > > > > it is set. However, when I profile binder working, it seems
> > > > > > > every binder buffers should be mapped in advance by binder_mmap.
> > > > > > > It means we could set VM_MIXEDMAP in binder_mmap time which is
> > > > > > > already hold a mmap_sem as down_write so binder_update_page_range
> > > > > > > doesn't need to hold a mmap_sem as down_write.
> > > > > > > Please use proper API down_read. It would help mmap_sem contention
> > > > > > > problem as well as fixing down_write abuse.
> > > > > > > 
> > > > > > > Ganesh Mahendran tested app launching and binder throughput test
> > > > > > > and he said he couldn't find any problem and I did binder latency
> > > > > > > test per Greg KH request(Thanks Martijn to teach me how I can do)
> > > > > > > I cannot find any problem, too.
> > > > > > > 
> > > > > > > Cc: Ganesh Mahendran <opensource.ganesh@gmail.com>
> > > > > > > Cc: Joe Perches <joe@perches.com>
> > > > > > > Cc: Arve Hjønnevåg <arve@android.com>
> > > > > > > Cc: Todd Kjos <tkjos@google.com>
> > > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > Reviewed-by: Martijn Coenen <maco@android.com>
> > > > > > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > > > > > ---
> > > > > > >  drivers/android/binder.c       | 4 +++-
> > > > > > >  drivers/android/binder_alloc.c | 6 +++---
> > > > > > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > > > > index 4eab5be3d00f..7b8e96f60719 100644
> > > > > > > --- a/drivers/android/binder.c
> > > > > > > +++ b/drivers/android/binder.c
> > > > > > > @@ -4730,7 +4730,9 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
> > > > > > >  		failure_string = "bad vm_flags";
> > > > > > >  		goto err_bad_arg;
> > > > > > >  	}
> > > > > > > -	vma->vm_flags = (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYWRITE;
> > > > > > > +	vma->vm_flags |= VM_DONTCOPY | VM_MIXEDMAP;
> > > > > > > +	vma->vm_flags &= ~VM_MAYWRITE;
> > > > > > > +
> > > > > > >  	vma->vm_ops = &binder_vm_ops;
> > > > > > >  	vma->vm_private_data = proc;
> > > > > > >  
> > > > > > > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > > > > > > index 5a426c877dfb..4f382d51def1 100644
> > > > > > > --- a/drivers/android/binder_alloc.c
> > > > > > > +++ b/drivers/android/binder_alloc.c
> > > > > > > @@ -219,7 +219,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
> > > > > > >  		mm = alloc->vma_vm_mm;
> > > > > > >  
> > > > > > >  	if (mm) {
> > > > > > > -		down_write(&mm->mmap_sem);
> > > > > > > +		down_read(&mm->mmap_sem);
> > > > > > 
> > > > > > 
> > > > > > Nice. Is there a need to hold the reader-lock at all here? Just curious what
> > > > > > else is it protecting (here or in vm_insert_page).
> > > > > 
> > > > > It should protect vm_area_struct. IOW, when we try insert page into virtual address area,
> > > > > vma shouldn't be changed(ie, unmap/collapse/split).
> > > > 
> > > > When you say unmap, are you talking about pages being unmapped from the VMA
> > > > or something else?
> > > 
> > > I mean to destroy vm_area_struct itself as well as unmap pages.
> > > 
> > > > 
> > > > For the collapse/split part, the binder VMA (vm_area_struct) itself isn't
> > > > changed after the initial mmap (AFAIK) so I don't see a need for protection
> > > > there.
> > > 
> > > There is no way to unmap in runtime? What happens if some buggy applications
> > > do unmap by mistake?
> > > Cannot we access those B's vma from A context?
> > > If B process is exiting, the VMA would be gone while A is accessing.
> > 
> > If the VMA is gone, then why is it a good idea to map pages into it anyway?
> 
> Hmm, sorry about that. I couldn't understand your point.

Sorry, I was just saying that we shouldn't hit a case where a process is dead
and we are trying to map pages into its VMA.

But considering this is a read mostly usecase, I think keeping the read lock
as you are doing would be fine for performance.

> > About the unmap at runtime part, your commit message was a bit confusing. You
> > said "every binder buffers should be mapped in advance by binder_mmap." but I
> > think the new binder shrinker mechanism doesn't make that true anymore.
> 
> It's good point. I didn't know know that.
> When I see binder_vm_fault, it emits SIGBUS. That means shrinker cannot zap pages
> process is using, I think. IOW, every pages for binder are mapped at mmap time
> and is never mapped in runtime by page fault. Right?

Hmm, so the shrinker doesn't touch pages that the process are using. The
shrinker maintains an LRU list which is populated only once pages are not
needed anymore.

Before the shrinker was added, the pages would be unmapped and freed when
they were no longer needed. After the shrinker was added, they are kept
allocated and mapped, and are added to an LRU list. The exact diff that does
this is from commit f2517eb76f ("android: binder: Add global lru shrinker to
binder") is below.

Coming back the point of pages mapped in advance, my assertion is - both in
previous code before the shrinker was added and in current code, the pages
are not all to be mapped in advance. Before it was aggressively freed and
unmapped, now its a lazy approach and I believe the point is to avoid
contention on locks used in the aggressive approach.

thanks,

- Joel
-----------------

@@ -264,16 +289,21 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 free_range:
 	for (page_addr = end - PAGE_SIZE; page_addr >= start;
 	     page_addr -= PAGE_SIZE) {
+		bool ret;
+
 		page = &alloc->pages[(page_addr - alloc->buffer) / PAGE_SIZE];
-		if (vma)
-			zap_page_range(vma, (uintptr_t)page_addr +
-				alloc->user_buffer_offset, PAGE_SIZE);
+
+		ret = list_lru_add(&binder_alloc_lru, &page->lru);
+		WARN_ON(!ret);
+		continue;
+
 err_vm_insert_page_failed:
 		unmap_kernel_range((unsigned long)page_addr, PAGE_SIZE);
 err_map_kernel_failed:
-		__free_page(*page);
-		*page = NULL;
+		__free_page(page->page_ptr);
+		page->page_ptr = NULL;
 err_alloc_page_failed:
+err_page_ptr_cleared:
 		;
 	}
 err_no_vma:
