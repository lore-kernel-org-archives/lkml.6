Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321FEC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAF520844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAF520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbeIFRcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:32:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727782AbeIFRcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:32:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D3ED402277F;
        Thu,  6 Sep 2018 12:57:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 488A62166B41;
        Thu,  6 Sep 2018 12:57:05 +0000 (UTC)
Date:   Thu, 6 Sep 2018 20:57:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jsmart2021@gmail.com,
        sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        jthumshirn@suse.de, bart.vanassche@wdc.com
Subject: Re: [PATCH 0/3] Introduce a light-weight queue close feature
Message-ID: <20180906125659.GA31250@ming.t460p>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180905212659.GB21352@ming.t460p>
 <b7074098-ab79-53b2-5cc6-25f859c4c666@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7074098-ab79-53b2-5cc6-25f859c4c666@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 06 Sep 2018 12:57:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 06 Sep 2018 12:57:19 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 09:51:43AM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 09/06/2018 05:27 AM, Ming Lei wrote:
> > On Wed, Sep 05, 2018 at 12:09:43PM +0800, Jianchao Wang wrote:
> >> Dear all
> >>
> >> As we know, queue freeze is used to stop new IO comming in and drain
> >> the request queue. And the draining queue here is necessary, because
> >> queue freeze kills the percpu-ref q_usage_counter and need to drain
> >> the q_usage_counter before switch it back to percpu mode. This could
> >> be a trouble when we just want to prevent new IO.
> >>
> >> In nvme-pci, nvme_dev_disable freezes queues to prevent new IO.
> >> nvme_reset_work will unfreeze and wait to drain the queues. However,
> >> if IO timeout at the moment, no body could do recovery as nvme_reset_work
> >> is waiting. We will encounter IO hang.
> > 
> > As we discussed this nvme time issue before, I have pointed out that
> > this is because of blk_mq_unfreeze_queue()'s limit which requires that
> > unfreeze can only be done when this queue ref counter drops to zero.
> > 
> > For this nvme timeout case, we may relax the limit, for example,
> > introducing another API of blk_freeze_queue_stop() as counter-pair of
> > blk_freeze_queue_start(), and simply switch the percpu-ref to percpu mode
> > from atomic mode inside the new API.
> 
> Looks like we cannot switch a percpu-ref to percpu mode directly w/o drain it.
> Some references maybe lost.
> 
> static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
> {
> 	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
> 	int cpu;
> 
> 	BUG_ON(!percpu_count);
> 
> 	if (!(ref->percpu_count_ptr & __PERCPU_REF_ATOMIC))
> 		return;
> 
> 	atomic_long_add(PERCPU_COUNT_BIAS, &ref->count);
> 
> 	/*
> 	 * Restore per-cpu operation.  smp_store_release() is paired
> 	 * with READ_ONCE() in __ref_is_percpu() and guarantees that the
> 	 * zeroing is visible to all percpu accesses which can see the
> 	 * following __PERCPU_REF_ATOMIC clearing.
> 	 */
> 	for_each_possible_cpu(cpu)
> 		*per_cpu_ptr(percpu_count, cpu) = 0;
> 
> 	smp_store_release(&ref->percpu_count_ptr,
> 			  ref->percpu_count_ptr & ~__PERCPU_REF_ATOMIC);

Before REF_ATOMIC is cleared, all counting is done on the atomic type
of &ref->count, and it is easy to keep the reference counter at
ATOMIC mode. Also the reference counter can only be READ at atomic mode.

So could you explain a bit how the lost may happen? And it is lost at
atomic mode or percpu mode?

> }
> 
> > 
> >>
> >> So introduce a light-weight queue close feature in this patch set
> >> which could prevent new IO and needn't drain the queue.
> > 
> > Frankly speaking, IMO, it may not be an good idea to mess up the fast path
> > just for handling the extremely unusual timeout event. The same is true
> > for doing the preemp only stuff, as you saw I have posted patchset for
> > killing it.
> > 
> 
> In normal case, it is just a judgment like 
> 
> 	if (unlikely(READ_ONCE(q->queue_gate))
> 
> It should not be a big deal.

Adding this stuff in fast path is quite difficult to verify its correctness
because it is really lockless, or even barrier-less.

Not to mention, READ_ONCE() implies one barrier of smp_read_barrier_depends().

Thanks,
Ming
