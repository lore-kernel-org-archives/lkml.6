Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753291AbeCFIen (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:34:43 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35000 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbeCFIem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:34:42 -0500
X-Google-Smtp-Source: AG47ELv2s2SZM7PJk4O0OkbFy6KCF6DTuONP5A+2KjMAnXoSANduAhKLZjX2WRbxbDUutUA/aRrfkw==
Date: Tue, 6 Mar 2018 11:34:25 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC, PATCH 18/22] x86/mm: Handle allocation of encrypted pages
Message-ID: <20180306083425.gwt7j5cxtd6vrd3r@node.shutemov.name>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-19-kirill.shutemov@linux.intel.com>
 <e2fed2a7-88db-96f0-56f5-b20b624eb665@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2fed2a7-88db-96f0-56f5-b20b624eb665@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 11:03:55AM -0800, Dave Hansen wrote:
> On 03/05/2018 08:26 AM, Kirill A. Shutemov wrote:
> > -#define __alloc_zeroed_user_highpage(movableflags, vma, vaddr) \
> > -	alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma, vaddr)
> >  #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
> > +#define __alloc_zeroed_user_highpage(movableflags, vma, vaddr)			\
> > +({										\
> > +	struct page *page;							\
> > +	gfp_t gfp = movableflags | GFP_HIGHUSER;				\
> > +	if (vma_is_encrypted(vma))						\
> > +		page = __alloc_zeroed_encrypted_user_highpage(gfp, vma, vaddr);	\
> > +	else									\
> > +		page = alloc_page_vma(gfp | __GFP_ZERO, vma, vaddr);		\
> > +	page;									\
> > +})
> 
> This is pretty darn ugly and also adds a big old branch into the hottest
> path in the page allocator.
> 
> It's also really odd that you strip __GFP_ZERO and then go ahead and
> zero the encrypted page unconditionally.  It really makes me wonder if
> this is the right spot to be doing this.
> 
> Can we not, for instance do it inside alloc_page_vma()?

Yes we can.

It would require substantial change into page allocation path for
CONFIG_NUMA=n as we don't path down vma at the moment. And without vma we
don't have a way to know which KeyID to use.

I will explore how it would fit together.

-- 
 Kirill A. Shutemov
