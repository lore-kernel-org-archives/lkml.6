Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756660AbeDZWwI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:52:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754728AbeDZWwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:52:07 -0400
Date: Thu, 26 Apr 2018 18:52:05 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: "Michael S. Tsirkin" <mst@redhat.com>
cc: John Stoffel <john@stoffel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Michal@stoffel.org, eric.dumazet@gmail.com, netdev@vger.kernel.org,
        jasowang@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Hocko <mhocko@kernel.org>, linux-mm@kvack.org, dm-devel@redhat.com,
        Vlastimil Babka <vbabka@suse.cz>, Andrew@stoffel.org,
        David Rientjes <rientjes@google.com>,
        Morton <akpm@linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        David Miller <davem@davemloft.net>, edumazet@google.com
Subject: Re: [dm-devel] [PATCH v5] fault-injection: introduce kvmalloc fallback
 options
In-Reply-To: <20180427005213-mutt-send-email-mst@kernel.org>
Message-ID: <alpine.LRH.2.02.1804261829190.30599@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1804251556060.30569@file01.intranet.prod.int.rdu2.redhat.com> <1114eda5-9b1f-4db8-2090-556b4a37c532@infradead.org> <alpine.LRH.2.02.1804251656300.9428@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.21.1804251417470.166306@chino.kir.corp.google.com>
 <alpine.LRH.2.02.1804251720090.9428@file01.intranet.prod.int.rdu2.redhat.com> <1524694663.4100.21.camel@HansenPartnership.com> <alpine.LRH.2.02.1804251857070.31135@file01.intranet.prod.int.rdu2.redhat.com> <1524697697.4100.23.camel@HansenPartnership.com>
 <23266.8532.619051.784274@quad.stoffel.home> <alpine.LRH.2.02.1804261726540.13401@file01.intranet.prod.int.rdu2.redhat.com> <20180427005213-mutt-send-email-mst@kernel.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Apr 2018, Michael S. Tsirkin wrote:

> On Thu, Apr 26, 2018 at 05:50:20PM -0400, Mikulas Patocka wrote:
> > How is the user or developer supposed to learn about this option, if 
> > he gets no crash at all?
> 
> Look in /sys/kernel/debug/fail* ? That actually lets you
> filter by module, process etc.
> 
> I think this patch conflates two things:
> 
> 1. Make kvmalloc use the vmalloc path.
>     This seems a bit narrow.
>     What is special about kvmalloc? IMHO nothing - it's yet another user
>     of __GFP_NORETRY or __GFP_RETRY_MAYFAIL. As any such

__GFP_RETRY_MAYFAIL makes the allocator retry the costly_order allocations

>     user, it either recovers correctly or not.
>     So IMHO it's just a case of
>     making __GFP_NORETRY, __GFP_RETRY_MAYFAIL, or both
>     fail once in a while.
>     Seems like a better extension to me than focusing on vmalloc.
>     I think you will find more bugs this way.

If the array is <= PAGE_SIZE, vmalloc will not use __GFP_NORETRY. So it 
still hides some bugs - such as, if a structure grows above 4k, it would 
start randomly crashing due to memory fragmentation.

> 2. Ability to control this from a separate config
>    option.
> 
>    It's still not that clear to me why is this such a
>    hard requirement.  If a distro wants to force specific
>    boot time options, why isn't CONFIG_CMDLINE sufficient?

There are 489 kernel options declared with the __setup keyword. Hardly any 
kernel developer notices that a new one was added and selects it when 
testing his code.

>    But assuming it's important to control this kind of
>    fault injection to be controlled from
>    a dedicated menuconfig option, why not the rest of
>    faults?

The injected faults cause damage to the user, so there's no point to 
enable them by default. vmalloc fallback should not cause any damage 
(assuming that the code is correctly written).

> IMHO if you split 1/2 up, and generalize, the path upstream
> will be much smoother.

This seems like a lost case. So, let's not care about code correctness and 
let's solve crashes only after they are reported. If the upstream wants to 
work this way, there's nothing that can be done about it.

I'm wondering if I can still push it to RHEL or not.

> Hope this helps.
> 
> -- 
> MST

Mikulas
