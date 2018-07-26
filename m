Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBF5C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0112B2064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0112B2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opengridcomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbeGZOUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:20:46 -0400
Received: from linode.aoot.com ([69.164.194.13]:35632 "EHLO linode.aoot.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729514AbeGZOUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:20:46 -0400
X-Greylist: delayed 1911 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jul 2018 10:20:45 EDT
Received: from stevoacer (47-221-137-213.gtwncmta03.res.dyn.suddenlink.net [47.221.137.213])
        by linode.aoot.com (Postfix) with ESMTP id 83C1D821C;
        Thu, 26 Jul 2018 07:32:15 -0500 (CDT)
From:   "Steve Wise" <swise@opengridcomputing.com>
To:     "'Stephen Rothwell'" <sfr@canb.auug.org.au>,
        "'Jens Axboe'" <axboe@kernel.dk>,
        "'Doug Ledford'" <dledford@redhat.com>,
        "'Jason Gunthorpe'" <jgg@mellanox.com>
Cc:     "'Linux-Next Mailing List'" <linux-next@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'Christoph Hellwig'" <hch@lst.de>
References: <20180726145624.13a604ed@canb.auug.org.au>
In-Reply-To: <20180726145624.13a604ed@canb.auug.org.au>
Subject: RE: linux-next: build failure after merge of the block tree
Date:   Thu, 26 Jul 2018 07:32:16 -0500
Message-ID: <011b01d424dc$b0a69820$11f3c860$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKoseR149ZceM129HjmJJMloZXPqqL4VUnA
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Stephen:

> I have applied the following merge fix patch for today:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 26 Jul 2018 14:32:15 +1000
> Subject: [PATCH] nvme-dma: merge fix up for replacement of max_sge
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/nvme/host/rdma.c   | 2 +-
>  drivers/nvme/target/rdma.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index cfa0319fcd1c..368fe5ac0c6b 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -378,7 +378,7 @@ nvme_rdma_find_get_device(struct rdma_cm_id
> *cm_id)
>  	}
> 
>  	ndev->num_inline_segments =
> min(NVME_RDMA_MAX_INLINE_SEGMENTS,
> -					ndev->dev->attrs.max_sge - 1);
> +					ndev->dev->attrs.max_send_sge - 1);
>  	list_add(&ndev->entry, &device_list);
>  out_unlock:
>  	mutex_unlock(&device_list_mutex);
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 86121a7a19b2..8c30ac7d8078 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -891,7 +891,7 @@ nvmet_rdma_find_get_device(struct rdma_cm_id
> *cm_id)
> 
>  	inline_page_count = num_pages(port->inline_data_size);
>  	inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
> -				cm_id->device->attrs.max_sge) - 1;
> +				cm_id->device->attrs.max_send_sge) - 1;

This should actually be max_recv_sge.

Thanks!

Steve.


