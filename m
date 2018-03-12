Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeCLOFQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:05:16 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38006 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbeCLOFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:05:14 -0400
X-Google-Smtp-Source: AG47ELv7PGR/IMmHON0EDFJpNi6SfEMoTKHOZr0RyplaiRYhWtTA8B/VBmkDpISojE4aZmy7jCHN9Q==
Date: Mon, 12 Mar 2018 17:04:49 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kirill.shutemov@linux.intel.com, gorcunov@openvz.org,
        luto@amacapital.net, keescook@chromium.org, willy@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, bp@suse.de,
        andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, ebiederm@xmission.com, jgross@suse.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/mm] x86/boot/compressed/64: Describe the logic behind
 the LA57 check
Message-ID: <20180312140449.oyngtgqppnjuh3lf@node.shutemov.name>
References: <20180226180451.86788-2-kirill.shutemov@linux.intel.com>
 <tip-a403d798182f4f7be5e9bab56cfa37e9828fd92a@git.kernel.org>
 <20180312124027.GG4064@hirez.programming.kicks-ass.net>
 <20180312124337.vw7bchm6brfzghfa@node.shutemov.name>
 <20180312131055.GH4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312131055.GH4064@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 02:10:55PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 12, 2018 at 03:43:37PM +0300, Kirill A. Shutemov wrote:
> > On Mon, Mar 12, 2018 at 01:40:27PM +0100, Peter Zijlstra wrote:
> > > On Mon, Mar 12, 2018 at 02:27:58AM -0700, tip-bot for Kirill A. Shutemov wrote:
> > > > +	/*
> > > > +	 * Check if LA57 is desired and supported.
> > > > +	 *
> > > > +	 * There are two parts to the check:
> > > > +	 *   - if the kernel supports 5-level paging: CONFIG_X86_5LEVEL=y
> > > > +	 *   - if the machine supports 5-level paging:
> > > > +	 *     + CPUID leaf 7 is supported
> > > > +	 *     + the leaf has the feature bit set
> > > > +	 *
> > > > +	 * That's substitute for boot_cpu_has() in early boot code.
> > > > +	 */
> > > > +	if (IS_ENABLED(CONFIG_X86_5LEVEL) &&
> > > > +			native_cpuid_eax(0) >= 7 &&
> > > > +			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
> > > >  		paging_config.l5_required = 1;
> > > > +	}
> > > 
> > > Should this not also include something like: machine actually has
> > > suffient memory for it to make sense to use l5 ?
> > 
> > Define "suffient". :)
> > 
> > The amount of physical memory is not the only reason to have 5-level
> > paging enabled. You may need 5-level paging to get access to wider virtual
> > address space to map something not backed by local physical memory
> > (consider RDMA).
> 
> Special needs can always use special knobs :-) But I was thinking
> something like >2/3 46 bits or so switching to 5L.

42TiB or so?

This basically means that 5-level paging will not get run on vast majority
of *capable* hardware. That's not good from testing POV.

> My main concern is the increased worst case TLB miss cost on machines
> that really don't need 5L paging (like my desktop, which I suspect will
> not exceed the multi terabyte of memory class for a while yet).

The microarchitecture was adjusted to accommodate the increased TLB
pressure. You shouldn't see the difference unless you actively use
increased virtual address space.

> We can of course bike shed / benchmark this once my desktop refresh
> sports this feature, but ISTR this being one of the very first things
> Ingo mentioned when we started this whole 5L thing.

I would rather not fix the problem that may not actually exist. :)

-- 
 Kirill A. Shutemov
