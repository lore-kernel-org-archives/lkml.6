Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AIpwx49JPgoqAuTBK4tqjzc1S02i6EsDcipsjvoldt0YGd2nuGqPGfIsIHfu1e2ib7cb4IbfHKOB
ARC-Seal: i=1; a=rsa-sha256; t=1524366104; cv=none;
        d=google.com; s=arc-20160816;
        b=ITcmuhaIc3mc53NgFyX/dGi6frWO5S4N6NK04fQ1BfVZ+/kzlMH+HANVAxSihUweN2
         kyvQecdsl7O3qDz1yF6ByQ1A76/fupPuGBga06fc7vem9ksgT3hLF17SDKxS0df0L1xX
         u1CuTIwHS1nqNgqZpDEgaFMX/9lnKbGADUpZvvKgHOrK52LRdchzQ/PtyLnjFHNqApAx
         iEZ+Uxl8cDKzPbimekdr1/n7uJQbYGLQIoAUf7xPEySBDVkl5XH/bfhag7hjjkS6+NJs
         D+elJn/JbOrkmNv9Q1eHPTbUoVq41XAwT3oF+phEvmKdB8rlsHjoIPHTg0o7TFDSlgsy
         IZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=D1DvZlojgdCsKh9v/29KuoiVajgPYD5qKGUupSwJINU=;
        b=QRCTl8nmnj2MH4gWMdZKiC3U/sOu0HNf6h/9y9aoWIi0SdJf36WACGk8JHoNpe7MvM
         8+LRPNmDvubN4GVoc9BZLH5WqqZ0ELr3v9QQpcyd/pKUF8/oYQ7a007aLSUNtA2PxpEO
         Px8azZpBF5irYzVC2qElEn4U/gzP7+ksgGAOvAhf0Y/v7IPpUl1xMmDxP0lwn98J/C0K
         +lzeqmOXwUwp2AJFTpWISRk74tNkcMvVfQoIPfZPVnhsgk7Db1k5rL0IzVqxLRr4aTFf
         0cZiEkrqf5Ing/T6Eizl7o59rUvolOZRaG7XhvGVxvk7oQxFt/z8DBqLt3kKtmjTMWpw
         pgoA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=TX6Gk9q3;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=TX6Gk9q3;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Sat, 21 Apr 2018 20:01:30 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Huang Ying <ying.huang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Miles Chen <miles.chen@mediatek.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rik van Riel <riel@redhat.com>, James Hogan <jhogan@kernel.org>,
	"Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/8] mm: introduce PG_offline
Message-ID: <20180422030130.GG14610@bombadil.infradead.org>
References: <20180413131632.1413-1-david@redhat.com>
 <20180413131632.1413-3-david@redhat.com>
 <20180413171120.GA1245@bombadil.infradead.org>
 <89329958-2ff8-9447-408e-fd478b914ec4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89329958-2ff8-9447-408e-fd478b914ec4@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597637040722220932?=
X-GMAIL-MSGID: =?utf-8?q?1598413712613486979?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 21, 2018 at 06:52:18PM +0200, Vlastimil Babka wrote:
> On 04/13/2018 07:11 PM, Matthew Wilcox wrote:
> > On Fri, Apr 13, 2018 at 03:16:26PM +0200, David Hildenbrand wrote:
> >> online_pages()/offline_pages() theoretically allows us to work on
> >> sub-section sizes. This is especially relevant in the context of
> >> virtualization. It e.g. allows us to add/remove memory to Linux in a VM in
> >> 4MB chunks.
> >>
> >> While the whole section is marked as online/offline, we have to know
> >> the state of each page. E.g. to not read memory that is not online
> >> during kexec() or to properly mark a section as offline as soon as all
> >> contained pages are offline.
> > 
> > Can you not use PG_reserved for this purpose?
> 
> Sounds like your newly introduced "page types" could be useful here? I
> don't suppose those offline pages would be using mapcount which is
> aliased there?

Oh, that's a good point!  Yes, this is a perfect use for page_type.
We have something like twenty bits available there.

Now you've got me thinking that we can move PG_hwpoison and PG_reserved
to be page_type flags too.  That'll take us from 23 to 21 bits (on 32-bit,
with PG_UNCACHED)
