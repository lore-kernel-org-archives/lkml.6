Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934077AbeBURSm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:18:42 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39661 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934022AbeBURSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:18:38 -0500
X-Google-Smtp-Source: AH8x2278UItl2+2pBKZps+Gja/IXK8YbiVuRWKj0oCSjylALqKeV/IjclosaccqZ4YD5ZzDpNVps67ojeiCQZtWaT3M=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1802211002200.12567@nuc-kabylake>
References: <20180221030101.221206-1-shakeelb@google.com> <alpine.DEB.2.20.1802211002200.12567@nuc-kabylake>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 21 Feb 2018 09:18:35 -0800
Message-ID: <CALvZod68LD-wnbm2+MQks=bd_D2zY64uScUBp28hyug_vaGyDA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Directed kmem charging
To: Christopher Lameter <cl@linux.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 8:09 AM, Christopher Lameter <cl@linux.com> wrote:
> Another way to solve this is to switch the user context right?
>
> Isnt it possible to avoid these patches if do the allocation in another
> task context instead?
>

Sorry, can you please explain what you mean by 'switch the user
context'. Is there any example in kernel which does something similar?

Another way is by adding a field 'remote_memcg_to_charge' in
task_struct and set it before the allocation and in memcontrol.c,
first check if current->remote_memcg_to_charge is set otherwise use
the memcg of current. Also if we provide a wrapper to do that for the
user, there will be a lot less plumbing.

Please let me know if you prefer this approach.


> Are there really any other use cases beyond fsnotify?
>

Another use case I have in mind and plan to upstream is to bind a
filesystem mount with a memcg. So, all the file pages (or anon pages
for shmem) and kmem (like inodes and dentry) will be charged to that
memcg.

>
> The charging of the memory works on a per page level but the allocation
> occur from the same page for multiple tasks that may be running on a
> system. So how relevant is this for other small objects?
>
> Seems that if you do a large amount of allocations for the same purpose
> your chance of accounting it to the right memcg increases. But this is a
> game of chance.
>
>
>
