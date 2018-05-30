Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeE3K1z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 06:27:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:22904 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751204AbeE3K1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 06:27:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,460,1520924400";
   d="scan'208";a="62848470"
Date: Wed, 30 May 2018 13:27:50 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/huge_memory.c: __split_huge_page() use atomic
 ClearPageDirty()
Message-ID: <20180530102750.6mmlmypt35w4xaei@black.fi.intel.com>
References: <alpine.LSU.2.11.1805291841070.3197@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1805291841070.3197@eggly.anvils>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 01:50:22AM +0000, Hugh Dickins wrote:
> Swapping load on huge=always tmpfs (with khugepaged tuned up to be very
> eager, but I'm not sure that is relevant) soon hung uninterruptibly,
> waiting for page lock in shmem_getpage_gfp()'s find_lock_entry(), most
> often when "cp -a" was trying to write to a smallish file.  Debug showed
> that the page in question was not locked, and page->mapping NULL by now,
> but page->index consistent with having been in a huge page before.
> 
> Reproduced in minutes on a 4.15 kernel, even with 4.17's 605ca5ede764
> ("mm/huge_memory.c: reorder operations in __split_huge_page_tail()")
> added in; but took hours to reproduce on a 4.17 kernel (no idea why).
> 
> The culprit proved to be the __ClearPageDirty() on tails beyond i_size
> in __split_huge_page(): the non-atomic __bitoperation may have been safe
> when 4.8's baa355fd3314 ("thp: file pages support for split_huge_page()")
> introduced it, but liable to erase PageWaiters after 4.10's 62906027091f
> ("mm: add PageWaiters indicating tasks are waiting for a page bit").
> 
> Fixes: 62906027091f ("mm: add PageWaiters indicating tasks are waiting for a page bit")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Thanks for catching this.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
