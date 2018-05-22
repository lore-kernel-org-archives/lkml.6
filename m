Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeEVAZd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:25:33 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:45470 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbeEVAZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:25:30 -0400
X-Google-Smtp-Source: AB8JxZqvIbRNflzNamPXVcW45QS82bBxqwP1+6Ho4bvybueEJo67L/Q1ipa7TmiDwKi2fPYWJiNb6ddaOL4w/cp4YHc=
MIME-Version: 1.0
In-Reply-To: <20180521162609.lpdrnozowmzdn57m@ast-mbp.dhcp.thefacebook.com>
References: <20180513173318.21680-1-alban@kinvolk.io> <20180521162609.lpdrnozowmzdn57m@ast-mbp.dhcp.thefacebook.com>
From: Y Song <ys114321@gmail.com>
Date: Mon, 21 May 2018 17:24:49 -0700
Message-ID: <CAH3MdRWgruVq+3r+2pHTah-c2zTO03vPkepjWDZ0_KrYcroy9A@mail.gmail.com>
Subject: Re: [PATCH] [RFC] bpf: tracing: new helper bpf_get_current_cgroup_ino
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alban Crequy <alban.crequy@gmail.com>, netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        cgroups@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 9:26 AM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Sun, May 13, 2018 at 07:33:18PM +0200, Alban Crequy wrote:
>>
>> +BPF_CALL_2(bpf_get_current_cgroup_ino, u32, hierarchy, u64, flags)
>> +{
>> +     // TODO: pick the correct hierarchy instead of the mem controller
>> +     struct cgroup *cgrp = task_cgroup(current, memory_cgrp_id);
>> +
>> +     if (unlikely(!cgrp))
>> +             return -EINVAL;
>> +     if (unlikely(hierarchy))
>> +             return -EINVAL;
>> +     if (unlikely(flags))
>> +             return -EINVAL;
>> +
>> +     return cgrp->kn->id.ino;
>
> ino only is not enough to identify cgroup. It needs generation number too.
> I don't quite see how hierarchy and flags can be used in the future.
> Also why limit it to memcg?
>
> How about something like this instead:
>
> BPF_CALL_2(bpf_get_current_cgroup_id)
> {
>         struct cgroup *cgrp = task_dfl_cgroup(current);
>
>         return cgrp->kn->id.id;
> }
> The user space can use fhandle api to get the same 64-bit id.

I think this should work. This will also be useful to bcc as user
space can encode desired id
in the bpf program and compared that id to the current cgroup id, so we can have
cgroup level tracing (esp. stat collection) support. To cope with
cgroup hierarchy, user can use
cgroup-array based approach or explicitly compare against multiple cgroup id's.
