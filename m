Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966610AbeBNJCq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:02:46 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50647 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754400AbeBNJCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:02:42 -0500
X-Google-Smtp-Source: AH8x227pJagaGZtl2rPpg9pk0qWPgqrVYkDnpjkvA9jSdz+Aip5SxzYb7s1p8CZhdr3uMaML//9vBQ==
Date: Wed, 14 Feb 2018 12:02:39 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Kai Huang <kai.huang@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Decouple dynamic __PHYSICAL_MASK from AMD SME
Message-ID: <20180214090239.cjidydeflvgeww4d@node.shutemov.name>
References: <20180208125524.88795-1-kirill.shutemov@linux.intel.com>
 <5199949d-6795-aa55-888c-7ba8abd406e2@amd.com>
 <20180214042121.tza3cpvrnpztjeme@node.shutemov.name>
 <37cf20a3-653b-1ad7-1e65-6bed935cf325@amd.com>
 <1518593420.13066.11.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518593420.13066.11.camel@linux.intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 08:30:20PM +1300, Kai Huang wrote:
> On Tue, 2018-02-13 at 22:57 -0600, Tom Lendacky wrote:
> > On 2/13/2018 10:21 PM, Kirill A. Shutemov wrote:
> > > On Tue, Feb 13, 2018 at 10:10:22PM -0600, Tom Lendacky wrote:
> > > > On 2/8/2018 6:55 AM, Kirill A. Shutemov wrote:
> > > > > AMD SME claims one bit from physical address to indicate
> > > > > whether the
> > > > > page is encrypted or not. To achieve that we clear out the bit
> > > > > from
> > > > > __PHYSICAL_MASK.
> > > > 
> > > > I was actually working on a suggestion by Linus to use one of the
> > > > software
> > > > page table bits to indicate encryption and translate that to the
> > > > hardware
> > > > bit when writing the actual page table entry.  With that,
> > > > __PHYSICAL_MASK
> > > > would go back to its original definition.
> > > 
> > > But you would need to mask it on reading of pfn from page table
> > > entry,
> > > right? I expect it to have more overhead than this one.
> > 
> > When reading back an entry it would translate the hardware bit
> > position
> > back to the software bit position.  The suggestion for changing it
> > was
> > to make _PAGE_ENC a constant and not tied to the sme_me_mask.

But is it really constant? I thought it's enumerated at boot-time.
Can we step onto a problem for future AMD CPUs?

In case of MKTME the bits we need to clear are not constant. Depends on
CPU and BIOS settings.

By making _PAGE_ENC constant we would effectively lower maximum physical
address space the kernel can handle, regardless if the system has SME
enabled. I can imagine some people wouldn't be happy about this.

And I think it would collide with 5-level paging.

I would leave it as variable for now and look on this later once we would
have infrastructure to patch constants in kernel text.

-- 
 Kirill A. Shutemov
