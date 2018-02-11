Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbeBKLHz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 06:07:55 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34207 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbeBKLHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 06:07:54 -0500
X-Google-Smtp-Source: AH8x224Kzl3oKsybvCeKCWnrPvDGWtWwAlLmU+jVlXaf0bDtcC0wVKoaBsWywG7Yj4dLJtaV+qcheA==
Date: Sun, 11 Feb 2018 14:07:51 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] mm/huge_memory.c: split should clone page flags before
 unfreezing pageref
Message-ID: <20180211110751.tsseper2356aptbe@node.shutemov.name>
References: <151834531706.176342.14968581451762734122.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151834531706.176342.14968581451762734122.stgit@buzz>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 01:35:17PM +0300, Konstantin Khlebnikov wrote:
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

Hm. Don't we have to have barrier between setting flags and updating
the refcounter in this case? Atomics don't generally have this semantics,
so you can see new refcount before new flags even after the change.

-- 
 Kirill A. Shutemov
