Return-Path: <joel@joelfernandes.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525907983; cv=none;
        d=google.com; s=arc-20160816;
        b=CN3QThhzEueTUr42el7VAEB2xJjj0+ZbDuFVoSVTYy6U1J7fTIMpubH/iZf0Ucj/fL
         X312uAHlffPLSPMPnFzFmTpJfi+wm3nHBGESLy41uYUubsI0KCE9g1/4Svq0FGCAId94
         tr1/wkpvqY2ZISb3lb5VCYXHorvMF+3dxGS0JKD7k1TfYNoHYU/wUkLya397vj6Ql0bn
         DQ0FnUwbRd59/6s1/4rShkYUInFnw3dE3gjlM3Wn7WrvTN2UErc0Z4UEJ46AmlbrQ+uM
         bV61gj28NK02Vy/CocpoRG7Pwn7JbRYanGv4kxV9xOsr0u6o2cSLjn+OOtwMWL9wAojQ
         blBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=YqbweGF0wvn1Z4SAKNrfAhkoygY4bosf+n3c0X9OEjk=;
        b=eg/Vfd5z+uDcEwei076WTVlKFGSCgPPjzCgMzUdZ52T63sumtlGppWR22re7iOsMm1
         QLNRhQ5+UhwbPeYGNABK8n9meVgN0SLBxDDFfbTpJESU7Vsw1XdXiusQIwn7+iG0MwSa
         yR7UBxNEMjmlbvg93ruz4J1OucP1e1DSzh8AuFy0aJyXES9VZA2rxYhglT+jeSAZZtoY
         6clEkOp7NHAnK78TZ87ZryZkd4sh53p913s4U8T0BjnzM7eNqz3aI7lcataYaxZ2SdYi
         qZ6K+GssLSwiThdsc7fFrkjNaOUVPDiyf2eXWKVKlupJVe36EmAclfChuUXdWUQdUnzr
         G+mQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@joelfernandes-org.20150623.gappssmtp.com header.s=20150623 header.b=UGzQgyFJ;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of joel@joelfernandes.org) smtp.mailfrom=joel@joelfernandes.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@joelfernandes-org.20150623.gappssmtp.com header.s=20150623 header.b=UGzQgyFJ;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of joel@joelfernandes.org) smtp.mailfrom=joel@joelfernandes.org
X-Google-Smtp-Source: AB8JxZqIpgZiJTdqINo643jKC5x1UZPHdTnKKp6SHYhfpTaxThtu+MMDDnZvTnneob+yr5DwMpdvhA==
Date: Wed, 9 May 2018 16:19:41 -0700
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
Message-ID: <20180509231941.GA4790@joelaf.mtv.corp.google.com>
References: <20180507141537.4855-1-minchan@kernel.org>
 <20180507172829.GA66161@joelaf.mtv.corp.google.com>
 <20180508105101.GB8209@rodete-desktop-imager.corp.google.com>
 <20180508230813.GA102094@joelaf.mtv.corp.google.com>
 <20180509064023.GD8209@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180509064023.GD8209@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599815073448562806?=
X-GMAIL-MSGID: =?utf-8?q?1600030490147122907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 03:40:23PM +0900, Minchan Kim wrote:
> On Tue, May 08, 2018 at 04:08:13PM -0700, Joel Fernandes wrote:
> > On Tue, May 08, 2018 at 07:51:01PM +0900, Minchan Kim wrote:
> > > On Mon, May 07, 2018 at 10:28:29AM -0700, Joel Fernandes wrote:
> > > > On Mon, May 07, 2018 at 11:15:37PM +0900, Minchan Kim wrote:
> > > > > binder_update_page_range needs down_write of mmap_sem because
> > > > > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> > > > > it is set. However, when I profile binder working, it seems
> > > > > every binder buffers should be mapped in advance by binder_mmap.
> > > > > It means we could set VM_MIXEDMAP in binder_mmap time which is
> > > > > already hold a mmap_sem as down_write so binder_update_page_range
> > > > > doesn't need to hold a mmap_sem as down_write.
> > > > > Please use proper API down_read. It would help mmap_sem contention
> > > > > problem as well as fixing down_write abuse.
> > > > > 
> > > > > Ganesh Mahendran tested app launching and binder throughput test
> > > > > and he said he couldn't find any problem and I did binder latency
> > > > > test per Greg KH request(Thanks Martijn to teach me how I can do)
> > > > > I cannot find any problem, too.
> > > > > 
> > > > > Cc: Ganesh Mahendran <opensource.ganesh@gmail.com>
> > > > > Cc: Joe Perches <joe@perches.com>
> > > > > Cc: Arve Hjønnevåg <arve@android.com>
> > > > > Cc: Todd Kjos <tkjos@google.com>
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Reviewed-by: Martijn Coenen <maco@android.com>
> > > > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > > > ---
> > > > >  drivers/android/binder.c       | 4 +++-
> > > > >  drivers/android/binder_alloc.c | 6 +++---
> > > > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > > index 4eab5be3d00f..7b8e96f60719 100644
> > > > > --- a/drivers/android/binder.c
> > > > > +++ b/drivers/android/binder.c
> > > > > @@ -4730,7 +4730,9 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
> > > > >  		failure_string = "bad vm_flags";
> > > > >  		goto err_bad_arg;
> > > > >  	}
> > > > > -	vma->vm_flags = (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYWRITE;
> > > > > +	vma->vm_flags |= VM_DONTCOPY | VM_MIXEDMAP;
> > > > > +	vma->vm_flags &= ~VM_MAYWRITE;
> > > > > +
> > > > >  	vma->vm_ops = &binder_vm_ops;
> > > > >  	vma->vm_private_data = proc;
> > > > >  
> > > > > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > > > > index 5a426c877dfb..4f382d51def1 100644
> > > > > --- a/drivers/android/binder_alloc.c
> > > > > +++ b/drivers/android/binder_alloc.c
> > > > > @@ -219,7 +219,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
> > > > >  		mm = alloc->vma_vm_mm;
> > > > >  
> > > > >  	if (mm) {
> > > > > -		down_write(&mm->mmap_sem);
> > > > > +		down_read(&mm->mmap_sem);
> > > > 
> > > > 
> > > > Nice. Is there a need to hold the reader-lock at all here? Just curious what
> > > > else is it protecting (here or in vm_insert_page).
> > > 
> > > It should protect vm_area_struct. IOW, when we try insert page into virtual address area,
> > > vma shouldn't be changed(ie, unmap/collapse/split).
> > 
> > When you say unmap, are you talking about pages being unmapped from the VMA
> > or something else?
> 
> I mean to destroy vm_area_struct itself as well as unmap pages.
> 
> > 
> > For the collapse/split part, the binder VMA (vm_area_struct) itself isn't
> > changed after the initial mmap (AFAIK) so I don't see a need for protection
> > there.
> 
> There is no way to unmap in runtime? What happens if some buggy applications
> do unmap by mistake?
> Cannot we access those B's vma from A context?
> If B process is exiting, the VMA would be gone while A is accessing.

If the VMA is gone, then why is it a good idea to map pages into it anyway?

About the unmap at runtime part, your commit message was a bit confusing. You
said "every binder buffers should be mapped in advance by binder_mmap." but I
think the new binder shrinker mechanism doesn't make that true anymore.

The unmap by mistake point is a valid one I guess.

thanks,

 - Joel
