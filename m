Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935027AbeBLOLN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:11:13 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33155 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933182AbeBLOLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:11:12 -0500
X-Google-Smtp-Source: AH8x2246zKNHV+l2SLopSgFBvTNaIUTQ6MeAfhb6hv0o1vSklnbsg6bNMZcfO0vmVnyVajUu+lfTeg==
Date: Mon, 12 Feb 2018 17:11:09 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 2/2] mm/huge_memory.c: reorder operations in
 __split_huge_page_tail()
Message-ID: <20180212141109.2lowammpogi3wtvt@node.shutemov.name>
References: <4f64569f-b8ce-54f8-33d9-0e67216bb54c@yandex-team.ru>
 <151844393341.210639.13162088407980624477.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151844393341.210639.13162088407980624477.stgit@buzz>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 04:58:53PM +0300, Konstantin Khlebnikov wrote:
> THP split makes non-atomic change of tail page flags. This is almost ok
> because tail pages are locked and isolated but this breaks recent changes
> in page locking: non-atomic operation could clear bit PG_waiters.
> 
> As a result concurrent sequence get_page_unless_zero() -> lock_page()
> might block forever. Especially if this page was truncated later.
> 
> Fix is trivial: clone flags before unfreezing page reference counter.
> 
> This race exists since commit 62906027091f ("mm: add PageWaiters indicating
> tasks are waiting for a page bit") while unsave unfreeze itself was added
> in commit 8df651c7059e ("thp: cleanup split_huge_page()").
> 
> clear_compound_head() also must be called before unfreezing page reference
> because after successful get_page_unless_zero() might follow put_page()
> which needs correct compound_head().
> 
> And replace page_ref_inc()/page_ref_add() with page_ref_unfreeze() which
> is made especially for that and has semantic of smp_store_release().
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
