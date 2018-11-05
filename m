Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B15C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BBD20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BBD20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbeKEMLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 07:11:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeKEMLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 07:11:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCA05C049587;
        Mon,  5 Nov 2018 02:53:49 +0000 (UTC)
Received: from [10.72.12.184] (ovpn-12-184.pek2.redhat.com [10.72.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FD825ED41;
        Mon,  5 Nov 2018 02:53:44 +0000 (UTC)
Subject: Re: [PATCH 1/1] vhost: add per-vq worker thread
To:     Vitaly Mayatskikh <v.mayatskih@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181102160710.3741-1-v.mayatskih@gmail.com>
 <20181102160710.3741-2-v.mayatskih@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <fe79c7fd-1e9f-dab8-3c65-8151181c922c@redhat.com>
Date:   Mon, 5 Nov 2018 10:53:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102160710.3741-2-v.mayatskih@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 05 Nov 2018 02:53:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/11/3 上午12:07, Vitaly Mayatskikh wrote:
> +
> +static int vhost_vq_poll_start(struct vhost_virtqueue *vq)
> +{
> +	if (!vq->worker) {
> +		vq->worker = kthread_create(vhost_vq_worker, vq, "vhost-%d/%i",
> +					    vq->dev->pid, vq->index);
> +		if (IS_ERR(vq->worker)) {
> +			int ret = PTR_ERR(vq->worker);
> +
> +			pr_err("%s: can't create vq worker: %d\n", __func__,
> +			       ret);
> +			vq->worker = NULL;
> +			return ret;
> +		}
> +	}
> +	vhost_work_init(&vq->work, vhost_vq_poll_start_work);
> +	vhost_vq_work_queue(vq, &vq->work);
> +	return 0;
> +}
> +


I wonder whether or not it's better to allow the device to specific the 
worker here instead of forcing a per vq worker model. Then we can keep 
the behavior of exist implementation and do optimization on top?

Thanks


