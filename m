Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeCOArP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 20:47:15 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33970 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCOArN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 20:47:13 -0400
X-Google-Smtp-Source: AG47ELuft+y07poRvan9vwslMcIS0RbUJAve6xTwn+y34MUoWYVsRNFJ+D7nbxhlte9XpKNQZqVNeQ==
Subject: Re: KASAN: use-after-free Read in pfifo_fast_enqueue
From: Eric Dumazet <eric.dumazet@gmail.com>
To: syzbot <syzbot+ed43b6903ab968b16f54@syzkaller.appspotmail.com>,
        davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
References: <000000000000081c6a056767c154@google.com>
 <a37dbc2c-2c43-2f71-7b36-275fcee83eb1@gmail.com>
Message-ID: <0ffb86a8-a316-f2a2-829e-6dc471122f3b@gmail.com>
Date: Wed, 14 Mar 2018 17:47:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a37dbc2c-2c43-2f71-7b36-275fcee83eb1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/14/2018 05:16 PM, Eric Dumazet wrote:

> 
> typical use after free...
> 
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 190570f21b208d5a17943360a3a6f85e1c2a2187..663e016491773f40f81d9bbfeab3dd68e1c2fc5c 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -628,6 +628,7 @@ static int pfifo_fast_enqueue(struct sk_buff *skb, struct Qdisc *qdisc,
>         int band = prio2band[skb->priority & TC_PRIO_MAX];
>         struct pfifo_fast_priv *priv = qdisc_priv(qdisc);
>         struct skb_array *q = band2list(priv, band);
> +       unsigned int pkt_len = qdisc_pkt_len(skb);
>         int err;
>  
>         err = skb_array_produce(q, skb);
> @@ -636,7 +637,7 @@ static int pfifo_fast_enqueue(struct sk_buff *skb, struct Qdisc *qdisc,
>                 return qdisc_drop_cpu(skb, qdisc, to_free);
>  
>         qdisc_qstats_cpu_qlen_inc(qdisc);
> -       qdisc_qstats_cpu_backlog_inc(qdisc, skb);
> +       this_cpu_add(qdisc->cpu_qstats->backlog, pkt_len);
>         return NET_XMIT_SUCCESS;
>  }
> 
There is also a similar issue right after qdisc_enqueue_skb_bad_txq() call.

We should move the following code in qdisc_enqueue_skb_bad_txq() to benefit from the locking

                       if (qdisc_is_percpu_stats(q)) {
                               qdisc_qstats_cpu_backlog_inc(q, nskb);
                               qdisc_qstats_cpu_qlen_inc(q);
                       } else {
                               qdisc_qstats_backlog_inc(q, nskb);
                               q->q.qlen++;
                       }


I will post a patch with the two fixes.
