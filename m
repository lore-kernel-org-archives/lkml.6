Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeEOAiy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 20:38:54 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36863 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752416AbeEOAix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 20:38:53 -0400
X-Google-Smtp-Source: AB8JxZqMZsgI0XbKmCtanAObbiqfOQZMCuLi6b3c4IqE4tVRjVy92R3KoAf/TWBmYmQxmPV0jzGs+w==
Subject: Re: [PATCH IB/core 2/2] IB/cm: Send authentic pkey in REQ msg and
 check eligibility of the pkeys
To: Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>
Cc: Doug Ledford <dledford@redhat.com>, Don Hiatt <don.hiatt@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Sean Hefty <sean.hefty@intel.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20180509093020.24503-1-Haakon.Bugge@oracle.com>
 <20180509093020.24503-3-Haakon.Bugge@oracle.com>
 <ab1f16cd-aa60-0c43-841c-aed301fd2a7e@dev.mellanox.co.il>
 <F9802EE9-4420-44EE-93DC-27CC799B427E@oracle.com>
 <3bee76df-49a6-cf3c-6df4-749a6309358e@dev.mellanox.co.il>
 <B3360947-5905-47BD-ABC4-6C4BB32F5DA6@oracle.com>
 <20180514210200.GN21531@ziepe.ca>
From: Hal Rosenstock <hal@dev.mellanox.co.il>
Message-ID: <ab0e1318-8e1a-5822-5484-33e460095830@dev.mellanox.co.il>
Date: Mon, 14 May 2018 20:38:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514210200.GN21531@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/2018 5:02 PM, Jason Gunthorpe wrote:
> On Thu, May 10, 2018 at 05:16:28PM +0200, Håkon Bugge wrote:
> 
>> We are talking about two things here. The PKey in the BTH and the
>> PKey in the CM REQ payload. They differ.
>>
>> I am out of office, but if my memory serves me correct, the PKey in
>> the BTH in the MAD packet will be the default PKey. Further, we have
>> per IBTA:
> 
> This sounds like a Linux bug.
> 
> Linux does not do a PR to get a reversible path dedicated to the GMP> so it always uses the data flow path, thus the GMP path paramenters
> and those in the REQ should always exactly match.
>
> Where is Linux setting the BTH.PKey and how did it choose to use the
> default pkey? Lets fix that at least for sure.
> 
> Once that is fixed the rest of the series makes no sense since a REQ
> with invalid PKey will never arrive.
> 
> However...
> 
> This series seems inconsistent with the spec.
> 
> IIRC the spec doesn't say if a full or limited pkey should be placed
> in the REQ (Hal?). 

CM spec for REQ just says partition key without indicating whether this
means P_Key or just the partition (15 bits) so my read is that either
full or limited pkey is allowed in REQ.

> It is designed so that the requestor can get a
> single reversible path and put that results into the REQ without
> additional processing, however the PR returns only one PKey and again,
> it is not really specified if it should be the full or limited pkey
> (Hal?).

Correct; it's not specified.

> Basically this means that any pkey in the REQ could randomly be the
> full or limited value, and that in-of-itself has not bearing on the
> connection.
> 
> So it is quite wrong to insist that the pkey be limited or full when
> processing the REQ. The end port is expected to match against the
> local table.

Note that there is thorny issue with shared (physical) port
virtualization. In shared port virtualization, the VF pkey assignment is
a local matter. Only thing SM knows is the physical port pkeys where
both full and limited membership of same partition is possible. It is
conceivable that CM REQ contains limited partition key between 2 limited
VFs and for that a new REJ reason code appears to be needed.

-- Hal

> The real answer to your trap problem is to fix the SM to not create
> paths that are non-functional, that is just flat out broken SM
> behavior.
>
> Jason
> 
