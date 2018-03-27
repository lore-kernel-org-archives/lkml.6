Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752756AbeC0NgT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:36:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47996 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752279AbeC0NgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:36:16 -0400
Date: Tue, 27 Mar 2018 15:36:10 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?ISO-8859-15?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>, namit@vmware.com
Subject: Re: [PATCH 00/11] Use global pages with PTI
In-Reply-To: <be2e683c-bf0a-e9ce-2f02-4905f6bd56d3@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1803271526260.1964@nanos.tec.linutronix.de>
References: <20180323174447.55F35636@viggo.jf.intel.com> <CA+55aFwEC1O+6qRc35XwpcuLSgJ+0GP6ciqw_1Oc-msX=efLvQ@mail.gmail.com> <be2e683c-bf0a-e9ce-2f02-4905f6bd56d3@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018, Dave Hansen wrote:
> On 03/23/2018 11:26 AM, Linus Torvalds wrote:
> > On Fri, Mar 23, 2018 at 10:44 AM, Dave Hansen
> > <dave.hansen@linux.intel.com> wrote:
> >>
> >> This adds one major change from the last version of the patch set
> >> (present in the last patch).  It makes all kernel text global for non-
> >> PCID systems.  This keeps kernel data protected always, but means that
> >> it will be easier to find kernel gadgets via meltdown on old systems
> >> without PCIDs.  This heuristic is, I think, a reasonable one and it
> >> keeps us from having to create any new pti=foo options
> > 
> > Sounds sane.
> > 
> > The patches look reasonable, but I hate seeing a patch series like
> > this where the only ostensible reason is performance, and there are no
> > performance numbers anywhere..
> 
> Well, rats.  This somehow makes things slower with PCIDs on.  I thought
> I reversed the numbers, but I actually do a "grep -c GLB
> /sys/kernel/debug/page_tables/kernel" and record that in my logs right
> next to the output of time(1), so it's awfully hard to screw up.
> 
> This is time doing a modestly-sized kernel compile on a 4-core Skylake
> desktop.
> 
>                         User Time       Kernel Time     Clock Elapsed
> Baseline ( 0 GLB PTEs)  803.79          67.77           237.30
> w/series (28 GLB PTEs)  807.70 (+0.7%)  68.07 (+0.7%)   238.07 (+0.3%)
> 
> Without PCIDs, it behaves the way I would expect.

What's the performance benefit on !PCID systems? And I mean systems which
actually do not have PCID, not a PCID system with 'nopcid' on the command
line.

Thanks,

	tglx
