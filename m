Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524190168; cv=none;
        d=google.com; s=arc-20160816;
        b=yCrWnj8r/JkNW6fre0Bs0a1s8xMxpDJ8l78XyNqhHpsccWsNpIqr2In8F6g518e29Y
         skcPX6/OAMPvbsgep+oaChW+nwj0WoWQJwJwGYJ1fPEMiL+UqGzuWJx0pIJD6Trbu/eO
         m7ulG9s5qdZScTZ1oH+NztI5Z7hEmkLU1XqfYEb+X0QbMSoYmI4nIRmf2wpoV5oEIPmf
         WV+jm1ERRgqkQjdRC4gmp3vQ2EAIPK9wPB5+jjOjlQDCsOjFNPLsjtfP3Xhth7jr8pAZ
         USEz1CavxzatNl2G3ZnfOEInK1GMA7dmfcedZv17uiVzoeKh4b0wvZQoI68E4LDgtaA4
         BFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=dtaK2TcpZq2UiIXiVpCsXY1nRua+/bepq/rOo9PdyYc=;
        b=1H/4If5Z8ZUddkY87Mi89xACdCwY+4SV54Z2+qOtUy/u8ZGC4qhBxA3wx0jMFlrxgH
         fZzn9S3juX8KrKvcZbjmriULq9QUdezn4egCIlRrPRuSZ3mamv13FLff+PH0VWIBxE3H
         +dGLk7NR78KnvNNaskSQhug4zcqWPY0ftDbPWg1poa4yWlGIRJwEHkmErFNjr40mjxPq
         RV+ZFA1QULWaeglAaxRLpDKXNt0uH1Mh4ZYE/UwJJlYJAurMcAAZ1wBFzfH1pk1xFw9X
         HoRxWKbPMxg9WzdD9xNmkUX6AL0Gh0VI23///wqtLI84uAydDLSjFFHWimuvbSU/TIN6
         mcug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fQH3uTkz;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fQH3uTkz;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx4/swN/WCMQ59+UCAjXHJ3VlBU3O9CwqxCPCmOScMsMLzfAo/hOzenBrtHXTDrVq98gijw0OhQ==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Fri, 20 Apr 2018 11:09:21 +0900
From: Minchan Kim <minchan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v5 4/4] zram: introduce zram memory tracking
Message-ID: <20180420020921.GA155841@rodete-desktop-imager.corp.google.com>
References: <20180416090946.63057-1-minchan@kernel.org>
 <20180416090946.63057-5-minchan@kernel.org>
 <20180417145921.eac3d6379b5bade6c4f1a091@linux-foundation.org>
 <20180418012636.GA196478@rodete-desktop-imager.corp.google.com>
 <20180418140715.4af4e837d6048a82117c85bd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418140715.4af4e837d6048a82117c85bd@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597872002743020578?=
X-GMAIL-MSGID: =?utf-8?q?1598229230168464095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 02:07:15PM -0700, Andrew Morton wrote:
> On Wed, 18 Apr 2018 10:26:36 +0900 Minchan Kim <minchan@kernel.org> wrote:
> 
> > Hi Andrew,
> > 
> > On Tue, Apr 17, 2018 at 02:59:21PM -0700, Andrew Morton wrote:
> > > On Mon, 16 Apr 2018 18:09:46 +0900 Minchan Kim <minchan@kernel.org> wrote:
> > > 
> > > > zRam as swap is useful for small memory device. However, swap means
> > > > those pages on zram are mostly cold pages due to VM's LRU algorithm.
> > > > Especially, once init data for application are touched for launching,
> > > > they tend to be not accessed any more and finally swapped out.
> > > > zRAM can store such cold pages as compressed form but it's pointless
> > > > to keep in memory. Better idea is app developers free them directly
> > > > rather than remaining them on heap.
> > > > 
> > > > This patch tell us last access time of each block of zram via
> > > > "cat /sys/kernel/debug/zram/zram0/block_state".
> > > > 
> > > > The output is as follows,
> > > >       300    75.033841 .wh
> > > >       301    63.806904 s..
> > > >       302    63.806919 ..h
> > > > 
> > > > First column is zram's block index and 3rh one represents symbol
> > > > (s: same page w: written page to backing store h: huge page) of the
> > > > block state. Second column represents usec time unit of the block
> > > > was last accessed. So above example means the 300th block is accessed
> > > > at 75.033851 second and it was huge so it was written to the backing
> > > > store.
> > > > 
> > > > Admin can leverage this information to catch cold|incompressible pages
> > > > of process with *pagemap* once part of heaps are swapped out.
> > > 
> > > A few things..
> > > 
> > > - Terms like "Admin can" and "Admin could" are worrisome.  How do we
> > >   know that admins *will* use this?  How do we know that we aren't
> > >   adding a bunch of stuff which nobody will find to be (sufficiently)
> > >   useful?  For example, is there some userspace tool to which you are
> > >   contributing which will be updated to use this feature?
> > 
> > Actually, I used this feature two years ago to find memory hogger
> > although the feature was very fast prototyping. It was very useful
> > to reduce memory cost in embedded space.
> > 
> > The reason I am trying to upstream the feature is I need the feature
> > again. :)
> > 
> > Yub, I have a userspace tool to use the feature although it was
> > not compatible with this new version. It should be updated with
> > new format. I will find a time to submit the tool.
> 
> hm, OK, can we get this info into the changelog?  

No problem. I will add as follows,

"I used the feature a few years ago to find memory hoggers in userspace
to notice them what memory they have wasted without touch for a long time.
With it, they could reduce unnecessary memory space. However, at that time,
I hacked up zram for the feature but now I need the feature again so
I decided it would be better to upstream rather than keeping it alone.
I hope I submit the userspace tool to use the feature soon"

> 
> > > 
> > > - block_state's second column is in microseconds since some
> > >   undocumented time.  But how is userspace to know how much time has
> > >   elapsed since the access?  ie, "current time".
> > 
> > It's a sched_clock so it should be elapsed time since the system boot.
> > I should have written it explictly.
> > I will fix it.
> > 
> > > 
> > > - Is the sched_clock() return value suitable for exporting to
> > >   userspace?  Is it monotonic?  Is it consistent across CPUs, across
> > >   CPU hotadd/remove, across suspend/resume, etc?  Does it run all the
> > >   way up to 2^64 on all CPU types, or will some processors wrap it at
> > >   (say) 32 bits?  etcetera.  Documentation/timers/timekeeping.txt
> > >   points out that suspend/resume can mess it up and that the counter
> > >   can drift between cpus.
> > 
> > Good point!
> > 
> > I just referenced it from ftrace because I thought the goal is similiar
> > "no need to be exact unless the drift is frequent but wanted to be fast"
> > 
> > AFAIK, ftrace/printk is active user of the function so if the problem
> > happens frequently, it might be serious. :)
> 
> It could be that ktime_get() is a better fit here - especially if
> sched_clock() goes nuts after resume.  Unfortunately ktime_get()
> appears to be totally undocumented :(
> 

I will use ktime_get_boottime(). With it, zram is not demamaged by
suspend/resume and code would be more simple/clear. For user, it
would be more straightforward to parse the time.

Thanks for good suggestion, Andrew!
