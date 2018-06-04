Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbeFDLcl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:32:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:2881 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752246AbeFDLcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:32:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,476,1520924400";
   d="scan'208";a="56355443"
Date: Mon, 4 Jun 2018 14:32:36 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Josef Bacik <jbacik@fb.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: Zero out unused vma fields in
 shmem_pseudo_vma_init()
Message-ID: <20180604113236.oewgy7jb7frsawg5@black.fi.intel.com>
References: <20180531135602.20321-1-kirill.shutemov@linux.intel.com>
 <alpine.LSU.2.11.1805311522380.13187@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1805311522380.13187@eggly.anvils>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 10:50:36PM +0000, Hugh Dickins wrote:
> On Thu, 31 May 2018, Kirill A. Shutemov wrote:
> 
> > shmem/tmpfs uses pseudo vma to allocate page with correct NUMA policy.
> > 
> > The pseudo vma doesn't have vm_page_prot set. We are going to encode
> > encryption KeyID in vm_page_prot. Having garbage there causes problems.
> > 
> > Zero out all unused fields in the pseudo vma.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> I won't go so far as to say NAK, but personally I much prefer that we
> document what fields actually get used, by initializing only those,
> rather than having such a blanket memset.

I recognize value of documentation here. But I still think leaving garbage
in the fields is not a great idea.

> 
> And you say "We are going to ...": so this should really be part of
> some future patchset, shouldn't it?

Yeah. It's for MKTME. I just try to push easy patches first.

> My opinion might be in the minority: you remind me of a similar
> request from Josef some while ago, Cc'ing him.
> 
> (I'm very ashamed, by the way, of shmem's pseudo-vma, I think it's
> horrid, and just reflects that shmem was an afterthought when NUMA
> mempolicies were designed.  Internally, we replaced alloc_pages_vma()
> throughout by alloc_pages_mpol(), which has no need for pseudo-vmas,
> and the advantage of dropping mmap_sem across the bulk of NUMA page
> migration. I shall be updating that work in coming months, and hope
> to upstream, but no promise from me on the timing - your need for
> vm_page_prot likely much sooner.)

I will try to look at how we can get alloc_pages_mpol() implemented.
(Although interleave bias is kinda confusing. I'll need to wrap my head
around the thing.)

-- 
 Kirill A. Shutemov
