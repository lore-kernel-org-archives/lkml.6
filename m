Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbeEWI5K (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:57:10 -0400
Received: from www62.your-server.de ([213.133.104.62]:54202 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754334AbeEWI5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:57:09 -0400
Subject: Re: [PATCH] [RFC] bpf: tracing: new helper bpf_get_current_cgroup_ino
To: Y Song <ys114321@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alban Crequy <alban.crequy@gmail.com>, netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        cgroups@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        tj@kernel.org
References: <20180513173318.21680-1-alban@kinvolk.io>
 <20180521162609.lpdrnozowmzdn57m@ast-mbp.dhcp.thefacebook.com>
 <CAH3MdRWgruVq+3r+2pHTah-c2zTO03vPkepjWDZ0_KrYcroy9A@mail.gmail.com>
 <CAH3MdRVdfw52atavT3KL8MpPw7zDM_hR6aUcqDP1PogLn_sH+w@mail.gmail.com>
 <20180523033550.z3tqo4lhd3zrmtdu@ast-mbp>
 <CAH3MdRVwmKd84ePvNX+NuAj3TfA_28BObEmzBqGXv=P5_A=8fQ@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ef833a5c-8307-fee7-26ec-057f623a9049@iogearbox.net>
Date: Wed, 23 May 2018 10:57:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAH3MdRVwmKd84ePvNX+NuAj3TfA_28BObEmzBqGXv=P5_A=8fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23/2018 06:31 AM, Y Song wrote:
> On Tue, May 22, 2018 at 8:35 PM, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Tue, May 22, 2018 at 08:33:24PM -0700, Y Song wrote:
>>> +       struct cgroup *cgrp = task_dfl_cgroup(current);
>>> +       if (!cgrp)
>>> +               return -EINVAL;
>>
>> why this check is needed?
> 
> No reason :-) Originally I am concerned whether it is possible cgrp
> could be NULL.
> By looking at the code, it SEEMS to me that it could not be NULL, but I am not
> 100% sure (as I am not a cgroup expert). Since you are asking,
> probably means it cannot be NULL, so will remove it in formal upstream patch.

Aside from this the cgrp->kn->id.id is also u64, so overlapping this with
error codes we'll get into a similar issue as with bpf_perf_event_read().
