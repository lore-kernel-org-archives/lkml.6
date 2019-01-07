Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F04C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 05:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3365D20657
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 05:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfAGF2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 00:28:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:17118 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbfAGF2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 00:28:19 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2ED2F9A25E917C6C7EE1;
        Mon,  7 Jan 2019 13:28:17 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.113) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Mon, 7 Jan 2019
 13:27:53 +0800
Subject: Re: [PATCH v2] nvme-pci: fix dbbuf_sq_db point to freed memory
To:     Christoph Hellwig <hch@infradead.org>
References: <E5D59058E6941147BD3ACF9CB4AA49E3B3572EC2@DGGEMA505-MBX.china.huawei.com>
 <20190104180710.GA4642@infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From:   "Lulina (A)" <lina.lulina@huawei.com>
Message-ID: <5C32E34D.3030705@huawei.com>
Date:   Mon, 7 Jan 2019 13:27:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20190104180710.GA4642@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.19.113]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for replying to my email, my description in the last email was not
clear enough, so here's a supplementary note.

The NVME device I used support DBBUF, but the nvme_admin_dbbuf request
returned a failure that eventually led to the kernel crash.

The problem occurs as follows:
1, Device support NVME_CTRL_OACS_DBBUF_SUPP，so reset worker alloc memory
   for dev->dbbuf_dbs。
2, In nvme_setup_io_queues process, the nvme_dbbuf_init function is called
   to assign values to pointers such as nvmeq->dbbuf_sq_db.
3, In nvme_dev_add function, the nvme_admin_dbbuf request is sent to the
   device, but the device returns failed, so the memory that dev->dbbuf_dbs
   points to is released.

Then, the driver issued IO requests, in the nvme_write_sq_db process,
nvme_dbbuf_update_and_check_event function judgment to Nvmeq->dbbuf_sq_db
pointer is not NULL, write to the memory it points to, causing memory
confusion and kernel crash.

On 2019/1/5 2:07, Christoph Hellwig wrote:
> On Fri, Dec 21, 2018 at 01:07:25AM +0000, Lulina (A) wrote:
>> The case is that nvme device support NVME_CTRL_OACS_DBBUF_SUPP, and
>> return failed when the driver sent nvme_admin_dbbuf. The nvmeq->dbbuf_sq_db
>> point to freed memory, as nvme_dbbuf_set is called after nvme_dbbuf_init.
> 
> But we never use those pointers in that state, do we?  Can you explain
> the problem in a little more detail?
> 
> 

