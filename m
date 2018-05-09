Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525848030; cv=none;
        d=google.com; s=arc-20160816;
        b=ijpNbgA7XDqDyrlGoosjmjHExC3UvUgXx5QoqRFwiNGq/h2Vg95pNC4GMeGbE1vSJx
         75X+6sne7R2u4Q/ZZ93Bydd3Z+/7JFyE1HtADSYGZ+as+JEp2NaLcWD7uQTMJLTxUZVR
         1gdf4t8wqOIIsMyhF+X948ENHQ93p7raiwP9rGRdbMBFHoYCsgDTkhCRZiArLI6weH5s
         bxxXmjTRTbrbmyWe2LU0dfmPgy57inx7LPpFGFsEw1n51W110atyWN+KnL/YDYq/wq5G
         riGjeftQMQkwiQdrb/XN8D9rkHLFAsd4im+dJVzOa5cxZLV6c9jVyUMXDC1+xh2v+Ajh
         WuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:dkim-signature:arc-authentication-results;
        bh=jmT6t/ypt9+N0gocVV4oi3406yefm0WeWZGciTKVSj8=;
        b=KC0FLzGtZoLU8yx0aVsDOa6SthknRilbECFlnFFhCRxBVLeNy7rrB6sABKQL42HROI
         uXTKTeBsAFYQwcTPl9g4PiUvxBq6dDxiHIZK7ZYkp/jNToMzyY+q7TUQl6qE+KpRJ1Hz
         gVdFK2UEefyCtio4PABs4M2FbI6uaguLAb9XIujXZVajN+Upx3wTPHIpZDd5DeFvlE8I
         /iPW/swpMCNs+PtvgedOB5SIT1PWuUnHdSs6uDhwdaxDsN+Nz3h7dNxcjsBigsSGbsWA
         a/bZxR4vbnVxgF41FEVPy7rlqSfRcXxv3evaJGQ0HFICA8ze9MCequ5vuWt7u+TmEbcg
         D2DQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RzYP1mFx;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RzYP1mFx;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZo3H38/knW1ZUKIjvHoDv3nU63EZVUDH/HF1n8sicYp/EIcMsXNN7xZeYHS83fCKRgH2XS4Kg==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Wed, 9 May 2018 15:40:23 +0900
From: Minchan Kim <minchan@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ganesh Mahendran <opensource.ganesh@gmail.com>,
	Joe Perches <joe@perches.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v6] ANDROID: binder: change down_write to down_read
Message-ID: <20180509064023.GD8209@rodete-desktop-imager.corp.google.com>
References: <20180507141537.4855-1-minchan@kernel.org>
 <20180507172829.GA66161@joelaf.mtv.corp.google.com>
 <20180508105101.GB8209@rodete-desktop-imager.corp.google.com>
 <20180508230813.GA102094@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180508230813.GA102094@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599815073448562806?=
X-GMAIL-MSGID: =?utf-8?q?1599967624191161179?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 04:08:13PM -0700, Joel Fernandes wrote:
> On Tue, May 08, 2018 at 07:51:01PM +0900, Minchan Kim wrote:
> > On Mon, May 07, 2018 at 10:28:29AM -0700, Joel Fernandes wrote:
> > > On Mon, May 07, 2018 at 11:15:37PM +0900, Minchan Kim wrote:
> > > > binder_update_page_range needs down_write of mmap_sem because
> > > > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> > > > it is set. However, when I profile binder working, it seems
> > > > every binder buffers should be mapped in advance by binder_mmap.
> > > > It means we could set VM_MIXEDMAP in binder_mmap time which is
> > > > already hold a mmap_sem as down_write so binder_update_page_range
> > > > doesn't need to hold a mmap_sem as down_write.
> > > > Please use proper API down_read. It would help mmap_sem contention
> > > > problem as well as fixing down_write abuse.
> > > > 
> > > > Ganesh Mahendran tested app launching and binder throughput test
> > > > and he said he couldn't find any problem and I did binder latency
> > > > test per Greg KH request(Thanks Martijn to teach me how I can do)
> > > > I cannot find any problem, too.
> > > > 
> > > > Cc: Ganesh Mahendran <opensource.ganesh@gmail.com>
> > > > Cc: Joe Perches <joe@perches.com>
> > > > Cc: Arve Hjønnevåg <arve@android.com>
> > > > Cc: Todd Kjos <tkjos@google.com>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Reviewed-by: Martijn Coenen <maco@android.com>
> > > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > > ---
> > > >  drivers/android/binder.c       | 4 +++-
> > > >  drivers/android/binder_alloc.c | 6 +++---
> > > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > index 4eab5be3d00f..7b8e96f60719 100644
> > > > --- a/drivers/android/binder.c
> > > > +++ b/drivers/android/binder.c
> > > > @@ -4730,7 +4730,9 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
> > > >  		failure_string = "bad vm_flags";
> > > >  		goto err_bad_arg;
> > > >  	}
> > > > -	vma->vm_flags = (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYWRITE;
> > > > +	vma->vm_flags |= VM_DONTCOPY | VM_MIXEDMAP;
> > > > +	vma->vm_flags &= ~VM_MAYWRITE;
> > > > +
> > > >  	vma->vm_ops = &binder_vm_ops;
> > > >  	vma->vm_private_data = proc;
> > > >  
> > > > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > > > index 5a426c877dfb..4f382d51def1 100644
> > > > --- a/drivers/android/binder_alloc.c
> > > > +++ b/drivers/android/binder_alloc.c
> > > > @@ -219,7 +219,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
> > > >  		mm = alloc->vma_vm_mm;
> > > >  
> > > >  	if (mm) {
> > > > -		down_write(&mm->mmap_sem);
> > > > +		down_read(&mm->mmap_sem);
> > > 
> > > 
> > > Nice. Is there a need to hold the reader-lock at all here? Just curious what
> > > else is it protecting (here or in vm_insert_page).
> > 
> > It should protect vm_area_struct. IOW, when we try insert page into virtual address area,
> > vma shouldn't be changed(ie, unmap/collapse/split).
> 
> When you say unmap, are you talking about pages being unmapped from the VMA
> or something else?

I mean to destroy vm_area_struct itself as well as unmap pages.

> 
> For the collapse/split part, the binder VMA (vm_area_struct) itself isn't
> changed after the initial mmap (AFAIK) so I don't see a need for protection
> there.

There is no way to unmap in runtime? What happens if some buggy applications
do unmap by mistake?
Cannot we access those B's vma from A context?
If B process is exiting, the VMA would be gone while A is accessing.

> 
> Again, I'm not against the patch but thought its good to clarify for myself
> what the usage of the lock is, here.

I know. :)
