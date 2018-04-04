Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeDDPEq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751329AbeDDPEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:04:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E328A20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 4 Apr 2018 11:04:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180404110442.4cf904ae@gandalf.local.home>
In-Reply-To: <20180404144255.GK6312@dhcp22.suse.cz>
References: <20180403123514.GX5501@dhcp22.suse.cz>
        <20180403093245.43e7e77c@gandalf.local.home>
        <20180403135607.GC5501@dhcp22.suse.cz>
        <20180403101753.3391a639@gandalf.local.home>
        <20180403161119.GE5501@dhcp22.suse.cz>
        <20180403185627.6bf9ea9b@gandalf.local.home>
        <20180404062039.GC6312@dhcp22.suse.cz>
        <20180404085901.5b54fe32@gandalf.local.home>
        <20180404141052.GH6312@dhcp22.suse.cz>
        <20180404102527.763250b4@gandalf.local.home>
        <20180404144255.GK6312@dhcp22.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018 16:42:55 +0200
Michal Hocko <mhocko@kernel.org> wrote:

> On Wed 04-04-18 10:25:27, Steven Rostedt wrote:
> > On Wed, 4 Apr 2018 16:10:52 +0200
> > Michal Hocko <mhocko@kernel.org> wrote:
> >   
> > > On Wed 04-04-18 08:59:01, Steven Rostedt wrote:
> > > [...]  
> > > > +       /*
> > > > +        * Check if the available memory is there first.
> > > > +        * Note, si_mem_available() only gives us a rough estimate of available
> > > > +        * memory. It may not be accurate. But we don't care, we just want
> > > > +        * to prevent doing any allocation when it is obvious that it is
> > > > +        * not going to succeed.
> > > > +        */
> > > > +       i = si_mem_available();
> > > > +       if (i < nr_pages)
> > > > +               return -ENOMEM;
> > > > +
> > > > 
> > > > Better?    
> > > 
> > > I must be really missing something here. How can that work at all for
> > > e.g. the zone_{highmem/movable}. You will get false on the above tests
> > > even when you will have hard time to allocate anything from your
> > > destination zones.  
> > 
> > You mean we will get true on the above tests?  Again, the current
> > method is to just say screw it and try to allocate.  
> 
> No, you will get false on that test. Say that you have a system with

Ah, I'm thinking backwards, I looked at false meaning "not enough
memory", where if it's true (i < nr_pages), false means there is enough
memory. OK, we are in agreement.

> large ZONE_MOVABLE. Now your kernel allocations can fit only into
> !movable zones (say we have 1G for !movable and 3G for movable). Now say
> that !movable zones are getting close to the edge while movable zones
> are full of reclaimable pages. si_mem_available will tell you there is a
> _lot_ of memory available while your GFP_KERNEL request will happily
> consume the rest of !movable zones and trigger OOM. See?

Which is still better than what we have today. I'm fine with it.
Really, I am.

> 
> [...]
> > I'm looking for something where "yes" means "there may be enough, but
> > there may not be, buyer beware", and "no" means "forget it, don't even
> > start, because you just asked for more than possible".  
> 
> We do not have _that_ something other than try to opportunistically
> allocate and see what happens. Sucks? Maybe yes but I really cannot
> think of an interface with sane semantic that would catch all the
> different scenarios.

And I'm fine with that too. I don't want to catch all different
scenarios. I want to just catch the crazy ones. Like trying to allocate
gigs of memory when there's only a few megs left. Those can easily
happen with the current interface that can't change.

I'm not looking for perfect. In fact, I love what si_mem_available()
gives me now! Sure, it can say "there's enough memory" even if I can't
use it. Because most of the OOM allocations that happen with increasing
the size of the ring buffer isn't due to "just enough memory
allocated", but it's due to "trying to allocate crazy amounts of
memory".  That's because it does the allocation one page at a time, and
if you try to allocate crazy amounts of memory, it will allocate all
memory before it fails. I don't want that. I want crazy allocations to
fail from the start. A "maybe this will allocate" is fine even if it
will end up causing an OOM.

-- Steve
