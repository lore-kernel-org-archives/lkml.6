Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E13EC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378AC20865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378AC20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbeJLVDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:03:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeJLVDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:03:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F32B680474;
        Fri, 12 Oct 2018 13:30:37 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECB396F96B;
        Fri, 12 Oct 2018 13:30:24 +0000 (UTC)
Date:   Fri, 12 Oct 2018 21:30:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        jejb@linux.vnet.ibm.com, linuxarm@huawei.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenxiang <chenxiang66@hisilicon.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH 0/7] hisi_sas: Misc bugfixes and an optimisation patch
Message-ID: <20181012133019.GA5361@ming.t460p>
References: <1537801594-207139-1-git-send-email-john.garry@huawei.com>
 <yq18t354532.fsf@oracle.com>
 <20181011063603.GA3456@infradead.org>
 <118d01db-05f4-a85b-850c-c4e5a5616a16@huawei.com>
 <20181011101534.GA31802@infradead.org>
 <e2f35903-e28f-0fb5-7c61-47aa7f1a6926@huawei.com>
 <20181011133159.GA31355@ming.t460p>
 <519812c7-970a-976c-7db5-a035bf4f4e24@huawei.com>
 <20181011233633.GA30271@ming.t460p>
 <3322d066-d118-320f-eb99-0fb03d530c67@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3322d066-d118-320f-eb99-0fb03d530c67@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 12 Oct 2018 13:30:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:02:57AM +0100, John Garry wrote:
> Hi Ming,
> 
> > In theory, you still may generate and manage the IPTT in the LLDD by
> > simply ignoring rq->tag, meantime enabling SCSI_MQ with 16 hw queues.
> > 
> 
> Well at the moment we can't expose all 16 hw queues to upper layer anyway,
> due to ordering restiction imposed by HW on LLDD. We have a plan to solve
> it.
> 
> Regardless, we still found performance better by using rq tag instead of
> exposing all 16 queues.
> 
> > However, not sure how much this way may improve performance, and it may
> > degrade IO perf. If 16 hw queues are exposed to blk-mq, 16*.can_queue
> > requests may be queued to the driver, and allocation & free on the single
> > IPTT pool will become a bottleneck.
> 
> Right, this IPTT management doesn't scale (especially for our host with 2
> sockets @ 48/64 cores each). So if upper layer is already generating a tag
> which we can use, good to use it.
> 
> > 
> > Per my experiment on host tagset, it might be a good tradeoff to allocate
> > one hw queue for each node to avoid the remote access on dispatch
> > data/requests structure for this case, but your IPTT pool is still
> > shared all CPUs, maybe you can try the smart sbitmap.
> > 
> > https://www.spinics.net/lists/linux-scsi/msg117920.html
> 
> I don't understand this about allocating a hw queue per node. Surely having
> and using all available queues in an intelligent way means less queue
> contention, right?

Yes.

> 
> Looking at this change:
> @@ -5761,6 +5762,11 @@ static int hpsa_scsi_host_alloc(struct ctlr_info *h)
>  static int hpsa_scsi_add_host(struct ctlr_info *h)
>  {
>  	int rv;
> +	/* 256 tags should be high enough to saturate device */
> +	int max_queues = DIV_ROUND_UP(h->scsi_host->can_queue, 256);
> +
> +	/* per NUMA node hw queue */
> +	h->scsi_host->nr_hw_queues = min_t(int, nr_node_ids, max_queues);
> 
> I assume h->scsi_host->nr_hw_queues was zero-init previously, so we're now
> using > 1 queue, but why limit?

From my test on null_blk/scsi_debug, per-node hw queue improves iops
much more obviously.

Also you may manage IPTT in LLD, and contention on the single IPTT pool
shouldn't be very serious, given there are less NUMA nodes usually.



Thanks,
Ming
