Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753393AbeBKNNS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 08:13:18 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:33119 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752597AbeBKNNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 08:13:17 -0500
Authentication-Results: smtpcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH] mm/huge_memory.c: split should clone page flags before
 unfreezing pageref
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>
References: <151834531706.176342.14968581451762734122.stgit@buzz>
 <20180211110751.tsseper2356aptbe@node.shutemov.name>
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <4f64569f-b8ce-54f8-33d9-0e67216bb54c@yandex-team.ru>
Date: Sun, 11 Feb 2018 16:13:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180211110751.tsseper2356aptbe@node.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.02.2018 14:07, Kirill A. Shutemov wrote:
> On Sun, Feb 11, 2018 at 01:35:17PM +0300, Konstantin Khlebnikov wrote:
>> THP split makes non-atomic change of tail page flags. This is almost ok
>> because tail pages are locked and isolated but this breaks recent changes
>> in page locking: non-atomic operation could clear bit PG_waiters.
>>
>> As a result concurrent sequence get_page_unless_zero() -> lock_page()
>> might block forever. Especially if this page was truncated later.
>>
>> Fix is trivial: clone flags before unfreezing page reference counter.
>>
>> This race exists since commit 62906027091f ("mm: add PageWaiters indicating
>> tasks are waiting for a page bit") while unsave unfreeze itself was added
>> in commit 8df651c7059e ("thp: cleanup split_huge_page()").
> 
> Hm. Don't we have to have barrier between setting flags and updating
> the refcounter in this case? Atomics don't generally have this semantics,
> so you can see new refcount before new flags even after the change.
> 

Ok.

I see another problem here - clear_compound_head() is placed after unfreeze.

This opens race window with get/put_page after speculative get page.
I think successful get_page_unless_zero() must stabilize compound_head() for tails as well as for heads.
