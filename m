Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F234C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2690B214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfBUIyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:54:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4244 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbfBUIyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:54:08 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E324495B190FBFD9B5F5;
        Thu, 21 Feb 2019 16:53:58 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Feb 2019
 16:53:56 +0800
Subject: Re: [RFC PATCH] scsi: fix oops in scsi_uninit_cmd()
To:     Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
CC:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hare@suse.com>,
        <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        Steffen Maier <maier@linux.ibm.com>
References: <20190219072743.13606-1-yanaijie@huawei.com>
 <1550595388.31902.133.camel@acm.org> <20190220151836.GA11695@infradead.org>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <10ea95ec-e259-3511-44c4-58e4d255eb9f@huawei.com>
Date:   Thu, 21 Feb 2019 16:53:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190220151836.GA11695@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christoph

On 2019/2/20 23:18, Christoph Hellwig wrote:
> [fullquote removed, please follow proper mail etiquette]
> 
> On Tue, Feb 19, 2019 at 08:56:28AM -0800, Bart Van Assche wrote:
>> regression in the SCSI sd driver due to the switch from the legacy block
>> layer to scsi-mq. The above patch introduces two atomic operations in the
>> hot path and hence would introduce a performance regression. I think this
>> can be avoided by making sure that sd_uninit_command() gets called before
>> the request tag is freed. What changes would be required to make the block
>> layer core call sd_uninit_command() before the request tag is freed? Would
>> introducing prep_rq_fn and unprep_rq_fn callbacks in struct blk_mq_ops and
>> making sure that the SCSI core sets these callback function pointers
>> appropriately be sufficient? Would such a change allow to simplify the NVMe
>> initiator driver? Are there any alternatives to this approach that are more
>> elegant?
> 
> Additional indirect calls in the I/O fast path is something I'd rather
> avoid.  But I don't fully understand the problem yet - where do
> we release a disk reference from blk_update_request?  

When userspace close the fd after blk_update_request() and before
scsi_mq_uninit_cmd(), a disk reference will be released. It is not the
blk_update_request() directly released it.

close
    ->sd_release
       ->scsi_disk_put
         ->scsi_disk_release
           ->disk->private_data = NULL;

The userspace can close the fd because blk_update_request() returned the
last IO , the userspace application does not have to stuck on read() or
write(). The window is very small, but it can be reproduce every day
in our testcases. So I'm very curious why. One possible explanation is
that we enabled kernel preempt(CONFIG_PREEMPT).

And why can't
> we move that release to __blk_mq_end_request?
> 
>>
>> Thanks,
>>
>> Bart.
> ---end quoted text---
> 
> .
> 

