Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeCNT5R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:57:17 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35294 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbeCNT5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:57:14 -0400
X-Google-Smtp-Source: AG47ELtCDk44Znq8mlh5Ao860KVd9hEqIvnNKXMwazQbX0l2wkgWiO+pGoLMNd1GPASBJ1y5oYdkbg==
Date: Wed, 14 Mar 2018 12:57:11 -0700
From: Tejun Heo <tj@kernel.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v4] cpuset: Enable cpuset controller in default hierarchy
Message-ID: <20180314195711.GD2943022@devbig577.frc2.facebook.com>
References: <1520609707-16582-1-git-send-email-longman@redhat.com>
 <1520613285.12489.36.camel@gmx.de>
 <1c3fe7b0-2600-c46d-1527-d3aaf024bb91@redhat.com>
 <1520619426.27998.18.camel@gmx.de>
 <55809fe4-98ba-5566-86ed-457acfef0e1c@redhat.com>
 <1520624424.27998.76.camel@gmx.de>
 <53de9683-01b7-bac4-8b70-dc1f93ede600@redhat.com>
 <20180309221736.GB5926@hirez.programming.kicks-ass.net>
 <f0fca497-e4e7-3dbd-1e5c-a7f502c05dcb@redhat.com>
 <1520653648.12749.20.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520653648.12749.20.camel@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Mar 10, 2018 at 04:47:28AM +0100, Mike Galbraith wrote:
> Some form of cpu_exclusive (preferably exactly that, but something else
> could replace it) is needed to define sets that must not overlap any
> other set at creation time or any time thereafter.  A set with property
> 'exclusive' is the enabler for fundamentally exclusive (but dynamic!)
> set properties such as 'isolated' (etc etc).

I'm not sure cpu_exclusive makes sense.  A controller knob can either
belong to the parent or the cgroup itself and cpu_exclusive doesn't
make sense in either case.

1. cpu_exclusive is owned by the parent as other usual resource
   control knobs.  IOW, it's not delegatable.

   This is weird because it's asking the kernel to protect against its
   own misconfiguration and there's nothing preventing cpu_exclusive
   itself being cleared by the same entitya.

2. cpu_exclusive is owned by the cgroup itself like memory.oom_group.
   IOW, it's delegatable.

   This allows a cgroup to affect what its siblings can or cannot do,
   which is broken.  Semantically, it doesn't make much sense either.

I don't think it's a good idea to add a kernel mechanism to prevent
misconfiguration from a single entity.

Thanks.

-- 
tejun
