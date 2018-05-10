Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757321AbeEJMan (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:30:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:40680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756741AbeEJMam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:30:42 -0400
Date: Thu, 10 May 2018 14:30:39 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, linux-mm@kvack.org, mgorman@techsingularity.net,
        mingo@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        fengguang.wu@intel.com, dennisszhou@gmail.com
Subject: Re: [PATCH v2] mm: allow deferred page init for vmemmap only
Message-ID: <20180510123039.GF5325@dhcp22.suse.cz>
References: <20180510115356.31164-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510115356.31164-1-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10-05-18 07:53:56, Pavel Tatashin wrote:
[...]
> Here is a sample path, where translation is required, that occurs before
> mm_init():
> 
> start_kernel()
>  trap_init()
>   setup_cpu_entry_areas()
>    setup_cpu_entry_area(cpu)
>     get_cpu_gdt_paddr(cpu)
>      per_cpu_ptr_to_phys(addr)
>       pcpu_addr_to_page(addr)
>        virt_to_page(addr)
>         pfn_to_page(__pa(addr) >> PAGE_SHIFT)

Thanks that helped me to see the problem. On the other hand isn't this a
bit of an overkill? AFAICS this affects only NEED_PER_CPU_KM which is !SMP
and DEFERRED_STRUCT_PAGE_INIT makes only very limited sense on UP,
right?

Or do we have more such places?
-- 
Michal Hocko
SUSE Labs
