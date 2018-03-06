Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbeCFI2B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:28:01 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40523 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeCFI17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:27:59 -0500
X-Google-Smtp-Source: AG47ELvvb7Jngklu5fIYvwWILlS5th7ZXufmFC+IhuA7/uvUwWDFVGa7uXNEIZdalZbYu4vl8nMVoA==
Date: Tue, 6 Mar 2018 11:27:43 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC, PATCH 13/22] mm, rmap: Free encrypted pages once mapcount
 drops to zero
Message-ID: <20180306082743.2epdfxv4ds7hz7py@node.shutemov.name>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-14-kirill.shutemov@linux.intel.com>
 <e04536bc-77e9-84d0-3c23-1dfea8542da5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e04536bc-77e9-84d0-3c23-1dfea8542da5@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 11:13:36AM -0800, Dave Hansen wrote:
> On 03/05/2018 08:26 AM, Kirill A. Shutemov wrote:
> > @@ -1292,6 +1308,12 @@ static void page_remove_anon_compound_rmap(struct page *page)
> >  		__mod_node_page_state(page_pgdat(page), NR_ANON_MAPPED, -nr);
> >  		deferred_split_huge_page(page);
> >  	}
> > +
> > +	anon_vma = page_anon_vma(page);
> > +	if (anon_vma_encrypted(anon_vma)) {
> > +		int keyid = anon_vma_keyid(anon_vma);
> > +		free_encrypt_page(page, keyid, compound_order(page));
> > +	}
> >  }
> 
> It's not covered in the description and I'm to lazy to dig into it, so:
> Without this code, where do they get freed?  Why does it not cause any
> problems to free them here?

It's the only place where we get it freed. "Freeing" is not the best
terminology here, but I failed to come up with something batter.
We prepare the encryption page to being freed: flush the cache in MKTME
case.

The page itself gets freed later in a usual manner: once refcount drops to
zero. The problem is that we may not have valid anon_vma around once
mapcount drops to zero, so we have to do "freeing" here.

For anonymous memory once mapcount dropped to zero there's no way it will
get mapped back to userspace. page_remove_anon

Kernel still will be able to access the page with kmap() and I will need
to be very careful to get it right wrt cache management.

I'll update the description.

-- 
 Kirill A. Shutemov
