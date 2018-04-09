Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754146AbeDITdX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:33:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753056AbeDITdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:33:22 -0400
Subject: Re: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, mingo@kernel.org, boqun.feng@gmail.com,
        paulmck@linux.vnet.ibm.com, catalin.marinas@arm.com
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
 <20180409105835.GC23134@arm.com> <20180409145409.GA9661@arm.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <5e7211d4-43f0-297e-dbbc-8e87721f96b8@redhat.com>
Date: Mon, 9 Apr 2018 15:33:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180409145409.GA9661@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 10:54 AM, Will Deacon wrote:
>
>>> I am not against this patch, but we certainly need to find out a way to
>>> bring the performance number up closer to what it is before applying
>>> the patch.
>> We certainly need to *understand* where the drop is coming from, because
>> the two-threaded case is still just a CAS on x86 with and without this
>> patch series. Generally, there's a throughput cost when ensuring fairness
>> and forward-progress otherwise we'd all be using test-and-set.
> Whilst I think we still need to address my questions above, I've had a
> crack at the diff below. Please can you give it a spin? It sticks a trylock
> on the slowpath before setting pending and replaces the CAS-based set
> with an xchg (which I *think* is safe, but will need to ponder it some
> more).
>
> Thanks,
>
> Will
>

Unfortunately, this patch didn't help.

pending count = 777
queuing count = 9,991,272
locking rate = 4,087 kop/s

-Longman
