Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21352C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA36B21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA36B21501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbeHBMaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:30:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726739AbeHBMaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:30:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 122E97DAC9;
        Thu,  2 Aug 2018 10:39:28 +0000 (UTC)
Received: from ming.t460p (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 69E3F7C49;
        Thu,  2 Aug 2018 10:39:21 +0000 (UTC)
Date:   Thu, 2 Aug 2018 18:39:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, bart.vanassche@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] blk-mq: clean up the hctx restart
Message-ID: <20180802103916.GB6520@ming.t460p>
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180731045805.GE15701@ming.t460p>
 <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
 <20180731061616.GF15701@ming.t460p>
 <42371198-2a4b-1062-3564-411645ffba98@oracle.com>
 <20180801085841.GA27962@ming.t460p>
 <dee91f9a-e681-b2d4-342b-5bf085464558@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dee91f9a-e681-b2d4-342b-5bf085464558@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 02 Aug 2018 10:39:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 02 Aug 2018 10:39:28 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 09:37:08PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 08/01/2018 04:58 PM, Ming Lei wrote:
> > On Wed, Aug 01, 2018 at 10:17:30AM +0800, jianchao.wang wrote:
> >> Hi Ming
> >>
> >> Thanks for your kindly response.
> >>
> >> On 07/31/2018 02:16 PM, Ming Lei wrote:
> >>> On Tue, Jul 31, 2018 at 01:19:42PM +0800, jianchao.wang wrote:
> >>>> Hi Ming
> >>>>
> >>>> On 07/31/2018 12:58 PM, Ming Lei wrote:
> >>>>> On Tue, Jul 31, 2018 at 12:02:15PM +0800, Jianchao Wang wrote:
> >>>>>> Currently, we will always set SCHED_RESTART whenever there are
> >>>>>> requests in hctx->dispatch, then when request is completed and
> >>>>>> freed the hctx queues will be restarted to avoid IO hang. This
> >>>>>> is unnecessary most of time. Especially when there are lots of
> >>>>>> LUNs attached to one host, the RR restart loop could be very
> >>>>>> expensive.
> >>>>>
> >>>>> The big RR restart loop has been killed in the following commit:
> >>>>>
> >>>>> commit 97889f9ac24f8d2fc8e703ea7f80c162bab10d4d
> >>>>> Author: Ming Lei <ming.lei@redhat.com>
> >>>>> Date:   Mon Jun 25 19:31:48 2018 +0800
> >>>>>
> >>>>>     blk-mq: remove synchronize_rcu() from blk_mq_del_queue_tag_set()
> >>>>>
> >>>>>
> >>>>
> >>>> Oh, sorry, I didn't look into this patch due to its title when iterated the mail list,
> >>>> therefore I didn't realize the RR restart loop has already been killed. :)
> >>>>
> >>>> The RR restart loop could ensure the fairness of sharing some LLDD resource,
> >>>> not just avoid IO hung. Is it OK to kill it totally ?
> >>>
> >>> Yeah, it is, also the fairness might be improved a bit by the way in
> >>> commit 97889f9ac24f8d2fc, especially inside driver tag allocation
> >>> algorithem.
> >>>
> >>
> >> Would you mind to detail more here ?
> >>
> >> Regarding the driver tag case:
> >> For example:
> >>
> >> q_a         q_b        q_c       q_d
> >> hctx0       hctx0      hctx0     hctx0
> >>
> >>                  tags
> >>
> >> Total number of tags is 32
> >> All of these 4 q are active.
> >>
> >> So every q has 8 tags.
> >>
> >> If all of these 4 q have used up their 8 tags, they have to wait.
> >>
> >> When part of the in-flight requests q_a are completed, tags are freed.
> >> but the __sbq_wake_up doesn't wake up the q_a, it may wake up q_b.
> > 
> > 1) in case of IO scheduler
> > q_a should be waken up because q_a->hctx0 is added to one wq of the tags if
> > no tag is available, see blk_mq_mark_tag_wait().
> > 
> > 2) in case of none scheduler
> > q_a should be waken up too, see blk_mq_get_tag().
> > 
> > So I don't understand why you mentioned that q_a can't be waken up.
> 
> There are multiple sbq_wait_states in one sbitmap_queue and __sbq_wake_up
> will only wake up the waiters on one of them one time. Please refer to __sbq_wake_up.

Yes, the multiple wqs are waken up in RR style, which is still fair generally speaking.
And there is no such issue of always not waking up 'q_a' when request is completed on
this queue, is there?

Thanks,
Ming
