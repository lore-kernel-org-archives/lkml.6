Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754327AbeDVPAr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 11:00:47 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:37684 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753830AbeDVPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 11:00:39 -0400
X-Google-Smtp-Source: AIpwx48CbmPJWZC/bXhub3lTstkPJ7C1xTBh0K/gVnmVdVwa/bew+lrBLbXYuq3CG5zKgFRv3K9DbAzb8qyrBwKpf/8=
MIME-Version: 1.0
In-Reply-To: <20180422125141.GF17484@dhcp22.suse.cz>
References: <1524243513-29118-1-git-send-email-chuhu@redhat.com>
 <20180420175023.3c4okuayrcul2bom@armageddon.cambridge.arm.com> <20180422125141.GF17484@dhcp22.suse.cz>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 22 Apr 2018 17:00:18 +0200
Message-ID: <CACT4Y+YWUgyzCBadg+Oe8wDkFCaBzmcKDgu3rKjQxim7NXNLpg@mail.gmail.com>
Subject: Re: [RFC] mm: kmemleak: replace __GFP_NOFAIL to GFP_NOWAIT in gfp_kmemleak_mask
To: Michal Hocko <mhocko@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Chunyu Hu <chuhu@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 2:51 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Fri 20-04-18 18:50:24, Catalin Marinas wrote:
>> On Sat, Apr 21, 2018 at 12:58:33AM +0800, Chunyu Hu wrote:
>> > __GFP_NORETRY and  __GFP_NOFAIL are combined in gfp_kmemleak_mask now.
>> > But it's a wrong combination. As __GFP_NOFAIL is blockable, but
>> > __GFP_NORETY is not blockable, make it self-contradiction.
>> >
>> > __GFP_NOFAIL means 'The VM implementation _must_ retry infinitely'. But
>> > it's not the real intention, as kmemleak allow alloc failure happen in
>> > memory pressure, in that case kmemleak just disables itself.
>>
>> Good point. The __GFP_NOFAIL flag was added by commit d9570ee3bd1d
>> ("kmemleak: allow to coexist with fault injection") to keep kmemleak
>> usable under fault injection.
>>
>> > commit 9a67f6488eca ("mm: consolidate GFP_NOFAIL checks in the allocator
>> > slowpath") documented that what user wants here should use GFP_NOWAIT, and
>> > the WARN in __alloc_pages_slowpath caught this weird usage.
>> >
>> >  <snip>
>> >  WARNING: CPU: 3 PID: 64 at mm/page_alloc.c:4261 __alloc_pages_slowpath+0x1cc3/0x2780
>> [...]
>> > Replace the __GFP_NOFAIL with GFP_NOWAIT in gfp_kmemleak_mask, __GFP_NORETRY
>> > and GFP_NOWAIT are in the gfp_kmemleak_mask. So kmemleak object allocaion
>> > is no blockable and no reclaim, making kmemleak less disruptive to user
>> > processes in pressure.
>>
>> It doesn't solve the fault injection problem for kmemleak (unless we
>> change __should_failslab() somehow, not sure yet). An option would be to
>> replace __GFP_NORETRY with __GFP_NOFAIL in kmemleak when fault injection
>> is enabled.
>
> Cannot we simply have a disable_fault_injection knob around the
> allocation rather than playing this dirty tricks with gfp flags which do
> not make any sense?
>
>> BTW, does the combination of NOWAIT and NORETRY make kmemleak
>> allocations more likely to fail?
>
> NOWAIT + NORETRY simply doesn't make much sesne. It is equivalent to
> NOWAIT.

Specifying a flag that says "don't do fault injection for this
allocation" looks like a reasonable solution. Fewer lines of code and
no need to switch on interrupts. __GFP_NOFAIL seems to mean more than
that, so perhaps we need a separate flag that affects only fault
injection and should be used only in debugging code (no-op without
fault injection anyway).
