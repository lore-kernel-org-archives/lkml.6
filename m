Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbeEOJKo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:10:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:53267 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752570AbeEOJKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:10:43 -0400
Date: Tue, 15 May 2018 11:10:36 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        Linux Memory Management List <linux-mm@kvack.org>,
        mgorman@techsingularity.net, mingo@kernel.org, peterz@infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Dennis Zhou <dennisszhou@gmail.com>
Subject: Re: [PATCH v2] mm: allow deferred page init for vmemmap only
Message-ID: <20180515091036.GC12670@dhcp22.suse.cz>
References: <20180510115356.31164-1-pasha.tatashin@oracle.com>
 <20180510123039.GF5325@dhcp22.suse.cz>
 <CAGM2reZbYR96_uv-SB=5eL6tt0OSq9yXhtA-B2TGHbRQtfGU6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reZbYR96_uv-SB=5eL6tt0OSq9yXhtA-B2TGHbRQtfGU6g@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-05-18 10:17:55, Pavel Tatashin wrote:
> > Thanks that helped me to see the problem. On the other hand isn't this a
> > bit of an overkill? AFAICS this affects only NEED_PER_CPU_KM which is !SMP
> > and DEFERRED_STRUCT_PAGE_INIT makes only very limited sense on UP,
> > right?
> 
> > Or do we have more such places?
> 
> I do not know other places, but my worry is that trap_init() is arch
> specific and we cannot guarantee that arches won't do virt to phys in
> trap_init() in other places. Therefore, I think a proper fix is simply
> allow DEFERRED_STRUCT_PAGE_INIT when it is safe to do virt to phys without
> accessing struct pages, which is with SPARSEMEM_VMEMMAP.

You are now disabling a potentially useful feature to SPARSEMEM users
without having any evidence that they do suffer from the issue which is
kinda sad. Especially when the only known offender is a UP pcp allocator
implementation.

I will not insist of course but it seems like your fix doesn't really
prevent virt_to_page or other direct page access either.
-- 
Michal Hocko
SUSE Labs
