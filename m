Return-Path: <joel@joelfernandes.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525820895; cv=none;
        d=google.com; s=arc-20160816;
        b=mmyaBJv1DdMcYk29wPt4Y05n4E6z/jW3er6iyBOOfrAIDCYJPpBpNmnc5PZNlrY5l9
         vC59jhPaJDbj1grqXpxWxLphdpoEB/fXh7p3JSoYcc8bTR8SIZQZF5P/VByDoqf0mqLM
         YeBJLeVn1Nhboca0M0QMBV9fgQhH6ZFpUOrDZ508LacMB2ywXtGiRVQlmBNOJ9Vdt9C7
         HTjWk/rtiNGcr4BYWE3Dv5l/32I3tpdl62J12hWuKU5IlYiOzbQWz+I9nrGwKPbQXS/W
         +diRjk34HbvDx9FJFbYyNdju/dBcDDDyq6576N/TSuAR52heYNeBG4h97sp4fu8Kusdu
         Ogmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=4e1m7bEZTdWTIwkFukaR2xOJrWi3dJevGbhj+sWS/QM=;
        b=xVckuNa4NBttDqkxVOfg08MDAF3lBQgw0cq+Bi+7olu0O+74rvr8YAFgNGtyFL8wO6
         0Ce5UVNK8GNK791XkNCdgUaLOxHd8zms0/cLFxhqsGxBEd3U4MSBYJ9C3tWvGEJYaDk/
         wOGcsblaY9v4H62wIq9J7D9tx5kOVejAbZK4oFC4sjh8pwdsVZkma7Ffbg83UWe9nu62
         cfKAiva3ZsvkCjotrODCRnTmwoCWFPb9bLR9TyIJ+/nWl4ZTCnzULfPJ5ZNLs8mSsRzi
         6yUZkCvT5QfvIidagxd6hbEXiDfgv1UoniTlV1TJbN9IYW1V0rRO1kKQvLsVjxZi1uiU
         gADA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@joelfernandes-org.20150623.gappssmtp.com header.s=20150623 header.b=uuQhuKVi;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of joel@joelfernandes.org) smtp.mailfrom=joel@joelfernandes.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@joelfernandes-org.20150623.gappssmtp.com header.s=20150623 header.b=uuQhuKVi;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of joel@joelfernandes.org) smtp.mailfrom=joel@joelfernandes.org
X-Google-Smtp-Source: AB8JxZqKha2myqJXkmXf7MO3I0Zspyi8W2jtg1Qd+Jwxr1e0fEd56ZFWocMiPubeuidKVj2WcqWLCg==
Date: Tue, 8 May 2018 16:08:13 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Minchan Kim <minchan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ganesh Mahendran <opensource.ganesh@gmail.com>,
	Joe Perches <joe@perches.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v6] ANDROID: binder: change down_write to down_read
Message-ID: <20180508230813.GA102094@joelaf.mtv.corp.google.com>
References: <20180507141537.4855-1-minchan@kernel.org>
 <20180507172829.GA66161@joelaf.mtv.corp.google.com>
 <20180508105101.GB8209@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180508105101.GB8209@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599815073448562806?=
X-GMAIL-MSGID: =?utf-8?q?1599939171157420358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 07:51:01PM +0900, Minchan Kim wrote:
> On Mon, May 07, 2018 at 10:28:29AM -0700, Joel Fernandes wrote:
> > On Mon, May 07, 2018 at 11:15:37PM +0900, Minchan Kim wrote:
> > > binder_update_page_range needs down_write of mmap_sem because
> > > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> > > it is set. However, when I profile binder working, it seems
> > > every binder buffers should be mapped in advance by binder_mmap.
> > > It means we could set VM_MIXEDMAP in binder_mmap time which is
> > > already hold a mmap_sem as down_write so binder_update_page_range
> > > doesn't need to hold a mmap_sem as down_write.
> > > Please use proper API down_read. It would help mmap_sem contention
> > > problem as well as fixing down_write abuse.
> > > 
> > > Ganesh Mahendran tested app launching and binder throughput test
> > > and he said he couldn't find any problem and I did binder latency
> > > test per Greg KH request(Thanks Martijn to teach me how I can do)
> > > I cannot find any problem, too.
> > > 
> > > Cc: Ganesh Mahendran <opensource.ganesh@gmail.com>
> > > Cc: Joe Perches <joe@perches.com>
> > > Cc: Arve Hjønnevåg <arve@android.com>
> > > Cc: Todd Kjos <tkjos@google.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Reviewed-by: Martijn Coenen <maco@android.com>
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > ---
> > >  drivers/android/binder.c       | 4 +++-
> > >  drivers/android/binder_alloc.c | 6 +++---
> > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index 4eab5be3d00f..7b8e96f60719 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -4730,7 +4730,9 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
> > >  		failure_string = "bad vm_flags";
> > >  		goto err_bad_arg;
> > >  	}
> > > -	vma->vm_flags = (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYWRITE;
> > > +	vma->vm_flags |= VM_DONTCOPY | VM_MIXEDMAP;
> > > +	vma->vm_flags &= ~VM_MAYWRITE;
> > > +
> > >  	vma->vm_ops = &binder_vm_ops;
> > >  	vma->vm_private_data = proc;
> > >  
> > > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > > index 5a426c877dfb..4f382d51def1 100644
> > > --- a/drivers/android/binder_alloc.c
> > > +++ b/drivers/android/binder_alloc.c
> > > @@ -219,7 +219,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
> > >  		mm = alloc->vma_vm_mm;
> > >  
> > >  	if (mm) {
> > > -		down_write(&mm->mmap_sem);
> > > +		down_read(&mm->mmap_sem);
> > 
> > 
> > Nice. Is there a need to hold the reader-lock at all here? Just curious what
> > else is it protecting (here or in vm_insert_page).
> 
> It should protect vm_area_struct. IOW, when we try insert page into virtual address area,
> vma shouldn't be changed(ie, unmap/collapse/split).

When you say unmap, are you talking about pages being unmapped from the VMA
or something else?

For the collapse/split part, the binder VMA (vm_area_struct) itself isn't
changed after the initial mmap (AFAIK) so I don't see a need for protection
there.

Again, I'm not against the patch but thought its good to clarify for myself
what the usage of the lock is, here.

thanks,

- Joel
