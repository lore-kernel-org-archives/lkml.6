Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7D8C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1979620658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1979620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeJKU70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:59:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbeJKU70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:59:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F7333002955;
        Thu, 11 Oct 2018 13:32:13 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44C726B49D;
        Thu, 11 Oct 2018 13:32:04 +0000 (UTC)
Date:   Thu, 11 Oct 2018 21:32:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        jejb@linux.vnet.ibm.com, linuxarm@huawei.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH 0/7] hisi_sas: Misc bugfixes and an optimisation patch
Message-ID: <20181011133159.GA31355@ming.t460p>
References: <1537801594-207139-1-git-send-email-john.garry@huawei.com>
 <yq18t354532.fsf@oracle.com>
 <20181011063603.GA3456@infradead.org>
 <118d01db-05f4-a85b-850c-c4e5a5616a16@huawei.com>
 <20181011101534.GA31802@infradead.org>
 <e2f35903-e28f-0fb5-7c61-47aa7f1a6926@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2f35903-e28f-0fb5-7c61-47aa7f1a6926@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 11 Oct 2018 13:32:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 02:12:11PM +0100, John Garry wrote:
> On 11/10/2018 11:15, Christoph Hellwig wrote:
> > On Thu, Oct 11, 2018 at 10:59:11AM +0100, John Garry wrote:
> > > 
> > > > blk-mq tags are always per-host (which has actually caused problems for
> > > > ATA, which is now using its own per-device tags).
> > > > 
> > > 
> > > So, for example, if Scsi_host.can_queue = 2048 and Scsi_host.nr_hw_queues =
> > > 16, then rq tags are still in range [0, 2048) for that HBA, i.e. invariant
> > > on queue count?
> > 
> > Yes, if can_queue is 2048 you will gets tags from 0..2047.
> > 
> 
> I should be clear about some things before discussing this further. Our
> device has 16 hw queues. And each command we send to any queue in the device
> must have a unique tag across all hw queues for that device, and should be
> in the range [0, 2048) - it's called an IPTT. So Scsi_host.can_queue = 2048.

Could you describe a bit about IPTT?

Looks like the 16 hw queues are like reply queues in other drivers,
such as megara_sas, but given all the 16 reply queues share one tagset,
so the hw queue number has to be 1 from blk-mq's view.

> 
> However today we only expose a single queue to upper layer (for unrelated
> LLDD error handling restriction). We hope to expose all 16 queues in future,
> which is what I meant by "enabling SCSI MQ in the driver". However, with
> 6/7, this creates a problem, below.

If the tag of each request from all hw queues has to be unique, you
can't expose all 16 queues.

> 
> > IFF you device needs different tags for different queues it can use
> > the blk_mq_unique_tag heper to generate unique global tag.
> 
> So this helper can't help, as fundamentially the issue is "the tag field in
> struct request is unique per hardware queue but not all all hw queues".
> Indeed blk_mq_unique_tag() does give a unique global tag, but cannot be used
> for the IPTT.
> 
> OTOH, We could expose 16 queues to upper layer, and drop 6/7, but we found
> it performs worse.

We discussed this issue before, but not found a good solution yet for
exposing multiple hw queues to blk-mq.

However, we still get good performance in case of none scheduler by the
following patches:

8824f62246be blk-mq: fail the request in case issue failure
6ce3dd6eec11 blk-mq: issue directly if hw queue isn't busy in case of 'none'


Thanks,
Ming
