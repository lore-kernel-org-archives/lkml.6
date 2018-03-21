Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbeCUSnX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 14:43:23 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:44035 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752616AbeCUSnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 14:43:19 -0400
X-Google-Smtp-Source: AG47ELs1nRdeCWfEjJ4ZI99cuwbrED0KjfRmsrbmoNbulNNbNl0tq7lK78PHgKqSvWkZHVTnxDXNRw==
Subject: Re: [bug, bisected] pfifo_fast causes packet reordering
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Dave Taht <dave.taht@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Martin Elshuber <martin.elshuber@theobroma-systems.com>
References: <946dbe16-a2eb-eca8-8069-468859ccc78d@theobroma-systems.com>
 <CAA93jw5FSbvg8AZ=EmneW8juqd8LCgp=xUrSxYm2GBEucKkT3w@mail.gmail.com>
 <95844480-d020-9000-53ef-0da8b965ce6e@gmail.com>
 <3a959e50-8656-5d9c-97b9-227d733948f8@theobroma-systems.com>
 <5aeb54ba-2d96-4ab5-53c4-2d3691be7acc@gmail.com>
 <340a6c54-6031-5522-98f5-eafdd3a37a38@theobroma-systems.com>
 <00cc2d41-6861-9a9c-603f-ba8013b2e2ce@theobroma-systems.com>
From: John Fastabend <john.fastabend@gmail.com>
Message-ID: <4e33aae4-9e87-22b4-7f09-008183ea553a@gmail.com>
Date: Wed, 21 Mar 2018 11:43:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <00cc2d41-6861-9a9c-603f-ba8013b2e2ce@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 03:01 AM, Jakob Unterwurzacher wrote:
> On 16.03.18 11:26, Jakob Unterwurzacher wrote:
>> On 15.03.18 23:30, John Fastabend wrote:
>>>> I have reproduced it using two USB network cards connected to each other. The test tool sends UDP packets containing a counter and listens on the other interface, it is available at
>>>> https://github.com/jakob-tsd/pfifo_stress/blob/master/pfifo_stress.py
>>>
>>> Great thanks, can you also run this with taskset to bind to
>>> a single CPU,
>>>
>>>   # taskset 0x1 ./pifof_stress.py
>>>
>>> And let me know if you still see the OOO.
>>
>> Interesting. Looks like it depends on which core it runs on. CPU0 is clean, CPU1 is not.
> 
> So we are at v4.16-rc6 now - have you managed to reproduce this is or should I try to get the revert correct?

I have a theory on what is going on here. Because we now run without
locks we can have multiple qdisc_run() calls running in parallel. Possible
if we send packets using multiple cores.

   --- application ---
     cpu0    cpu1
        |     |
        |     |
    enqueue enqueue   
        |     |
      pfifo_fast
        |     |
    dequeue   dequeue
         \    /
        ndo_xmit

The skb->ooo_okay flag will keep the enqueue side packets in
order. So that is covered.

But on the dequeue side if two cores dequeue in parallel we will
race to ndo ops to ensure packets are in order. Rarely, I guess the
second dequeue could actually call ndo hook before first dequeued
packet. Because usually the dequeue happens on the same queue the
enqueue happened on we don't see this very often. But there seems
to be a case where the driver calls netif_tx_wake_queue() on a
different core (from the rx interrupt context). The wake queue call
then eventually runs the dequeue on a different core. So when taskset
is aligned with the interrupt everything is in-order when it is moved
to a different core we see the OOO.

Thats my theory at least. Are you able to test a patch if I generate
one to fix this?

FWIW the revert on this is trivial, but I think we can fix this
without too much work. Also, if you had a driver tx queue per core
this would not be an issue. 

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 190570f..171f470 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -792,7 +792,6 @@ struct Qdisc_ops pfifo_fast_ops __read_mostly = {
        .dump           =       pfifo_fast_dump,
        .change_tx_queue_len =  pfifo_fast_change_tx_queue_len,
        .owner          =       THIS_MODULE,
-       .static_flags   =       TCQ_F_NOLOCK | TCQ_F_CPUSTATS,
 };
 EXPORT_SYMBOL(pfifo_fast_ops);

> 
> Best regards,
> Jakob
