Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754312AbeCVAdA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 20:33:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754185AbeCVAc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 20:32:56 -0400
Date: Wed, 21 Mar 2018 20:32:54 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: mm/hmm: a simple question regarding devm_request_mem_region()
Message-ID: <20180322003253.GL3214@redhat.com>
References: <20180321222357.GA31089@Asurada-Nvidia>
 <20180321225632.GI3214@redhat.com>
 <20180322002352.GA12673@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180322002352.GA12673@Asurada-Nvidia>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 05:23:55PM -0700, Nicolin Chen wrote:
> On Wed, Mar 21, 2018 at 06:56:32PM -0400, Jerome Glisse wrote:
> > On Wed, Mar 21, 2018 at 03:23:57PM -0700, Nicolin Chen wrote:
> > > Hello Jerome,
> > > 
> > > I started to looking at the mm/hmm code and having a question at the
> > > devm_request_mem_region() call in the hmm_devmem_add() implementation:
> > > 
> > > >	addr = min((unsigned long)iomem_resource.end,
> > > >		   (1UL << MAX_PHYSMEM_BITS) - 1);
> > > 
> > > The main question is here as I am a bit confused by this addr. The code
> > > is trying to get an addr from the end of memory space. However, I have
> > > tried on an ARM64 platform where ioport_resource.end is -1, so it takes
> > > "(1UL << MAX_PHYSMEM_BITS) - 1" as the addr base, while this addr is way
> > > beyond the actual main memory size that's available on my board. Is HMM
> > > supposed to get an memory region like this? Would it be possible for you
> > > to give some hint to help me understand it?
> > 
> > What are you trying to do ? hmm_devmem_add() is use either for device
> > private memory or device public memory. Device private memory is memory
> > that is not accessible by the CPU, the code you are pointing to is for
> > that case where i try to find a range of physical address not currently
> > use (memory not being accessible means that there is not any valid
> > physical address reserved for it). On x86 MAX_PHYSMEM_BITS is defined
> > to something that make sense, but as it is often the case for those
> > define, it seems that arm define an unreal value. My advice fix the
> > definition for ARM iirc it depends on the SOC dunno if you can know
> > that at build time. You can probably know the biggest one at build time
> > (1 << 47 or something like that).
> > 
> > But this all assume that you have a device with its own memory that is
> > not accessible from the CPU. Which is very uncommon on ARM, only case
> > i know of is regular PCIE GPU on a ARM system with PCIE.
> 
> I am testing with drivers/char/hmm_dmirror.c from your git repository.
> 
> The addr I got (before "- size") is actually 0x7fffffffff, so equally
> (1 << 40).
> 
> So from your reply, it seems to me that HMM is supposed to request a
> region like it.

The dummy driver by default test the private memory, i had patches to
make it test public memory too somewhere in a branch. So yes this is
expected from the dummy driver. HMM here is trying to get a region that
will not collide with any known existing resources. Idealy we would
like a platform/arch function for that but it is hard to justify it
nor is there a safe way to find such thing either from arch/platform
specific code (there isn't for x86 at least).

For real device driver of pcie devices, the advice is to use the pci
bar region of the device. This way we know for sure we do not collide
with anything (ie use hmm_devmem_add_resource() not hmm_devmem_add()
but this need some code change for res->desc).

Cheers,
Jérôme
