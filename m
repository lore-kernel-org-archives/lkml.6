Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF94C10F04
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC8B20840
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfBOAXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:23:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:36415 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfBOAXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:23:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 16:23:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,370,1544515200"; 
   d="scan'208";a="124601955"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2019 16:23:19 -0800
Date:   Thu, 14 Feb 2019 16:23:12 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     john.hubbard@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/2] mm: put_user_page() call site conversion first
Message-ID: <20190215002312.GC7512@iweiny-DESK2.sc.intel.com>
References: <20190208075649.3025-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208075649.3025-1-jhubbard@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 11:56:47PM -0800, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> Hi,
> 
> It seems about time to post these initial patches: I think we have pretty
> good consensus on the concept and details of the put_user_pages() approach.
> Therefore, here are the first two patches, to get started on converting the
> get_user_pages() call sites to use put_user_page(), instead of put_page().
> This is in order to implement tracking of get_user_page() pages.
> 
> A discussion of the overall problem is below.
> 
> As mentioned in patch 0001, the steps are to fix the problem are:
> 
> 1) Provide put_user_page*() routines, intended to be used
>    for releasing pages that were pinned via get_user_pages*().
> 
> 2) Convert all of the call sites for get_user_pages*(), to
>    invoke put_user_page*(), instead of put_page(). This involves dozens of
>    call sites, and will take some time.
> 
> 3) After (2) is complete, use get_user_pages*() and put_user_page*() to
>    implement tracking of these pages. This tracking will be separate from
>    the existing struct page refcounting.
> 
> 4) Use the tracking and identification of these pages, to implement
>    special handling (especially in writeback paths) when the pages are
>    backed by a filesystem.
> 
> This write up is lifted from the RFC v2 patchset cover letter [1]:
> 
> Overview
> ========
> 
> Some kernel components (file systems, device drivers) need to access
> memory that is specified via process virtual address. For a long time, the
> API to achieve that was get_user_pages ("GUP") and its variations. However,
> GUP has critical limitations that have been overlooked; in particular, GUP
> does not interact correctly with filesystems in all situations. That means
> that file-backed memory + GUP is a recipe for potential problems, some of
> which have already occurred in the field.
> 
> GUP was first introduced for Direct IO (O_DIRECT), allowing filesystem code
> to get the struct page behind a virtual address and to let storage hardware
> perform a direct copy to or from that page. This is a short-lived access
> pattern, and as such, the window for a concurrent writeback of GUP'd page
> was small enough that there were not (we think) any reported problems.
> Also, userspace was expected to understand and accept that Direct IO was
> not synchronized with memory-mapped access to that data, nor with any
> process address space changes such as munmap(), mremap(), etc.
> 
> Over the years, more GUP uses have appeared (virtualization, device
> drivers, RDMA) that can keep the pages they get via GUP for a long period
> of time (seconds, minutes, hours, days, ...). This long-term pinning makes
> an underlying design problem more obvious.
> 
> In fact, there are a number of key problems inherent to GUP:
> 
> Interactions with file systems
> ==============================
> 
> File systems expect to be able to write back data, both to reclaim pages,
> and for data integrity. Allowing other hardware (NICs, GPUs, etc) to gain
> write access to the file memory pages means that such hardware can dirty
> the pages, without the filesystem being aware. This can, in some cases
> (depending on filesystem, filesystem options, block device, block device
> options, and other variables), lead to data corruption, and also to kernel
> bugs of the form:
> 
>     kernel BUG at /build/linux-fQ94TU/linux-4.4.0/fs/ext4/inode.c:1899!
>     backtrace:
>         ext4_writepage
>         __writepage
>         write_cache_pages
>         ext4_writepages
>         do_writepages
>         __writeback_single_inode
>         writeback_sb_inodes
>         __writeback_inodes_wb
>         wb_writeback
>         wb_workfn
>         process_one_work
>         worker_thread
>         kthread
>         ret_from_fork
> 
> ...which is due to the file system asserting that there are still buffer
> heads attached:
> 
>         ({                                                      \
>                 BUG_ON(!PagePrivate(page));                     \
>                 ((struct buffer_head *)page_private(page));     \
>         })
> 
> Dave Chinner's description of this is very clear:
> 
>     "The fundamental issue is that ->page_mkwrite must be called on every
>     write access to a clean file backed page, not just the first one.
>     How long the GUP reference lasts is irrelevant, if the page is clean
>     and you need to dirty it, you must call ->page_mkwrite before it is
>     marked writeable and dirtied. Every. Time."
> 
> This is just one symptom of the larger design problem: filesystems do not
> actually support get_user_pages() being called on their pages, and letting
> hardware write directly to those pages--even though that pattern has been
> going on since about 2005 or so.
> 
> Long term GUP
> =============
> 
> Long term GUP is an issue when FOLL_WRITE is specified to GUP (so, a
> writeable mapping is created), and the pages are file-backed. That can lead
> to filesystem corruption. What happens is that when a file-backed page is
> being written back, it is first mapped read-only in all of the CPU page
> tables; the file system then assumes that nobody can write to the page, and
> that the page content is therefore stable. Unfortunately, the GUP callers
> generally do not monitor changes to the CPU pages tables; they instead
> assume that the following pattern is safe (it's not):
> 
>     get_user_pages()
> 
>     Hardware can keep a reference to those pages for a very long time,
>     and write to it at any time. Because "hardware" here means "devices
>     that are not a CPU", this activity occurs without any interaction
>     with the kernel's file system code.
> 
>     for each page
>         set_page_dirty
>         put_page()
> 
> In fact, the GUP documentation even recommends that pattern.
> 
> Anyway, the file system assumes that the page is stable (nothing is writing
> to the page), and that is a problem: stable page content is necessary for
> many filesystem actions during writeback, such as checksum, encryption,
> RAID striping, etc. Furthermore, filesystem features like COW (copy on
> write) or snapshot also rely on being able to use a new page for as memory
> for that memory range inside the file.
> 
> Corruption during write back is clearly possible here. To solve that, one
> idea is to identify pages that have active GUP, so that we can use a bounce
> page to write stable data to the filesystem. The filesystem would work
> on the bounce page, while any of the active GUP might write to the
> original page. This would avoid the stable page violation problem, but note
> that it is only part of the overall solution, because other problems
> remain.
> 
> Other filesystem features that need to replace the page with a new one can
> be inhibited for pages that are GUP-pinned. This will, however, alter and
> limit some of those filesystem features. The only fix for that would be to
> require GUP users to monitor and respond to CPU page table updates.
> Subsystems such as ODP and HMM do this, for example. This aspect of the
> problem is still under discussion.
> 
> Direct IO
> =========
> 
> Direct IO can cause corruption, if userspace does Direct-IO that writes to
> a range of virtual addresses that are mmap'd to a file.  The pages written
> to are file-backed pages that can be under write back, while the Direct IO
> is taking place.  Here, Direct IO races with a write back: it calls
> GUP before page_mkclean() has replaced the CPU pte with a read-only entry.
> The race window is pretty small, which is probably why years have gone by
> before we noticed this problem: Direct IO is generally very quick, and
> tends to finish up before the filesystem gets around to do anything with
> the page contents.  However, it's still a real problem.  The solution is
> to never let GUP return pages that are under write back, but instead,
> force GUP to take a write fault on those pages.  That way, GUP will
> properly synchronize with the active write back.  This does not change the
> required GUP behavior, it just avoids that race.
> 
> 
> [1] https://lkml.kernel.org/r/20190204052135.25784-1-jhubbard@nvidia.com
> 
> Cc: Christian Benvenuti <benve@cisco.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Christopher Lameter <cl@linux.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Tom Talpey <tom@talpey.com>
> 
> John Hubbard (2):
>   mm: introduce put_user_page*(), placeholder versions
>   infiniband/mm: convert put_page() to put_user_page*()

A bit late but, FWIW:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

John these are the pages sitting in your gup_dma/first_steps branch here,
correct?

https://github.com/johnhubbard/linux.git

> 
>  drivers/infiniband/core/umem.c              |  7 +-
>  drivers/infiniband/core/umem_odp.c          |  2 +-
>  drivers/infiniband/hw/hfi1/user_pages.c     | 11 +--
>  drivers/infiniband/hw/mthca/mthca_memfree.c |  6 +-
>  drivers/infiniband/hw/qib/qib_user_pages.c  | 11 +--
>  drivers/infiniband/hw/qib/qib_user_sdma.c   |  6 +-
>  drivers/infiniband/hw/usnic/usnic_uiom.c    |  7 +-
>  include/linux/mm.h                          | 24 ++++++
>  mm/swap.c                                   | 82 +++++++++++++++++++++
>  9 files changed, 129 insertions(+), 27 deletions(-)
> 
> -- 
> 2.20.1
> 
