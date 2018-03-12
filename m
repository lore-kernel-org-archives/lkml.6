Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeCLOu4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:50:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:60267 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbeCLOuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:50:55 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,461,1515484800";
   d="scan'208";a="210796691"
Date: Mon, 12 Mar 2018 17:50:49 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>, gorcunov@openvz.org,
        luto@amacapital.net, keescook@chromium.org, willy@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, bp@suse.de,
        andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        ebiederm@xmission.com, jgross@suse.com,
        linux-tip-commits@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>
Subject: Re: [tip:x86/mm] x86/boot/compressed/64: Describe the logic behind
 the LA57 check
Message-ID: <20180312145049.boh3wmaotim6sfh2@black.fi.intel.com>
References: <20180226180451.86788-2-kirill.shutemov@linux.intel.com>
 <tip-a403d798182f4f7be5e9bab56cfa37e9828fd92a@git.kernel.org>
 <20180312124027.GG4064@hirez.programming.kicks-ass.net>
 <20180312124337.vw7bchm6brfzghfa@node.shutemov.name>
 <20180312131055.GH4064@hirez.programming.kicks-ass.net>
 <20180312140449.oyngtgqppnjuh3lf@node.shutemov.name>
 <20180312143212.77z2ptyqbsbqdll3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312143212.77z2ptyqbsbqdll3@gmail.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 02:32:12PM +0000, Ingo Molnar wrote:
> 
> * Kirill A. Shutemov <kirill@shutemov.name> wrote:
> 
> > > We can of course bike shed / benchmark this once my desktop refresh
> > > sports this feature, but ISTR this being one of the very first things
> > > Ingo mentioned when we started this whole 5L thing.
> > 
> > I would rather not fix the problem that may not actually exist. :)
> 
> That 5 level pagetables involve more overhead is a realy problem.

As I mentioned before, microarchitecture changes takes care about
additional overhead: size of intermediate TLB was increased which should
make the difference between 4- and 5-level paging negligible.

> By default we should only enable 5-level paging if memory mappings exist in
> the memory map that require the extended physical memory space.

I disagree that we should decide usefulness of the 5-level paging based on
size of physical memory on the machine.

Consider use case when you have 100TiB database file. It's pretty
reasonable to mmap() such file at once even if you don't have 100TiB of
physical memory to back it up. 1/100 of the file size may still work
fairly well.

Virtual address space is useful on its own and we shouldn't take the
value from the user just because he doesn't have tens of terabytes of
memory.

-- 
 Kirill A. Shutemov
