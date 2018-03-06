Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeCFIya (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:54:30 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38806 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeCFIy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:54:29 -0500
X-Google-Smtp-Source: AG47ELtCw2/a8vVr41rzt0TqYj2PYYeXyk6XxjEJN9HNqK+06e3jC6reBtGZXL+N6a/54KDrfFNy+w==
Date: Tue, 6 Mar 2018 11:54:12 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC, PATCH 19/22] x86/mm: Implement free_encrypt_page()
Message-ID: <20180306085412.vkgheeya24dze53t@node.shutemov.name>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-20-kirill.shutemov@linux.intel.com>
 <a692b2ff-b590-b731-ad14-18238f471a1c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a692b2ff-b590-b731-ad14-18238f471a1c@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 11:07:16AM -0800, Dave Hansen wrote:
> On 03/05/2018 08:26 AM, Kirill A. Shutemov wrote:
> > +void free_encrypt_page(struct page *page, int keyid, unsigned int order)
> > +{
> > +	int i;
> > +	void *v;
> > +
> > +	for (i = 0; i < (1 << order); i++) {
> > +		v = kmap_atomic_keyid(page, keyid + i);
> > +		/* See comment in prep_encrypt_page() */
> > +		clflush_cache_range(v, PAGE_SIZE);
> > +		kunmap_atomic(v);
> > +	}
> > +}
> 
> Have you measured how slow this is?

No, I have not.

> It's an optimization, but can we find a way to only do this dance when
> we *actually* change the keyid?  Right now, we're doing mapping at alloc
> and free, clflushing at free and zeroing at alloc.  Let's say somebody does:
> 
> 	ptr = malloc(PAGE_SIZE);
> 	*ptr = foo;
> 	free(ptr);
> 
> 	ptr = malloc(PAGE_SIZE);
> 	*ptr = bar;
> 	free(ptr);
> 
> And let's say ptr is in encrypted memory and that we actually munmap()
> at free().  We can theoretically skip the clflush, right?

Yes we can. Theoretically. We would need to find a way to keep KeyID
around after the page is removed from rmap. That's not so trivial as far
as I can see.

I will look into optimization after I'll got functionality in place.

-- 
 Kirill A. Shutemov
