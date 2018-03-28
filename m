Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522219635; cv=none;
        d=google.com; s=arc-20160816;
        b=MgWqOPZ+ZmU8Fsx80tp+XALvz4ddv0IbLeIsNJu9bJYIE+cfiINn3H8yh40dLB+2gi
         pB9NCo9a+C50rB9SRyrgtIGLRBUYbVLdcbbIM2iZZZY3YlPtNKyB40eBRIDBENe7+YKt
         Ly7TIHFlquDABYoxBP4yCyhcXfIpRF4pieCTvmP/Z49KqxXmtNCZMdSYHCgQjC27nS0A
         8s1G0nej6Kn122IRlaj6fk8NTv8CbcVSHn0IzOCkfSbauTfrAvzRDXvkeDgA2LCh4e5s
         W8HbFxkuBIb7ZbPGLXZnfN/DhcAA819wylGbim5aRjenLa1+6ymWf91s9S1IMx3rQXvz
         CJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=/fGuBi//+vPI3ZSMXSb/7cJRqEJsW1h7hvlWUlx532g=;
        b=hQIThMZTJxCIyR6MHZc0xBgC//aW0es4Ht4zQAapJUNuQPyCp48SNWE0mtkjURu56C
         DWQvTDV1XwMUs1Ukt6wBq2q01+d1oLCtDc57MdJlxO1fhZFfA0ojG3kHRJvNGpYn/Cjw
         PeKVFuA8NdR3O2KwA6ucC00GOwjKsdws8Y8OESpwfKcnc6A3LqEE4idBkcuCunArxNiS
         aiFzxN+CE/ZQEeU3JTHJR/vz3y+N1uOprJjNZnTxYztmQrd2COle/LGYKcPZV2rr9ADy
         /vqUabD4YPUuLgAL3o1Wxw5pK2/LiF3hQTfvg0bT6w203mhWb23qPLvgJ3DvWBN3PHNT
         +RqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Fkpzm3po;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Fkpzm3po;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AG47ELtoVaEiL3E3kDvJUZ4su4y6trMVZZ32SmaHYxSuAq0TbcNPGxMG8+ngxRhxGDnesU09fHsHSg==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Wed, 28 Mar 2018 15:47:08 +0900
From: Minchan Kim <minchan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Martijn Coenen <maco@android.com>,
	Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] ANDROID: binder: change down_write to down_read
Message-ID: <20180328064708.GA44818@rodete-desktop-imager.corp.google.com>
References: <20180328024231.239725-1-minchan@kernel.org>
 <20180328055354.GC6212@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328055354.GC6212@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596147613657109396?=
X-GMAIL-MSGID: =?utf-8?q?1596162976376022446?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 07:53:54AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Mar 28, 2018 at 11:42:31AM +0900, Minchan Kim wrote:
> > binder_update_page_range needs down_write of mmap_sem because
> > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> > it is set. However, when I profile binder working, it seems
> > every binder buffers should be mapped in advance by binder_mmap.
> > It means we could set VM_MIXEDMAP in bider_mmap time which is
> > already hold a mmap_sem as down_write so binder_update_page_range
> > doesn't need to hold a mmap_sem as down_write.
> > 
> > Android suffers from mmap_sem contention so let's reduce mmap_sem
> > down_write.
> > 
> > Cc: Martijn Coenen <maco@android.com>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  drivers/android/binder.c       | 2 +-
> >  drivers/android/binder_alloc.c | 8 +++++---
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index 764b63a5aade..9a14c6dd60c4 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -4722,7 +4722,7 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
> >  		failure_string = "bad vm_flags";
> >  		goto err_bad_arg;
> >  	}
> > -	vma->vm_flags = (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYWRITE;
> > +	vma->vm_flags |= (VM_DONTCOPY | VM_MIXEDMAP) & ~VM_MAYWRITE;
> >  	vma->vm_ops = &binder_vm_ops;
> >  	vma->vm_private_data = proc;
> >  
> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > index 5a426c877dfb..a184bf12eb15 100644
> > --- a/drivers/android/binder_alloc.c
> > +++ b/drivers/android/binder_alloc.c
> > @@ -219,7 +219,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
> >  		mm = alloc->vma_vm_mm;
> >  
> >  	if (mm) {
> > -		down_write(&mm->mmap_sem);
> > +		down_read(&mm->mmap_sem);
> >  		vma = alloc->vma;
> >  	}
> >  
> > @@ -229,6 +229,8 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
> >  		goto err_no_vma;
> >  	}
> >  
> > +	WARN_ON_ONCE(vma && !(vma->vm_flags & VM_MIXEDMAP));
> 
> What can we do with this warning?  What about systems that run in 'panic
> on warn' mode?  Is this something we should handle directly instead?

Hmm, it seems we don't need above warning there because vm_insert_page will hit
BUG_ON in that case. I will remove it at respin. Thanks for the review, Greg.

I will wait other binder maintainer's opinion about below question.

> > it seems
> > every binder buffers should be mapped in advance by binder_mmap.
