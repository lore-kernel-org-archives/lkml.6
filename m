Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDBBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F2D20685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfAISjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:39:22 -0500
Received: from verein.lst.de ([213.95.11.211]:43346 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfAISjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:39:22 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B3FAB67358; Wed,  9 Jan 2019 19:39:20 +0100 (CET)
Date:   Wed, 9 Jan 2019 19:39:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hongbo Yao <yaohongbo@huawei.com>
Cc:     wangxiongfeng2@huawei.com, guohanjun@huawei.com,
        huawei.libin@huawei.com, thunder.leizhen@huawei.com,
        tanxiaojun@huawei.com, xiexiuqi@huawei.com,
        yangyingliang@huawei.com, cj.chengjian@huawei.com,
        wxf.wang@hisilicon.com, keith.busch@intel.com, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix out of bounds access in nvme_cqe_pending
Message-ID: <20190109183920.GA22070@lst.de>
References: <1546827727-49635-1-git-send-email-yaohongbo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546827727-49635-1-git-send-email-yaohongbo@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 10:22:07AM +0800, Hongbo Yao wrote:
> There is an out of bounds array access in nvme_cqe_peding().
> 
> When enable irq_thread for nvme interrupt, there is racing between the
> nvmeq->cq_head updating and reading.

Just curious: why did you enable this option?  Do you have a workload
where it matters?

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d668682..68375d4 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -908,9 +908,11 @@ static void nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end)
>  
>  static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
>  {
> -	if (++nvmeq->cq_head == nvmeq->q_depth) {
> +	if (nvmeq->cq_head == (nvmeq->q_depth - 1)) {
>  		nvmeq->cq_head = 0;
>  		nvmeq->cq_phase = !nvmeq->cq_phase;
> +	} else {
> +		++nvmeq->cq_head;

No need for the braces above, but otherwise this looks fine.  I'll apply
it to nvme-4.21.
