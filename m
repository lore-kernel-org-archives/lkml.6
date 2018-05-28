Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeE1RXO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 13:23:14 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34886 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbeE1RXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 13:23:10 -0400
X-Google-Smtp-Source: AB8JxZqfjE78hRwkpON9WkXpdckvwfIEg+MDQfOM/+moHgn2fw9FhgX1wZ/t8d3nkZmFOdf6qku8gv8dgKCc5+hkcJ8=
MIME-Version: 1.0
In-Reply-To: <20180528091110.GG1517@dhcp22.suse.cz>
References: <20180525185501.82098-1-shakeelb@google.com> <20180526185144.xvh7ejlyelzvqwdb@esperanza>
 <CALvZod5yTxcuB_Aao-a0ChNEnwyBJk9UPvEQ80s9tZFBQ0cxpw@mail.gmail.com> <20180528091110.GG1517@dhcp22.suse.cz>
From: Shakeel Butt <shakeelb@google.com>
Date: Mon, 28 May 2018 10:23:07 -0700
Message-ID: <CALvZod6x5iRmcJ6pYKS+jwJd855jnwmVcPK9tnKbuJ9Hfppa-A@mail.gmail.com>
Subject: Re: [PATCH] memcg: force charge kmem counter too
To: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 2:11 AM, Michal Hocko <mhocko@kernel.org> wrote:
> On Sat 26-05-18 15:37:05, Shakeel Butt wrote:
>> On Sat, May 26, 2018 at 11:51 AM, Vladimir Davydov
>> <vdavydov.dev@gmail.com> wrote:
>> > On Fri, May 25, 2018 at 11:55:01AM -0700, Shakeel Butt wrote:
>> >> Based on several conditions the kernel can decide to force charge an
>> >> allocation for a memcg i.e. overcharge memcg->memory and memcg->memsw
>> >> counters. Do the same for memcg->kmem counter too. In cgroup-v1, this
>> >> bug can cause a __GFP_NOFAIL kmem allocation fail if an explicit limit
>> >> on kmem counter is set and reached.
>> >
>> > memory.kmem.limit is broken and unlikely to ever be fixed as this knob
>> > was deprecated in cgroup-v2. The fact that hitting the limit doesn't
>> > trigger reclaim can result in unexpected behavior from user's pov, like
>> > getting ENOMEM while listing a directory. Bypassing the limit for NOFAIL
>> > allocations isn't going to fix those problem.
>>
>> I understand that fixing NOFAIL will not fix all other issues but it
>> still is better than current situation. IMHO we should keep fixing
>> kmem bit by bit.
>>
>> One crazy idea is to just break it completely by force charging all the time.
>
> What is the limit good for then? Accounting?
>

Unlike tcpmem, the kmem accounting is enabled by default. No need to
set the limit to enable accounting.

I think my crazy idea was just wrong and without much thought. Though
is there a precedence where the broken feature is not fixed because an
alternative is available?
