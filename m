Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbeDWIEo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:04:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:56581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751356AbeDWIEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:04:39 -0400
Message-ID: <1524470676.5451.1.camel@gmx.de>
Subject: Re: DOS by unprivileged user
From: Mike Galbraith <efault@gmx.de>
To: Ferry Toth <ftoth@telfort.nl>
Cc: linux-kernel@vger.kernel.org
Date: Mon, 23 Apr 2018 10:04:36 +0200
In-Reply-To: <6057755.ozdVOybsI6@delfion>
References: <9023506.UBh6vynRGa@delfion> <4285098.DEWjdbWF2X@delfion>
         <1524325275.8078.2.camel@gmx.de> <6057755.ozdVOybsI6@delfion>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:YhLL4xHBvcRF+h5vlTkxFc57S2tsTKHMZBdUopAP+ZYA1Netx/0
 bXYG5dAmBXrl3HGu8nkbbkbAeBUN7rtBktlNQJ3W06wpWFuUfpQB6nmYalVxNvg1urTOHbk
 srR2zhH2boJ7Tl+JlRLbv6GTnVN9YMDJGuAg6lesAu51Xd7TtS/17isdSystJHbSjY8zANz
 QYpmEc9rj9tRtg3HHOoUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T1udFbawPvg=:1GJlxgkUsxVsV9gGZOA8JE
 R+tN36fRMDnFP4itB94h4/dXxH+9cSOMHpXdbu63I/VHgqB594vPFssnBqH/15041RsCon0gN
 +NoVvpooZoA+XuRY/LJUQMmGPjxnEuwhZbLda/QFnh+RqX4sOalgXRLXZn8AVz3dmFu228gJe
 KaIpP+vClVqaOmhvcv2ZDVpgGSZ2bMhVEQwOrTlCHbMstGZzbpSMUfj6xLr2XXfhiYdk+Ser9
 lh46DUEQ7Fx9jYOS4CZNZkO6CtPCm3B8TNQ/89RG0y1WetDlNZxGyODixnGmpipZuUdAKKUt6
 gYsOmLir/4bpBy+UtXiJ0wDPzBOtk5oDJRsb3uPmfJuifCnFxJRJwBcKqBTeptXN8gOjnoCyW
 cHIXL+KeG/ZWDwP4WoBjLDcoE5HNy+tfEb6Wvs1MSC81CwhCYoGlYrfc+3aqo+/rUfABcOBOX
 FrIumghOv8+OGcrtKbFUQv/ljQTb1BfnxIhnxbxuzqFDVwOn9MiuaVAEgJjydnTlLK3A/W+14
 V25mWAjes11QTcodc/xYVQ5CjnfTrKbf7rDx9FJSQfMv5FcvRmiuuy5P3nYq/HF7y7rlcfaMH
 E6VdzvsiwPdJjuHx0gkgSoqWRg0avPl6/yvcc6+VvjuJsvnFN40Y+/NuYzQLYe5t9e/Uj+p+Z
 M5/fktRgrw2Hl+EF50XPkTiHzT9FRU4+T5dktKBnqCTfOMY2foqj8QpQKdxr4QHKUSimiUYi2
 LCI+oI9Mf7CgymWl6l7YyLIZMwOEy+LX3/k6Cc/KSbc8SNBjoMoBJ9CG6NQGUYrjGq/5/5jm2
 TRvC2ZFfvVFRc6VBgyI3KxGb3TFXrhUZgJqoisYbPr2Pi7ijvs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-04-22 at 21:37 +0200, Ferry Toth wrote:
> > Yes your memory hog scenario thoroughly wrecks the user experience, but
> > the process scheduler in not the source of that wreckage, it's a memory
> > management issue.  With no constraints in place, anybody can just keep
> > on allocating until the entire system starts grinding itself to dust.
> > 
> > 	-Mike
>  
> That is exactly the issue I think. It is not just a user experience,
> they is no distinction between crashing the kernel and grinding it to
> dust. The effect we have is: any user on a multi user system can
> crash the system.
>  
> Memory management / constraints can't solve the problem either: it
> might be intentional to alloc such amounts of memory.

Constraints definitely can solve this particular problem instance. 
Plain old ulimit can stop the memory hog (wish) dead in its tracks, or
you can use memory cgroup controller to constrain it in a more friendly
manner.  I started gitk in a 4G constrained cgroup, which redirected
its greedy fingers to the swap bin for the remainder of its needs.

But yes, there is currently no wonderful one size fits all fully
automatic solution to running low on memory that doesn't involve
running to the store.

> I think memory allocation and io waits can't be decoupled from
> scheduling as they are now.

The scheduler is not decoupled from either, it is intimately involved
in both.  However, none of the decision making smarts for either reside
in the scheduler, nor should they.

	-Mike
