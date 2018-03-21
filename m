Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeCUUxM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:53:12 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42236 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753209AbeCUUxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:53:02 -0400
X-Google-Smtp-Source: AG47ELv42YcG24devEdq2EDsfHAjUwcITrTA65rB6GqG/lp+dR8TeoKiWeV28jlAbodiONeUmMl9Bw==
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
 <4e33aae4-9e87-22b4-7f09-008183ea553a@gmail.com>
 <983427eb-2e25-f201-c953-4cff22569deb@theobroma-systems.com>
From: John Fastabend <john.fastabend@gmail.com>
Message-ID: <ffdc6ca9-bf64-5514-bac9-7b107f9b443b@gmail.com>
Date: Wed, 21 Mar 2018 13:52:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <983427eb-2e25-f201-c953-4cff22569deb@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 12:44 PM, Jakob Unterwurzacher wrote:
> On 21.03.18 19:43, John Fastabend wrote:
>> Thats my theory at least. Are you able to test a patch if I generate
>> one to fix this?
> 
> Yes, no problem.

Can you try this,

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d4907b5..1e596bd 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -30,6 +30,7 @@ struct qdisc_rate_table {
 enum qdisc_state_t {
        __QDISC_STATE_SCHED,
        __QDISC_STATE_DEACTIVATED,
+       __QDISC_STATE_RUNNING,
 };
 
 struct qdisc_size_table {
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 190570f..cf7c37d 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -377,20 +377,26 @@ static inline bool qdisc_restart(struct Qdisc *q, int *packets)
        struct netdev_queue *txq;
        struct net_device *dev;
        struct sk_buff *skb;
-       bool validate;
+       bool more, validate;
 
        /* Dequeue packet */
+       if (test_and_set_bit(__QDISC_STATE_RUNNING, &q->state))
+               return false;
+
        skb = dequeue_skb(q, &validate, packets);
-       if (unlikely(!skb))
+       if (unlikely(!skb)) {
+               clear_bit(__QDISC_STATE_RUNNING, &q->state);
                return false;
+       }
 
        if (!(q->flags & TCQ_F_NOLOCK))
                root_lock = qdisc_lock(q);
 
        dev = qdisc_dev(q);
        txq = skb_get_tx_queue(dev, skb);
-
-       return sch_direct_xmit(skb, q, dev, txq, root_lock, validate);
+       more = sch_direct_xmit(skb, q, dev, txq, root_lock, validate);
+       clear_bit(__QDISC_STATE_RUNNING, &q->state);
+       return more;
 }


> 
> I just tested with the flag change you suggested (see below, I had to keep TCQ_F_CPUSTATS to prevent a crash) and I have NOT seen OOO so far.
> 

Right because the code expects per cpu stats if the CPUSTATS flag is
removed it will crash.

> Thanks,
> Jakob
> 
> 
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 190570f21b20..51b68ef4977b 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -792,7 +792,7 @@ struct Qdisc_ops pfifo_fast_ops __read_mostly = {
>         .dump           =       pfifo_fast_dump,
>         .change_tx_queue_len =  pfifo_fast_change_tx_queue_len,
>         .owner          =       THIS_MODULE,
> -       .static_flags   =       TCQ_F_NOLOCK | TCQ_F_CPUSTATS,
> +       .static_flags   =       TCQ_F_CPUSTATS,
>  };
>  EXPORT_SYMBOL(pfifo_fast_ops);
