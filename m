Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AH8x226ve4vjKpFQX0J85CvKek1nW+zbUYYfa0H2IW0ZLklr5xYqVIDKyETFqshbPVDBCUmbc/J4
ARC-Seal: i=1; a=rsa-sha256; t=1518705616; cv=none;
        d=google.com; s=arc-20160816;
        b=sihieOTt4qKbr+5s4pOUdmhIzcdKrOMqEL8VhBfm4sCAW8zMyfGJZWhczVWntfbad5
         7FTdqCS5TyETELU0P5ZTsZdXnaYweaAglM9Rc9Xi1XJXqnc76h/Wa9KLMcGzABKIVjl9
         cGlfLXyoe5Rz0r7ezvXVNSs1EnZdXQlCy1Jovpj9IL1dw0HOYQfN0DIlZZeI12uryzGF
         IkOy6LdHGqkv5qBJO+BfrA5GDZ0lAEE1lDZmbKjdjn9yuVJMDArbagPbHRtWkIxz+TAy
         s+Je7HYl1KczLbk7cBNpYRZTgoNRZ8UvmaBStrVGcSEa0qgd2e2eLqHwA333GwIAXsXJ
         3LPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=0ZXmSFCj8ZXxDQ/4L6eFrCxkZhB5mLCfhdJM0WLwJcc=;
        b=FI+xvgKcU4kgcQg4TRQCalwDjC0BjKCqljVoWlLjsGS8JsSSwBkpSzZWf29UBBVxBd
         Y1fP0cw5FYyZUakz/WSg9k6Asa5BYPEE8yoKw8xR6713lqEjbsEibtO1StQWemEefkWE
         Apkjs0CW7dAwQujBmnKDoQ3qYnGGgh4yaAyRvic9NOn1f1/fMHIRkcye5bbfakssYcVq
         UcxwuEzaVj4GswmQ6fq4dSdYstmdhWfglhe5MItZl4XDt3fKniiBwca/KEnRQlliPRta
         Xbtu6YeEPgx0osDG50LtYikY29MEqHRQEIVPTZWMn8tAhYlIICQv0T720sUS/zRKlCwf
         SVAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Thu, 15 Feb 2018 15:40:11 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steve Sistare <steven.sistare@oracle.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Bharata B Rao <bharata@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, dan.j.williams@intel.com,
	kirill.shutemov@linux.intel.com, bhe@redhat.com
Subject: Re: [PATCH v3 1/4] mm/memory_hotplug: enforce block size aligned
 range check
Message-ID: <20180215144011.GF7275@dhcp22.suse.cz>
References: <20180213193159.14606-1-pasha.tatashin@oracle.com>
 <20180213193159.14606-2-pasha.tatashin@oracle.com>
 <20180215113407.GB7275@dhcp22.suse.cz>
 <CAOAebxvF6mxDb4Ub02F0B9TEMRJUG0UGrKJ6ypaMGcje80cy6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOAebxvF6mxDb4Ub02F0B9TEMRJUG0UGrKJ6ypaMGcje80cy6w@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315509448855886?=
X-GMAIL-MSGID: =?utf-8?q?1592478260108378700?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 15-02-18 08:36:00, Pavel Tatashin wrote:
> Hi Michal,
> 
> Thank you very much for your reviews and for Acking this patch.
> 
> >
> > The whole memblock != section_size sucks! It leads to corner cases like
> > you see. There is no real reason why we shouldn't be able to to online
> > 2G unaligned memory range. Failing for that purpose is just wrong. The
> > whole thing is just not well thought through and works only for well
> > configured cases.
> 
> Hotplug operates over memory blocks, and it seems that conceptually
> memory blocks are OK: their sizes are defined by arch, and may
> represent a pluggable dimm (on virtual machines it is a different
> story though). If we forced memory blocks to be equal to section size,
> that would force us to handle millions of memory devices in sysfs,
> which would not scale well.

Yes, I am very well avare of the reason why memblock is larger on larger
systems. I was merely ranting about the way how it has been added to the
existing code.

> > Your patch doesn't address the underlying problem.
> 
> What is the underlying problem? The hotplug operation was allowed, but
> we ended up with half populated memory block, which is broken. The
> patch solves this problem by making sure that this is never the case
> for any arch, no matter what block size is defined as unit of
> hotplugging.

The underlying problem is that we require some alignment here. There
shouldn't be any reason to do so. The only requirement dictated by the
memory model is the size of the section.

> > On the other hand, it
> > is incorrect to check memory section here conceptually because this is
> > not a hotplug unit as you say so I am OK with the patch regardless. It
> > deserves a big fat TODO to fix this properly at least. I am not sure why
> > we insist on the alignment in the first place. All we should care about
> > is the proper memory section based range. The code is crap and it
> > assumes pageblock start aligned at some places but there shouldn't be
> > anything fundamental to change that.
> 
> So, if I understand correctly, ideally you would like to redefine unit
> of memory hotplug to be equal to section size?

No, not really. I just think the alignment shouldn't really matter. Each
memory block should simply represent a hotplugable entitity with a well
defined pfn start and size (in multiples of section size). This is in
fact what we do internally anyway. One problem might be that an existing
userspace might depend on the existing size restrictions so we might not
be able to have variable block sizes. But block size alignment should be
fixable.
-- 
Michal Hocko
SUSE Labs
