Date: Sat, 24 Feb 2018 09:26:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+76e7efc4748495855a4d@syzkaller.appspotmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH 4.4 013/193] staging: android: ion: Add __GFP_NOWARN for
 system contig heap
Message-ID: <20180224082625.GA9681@kroah.com>
References: <20180223170325.997716448@linuxfoundation.org>
 <20180223170328.219713270@linuxfoundation.org>
 <20180223204608.GA6714@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223204608.GA6714@flashbox>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 01:46:08PM -0700, Nathan Chancellor wrote:
> On Fri, Feb 23, 2018 at 07:24:06PM +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Laura Abbott <labbott@redhat.com>
> > 
> > commit 0c75f10312a35b149b2cebb1832316b35c2337ca upstream.
> > 
> > syzbot reported a warning from Ion:
> > 
> >   WARNING: CPU: 1 PID: 3485 at mm/page_alloc.c:3926
> > 
> >   ...
> >    __alloc_pages_nodemask+0x9fb/0xd80 mm/page_alloc.c:4252
> >   alloc_pages_current+0xb6/0x1e0 mm/mempolicy.c:2036
> >   alloc_pages include/linux/gfp.h:492 [inline]
> >   ion_system_contig_heap_allocate+0x40/0x2c0
> >   drivers/staging/android/ion/ion_system_heap.c:374
> >   ion_buffer_create drivers/staging/android/ion/ion.c:93 [inline]
> >   ion_alloc+0x2c1/0x9e0 drivers/staging/android/ion/ion.c:420
> >   ion_ioctl+0x26d/0x380 drivers/staging/android/ion/ion-ioctl.c:84
> >   vfs_ioctl fs/ioctl.c:46 [inline]
> >   do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
> >   SYSC_ioctl fs/ioctl.c:701 [inline]
> >   SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
> > 
> > This is a warning about attempting to allocate order > MAX_ORDER. This
> > is coming from a userspace Ion allocation request. Since userspace is
> > free to request however much memory it wants (and the kernel is free to
> > deny its allocation), silence the allocation attempt with __GFP_NOWARN
> > in case it fails.
> > 
> > Reported-by: syzbot+76e7efc4748495855a4d@syzkaller.appspotmail.com
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Signed-off-by: Laura Abbott <labbott@redhat.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > ---
> >  drivers/staging/android/ion/ion_system_heap.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/drivers/staging/android/ion/ion_system_heap.c
> > +++ b/drivers/staging/android/ion/ion_system_heap.c
> > @@ -336,7 +336,7 @@ static int ion_system_contig_heap_alloca
> >  	if (align > (PAGE_SIZE << order))
> >  		return -EINVAL;
> >  
> > -	page = alloc_pages(low_order_gfp_flags, order);
> > +	page = alloc_pages(low_order_gfp_flags | __GFP_NOWARN, order);
> >  	if (!page)
> >  		return -ENOMEM;
> >  
> > 
> >
> 
> This commit is not necessary as __GFP_NOWARN is still in the global
> low_order_gfp_flags since commit d2805d7fff5b ("staging: ion: remove
> __GFP_NOWARN when use low order gfp flags") did not show up until 4.9.
> This also applies to 3.18.

Ah, good catch, now fixed by dropping this patch from 4.4.y and 3.18.y,
thanks.

greg k-h
