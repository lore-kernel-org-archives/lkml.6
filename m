Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeCFIjT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:39:19 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35961 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753077AbeCFIjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:39:07 -0500
X-Google-Smtp-Source: AG47ELsYBsGQzB3QaslPBvE8UYSDHgmNUusu5TL0slFLJCX7TAaUYA6kvpb845b86LOIeJfN8RHaFQ==
Date: Tue, 6 Mar 2018 11:38:51 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC, PATCH 19/22] x86/mm: Implement free_encrypt_page()
Message-ID: <20180306083851.g5yh6f66srvrtc5n@node.shutemov.name>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-20-kirill.shutemov@linux.intel.com>
 <f9129b50-9231-abfd-9eb2-5eecad7e220d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9129b50-9231-abfd-9eb2-5eecad7e220d@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 11:00:00AM -0800, Dave Hansen wrote:
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
> Did you miss adding the call sites for this?

No. It is in "mm, rmap: Free encrypted pages once mapcount drops to zero".
But the call is optimized out since anon_vma_encrypted() is always false
so far.

-- 
 Kirill A. Shutemov
