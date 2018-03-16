Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeCPKFP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:05:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:23168 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750982AbeCPKFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:05:14 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,315,1517904000";
   d="scan'208";a="183348583"
Date: Fri, 16 Mar 2018 13:05:10 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Laura Abbott <labbott@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: Convert VM_BUG_ON() to collapse fail
Message-ID: <20180316100510.gedh6svgemb5jrmj@black.fi.intel.com>
References: <20180315152353.27989-1-kirill.shutemov@linux.intel.com>
 <20180315160453.dff17cfe3dca056dabc98b9e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315160453.dff17cfe3dca056dabc98b9e@linux-foundation.org>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 11:04:53PM +0000, Andrew Morton wrote:
> On Thu, 15 Mar 2018 18:23:53 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> 
> > khugepaged is not yet able to convert PTE-mapped huge pages back to PMD
> > mapped. We do not collapse such pages. See check khugepaged_scan_pmd().
> > 
> > But if between khugepaged_scan_pmd() and __collapse_huge_page_isolate()
> > somebody managed to instantiate THP in the range and then split the PMD
> > back to PTEs we would have a problem -- VM_BUG_ON_PAGE(PageCompound(page))
> > will get triggered.
> > 
> > It's possible since we drop mmap_sem during collapse to re-take for
> > write.
> > 
> > Replace the VM_BUG_ON() with graceful collapse fail.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Fixes: b1caa957ae6d ("khugepaged: ignore pmd tables with THP mapped with ptes")
> 
> Jan 2016.  Do we need a cc:stable?

Yes, please. I forgot to put it.

-- 
 Kirill A. Shutemov
