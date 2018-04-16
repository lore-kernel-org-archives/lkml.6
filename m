Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523852768; cv=none;
        d=google.com; s=arc-20160816;
        b=YZLVF5vJ3rZtL4rm6ireXN5uAYcm0C2w8d9VbzuAYGocvE3O0CDm64ypQfB43yBKmq
         weXSWEko+fjkbo+L52hRnAX5feGaY3d/fmy5+XY5oN5Jv9y42waznNbqiMnEk1aqJRO6
         0n8qYh8OQXKNByHbHge6gw8HB/MCiuvm1/vUyscpWc3pwcliUZmVFh3POgue1G3m7U/W
         Vj1oZ0hK1HPX45sO+GA54GM+FNww0doYbYrqcGg1MPzwuKnZuc4jl8XZ5jwBNxuSx06F
         HgeTBhNrDfoQ0MDpE5MNta4hmB07B6TNOeUm6R098yh9z1CJBzUg/AP+31nqX40jGozH
         RQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=60Or+irUc/C7IKAadYXLKHpXUoZOzvKMDs/+k3WTNu4=;
        b=OXnAHfCt9RiTUzw70zm13EbqXCdvhRlDgylzfm/osuQIYmVyPdD9T2cBAPcVl8DX+/
         j1cDrephF//HDnuUr+qapbQME9WRJkrwoJ8A3ffTzGiF6ME7KPiJDHfIIGNoSpKcdLM4
         pyaaOr/RRlOPUmcxK7kF4caslKCBiRJETkKw+MOkBQMvBUL1BXncVvaRDUEqrAO9Haax
         tzG29+vNxqxl5KveHbQ2hDrlp7RuipCtYXlQLDGV/TvO7PS2f4g9X6NFRiz6cbmpUUMt
         WGo41XalkolsxfnXfq5BvdtMMrxbiBEBAKX/A3OIFABngQkJMrrD+K3a15HCg/Cw1A2V
         X/uw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r7J7rc+K;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r7J7rc+K;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx48LyanxzFK1B8OocDm/DK+jOLnedi6zpEF71YwvVsbZmH5NefRiwmEoLOLI6dcuKF2+MsUzDg==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Mon, 16 Apr 2018 13:26:01 +0900
From: Minchan Kim <minchan@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 4/4] zram: introduce zram memory tracking
Message-ID: <20180416042601.GA48495@rodete-desktop-imager.corp.google.com>
References: <20180416033110.32361-1-minchan@kernel.org>
 <20180416033110.32361-5-minchan@kernel.org>
 <496fe3d5-3306-1aa0-51b7-c61380dc2797@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496fe3d5-3306-1aa0-51b7-c61380dc2797@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597872002743020578?=
X-GMAIL-MSGID: =?utf-8?q?1597875440782699592?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 15, 2018 at 09:17:45PM -0700, Randy Dunlap wrote:
> On 04/15/2018 08:31 PM, Minchan Kim wrote:
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
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  Documentation/blockdev/zram.txt |  24 ++++++
> >  drivers/block/zram/Kconfig      |  10 +++
> >  drivers/block/zram/zram_drv.c   | 140 +++++++++++++++++++++++++++++---
> >  drivers/block/zram/zram_drv.h   |   5 ++
> >  4 files changed, 168 insertions(+), 11 deletions(-)
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
> 
> ?               process
> 
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
> > index ac3a31d433b2..01090338fb47 100644
> > --- a/drivers/block/zram/Kconfig
> > +++ b/drivers/block/zram/Kconfig
> > @@ -26,3 +26,13 @@ config ZRAM_WRITEBACK
> >  	 /sys/block/zramX/backing_dev.
> >  
> >  	 See zram.txt for more infomration.
> > +
> > +config ZRAM_MEMORY_TRACKING
> > +	bool "Tracking zram block status"
> 
> 	bool "Track zram block status"
> 
> although sometimes it is zRam or zRAM.
> 
> 
> > +	depends on ZRAM && DEBUG_FS
> > +	help
> > +	  With this feature, admin can track the state of allocated block
> 
> 	                                                            blocks
> 
> > +	  of zRAM. Admin could see the information via
> > +	  /sys/kernel/debug/zram/zramX/block_state.
> > +
> > +	  See zram.txt for more information.
> 
> 	  See Documentation/blockdev/zram.txt for more information.

I just fix things. I will wait more feedback and then resend.
Thanks for the review!
