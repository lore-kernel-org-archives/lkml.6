Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbeBUUFQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:05:16 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42074 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeBUUFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:05:14 -0500
X-Google-Smtp-Source: AH8x225uRliutGp7uFzdAV2ieC9KfhmwCxLO7PzTypULShS3ZXwSwUeOwnszICsv8JzVRg4VwQMI9FjJFAJzk6vJ8lE=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1802211155500.13845@nuc-kabylake>
References: <20180221030101.221206-1-shakeelb@google.com> <alpine.DEB.2.20.1802211002200.12567@nuc-kabylake>
 <CALvZod68LD-wnbm2+MQks=bd_D2zY64uScUBp28hyug_vaGyDA@mail.gmail.com> <alpine.DEB.2.20.1802211155500.13845@nuc-kabylake>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 21 Feb 2018 12:05:11 -0800
Message-ID: <CALvZod5e+DUKKvsZwv02SK9r1SXpZApQedvbdvuXm7V5cBAsGA@mail.gmail.com>
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

On Wed, Feb 21, 2018 at 9:57 AM, Christopher Lameter <cl@linux.com> wrote:
> On Wed, 21 Feb 2018, Shakeel Butt wrote:
>
>> On Wed, Feb 21, 2018 at 8:09 AM, Christopher Lameter <cl@linux.com> wrote:
>> > Another way to solve this is to switch the user context right?
>> >
>> > Isnt it possible to avoid these patches if do the allocation in another
>> > task context instead?
>> >
>>
>> Sorry, can you please explain what you mean by 'switch the user
>> context'. Is there any example in kernel which does something similar?
>
> See include/linux/task_work.h. One use case is in mntput_no_expire() in
> linux/fs/namespace.c
>

>From what I understand, using task_work will require fanotify/inotify
event handler to allocate memory asynchronously. IMHO the code will be
much more complex if we go through that route.

> Another way is by adding a field 'remote_memcg_to_charge' in
> task_struct and set it before the allocation and in memcontrol.c,
> first check if current->remote_memcg_to_charge is set otherwise use
> the memcg of current. Also if we provide a wrapper to do that for the
> user, there will be a lot less plumbing.
>
> Please let me know if you prefer this approach.
>

What do you think of the above approach. I think the amount and
complexity of code will be much less.

>> > Are there really any other use cases beyond fsnotify?
>> >
>>
>> Another use case I have in mind and plan to upstream is to bind a
>> filesystem mount with a memcg. So, all the file pages (or anon pages
>> for shmem) and kmem (like inodes and dentry) will be charged to that
>> memcg.
>
> The mount logic already uses task_work.h. That may be the approach to
> expand there.

The task_work approach will require that the job is already running at
the time of mount operation. Usually the mount operations are done by
either admin or the control task starting the job and is a part of
setting up the environment. So, there might not be any process running
at the time of mount operation.
