Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeCaBlz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 21:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752603AbeCaBly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 21:41:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1321021773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 30 Mar 2018 21:41:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelaf@google.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180330214151.415e90ea@gandalf.local.home>
In-Reply-To: <CAJWu+orx=NZrkAf7x_HqttnrMssmW7DPZOL1fxR=N6D_-fbmtw@mail.gmail.com>
References: <1522320104-6573-1-git-send-email-zhaoyang.huang@spreadtrum.com>
        <20180330102038.2378925b@gandalf.local.home>
        <20180330205356.GA13332@bombadil.infradead.org>
        <20180330173031.257a491a@gandalf.local.home>
        <20180330174209.4cb77003@gandalf.local.home>
        <CAJWu+orx=NZrkAf7x_HqttnrMssmW7DPZOL1fxR=N6D_-fbmtw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018 16:38:52 -0700
Joel Fernandes <joelaf@google.com> wrote:

> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -1164,6 +1164,11 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
> >         struct buffer_page *bpage, *tmp;
> >         long i;
> >
> > +       /* Check if the available memory is there first */
> > +       i = si_mem_available();
> > +       if (i < nr_pages)  
> 
> Does it make sense to add a small margin here so that after ftrace
> finishes allocating, we still have some memory left for the system?
> But then then we have to define a magic number :-|

I don't think so. The memory is allocated by user defined numbers. They
can do "free" to see what is available. The original patch from
Zhaoyang was due to a script that would just try a very large number
and cause issues.

If the memory is available, I just say let them have it. This is
borderline user space issue and not a kernel one.

> > +  
> 
> I tested in Qemu with 1GB memory, I am always able to get it to fail
> allocation even without this patch without causing an OOM. Maybe I am
> not running enough allocations in parallel or something :)

Try just echoing in "1000000" into buffer_size_kb and see what happens.

> 
> The patch you shared using si_mem_available is working since I'm able
> to allocate till the end without a page allocation failure:
> 
> bash-4.3# echo 237800 > /d/tracing/buffer_size_kb
> bash: echo: write error: Cannot allocate memory
> bash-4.3# echo 237700 > /d/tracing/buffer_size_kb
> bash-4.3# free -m
>              total         used         free       shared      buffers
> Mem:           985          977            7           10            0
> -/+ buffers:                977            7
> Swap:            0            0            0
> bash-4.3#
> 
> I think this patch is still good to have, since IMO we should not go
> and get page allocation failure (even if its a non-OOM) and subsequent
> stack dump from mm's allocator, if we can avoid it.
> 
> Tested-by: Joel Fernandes <joelaf@google.com>

Great thanks! I'll make it into a formal patch.

-- Steve
