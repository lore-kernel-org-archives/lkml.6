Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeDISuV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:50:21 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37932 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751767AbeDISuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:50:19 -0400
X-Google-Smtp-Source: AIpwx4/K7nM/Fxbd+kJqez5SLo+flO6TkvqXlgiXDq6nqNiSr0MExbtczSbuBHgEIuhGut1dBS6dVQ==
Date: Mon, 9 Apr 2018 11:50:16 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ipc/shm: fix use-after-free of shm file via
 remap_file_pages()
Message-ID: <20180409185016.GA203367@gmail.com>
References: <94eb2c06f65e5e2467055d036889@google.com>
 <20180409043039.28915-1-ebiggers3@gmail.com>
 <20180409094813.bsjc3u2hnsrdyiuk@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409094813.bsjc3u2hnsrdyiuk@black.fi.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 12:48:14PM +0300, Kirill A. Shutemov wrote:
> On Mon, Apr 09, 2018 at 04:30:39AM +0000, Eric Biggers wrote:
> > diff --git a/ipc/shm.c b/ipc/shm.c
> > index acefe44fefefa..c80c5691a9970 100644
> > --- a/ipc/shm.c
> > +++ b/ipc/shm.c
> > @@ -225,6 +225,12 @@ static int __shm_open(struct vm_area_struct *vma)
> >  	if (IS_ERR(shp))
> >  		return PTR_ERR(shp);
> >  
> > +	if (shp->shm_file != sfd->file) {
> > +		/* ID was reused */
> > +		shm_unlock(shp);
> > +		return -EINVAL;
> > +	}
> > +
> >  	shp->shm_atim = ktime_get_real_seconds();
> >  	ipc_update_pid(&shp->shm_lprid, task_tgid(current));
> >  	shp->shm_nattch++;
> > @@ -455,8 +461,9 @@ static int shm_mmap(struct file *file, struct vm_area_struct *vma)
> >  	int ret;
> >  
> >  	/*
> > -	 * In case of remap_file_pages() emulation, the file can represent
> > -	 * removed IPC ID: propogate shm_lock() error to caller.
> > +	 * In case of remap_file_pages() emulation, the file can represent an
> > +	 * IPC ID that was removed, and possibly even reused by another shm
> > +	 * segment already.  Propagate this case as an error to caller.
> >  	 */
> >  	ret = __shm_open(vma);
> >  	if (ret)
> > @@ -480,6 +487,7 @@ static int shm_release(struct inode *ino, struct file *file)
> >  	struct shm_file_data *sfd = shm_file_data(file);
> >  
> >  	put_ipc_ns(sfd->ns);
> > +	fput(sfd->file);
> >  	shm_file_data(file) = NULL;
> >  	kfree(sfd);
> >  	return 0;
> > @@ -1432,7 +1440,7 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
> >  	file->f_mapping = shp->shm_file->f_mapping;
> >  	sfd->id = shp->shm_perm.id;
> >  	sfd->ns = get_ipc_ns(ns);
> > -	sfd->file = shp->shm_file;
> > +	sfd->file = get_file(shp->shm_file);
> >  	sfd->vm_ops = NULL;
> >  
> >  	err = security_mmap_file(file, prot, flags);
> 
> Hm. Why do we need sfd->file refcounting now? It's not obvious to me.
> 
> Looks like it's either a separate bug or an unneeded change.
> 

It's necessary because if we don't hold a reference to sfd->file, then it can be
a stale pointer when we compare it in __shm_open().  In particular, if the new
struct file happened to be allocated at the same address as the old one, then
'sfd->file == shp->shm_file' so the mmap would be allowed.  But, it will be a
different shm segment than was intended.  The caller may not even have
permissions to map it normally, yet it would be done anyway.

In the end it's just broken to have a pointer to something that can be freed out
from under you...

- Eric
