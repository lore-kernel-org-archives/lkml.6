Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46DAC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 04:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767592152D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 04:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767592152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeHTHc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 03:32:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbeHTHc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 03:32:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CC22DFF6;
        Mon, 20 Aug 2018 04:18:57 +0000 (UTC)
Received: from ming.t460p (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 804122026D66;
        Mon, 20 Aug 2018 04:18:44 +0000 (UTC)
Date:   Mon, 20 Aug 2018 12:18:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@linux.intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] blk-mq: init hctx sched after update ctx and hctx
 mapping
Message-ID: <20180820041833.GB21600@ming.t460p>
References: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534478043-7170-2-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVPZF7ohzUib4Nr1qdHLwjpEWP4+be6h6GmZh1y9-qsVqg@mail.gmail.com>
 <96657784-dd95-6ea9-3ffd-25737c534075@oracle.com>
 <CACVXFVMqjiSmzL2JeLUV2Q4bXqy2WRNHahg-fusFYjHeCX3gng@mail.gmail.com>
 <3ce9f249-4c2f-89a6-727f-9bc449a4fdf4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce9f249-4c2f-89a6-727f-9bc449a4fdf4@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 20 Aug 2018 04:18:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 20 Aug 2018 04:18:57 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 11:57:52AM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 08/20/2018 10:24 AM, Ming Lei wrote:
> >> The code path is:
> >>
> >> elevator_release
> >>   -> elevator_put(e->type)
> >>     -> module_put(e->elevator_owner)
> >>
> >> In normal elevator switch path, elevator_get will hold a reference counter of the
> >> elevator_owner.
> >> In this patch set, the elevator_type is saved directly. To prevent the io scheduler module
> >> is removed, we need to hold a reference of the module.
> > Yeah, I agree that the module reference need to be held, but it need to be
> > released too.
> > 
> > My concern is that this introduced getting module reference in your patch
> > isn't released. The module reference is a counter too, so the get and
> > put operation should be matched.
> 
> elevator_switch_mq
>   -> elevator_exit
> it will put a reference count of the elevator_queue associated with the request_queue.
> and the elevator_release will be invoked when the reference count of elevator_queue->kobj reaches zero.
> elevator_release will put the reference count of the io scheduler module.
> 
> the elevator_queue structure will be allocated and freed every time when we switch io scheduler.
> so the elevator_release will always be invoked.
> 
> This is the put ref corresponding to the get one in this patch.

OK, got it, the added __module_get() is just like what elevator_get()
does from __elevator_change(). Sorry for the noise.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
