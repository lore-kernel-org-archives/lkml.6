Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D948C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3DC205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3DC205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeK0GTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:19:00 -0500
Received: from ale.deltatee.com ([207.54.116.67]:51994 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbeK0GS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:18:59 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gRMTv-00019x-C5; Mon, 26 Nov 2018 12:23:44 -0700
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
References: <20181126105059.832485122@linuxfoundation.org>
 <20181126105100.053276084@linuxfoundation.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <22aec0ec-4da1-fcbc-3318-ec7709888769@deltatee.com>
Date:   Mon, 26 Nov 2018 12:23:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126105100.053276084@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sashal@kernel.org, axboe@kernel.dk, hch@lst.de, keith.busch@intel.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 4.19 005/118] nvme-pci: fix conflicting p2p resource adds
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-11-26 3:49 a.m., Greg Kroah-Hartman wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me know.

This commit is fixing a bug in the p2pdma code which was merged for
4.20. I'm not sure it would actually fix anything in the stable kernels.
On the other hand, based on my understanding, it shouldn't hurt anything
either.

Thanks,

Logan

> ------------------
> 
> [ Upstream commit 9fe5c59ff6a1e5e26a39b75489a1420e7eaaf0b1 ]
> 
> The nvme pci driver had been adding its CMB resource to the P2P DMA
> subsystem everytime on on a controller reset. This results in the
> following warning:
> 
>     ------------[ cut here ]------------
>     nvme 0000:00:03.0: Conflicting mapping in same section
>     WARNING: CPU: 7 PID: 81 at kernel/memremap.c:155 devm_memremap_pages+0xa6/0x380
>     ...
>     Call Trace:
>      pci_p2pdma_add_resource+0x153/0x370
>      nvme_reset_work+0x28c/0x17b1 [nvme]
>      ? add_timer+0x107/0x1e0
>      ? dequeue_entity+0x81/0x660
>      ? dequeue_entity+0x3b0/0x660
>      ? pick_next_task_fair+0xaf/0x610
>      ? __switch_to+0xbc/0x410
>      process_one_work+0x1cf/0x350
>      worker_thread+0x215/0x3d0
>      ? process_one_work+0x350/0x350
>      kthread+0x107/0x120
>      ? kthread_park+0x80/0x80
>      ret_from_fork+0x1f/0x30
>     ---[ end trace f7ea76ac6ee72727 ]---
>     nvme nvme0: failed to register the CMB
> 
> This patch fixes this by registering the CMB with P2P only once.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/nvme/host/pci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d668682f91df..da18e0ac9fa2 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1647,6 +1647,9 @@ static void nvme_map_cmb(struct nvme_dev *dev)
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  	int bar;
>  
> +	if (dev->cmb_size)
> +		return;
> +
>  	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
>  	if (!dev->cmbsz)
>  		return;
> @@ -2129,7 +2132,6 @@ static void nvme_pci_disable(struct nvme_dev *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  
> -	nvme_release_cmb(dev);
>  	pci_free_irq_vectors(pdev);
>  
>  	if (pci_is_enabled(pdev)) {
> @@ -2577,6 +2579,7 @@ static void nvme_remove(struct pci_dev *pdev)
>  	nvme_stop_ctrl(&dev->ctrl);
>  	nvme_remove_namespaces(&dev->ctrl);
>  	nvme_dev_disable(dev, true);
> +	nvme_release_cmb(dev);
>  	nvme_free_host_mem(dev);
>  	nvme_dev_remove_admin(dev);
>  	nvme_free_queues(dev, 0);
> 
