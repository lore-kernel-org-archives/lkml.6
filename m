Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631ADECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28ACF20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28ACF20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbeJaKxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 06:53:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45164 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbeJaKxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 06:53:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id o19-v6so6442841pll.12;
        Tue, 30 Oct 2018 18:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PY89FeHeNVtuwMMW0RIlywAgg9wBFVTKbaxJ/wRV2YE=;
        b=T7/Uk3bhUSmcRHJhGS33yJdOAZGgDo5bQcK0TbYye6jSTA7tSQwonM8tYkoigUqhXU
         Xz2Si/tjKC9WLcq0ArYW8VeUuXQEcPTgkZl6m83e5UQRPXoiilzuFpZGl25fvKJ+cwqI
         wi35TUTHQAo5EbxyFQRhP67c2Ay+JHvu5H1hopfJ6rigApqy6Cg6GwSnt3268caS8jEt
         rGuNSRXFAWLvIOXizXfuQLYtFZtEPrJOk57RbHXPfSC46Ra7+GerbVo8DzFS00J06A1h
         a8BVbjtrNOVR+ImtBFVXe/EhqWZyfpQ6VAUm56jc5wgyNHs/Kh/tz+PvDr65ah0IOUZ2
         rDhQ==
X-Gm-Message-State: AGRZ1gLcCqACb3wuZfQfMP9THEdOwoxipo7FrV1jwffi8iBawNux42gB
        mQgXsLcZPkAOVfuuSLgHWLFfkuG3
X-Google-Smtp-Source: AJdET5frx3o9ZjzhRzcX6qmJWNXUEYE0avLv6yFpXB1g9veAG2rCDrUaIOSzi8PzNEt5Bgu8m1CehQ==
X-Received: by 2002:a17:902:aa45:: with SMTP id c5-v6mr1271371plr.100.1540951027617;
        Tue, 30 Oct 2018 18:57:07 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:e9fd:d0f6:3e3:43a5? ([2601:647:4800:973f:e9fd:d0f6:3e3:43a5])
        by smtp.gmail.com with ESMTPSA id g72-v6sm27480675pfd.181.2018.10.30.18.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 18:57:06 -0700 (PDT)
Subject: Re: [PATCH 14/16] nvme: utilize two queue maps, one for reads and one
 for writes
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-15-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <193a50fe-0c02-9f01-f110-5cfa1cec9283@grimberg.me>
Date:   Tue, 30 Oct 2018 18:57:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-15-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int queue_irq_offset(struct nvme_dev *dev)
> +{
> +	/* if we have more than 1 vec, admin queue offsets us 1 */

offsets us by 1?

> +	if (dev->num_vecs > 1)
> +		return 1;
> +
> +	return 0;
> +}
> +

...

> @@ -1934,13 +2048,48 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>   	 * setting up the full range we need.
>   	 */
>   	pci_free_irq_vectors(pdev);
> -	result = pci_alloc_irq_vectors_affinity(pdev, 1, nr_io_queues + 1,
> -			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
> -	if (result <= 0)
> -		return -EIO;
> +
> +	/*
> +	 * For irq sets, we have to ask for minvec == maxvec. This passes
> +	 * any reduction back to us, so we can adjust our queue counts and
> +	 * IRQ vector needs.
> +	 */
> +	do {
> +		nvme_calc_io_queues(dev, nr_io_queues);
> +		irq_sets[0] = dev->io_queues[NVMEQ_TYPE_READ];
> +		irq_sets[1] = dev->io_queues[NVMEQ_TYPE_WRITE];
> +		if (!irq_sets[1])
> +			affd.nr_sets = 1;
> +
> +		/*
> +		 * Need IRQs for read+write queues, and one for the admin queue
> +		 */
> +		nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
> +
> +		result = pci_alloc_irq_vectors_affinity(pdev, nr_io_queues,
> +				nr_io_queues,
> +				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
> +
> +		/*
> +		 * Need to reduce our vec counts
> +		 */
> +		if (result == -ENOSPC) {
> +			nr_io_queues--;
> +			if (!nr_io_queues)
> +				return result;
> +			continue;
> +		} else if (result <= 0)
> +			return -EIO;
> +		break;
> +	} while (1);
> +
>   	dev->num_vecs = result;
>   	dev->max_qid = max(result - 1, 1);
>   
> +	dev_info(dev->ctrl.device, "%d/%d/%d read/write queues\n",
> +					dev->io_queues[NVMEQ_TYPE_READ],
> +					dev->io_queues[NVMEQ_TYPE_WRITE]);
> +

Perhaps it would be better if we move this code into a function.
