Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeFEWTS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:19:18 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37597 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752380AbeFEWTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:19:17 -0400
X-Google-Smtp-Source: ADUXVKI1myqQ+NisKXm8ZNc2KXivKfvsyGh1ELY9n9/k+csjmi1wmeYwwrbIAVDUJQeowY2mQjSgZdFYUWnfsolQ9sg=
MIME-Version: 1.0
In-Reply-To: <20180605184811.GC4423@redhat.com>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180524001026.GA3527@redhat.com> <CAPcyv4hVERZoqWrCxwOkmM075OP_ada7FiYsQgokijuWyC1MbA@mail.gmail.com>
 <CAPM=9tzMJq=KC+ijoj-JGmc1R3wbshdwtfR3Zpmyaw3jYJ9+gw@mail.gmail.com>
 <CAPcyv4g2XQtuYGPu8HMbPj6wXqGwxiL5jDRznf5fmW4WgC2DTw@mail.gmail.com>
 <CAPM=9twm=17t=2=M27ELB=vZWzpqM7GuwCUsC891jJ0t3JM4vg@mail.gmail.com>
 <CAPcyv4jTty4k1xXCOWbeRjzv-KjxNH1L4oOkWW1EbJt66jF4_w@mail.gmail.com> <20180605184811.GC4423@redhat.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 6 Jun 2018 08:19:15 +1000
Message-ID: <CAPM=9twgL_tzkPO=V2mmecSzLjKJkEsJ8A4426fO2Nuus0N_UQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] mm: rework hmm to use devm_memremap_pages
To: Jerome Glisse <jglisse@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 June 2018 at 04:48, Jerome Glisse <jglisse@redhat.com> wrote:
> On Tue, May 29, 2018 at 04:33:49PM -0700, Dan Williams wrote:
>> On Tue, May 29, 2018 at 4:00 PM, Dave Airlie <airlied@gmail.com> wrote:
>> > On 30 May 2018 at 08:31, Dan Williams <dan.j.williams@intel.com> wrote:
>> >> On Tue, May 29, 2018 at 3:22 PM, Dave Airlie <airlied@gmail.com> wrote:
>> >>>
>> >>> On 24 May 2018 at 13:18, Dan Williams <dan.j.williams@intel.com> wrote:
>> >>> > On Wed, May 23, 2018 at 5:10 PM, Jerome Glisse <jglisse@redhat.com> wrote:
>> >>> >> On Mon, May 21, 2018 at 03:35:14PM -0700, Dan Williams wrote:
>> >>> >>> Hi Andrew, please consider this series for 4.18.
>> >>> >>>
>> >>> >>> For maintainability, as ZONE_DEVICE continues to attract new users,
>> >>> >>> it is useful to keep all users consolidated on devm_memremap_pages() as
>> >>> >>> the interface for create "device pages".
>> >>> >>>
>> >>> >>> The devm_memremap_pages() implementation was recently reworked to make
>> >>> >>> it more generic for arbitrary users, like the proposed peer-to-peer
>> >>> >>> PCI-E enabling. HMM pre-dated this rework and opted to duplicate
>> >>> >>> devm_memremap_pages() as hmm_devmem_pages_create().
>> >>> >>>
>> >>> >>> Rework HMM to be a consumer of devm_memremap_pages() directly and fix up
>> >>> >>> the licensing on the exports given the deep dependencies on the mm.
>> >>> >>
>> >>> >> I am on PTO right now so i won't be able to quickly review it all
>> >>> >> but forcing GPL export is problematic for me now. I rather have
>> >>> >> device driver using "sane" common helpers than creating their own
>> >>> >> crazy thing.
>> >>> >
>> >>> > Sane drivers that need this level of deep integration with Linux
>> >>> > memory management need to be upstream. Otherwise, HMM is an
>> >>> > unprecedented departure from the norms of Linux kernel development.
>> >>>
>> >>> Isn't it the author of code choice what EXPORT_SYMBOL to use? and
>> >>> isn't the agreement that if something is EXPORT_SYMBOL now, changing
>> >>> underlying exports isn't considered a good idea. We've seen this before
>> >>> with the refcount fun,
>> >>>
>> >>> See d557d1b58b3546bab2c5bc2d624c5709840e6b10
>> >>>
>> >>> Not commenting on the legality or what derived works are considered,
>> >>> since really the markings are just an indication of the authors opinion,
>> >>> and at this stage I think are actually meaningless, since we've diverged
>> >>> considerably from the advice given to Linus back when this started.
>> >>
>> >> Yes, and in this case devm_memremap_pages() was originally written by
>> >> Christoph and I:
>> >>
>> >>     41e94a851304 add devm_memremap_pages
>> >
>> > So you wrote some code in 2015 (3 years ago) and you've now decided
>> > to change the EXPORT marker on it? what changed in 3 years, and why
>> > would changing that marker 3 years later have any effect on your original
>> > statement that it was an EXPORT_SYMBOL.
>> >
>> > Think what EXPORT_SYMBOL vs GPL means, it isn't a bit stick that magically
>> > makes things into derived works. If something wasn't a derived work for 3 years
>> > using that API, then it isn't a derived work now 3 years later because you
>> > changed the marker. Retrospectively changing the markers doesn't really
>> > make any sense legally or otherwise.
>>
>> It honestly was an oversight, and as we've gone on to add deeper and
>> deeper ties into the mm and filesystems [1] I realized this symbol was
>> mis-labeled.  It would be one thing if this was just some random
>> kernel leaf / library function, but this capability when turned on
>> causes the entire kernel to be recompiled as things like the
>> definition of put_page() changes. It's deeply integrated with how
>> Linux manages memory.
>
> I am personaly on the fence on deciding GPL versus non GPL export
> base on subjective view of what is deeply integrated and what is
> not. I think one can argue that every single linux kernel function
> is deeply integrated within the kernel, starting with all device
> drivers functions. One could similarly argue that nothing is ...

This is the point I wasn't making so well, the whole deciding on a derived
work from the pov of one of the works isn't really going to be how a court
looks at it.

At day 0, you have a Linux kernel, and a separate Windows kernel driver,
clearly they are not derived works.

You add interfaces to the Windows kernel driver and it becomes a Linux
kernel driver, you never ship them together, derived work only if those
interfaces are GPL only? or derived work only if shipped together?
only shipped together and GPL only? Clearly not a clearcut case here.

The code base is 99% the same, the kernel changes an export to a GPL
export, the external driver hasn't changed one line of code, and it suddenly
becomes a derived work?

Oversights happen, but 3 years of advertising an interface under the non-GPL
and changing it doesn't change whether the external driver is derived or not,
nor will it change anyone's legal position.

Dave.
