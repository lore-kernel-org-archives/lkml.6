Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbeBIRgn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:36:43 -0500
Received: from gateway36.websitewelcome.com ([192.185.193.12]:31106 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751091AbeBIRgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:36:42 -0500
Date: Fri, 09 Feb 2018 11:36:40 -0600
Message-ID: <20180209113640.Horde.xafidJ_CTj9RROQxEbXk8Qi@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/nldev: Fix multiple potential NULL pointer
 dereferences
References: <20180209063702.GA28685@embeddedgus>
 <20180209122549.GK2197@mtr-leonro.local>
 <20180209073649.Horde.OueGLKMtzpLyz4w36quXUca@gator4166.hostgator.com>
 <20180209143541.GN2197@mtr-leonro.local>
 <20180209095600.Horde.e7EqwCs_5bRLfE3Nnkfl3L3@gator4166.hostgator.com>
 <20180209164918.GP2197@mtr-leonro.local>
In-Reply-To: <20180209164918.GP2197@mtr-leonro.local>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 108.167.133.22
X-Source-L: Yes
X-Exim-ID: 1ekCbJ-000M2o-2r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: gator4166.hostgator.com [108.167.133.22]:14988
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Quoting Leon Romanovsky <leon@kernel.org>:

> On Fri, Feb 09, 2018 at 09:56:00AM -0600, Gustavo A. R. Silva wrote:
>>
>> Quoting Leon Romanovsky <leon@kernel.org>:
>>
>> > On Fri, Feb 09, 2018 at 07:36:49AM -0600, Gustavo A. R. Silva wrote:
>> > > Hi Leon,
>> > >
>> > > Quoting Leon Romanovsky <leon@kernel.org>:
>> > >
>> > > > On Fri, Feb 09, 2018 at 12:37:02AM -0600, Gustavo A. R. Silva wrote:
>> > > > > In case the message header and payload cannot be stored, function
>> > > > > nlmsg_put returns null.
>> > > > >
>> > > > > Fix this by adding multiple sanity checks and avoid a potential
>> > > > > null dereference on _nlh_ when calling nlmsg_end.
>> > > > >
>> > > > > Addresses-Coverity-ID: 1454215 ("Dereference null return value")
>> > > > > Addresses-Coverity-ID: 1454223 ("Dereference null return value")
>> > > > > Addresses-Coverity-ID: 1454224 ("Dereference null return value")
>> > > > > Addresses-Coverity-ID: 1464669 ("Dereference null return value")
>> > > > > Addresses-Coverity-ID: 1464670 ("Dereference null return value")
>> > > > > Addresses-Coverity-ID: 1464672 ("Dereference null return value")
>> > > > > Fixes: e5c9469efcb1 ("RDMA/netlink: Add nldev device doit
>> > > implementation")
>> > > > > Fixes: c3f66f7b0052 ("RDMA/netlink: Implement nldev port  
>> doit callback")
>> > > > > Fixes: 7d02f605f0dc ("RDMA/netlink: Add nldev port dumpit
>> > > implementation")
>> > > > > Fixes: b5fa635aab8f ("RDMA/nldev: Provide detailed QP information")
>> > > > > Fixes: bf3c5a93c523 ("RDMA/nldev: Provide global resource  
>> utilization")
>> > > > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> > > > > ---
>> > > > >  drivers/infiniband/core/nldev.c | 26 +++++++++++++++++++++++++-
>> > > > >  1 file changed, 25 insertions(+), 1 deletion(-)
>> > > > >
>> > > >
>> > > > It will be much better to fix the tool instead of fixing ghost case.
>> > > > This scenario is impossible for all those flows.
>> > > > We can receive the skv/msg in two ways:
>> > > >  * First by allocating new message with NLMSG_DEFAULT_SIZE, which has
>> > > > more room
>> > > >    than nlmsg_total_size(payload), payload is 0.
>> > > >  * Second by getting from netlink.c and it will be at least "struct
>> > > > nlmsghdr" too.
>> > > >
>> > > > Can you please add this info to the commit message?
>> > > >
>> > >
>> > > Actually, I was planing to send a new version of this patch.  
>> This time using
>> > > the unlikely macro for all the null checks on nlh.
>> > >
>> > > What do you think?
>> >
>> > It is not datapath, so "unlikely" is not needed. Let's assume that smart
>> > enough
>> > compiler will optimize such flow anyway, because nlmsg_put returns NULL
>> > in unlikely scenario, so this check will be unlikely automatically too.
>> >
>>
>> I'm curious about why the return value of nlmsg_put is null checked 118 out
>> of 129 times (based on Coverity reports) in the last linux-next tree.
>>
>> So based on what you mention, do you think all those checks are actually
>> unnecessary and, maybe they should be removed?
>
> I honestly don't know about all cases, but if message is allocated with
> NLMSG_DEFAULT_SIZE and payload is 0, this check won't be needed.
>

I got it.

> So go ahead, add check if (!...) in all places, but be cautious with
> "potential null dereference" claims, it is not always true.
>

You are right. I will update the subject and commit message.

Thanks for the feedback, Leon.
I appreciate it.
--
Gustavo
