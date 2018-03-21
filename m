Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeCUPwv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:52:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751502AbeCUPwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:52:31 -0400
Date: Wed, 21 Mar 2018 11:52:28 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: [PATCH 15/15] mm/hmm: use device driver encoding for HMM pfn v2
Message-ID: <20180321155228.GD3214@redhat.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
 <20180320020038.3360-16-jglisse@redhat.com>
 <0a46cec4-3c39-bc2c-90f5-da33981cb8f2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a46cec4-3c39-bc2c-90f5-da33981cb8f2@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 09:39:27PM -0700, John Hubbard wrote:
> On 03/19/2018 07:00 PM, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>

[...]

> > diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> > index 0f7ea3074175..5d26e0a223d9 100644
> > --- a/include/linux/hmm.h
> > +++ b/include/linux/hmm.h
> > @@ -80,68 +80,145 @@
> >  struct hmm;
> >  
> >  /*
> > + * hmm_pfn_flag_e - HMM flag enums
> > + *
> >   * Flags:
> >   * HMM_PFN_VALID: pfn is valid. It has, at least, read permission.
> >   * HMM_PFN_WRITE: CPU page table has write permission set
> > + * HMM_PFN_DEVICE_PRIVATE: private device memory (ZONE_DEVICE)
> > + *
> > + * The driver provide a flags array, if driver valid bit for an entry is bit
> > + * 3 ie (entry & (1 << 3)) is true if entry is valid then driver must provide
> > + * an array in hmm_range.flags with hmm_range.flags[HMM_PFN_VALID] == 1 << 3.
> > + * Same logic apply to all flags. This is same idea as vm_page_prot in vma
> > + * except that this is per device driver rather than per architecture.
> 
> Hi Jerome,
> 
> If we go with this approach--and I hope not, I'll try to talk you down from the
> ledge, in a moment--then maybe we should add the following to the comments: 
> 
> "There is only one bit ever set in each hmm_range.flags[entry]." 

This is not necesarily true, driver can have multiple bits set matching
one HMM flag. Actually i do expect to see that (in nouveau).


> Or maybe we'll get pushback, that the code shows that already, but IMHO this is 
> strange way to do things (especially when there is a much easier way), and deserves 
> that extra bit of helpful documentation.
> 
> More below...
> 
> > + */
> > +enum hmm_pfn_flag_e {
> > +	HMM_PFN_VALID = 0,
> > +	HMM_PFN_WRITE,
> > +	HMM_PFN_DEVICE_PRIVATE,
> > +	HMM_PFN_FLAG_MAX
> > +};
> > +
> > +/*
> > + * hmm_pfn_value_e - HMM pfn special value
> > + *
> > + * Flags:
> >   * HMM_PFN_ERROR: corresponding CPU page table entry points to poisoned memory
> > + * HMM_PFN_NONE: corresponding CPU page table entry is pte_none()
> >   * HMM_PFN_SPECIAL: corresponding CPU page table entry is special; i.e., the
> >   *      result of vm_insert_pfn() or vm_insert_page(). Therefore, it should not
> >   *      be mirrored by a device, because the entry will never have HMM_PFN_VALID
> >   *      set and the pfn value is undefined.
> > - * HMM_PFN_DEVICE_PRIVATE: unaddressable device memory (ZONE_DEVICE)
> > + *
> > + * Driver provide entry value for none entry, error entry and special entry,
> > + * driver can alias (ie use same value for error and special for instance). It
> > + * should not alias none and error or special.
> > + *
> > + * HMM pfn value returned by hmm_vma_get_pfns() or hmm_vma_fault() will be:
> > + * hmm_range.values[HMM_PFN_ERROR] if CPU page table entry is poisonous,
> > + * hmm_range.values[HMM_PFN_NONE] if there is no CPU page table
> > + * hmm_range.values[HMM_PFN_SPECIAL] if CPU page table entry is a special one
> >   */
> > -#define HMM_PFN_VALID (1 << 0)
> > -#define HMM_PFN_WRITE (1 << 1)
> > -#define HMM_PFN_ERROR (1 << 2)
> > -#define HMM_PFN_SPECIAL (1 << 3)
> > -#define HMM_PFN_DEVICE_PRIVATE (1 << 4)
> > -#define HMM_PFN_SHIFT 5
> > +enum hmm_pfn_value_e {
> > +	HMM_PFN_ERROR,
> > +	HMM_PFN_NONE,
> > +	HMM_PFN_SPECIAL,
> > +	HMM_PFN_VALUE_MAX
> > +};
> 
> I can think of perhaps two good solid ways to get what you want, without
> moving to what I consider an unnecessary excursion into arrays of flags. 
> If I understand correctly, you want to let each architecture
> specify which bit to use for each of the above HMM_PFN_* flags. 
> 
> The way you have it now, the code does things like this:
> 
>         cpu_flags & range->flags[HMM_PFN_WRITE]
> 
> but that array entry is mostly empty space, and it's confusing. It would
> be nicer to see:
> 
>         cpu_flags & HMM_PFN_WRITE
> 
> ...which you can easily do, by defining HMM_PFN_WRITE and friends in an
> arch-specific header file.

arch-specific header do not work, HMM can be use in same kernel by
different device driver (AMD and NVidia for instance) and each will
have their own page table entry format and they won't match.


> The other way to make this more readable would be to use helper routines
> similar to what the vm_pgprot* routines do:
> 
> static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
> {
> 	return pgprot_modify(oldprot, vm_get_page_prot(vm_flags));
> }
> 
> ...but that's also unnecessary.
> 
> Let's just keep it simple, and go back to the bitmap flags!

This simplify nouveau code and it is the reason why i did that patch.
I am sure it can simplify NVidia uvm code, i can look into it if you
want to give pointers. Idea here is that HMM can fill array with some-
thing that match device driver internal format and avoid the conversion
step from HMM format to driver format (saving CPU cycles and memory
doing so). I am open to alternative that give the same end result.

[Just because code is worth 2^32 words :)

Without this patch:
    int nouveau_do_fault(..., ulong addr, unsigned npages, ...)
    {
        uint64_t *hmm_pfns, *nouveau_pfns;

        hmm_pfns = kmalloc(sizeof(uint64_t) * npages, GFP_KERNEL);
        nouveau_pfns = kmalloc(sizeof(uint64_t) * npages, GFP_KERNEL);
        hmm_vma_fault(..., hmm_pfns, ...);

        for (i = 0; i < npages; ++i) {
            nouveau_pfns[i] = nouveau_pfn_from_hmm_pfn(hmm_pfns[i]);
        }
        ...
    }

With this patch:
    int nouveau_do_fault(..., ulong addr, unsigned npages, ...)
    {
        uint64_t *nouveau_pfns;

        nouveau_pfns = kmalloc(sizeof(uint64_t) * npages, GFP_KERNEL);
        hmm_vma_fault(..., nouveau_pfns, ...);

        ...
    }

Benefit from this patch is quite obvious to me. Down the road with bit
more integration between HMM and IOMMU/DMA this can turn into something
directly ready for hardware consumptions.

Note that you could argue that i can convert nouveau to use HMM format
but this would not work, first because it requires a lot of changes in
nouuveau, second because HMM do not have all the flags needed by the
drivers (nor does HMM need them). HMM being the helper here, i feel it
is up to HMM to adapt to drivers than the other way around.]

Cheers,
Jérôme
