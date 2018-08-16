Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51326C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4B62148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4B62148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390567AbeHPMg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:36:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730390AbeHPMg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:36:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 109D040201C9;
        Thu, 16 Aug 2018 09:39:08 +0000 (UTC)
Received: from ming.t460p (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F1DAA2026D7E;
        Thu, 16 Aug 2018 09:38:56 +0000 (UTC)
Date:   Thu, 16 Aug 2018 17:38:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@linux.intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] blk-mq: sync the update nr_hw_queues with
 part_in_flight
Message-ID: <20180816093850.GB7144@ming.t460p>
References: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534317915-5041-3-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVO+g2ACx9XYx4XtwRkpSC9bCYeSFEj07Z==6r7nT-HxkQ@mail.gmail.com>
 <8cd103e6-0986-2c45-00f2-8a2a540a2eb5@oracle.com>
 <20180816090334.GA7144@ming.t460p>
 <f3fad2f5-9ab5-438a-d5a6-93c637921378@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3fad2f5-9ab5-438a-d5a6-93c637921378@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 16 Aug 2018 09:39:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 16 Aug 2018 09:39:08 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 05:20:50PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 08/16/2018 05:03 PM, Ming Lei wrote:
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index b42a2c9ba00e..fbc5534f8178 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -113,6 +113,10 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
> >  	struct mq_inflight mi = { .part = part, .inflight = inflight, };
> >  
> >  	inflight[0] = inflight[1] = 0;
> > +
> > +	if (percpu_ref_is_dying(&q->q_usage_counter))
> > +		return;
> > +
> >  	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
> >  }
> 
> That's a good idea to use q->q_usage_counter.
> But I think we could do following modification:
> 1. use percpu_ref_is_zero, then we will not miss any in-flight request here.
> 2. use rcu to ensure the user of blk_mq_in_flight has gone out of the critical section.
> Like following patch:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 89904cc..cd9878e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -113,7 +113,12 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
>  
>         inflight[0] = inflight[1] = 0;
>  
> +       rcu_read_lock();
> +       if (percpu_ref_is_zero(&q->q_usage_counter))
> +               return;
> +
>         blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
> +       rcu_read_unlock();
>  }
>  
>  static void blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
> @@ -2907,6 +2912,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>         list_for_each_entry(q, &set->tag_list, tag_set_list)
>                 blk_mq_freeze_queue(q);
>  
> +       synchronize_rcu();
>         /*
>          * switch io scheduler to NULL to clean up the data in it.
>          * will get it back after update mapping between cpu and hw queues.
> 
> And also, some comment is needed to describe them. ；）

This patch looks fine for me.

Thanks
Ming
