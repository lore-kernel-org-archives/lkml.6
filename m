Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeB0Hov (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 02:44:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:54831 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752475AbeB0Hot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 02:44:49 -0500
Subject: Re: [v2 1/1] xen, mm: Allow deferred page initialization for xen pv
 domains
To: Pavel Tatashin <pasha.tatashin@oracle.com>, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, akataria@vmware.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        boris.ostrovsky@oracle.com, akpm@linux-foundation.org, mhocko@suse.com,
        vbabka@suse.cz, luto@kernel.org, labbott@redhat.com,
        kirill.shutemov@linux.intel.com, bp@suse.de, minipli@googlemail.com,
        jinb.park7@gmail.com, dan.j.williams@intel.com, bhe@redhat.com,
        zhang.jia@linux.alibaba.com, mgorman@techsingularity.net,
        hannes@cmpxchg.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org
References: <20180226160112.24724-1-pasha.tatashin@oracle.com>
 <20180226160112.24724-2-pasha.tatashin@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <927f2a94-2ece-53f7-3be8-532f3be77dd4@suse.com>
Date: Tue, 27 Feb 2018 08:44:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226160112.24724-2-pasha.tatashin@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/18 17:01, Pavel Tatashin wrote:
> Juergen Gross noticed that commit
> f7f99100d8d ("mm: stop zeroing memory during allocation in vmemmap")
> broke XEN PV domains when deferred struct page initialization is enabled.
> 
> This is because the xen's PagePinned() flag is getting erased from struct
> pages when they are initialized later in boot.
> 
> Juergen fixed this problem by disabling deferred pages on xen pv domains.
> It is desirable, however, to have this feature available as it reduces boot
> time. This fix re-enables the feature for pv-dmains, and fixes the problem
> the following way:
> 
> The fix is to delay setting PagePinned flag until struct pages for all
> allocated memory are initialized, i.e. until after free_all_bootmem().
> 
> A new x86_init.hyper op init_after_bootmem() is called to let xen know
> that boot allocator is done, and hence struct pages for all the allocated
> memory are now initialized. If deferred page initialization is enabled, the
> rest of struct pages are going to be initialized later in boot once
> page_alloc_init_late() is called.
> 
> xen_after_bootmem() walks page table's pages and marks them pinned.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Verified to work on a system where the original issue caused a crash.

Reviewed-by: Juergen Gross <jgross@suse.com>
Tested-by: Juergen Gross <jgross@suse.com>


Juergen
