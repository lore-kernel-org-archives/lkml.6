Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AIpwx48CtUQa+0MWUMNfdNbjCm5wk4pVL1KAvATeTvmGZcf4VndGKvzQmtZUZlbyuQ2otkg1nb7J
ARC-Seal: i=1; a=rsa-sha256; t=1524085636; cv=none;
        d=google.com; s=arc-20160816;
        b=Z1qZ474j97VUKOWaCq32Igmzgj5xKhPdThTwvUdLCqWXn0++wronlXg2LNx4ZFvJSl
         63oCXcRelyNmTjJD6gNQl6GCmOBUEYsphDb2mthuhxY3A98lSfiwpAVNKlCUjISuoO4F
         ItBbxgbiOZp1CrQZLChAvE/+u1V94hpMKTgXJ6J3NitNZWF2hkhNRUA/sFmqa7hqjCjg
         c3SPXoWEXUcVA1PSBIHeWUaHMaa9WbDS3lueEVdhK/Y9XV/PjYZSQf2BDyP0yrxdBGyw
         vr5eEkU3Vog60h9if4pQ2N6iKJ/wk4ZsRnsKKJy2wrFPACWw91ZdR+nzkWwmckZttcTM
         X4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ib9GBK6GQg600QlsDhNybgiz3iWjIodcsUDUnxBUvn4=;
        b=E6iQElppUkktEZ1TSmK+OARZTA4BAg/XPY8SSHxMXtzN29fiZ/nqmkfEazrXMJYiwp
         4kG6RVVPr3ipfmF/EnD3l/SlRy/0/wsf45FljPv7uhAGmlZM2vUooZx0QaVO6BoUSg+I
         hNhe1Dkiv2QmCHhc3LngHi4SFgZwB+cOXI0eZgKLkcVX6OXZ7O7875e21VxF1IYHHeh8
         T61UilScJfqc0d4rJs7+w11brV9kbQwXqQZ/q3z+wv96FFSldfEbjoxx83wyolxpfCfP
         y6rulzzycgw72Km9F2cOEtCoI3CkCkBbo3L60m6U/PQ7YS3+9B3hN10RSd/lqYOdtp91
         mVQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Wed, 18 Apr 2018 14:07:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Minchan Kim <minchan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Sergey Senozhatsky
 <sergey.senozhatsky.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergey Senozhatsky
 <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v5 4/4] zram: introduce zram memory tracking
Message-Id: <20180418140715.4af4e837d6048a82117c85bd@linux-foundation.org>
In-Reply-To: <20180418012636.GA196478@rodete-desktop-imager.corp.google.com>
References: <20180416090946.63057-1-minchan@kernel.org>
	<20180416090946.63057-5-minchan@kernel.org>
	<20180417145921.eac3d6379b5bade6c4f1a091@linux-foundation.org>
	<20180418012636.GA196478@rodete-desktop-imager.corp.google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597872002743020578?=
X-GMAIL-MSGID: =?utf-8?q?1598119620046183445?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 18 Apr 2018 10:26:36 +0900 Minchan Kim <minchan@kernel.org> wrote:

> Hi Andrew,
> 
> On Tue, Apr 17, 2018 at 02:59:21PM -0700, Andrew Morton wrote:
> > On Mon, 16 Apr 2018 18:09:46 +0900 Minchan Kim <minchan@kernel.org> wrote:
> > 
> > > zRam as swap is useful for small memory device. However, swap means
> > > those pages on zram are mostly cold pages due to VM's LRU algorithm.
> > > Especially, once init data for application are touched for launching,
> > > they tend to be not accessed any more and finally swapped out.
> > > zRAM can store such cold pages as compressed form but it's pointless
> > > to keep in memory. Better idea is app developers free them directly
> > > rather than remaining them on heap.
> > > 
> > > This patch tell us last access time of each block of zram via
> > > "cat /sys/kernel/debug/zram/zram0/block_state".
> > > 
> > > The output is as follows,
> > >       300    75.033841 .wh
> > >       301    63.806904 s..
> > >       302    63.806919 ..h
> > > 
> > > First column is zram's block index and 3rh one represents symbol
> > > (s: same page w: written page to backing store h: huge page) of the
> > > block state. Second column represents usec time unit of the block
> > > was last accessed. So above example means the 300th block is accessed
> > > at 75.033851 second and it was huge so it was written to the backing
> > > store.
> > > 
> > > Admin can leverage this information to catch cold|incompressible pages
> > > of process with *pagemap* once part of heaps are swapped out.
> > 
> > A few things..
> > 
> > - Terms like "Admin can" and "Admin could" are worrisome.  How do we
> >   know that admins *will* use this?  How do we know that we aren't
> >   adding a bunch of stuff which nobody will find to be (sufficiently)
> >   useful?  For example, is there some userspace tool to which you are
> >   contributing which will be updated to use this feature?
> 
> Actually, I used this feature two years ago to find memory hogger
> although the feature was very fast prototyping. It was very useful
> to reduce memory cost in embedded space.
> 
> The reason I am trying to upstream the feature is I need the feature
> again. :)
> 
> Yub, I have a userspace tool to use the feature although it was
> not compatible with this new version. It should be updated with
> new format. I will find a time to submit the tool.

hm, OK, can we get this info into the changelog?  

> > 
> > - block_state's second column is in microseconds since some
> >   undocumented time.  But how is userspace to know how much time has
> >   elapsed since the access?  ie, "current time".
> 
> It's a sched_clock so it should be elapsed time since the system boot.
> I should have written it explictly.
> I will fix it.
> 
> > 
> > - Is the sched_clock() return value suitable for exporting to
> >   userspace?  Is it monotonic?  Is it consistent across CPUs, across
> >   CPU hotadd/remove, across suspend/resume, etc?  Does it run all the
> >   way up to 2^64 on all CPU types, or will some processors wrap it at
> >   (say) 32 bits?  etcetera.  Documentation/timers/timekeeping.txt
> >   points out that suspend/resume can mess it up and that the counter
> >   can drift between cpus.
> 
> Good point!
> 
> I just referenced it from ftrace because I thought the goal is similiar
> "no need to be exact unless the drift is frequent but wanted to be fast"
> 
> AFAIK, ftrace/printk is active user of the function so if the problem
> happens frequently, it might be serious. :)

It could be that ktime_get() is a better fit here - especially if
sched_clock() goes nuts after resume.  Unfortunately ktime_get()
appears to be totally undocumented :(
