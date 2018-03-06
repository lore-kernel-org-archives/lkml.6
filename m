Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbeCFIaa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:30:30 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33392 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeCFIaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:30:24 -0500
X-Google-Smtp-Source: AG47ELs7YJU4eP384EFuTi6cqfXwaAV4cEq8MLb+alS4mwbWkJ7/48vUcWhjMViO/ke0WPrI65rSWw==
Date: Tue, 6 Mar 2018 11:30:08 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC, PATCH 16/22] x86/mm: Preserve KeyID on pte_modify() and
 pgprot_modify()
Message-ID: <20180306083008.6dklty5oq3pbzxuo@node.shutemov.name>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-17-kirill.shutemov@linux.intel.com>
 <774c1251-46d9-534e-24c2-ca04f1e0a8bb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <774c1251-46d9-534e-24c2-ca04f1e0a8bb@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 11:09:23AM -0800, Dave Hansen wrote:
> On 03/05/2018 08:26 AM, Kirill A. Shutemov wrote:
> > + * It includes full range of PFN bits regardless if they were claimed for KeyID
> > + * or not: we want to preserve KeyID on pte_modify() and pgprot_modify().
> >   */
> > -#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
> > +#define PTE_PFN_MASK_MAX \
> > +	(((signed long)PAGE_MASK) & ((1UL << __PHYSICAL_MASK_SHIFT) - 1))
> > +#define _PAGE_CHG_MASK	(PTE_PFN_MASK_MAX | _PAGE_PCD | _PAGE_PWT |		\
> >  			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
> >  			 _PAGE_SOFT_DIRTY)
> 
> Is there a way to make this:
> 
> #define _PAGE_CHG_MASK	(PTE_PFN_MASK | PTE_KEY_MASK...? | _PAGE_PCD |
> 
> That would be a lot more understandable.

Yes, it would.

But it means we will have *two* variables referenced from _PAGE_CHG_MASK:
one for PTE_PFN_MASK and one for PTE_KEY_MASK as both of them are dynamic.

With this patch we would get rid of both of them.

I'll update the description.

-- 
 Kirill A. Shutemov
