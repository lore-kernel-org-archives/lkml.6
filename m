Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AB8JxZrbfCWVaPQzmzpLYpBftcVJscWnYfG/rJUF+F+vsFkjfXef/bdLdoWiOQh/XKZTTCio6gED
ARC-Seal: i=1; a=rsa-sha256; t=1525036134; cv=none;
        d=google.com; s=arc-20160816;
        b=VboyusMD4lVouP02spfH9WTfYpIn8F6waVi9Uznc2uh+68PIKOQev40kKx8x3qDyur
         h26mJGyxR7vof2uKK+hnoDUlJzd+1sknccUGz4Y+QH1tQ+H+gbdRN3PV7czkjdraxe+T
         u59tgNLDkf8fZuj+QW7ebTJM4GPMDMSB33w4ItmY+bmnLwdgwa3RXZ+AFpamY6tfwP7w
         uB6uSR6ucvypocUHlrQK8VXH/91Be+lzql5NVKsIn7bdvNIwqd7oxU+sT0Qg4VB3Tiry
         45gAP+kQ9xIu61z3XXrMaK/tZ8tXimFZQi9792juyCMA2HfKb1go9EkRE/ny7danZ6UN
         nYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=gJclgibFyN9lLOGwJvItJovLtk0y7K821JtQu0IdZGQ=;
        b=vyhc/xbPC2HJ98l90OM39TdnYMh9y6IxDV8FU/aaalvDFc476rRraPiiRJOF8cou08
         Rjtt+80/BbvoMJ9SYoRW4Qv7wEPMo2cRAyIeZVvIWv3XdR5ZYn9V9UZp9eVtQK7RPu7k
         lPAi5PM5t/KwpyiXnYSV3dKzYCJiymwyDAlNZx4ItRnmi35DVHy8BjSC3LFs4HDTvk08
         mhxiS0WgA7EXUNc/FrexXPVxG9EqZDiGpAxBAr+dk3qsyxxVJrfsnyfMokxvCScEIicA
         x+cUD87lqXqWxOQp0gZUGF8NS6EKe/W40SjCL5U710+O0xwyoLC8+Pk/gKMlM2s9vUHd
         ygTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Sun, 29 Apr 2018 23:08:50 +0200
From: Michal Hocko <mhocko@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Miles Chen <miles.chen@mediatek.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rik van Riel <riel@redhat.com>, James Hogan <jhogan@kernel.org>,
	"Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/8] mm: introduce PG_offline
Message-ID: <20180429210850.GB26305@dhcp22.suse.cz>
References: <20180413131632.1413-1-david@redhat.com>
 <20180413131632.1413-3-david@redhat.com>
 <20180413171120.GA1245@bombadil.infradead.org>
 <89329958-2ff8-9447-408e-fd478b914ec4@suse.cz>
 <20180422030130.GG14610@bombadil.infradead.org>
 <7db70df4-c714-574c-5b14-898c1cf49af6@redhat.com>
 <20180422140246.GA30714@bombadil.infradead.org>
 <903ab7f7-88ce-9bc3-036b-261cce1bb26c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <903ab7f7-88ce-9bc3-036b-261cce1bb26c@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597637040722220932?=
X-GMAIL-MSGID: =?utf-8?q?1599116289491675863?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun 22-04-18 17:13:52, David Hildenbrand wrote:
> On 22.04.2018 16:02, Matthew Wilcox wrote:
> > On Sun, Apr 22, 2018 at 10:17:31AM +0200, David Hildenbrand wrote:
> >> On 22.04.2018 05:01, Matthew Wilcox wrote:
> >>> On Sat, Apr 21, 2018 at 06:52:18PM +0200, Vlastimil Babka wrote:
> >>>> Sounds like your newly introduced "page types" could be useful here? I
> >>>> don't suppose those offline pages would be using mapcount which is
> >>>> aliased there?
> >>>
> >>> Oh, that's a good point!  Yes, this is a perfect use for page_type.
> >>> We have something like twenty bits available there.
> >>>
> >>> Now you've got me thinking that we can move PG_hwpoison and PG_reserved
> >>> to be page_type flags too.  That'll take us from 23 to 21 bits (on 32-bit,
> >>> with PG_UNCACHED)
> >>
> >> Some things to clarify here. I modified the current RFC to also allow
> >> PG_offline on allocated (ballooned) pages (e.g. virtio-balloon).
> >>
> >> kdump based dump tools can then easily identify which pages are not to
> >> be dumped (either because the content is invalid or not accessible).
> >>
> >> I previously stated that ballooned pages would be marked as PG_reserved,
> >> which is not true (at least not for virtio-balloon). However this allows
> >> me to detect if all pages in a section are offline by looking at
> >> (PG_reserved && PG_offline). So I can actually tell if a page is marked
> >> as offline and allocated or really offline.
> >>
> >>
> >> 1. The location (not the number!) of PG_hwpoison is basically ABI and
> >> cannot be changed. Moving it around will most probably break dump tools.
> >> (see kernel/crash_core.c)
> > 
> > It's not ABI.  It already changed after 4.9 when PG_waiters was introduced
> > by commit 62906027091f.
> 
> It is, please have a look at the file I pointed you to.
> 
> We export the *value* of PG_hwpoison in the ELF file, therefore the
> *value* can change, but the *location* (page_flags, mapcount, whatever)
> must not change. Or am I missing something here? I don't think we can
> move PG_hwpoison that easily.
> 
> Also, I can read "For pages that are never mapped to userspace,
> page->mapcount may be used for storing extra information about page
> type" - is that true for PG_hwpoison/PG_reserved? I am skeptical.
> 
> And we need something similar for PG_offline, because it will become
> ABI. (I can see that PAGE_BUDDY_MAPCOUNT_VALUE is also exported in an
> ELF file, so maybe a new page type might work for marking a page offline
> - but I have to look at the details first tomorrow)

Wait wait wait. Who is relying on this? Kdump? Page flags have always
been an internal implementation detail and _nobody_ outside of the
kernel should ever rely on the specific value. Well, kdump has been
cheating but that is because kdump is inherently tight to a specific
kernel implementation but that doesn't make it a stable ABI IMHO.
Restricting the kernel internals because of a debugging tool would be
quite insane.
-- 
Michal Hocko
SUSE Labs
