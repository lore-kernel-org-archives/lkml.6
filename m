Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031846AbeBNPwD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:52:03 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:50809 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031649AbeBNPwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:52:01 -0500
X-Google-Smtp-Source: AH8x227dlcjLvbUE3yqXceK42HE6dVTHT/WU6jd5Ard3hyAqGSiQSf4W0+i+wfXrhKgjuLJqBe+/nw==
Date: Wed, 14 Feb 2018 18:51:57 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kai Huang <kai.huang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Decouple dynamic __PHYSICAL_MASK from AMD SME
Message-ID: <20180214155157.e4z5vsm3237445xy@node.shutemov.name>
References: <20180208125524.88795-1-kirill.shutemov@linux.intel.com>
 <5199949d-6795-aa55-888c-7ba8abd406e2@amd.com>
 <20180214042121.tza3cpvrnpztjeme@node.shutemov.name>
 <37cf20a3-653b-1ad7-1e65-6bed935cf325@amd.com>
 <1518593420.13066.11.camel@linux.intel.com>
 <20180214090239.cjidydeflvgeww4d@node.shutemov.name>
 <6f5f917e-cded-66ca-2549-f3d51dff1595@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f5f917e-cded-66ca-2549-f3d51dff1595@amd.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 09:09:05AM -0600, Tom Lendacky wrote:
> On 2/14/2018 3:02 AM, Kirill A. Shutemov wrote:
> > On Wed, Feb 14, 2018 at 08:30:20PM +1300, Kai Huang wrote:
> >> On Tue, 2018-02-13 at 22:57 -0600, Tom Lendacky wrote:
> >>> On 2/13/2018 10:21 PM, Kirill A. Shutemov wrote:
> >>>> On Tue, Feb 13, 2018 at 10:10:22PM -0600, Tom Lendacky wrote:
> >>>>> On 2/8/2018 6:55 AM, Kirill A. Shutemov wrote:
> >>>>>> AMD SME claims one bit from physical address to indicate
> >>>>>> whether the
> >>>>>> page is encrypted or not. To achieve that we clear out the bit
> >>>>>> from
> >>>>>> __PHYSICAL_MASK.
> >>>>>
> >>>>> I was actually working on a suggestion by Linus to use one of the
> >>>>> software
> >>>>> page table bits to indicate encryption and translate that to the
> >>>>> hardware
> >>>>> bit when writing the actual page table entry.  With that,
> >>>>> __PHYSICAL_MASK
> >>>>> would go back to its original definition.
> >>>>
> >>>> But you would need to mask it on reading of pfn from page table
> >>>> entry,
> >>>> right? I expect it to have more overhead than this one.
> >>>
> >>> When reading back an entry it would translate the hardware bit
> >>> position
> >>> back to the software bit position.  The suggestion for changing it
> >>> was
> >>> to make _PAGE_ENC a constant and not tied to the sme_me_mask.
> > 
> > But is it really constant? I thought it's enumerated at boot-time.
> > Can we step onto a problem for future AMD CPUs?
> 
> _PAGE_ENC would be constant and it would be translated to the actual bit
> that was enumerated at boot-time when writing the page table entry and
> translated back to _PAGE_ENC when reading the page table entry.

I'm confused. I thought that _PAGE_ENC would actual bit that indicate
encryption.

If we need translation, I don't see how pte_pfn() can be implemented
efficiently. Getting pfn from page table entry is the path that I'm worry
about. It's all over the kernel and having overhead there comes with cost.

Could you write a prototype of such patch? I have hard time grasping your
idea.

> > In case of MKTME the bits we need to clear are not constant. Depends on
> > CPU and BIOS settings.
> > 
> > By making _PAGE_ENC constant we would effectively lower maximum physical
> > address space the kernel can handle, regardless if the system has SME
> > enabled. I can imagine some people wouldn't be happy about this.
> 
> I don't see how this would lower the maximum physical address space the
> kernel could handle.  Bit 57 is part of the reserved page table flag
> bits and if SME is not enabled the hardware bits are never used.

My statement came from confusion about _PAGE_ENC value.

> What I do see as a problem is a kernel built with support for SME, and
> therefore _PAGE_ENC is not zero, but SME has not been enabled by the BIOS
> or mem_encrypt=off is specified.  In this case you can never be certain
> that the translation from software bit to hardware bit and back is
> correct.  Take for example, pmd_bad(). Here, _KERNPG_TABLE would have a
> non-zero _PAGE_ENC or'd into it.  When written to a page table entry when
> SME is not enabled/active, the actual hardware encryption bit would not be
> set.  When reading back the value, since the hardware encryption bit is
> not set, the translation to set _PAGE_ENC bit won't be done and the
> comparison to _KERNPG_TABLE would fail.  Of course we could just eliminate
> _PAGE_ENC from the comparison...
> 
> > 
> > And I think it would collide with 5-level paging.
> 
> Does 5-level paging remove bit 57 from the reserved flags?

No. The same confusion.

> > I would leave it as variable for now and look on this later once we would
> > have infrastructure to patch constants in kernel text.
> 
> If the MK-TME support is going to use the same approach to include the
> mask/bits real time in _PAGE_ENC then maybe it would be best to get that
> in first and then look to see if something could be done along the lines
> of what Linus suggests or with the patchable constants.

-- 
 Kirill A. Shutemov
