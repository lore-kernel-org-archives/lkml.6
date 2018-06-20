Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5ADC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC1120846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC1120846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754218AbeFTOau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:30:50 -0400
Received: from verein.lst.de ([213.95.11.211]:47126 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754099AbeFTOar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:30:47 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BC38B68E40; Wed, 20 Jun 2018 16:39:56 +0200 (CEST)
Date:   Wed, 20 Jun 2018 16:39:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        keith.busch@intel.com, josef@toxicpanda.com,
        ulf.hansson@linaro.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] nvme: use __blk_mq_complete_request in timeout path
Message-ID: <20180620143956.GA20950@lst.de>
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com> <1529500964-28429-6-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529500964-28429-6-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 73a97fc..2a161f6 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1203,6 +1203,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  		nvme_warn_reset(dev, csts);
>  		nvme_dev_disable(dev, false);
>  		nvme_reset_ctrl(&dev->ctrl);
> +		__blk_mq_complete_request(req);
>  		return BLK_EH_DONE;
>  	}
>  
> @@ -1213,6 +1214,11 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  		dev_warn(dev->ctrl.device,
>  			 "I/O %d QID %d timeout, completion polled\n",
>  			 req->tag, nvmeq->qid);
> +		/*
> +		 * nvme_end_request will invoke blk_mq_complete_request,
> +		 * it will do nothing for this timed out request.
> +		 */
> +		__blk_mq_complete_request(req);

And this clearly is bogus.  We want to iterate over the tagetset
and cancel all requests, not do that manually here.

That was the whole point of the original change.
