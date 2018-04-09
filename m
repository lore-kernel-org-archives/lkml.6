Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523313582; cv=none;
        d=google.com; s=arc-20160816;
        b=fGI6i2+BmdM4tIkdw+amFGheNYzJZSf4olmm5O3MQk6JxsaONGaytsDhg3smSsIqZb
         a6vkZ5UutcdGQNQ86To8lfK6iXd5j2WTpyCfVk2FvfMcrbNmT9X52NtVuiTq27zdBODI
         xl8N+H+cfznIgOEuh1JqdJ2Ve7atrCQzCsEdSpHVPcZ+kqfeqwlfEyP5bRpeMm6S52/T
         oTx0plTNO/pxm0YOpAhOvMIFMerW7IhE2iRaVVncGdCS0xUivtJbIsq1h+l6A6cSUML6
         dlcp+GfYSu5LpmfXi+Ne9kE/B1sc42Mn3PdMPVZZrRc0775ioYwUOgmy2F3XNUUdlvdM
         cKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=gHQXFv/Giqc4Pc4ZcSCWJdMwyZ435t8FsIJv8f2HOKo=;
        b=sx+BKHThmenW2CsPmCr9Xr3btgYtX63dh5GUWL42cx0LKwu/IiwpPUwoUbe2p1JtEJ
         bCVojLHt/r8dPvHAMzbTjDnWXdf3loKkcb38byEzJ7Si2btaoAR7pUzAwY/WiOp6REkD
         tie6tTPGM8WuHqrR8Dsl4KGbqGcxRoB+gFxIRODXkHPGzXV4DVtTZiQ6c23b488QM5+2
         OzDSfJQjLyYfkkYjOHZOkMRWAAFmSCumBUpg+WWt0bxhb5ZNxDUZ/ro0V2i/b4Vt02PG
         kOkjj880b51NK9gJ1fFgqfqEIJ/VF1RIgWP0u2Ljl2ysQWQfKWkPKDPvoSZ/QyGdJcWn
         mZVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Xn4hRuj3;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Xn4hRuj3;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/ZNc7vjTETo9Jkzjj88ar17UweH+xQNvC8r2PkSGFu3PsUjVt0z2xj6mVvgSQ+XShMjx4O3Q==
Date: Tue, 10 Apr 2018 07:39:36 +0900
From: Minchan Kim <minchan.kim@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Minchan Kim <minchan@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Sergey
 Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v3 4/4] zram: introduce zram memory tracking
Message-Id: <20180410073936.a5de18504dd27e317474d197@gmail.com>
In-Reply-To: <20180409080345.GC18095@kroah.com>
References: <20180409055435.135695-1-minchan@kernel.org>
	<20180409055435.135695-5-minchan@kernel.org>
	<20180409080345.GC18095@kroah.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597246846962715384?=
X-GMAIL-MSGID: =?utf-8?q?1597310062792447606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 9 Apr 2018 10:03:45 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Apr 09, 2018 at 02:54:35PM +0900, Minchan Kim wrote:
> > zRam as swap is useful for small memory device. However, swap means
> > those pages on zram are mostly cold pages due to VM's LRU algorithm.
> > Especially, once init data for application are touched for launching,
> > they tend to be not accessed any more and finally swapped out.
> > zRAM can store such cold pages as compressed form but it's pointless
> > to keep in memory. Better idea is app developers free them directly
> > rather than remaining them on heap.
> > 
> > This patch tell us last access time of each block of zram via
> > "cat /sys/kernel/debug/zram/zram0/block_state".
> > 
> > The output is as follows,
> >       300    75.033841 .wh
> >       301    63.806904 s..
> >       302    63.806919 ..h
> > 
> > First column is zram's block index and 3rh one represents symbol
> > (s: same page w: written page to backing store h: huge page) of the
> > block state. Second column represents usec time unit of the block
> > was last accessed. So above example means the 300th block is accessed
> > at 75.033851 second and it was huge so it was written to the backing
> > store.
> > 
> > Admin can leverage this information to catch cold|incompressible pages
> > of process with *pagemap* once part of heaps are swapped out.
> > 
> > Cc: Greg KH <gregkh@linuxfoundation.org>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  Documentation/blockdev/zram.txt |  24 ++++++
> >  drivers/block/zram/Kconfig      |   9 +++
> >  drivers/block/zram/zram_drv.c   | 139 +++++++++++++++++++++++++++++---
> >  drivers/block/zram/zram_drv.h   |   5 ++
> >  4 files changed, 166 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
> > index 78db38d02bc9..45509c7d5716 100644
> > --- a/Documentation/blockdev/zram.txt
> > +++ b/Documentation/blockdev/zram.txt
> > @@ -243,5 +243,29 @@ to backing storage rather than keeping it in memory.
> >  User should set up backing device via /sys/block/zramX/backing_dev
> >  before disksize setting.
> >  
> > += memory tracking
> > +
> > +With CONFIG_ZRAM_MEMORY_TRACKING, user can know information of the
> > +zram block. It could be useful to catch cold or incompressible
> > +pages of the proess with*pagemap.
> > +If you enable the feature, you could see block state via
> > +/sys/kernel/debug/zram/zram0/block_state". The output is as follows,
> > +
> > +	  300    75.033841 .wh
> > +	  301    63.806904 s..
> > +	  302    63.806919 ..h
> > +
> > +First column is zram's block index.
> > +Second column is access time.
> > +Third column is state of the block.
> > +(s: same page
> > +w: written page to backing store
> > +h: huge page)
> > +
> > +First line of above example says 300th block is accessed at 75.033841sec
> > +and the block's state is huge so it is written back to the backing
> > +storage. It's a debugging feature so anyone shouldn't rely on it to work
> > +properly.
> > +
> >  Nitin Gupta
> >  ngupta@vflare.org
> > diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> > index ac3a31d433b2..efe60c82d8ec 100644
> > --- a/drivers/block/zram/Kconfig
> > +++ b/drivers/block/zram/Kconfig
> > @@ -26,3 +26,12 @@ config ZRAM_WRITEBACK
> >  	 /sys/block/zramX/backing_dev.
> >  
> >  	 See zram.txt for more infomration.
> > +
> > +config ZRAM_MEMORY_TRACKING
> > +	bool "Tracking zram block status"
> > +	depends on ZRAM
> > +	select DEBUG_FS
> 
> Select?  Shouldn't you depend on this instead?  Selecting is a pain to
> try to track down what is keeping an option enabled.

Okay, I will modify.

> 
> > +	help
> > +	  With this feature, admin can track the state of allocated block
> > +	  of zRAM. Admin could see the information via
> > +	  /sys/kernel/debug/zram/zramX/block_state.
> 
> A short note here as to where to find the documentation for what that
> info is (i.e. in the file you wrote above?)

Yub. Will change.

> 
> > +#else
> > +static void zram_debugfs_create(void) {};
> > +static void zram_debugfs_destroy(void) {};
> > +static void zram_accessed(struct zram *zram, u32 index) {};
> > +static void zram_reset_access(struct zram *zram, u32 index) {};
> > +static void zram_debugfs_register(struct zram *zram) {};
> > +static void zram_debugfs_unregister(struct zram *zram) {};
> > +#endif
> 
> Much nicer, thanks!
> 
> The above was only very minor nits, no need to change anything if you
> don't want to.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I will wait a few days for getting review from Sergey and resend it with
fix.
Thanks for the review, Greg.
