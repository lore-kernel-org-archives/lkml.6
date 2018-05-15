Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752272AbeEOUDa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:03:30 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33696 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbeEOUD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:03:28 -0400
X-Google-Smtp-Source: AB8JxZpeGCNphbnNfxZc+VC1+2L7WtyuL1gFH+Hnk1RiyvMVIDIzqQN8D2paZijl2sAFJutxVxfgGg==
Date: Tue, 15 May 2018 13:03:26 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: "Huang, Ying" <ying.huang@intel.com>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Shaohua Li <shli@fb.com>, Christopher Lameter <cl@linux.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH -mm] mm, hugetlb: Pass fault address to no page handler
In-Reply-To: <20180515005756.28942-1-ying.huang@intel.com>
Message-ID: <alpine.DEB.2.21.1805151303160.5896@chino.kir.corp.google.com>
References: <20180515005756.28942-1-ying.huang@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2018, Huang, Ying wrote:

> From: Huang Ying <ying.huang@intel.com>
> 
> This is to take better advantage of huge page clearing
> optimization (c79b57e462b5d, "mm: hugetlb: clear target sub-page last
> when clearing huge page").  Which will clear to access sub-page last
> to avoid the cache lines of to access sub-page to be evicted when
> clearing other sub-pages.  This needs to get the address of the
> sub-page to access, that is, the fault address inside of the huge
> page.  So the hugetlb no page fault handler is changed to pass that
> information.  This will benefit workloads which don't access the begin
> of the huge page after page fault.
> 
> With this patch, the throughput increases ~28.1% in vm-scalability
> anon-w-seq test case with 88 processes on a 2 socket Xeon E5 2699 v4
> system (44 cores, 88 threads).  The test case creates 88 processes,
> each process mmap a big anonymous memory area and writes to it from
> the end to the begin.  For each process, other processes could be seen
> as other workload which generates heavy cache pressure.  At the same
> time, the cache miss rate reduced from ~36.3% to ~25.6%, the
> IPC (instruction per cycle) increased from 0.3 to 0.37, and the time
> spent in user space is reduced ~19.3%
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Andi Kleen <andi.kleen@intel.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Shaohua Li <shli@fb.com>
> Cc: Christopher Lameter <cl@linux.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Acked-by: David Rientjes <rientjes@google.com>
