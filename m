Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeBSN4w (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:56:52 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38807 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbeBSN4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:56:50 -0500
X-Google-Smtp-Source: AH8x227uwWICjA31KkadA9mvi+ojFWi0HG+1agsjLpw0WQMuqGmWIgjA3GigZtcJTSDrNr8EMidUOg==
Date: Mon, 19 Feb 2018 16:56:46 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Michal Hocko <mhocko@kernel.org>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com, mpe <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        sachinp <sachinp@linux.vnet.ibm.com>
Subject: Re: [mainline][Memory off/on][83e3c48] kernel Oops with memory
 hot-unplug on ppc
Message-ID: <20180219135646.lsmxkbgdwrjdlwxy@node.shutemov.name>
References: <1517840664.647.17.camel@abdul.in.ibm.com>
 <20180219134735.GN21134@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219134735.GN21134@dhcp22.suse.cz>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 02:47:35PM +0100, Michal Hocko wrote:
> [CC Kirill - I have a vague recollection that there were some follow ups
>  for 83e3c48729d9 ("mm/sparsemem: Allocate mem_section at runtime for
>  CONFIG_SPARSEMEM_EXTREME=y"). Does any of them apply to this issue?]

All fixups are in v4.15.

> On Mon 05-02-18 19:54:24, Abdul Haleem wrote:
> > 
> > Greetings,
> > 
> > Kernel Oops seen when memory hot-unplug on powerpc mainline kernel.
> > 
> > Machine: Power6 PowerVM ppc64
> > Kernel: 4.15.0
> > Config: attached
> > gcc: 4.8.2
> > Test: Memory hot-unplug of a memory block
> > echo offline > /sys/devices/system/memory/memory<x>/state
> > 
> > The faulty instruction address points to the code path:
> > 
> > # gdb -batch vmlinux -ex 'list *(0xc000000000238330)'
> > 0xc000000000238330 is in get_pfnblock_flags_mask
> > (./include/linux/mmzone.h:1157).
> > 1152	#endif
> > 1153	
> > 1154	static inline struct mem_section *__nr_to_section(unsigned long nr)
> > 1155	{
> > 1156	#ifdef CONFIG_SPARSEMEM_EXTREME
> > 1157		if (!mem_section)
> > 1158			return NULL;
> > 1159	#endif
> > 1160		if (!mem_section[SECTION_NR_TO_ROOT(nr)])
> > 1161			return NULL;
> > 
> > 
> > The code was first introduced with commit( 83e3c48: mm/sparsemem:
> > Allocate mem_section at runtime for CONFIG_SPARSEMEM_EXTREME=y)

Any chance to bisect it?

Could you check if the commit just before 83e3c48729d9 is fine?

-- 
 Kirill A. Shutemov
