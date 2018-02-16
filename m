Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758077AbeBPPAT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:00:19 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54436 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758065AbeBPPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:00:18 -0500
X-Google-Smtp-Source: AH8x225kBZg9vaEREb+vJZPF70cj8+k2E0JnZ4j/n3l8DMze0aG2FSI7jIurUVwvf82w0FF+dm14FA==
Date: Fri, 16 Feb 2018 18:00:13 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/xen: Allow XEN_PV and XEN_PVH to be enabled with
 X86_5LEVEL
Message-ID: <20180216150013.twajic7ewrbacx7m@node.shutemov.name>
References: <20180216114948.68868-1-kirill.shutemov@linux.intel.com>
 <20180216114948.68868-2-kirill.shutemov@linux.intel.com>
 <20180216141110.GA10501@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216141110.GA10501@bombadil.infradead.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 06:11:10AM -0800, Matthew Wilcox wrote:
> On Fri, Feb 16, 2018 at 02:49:46PM +0300, Kirill A. Shutemov wrote:
> > @@ -38,12 +38,12 @@
> >   *
> >   */
> >  
> > +#define l4_index(x)	(((x) >> 39) & 511)
> >  #define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
> 
> Shouldn't that be
> +#define p4d_index(x)	(((x) >> P4D_SHIFT) & (PTRS_PER_P4D-1))

With CONFIG_X86_5LEVEL=y, PTRS_PER_P4D is a varaible, so it won't compile.
With CONFIG_X86_5LEVEL=n, PTRS_PER_P4D is 1, so it's broken.

And I didn't want to mixin p4d here: it's actually top-level page table
in 4-level paging mode.

I guess we can do something like:

#define l4_index(x)	(((x) >> P4D_SIFT) & (PTRS_PER_PGD-1))

But to me it's more confusing than couple numbers.

-- 
 Kirill A. Shutemov
