Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BBBC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624F2213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="iZPdrw4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624F2213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeJIMZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:25:45 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:39361 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbeJIMZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y4jc8aNJ9RxCPKTVX4gvibEsq2FCRgeegfKiNidEN68=; b=iZPdrw4UHmiRilL2CUi8ZuwM0K
        dLuMIq20Mw+RKgiKMMvgSQiNejMfeVUjfdSZy41Es1butxlGSBpqktlMrud5nK2luyA36OMZaqtVm
        C1dS6IcgPhS91ZdVAqJR3t6BKgp6B2kno54swfKhKaBngAGSiozgzX3KeqyLOAMoJwUSlrrUX8QwR
        CsfHogBJO+1zPuf7tREWTspMzE7vOuzmfxuGmbvnp5g8v7zXIESXsTUcqYKnnS1HQvxm/5586hhYU
        Cobmi44V9AwYL5jVfZo7s8R5f3StwZ7Q3PXMmY66dJM/k5fo/l8XniJKH2x8OrwO6WmjSJ4WnQmj9
        2xed1uLQ==;
Received: from [39.110.237.146] (helo=[10.19.58.25])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1g9kI2-0004Y8-Hv; Tue, 09 Oct 2018 08:10:38 +0300
Subject: Re: [PATCH v2 3/3] gpu: host1x: Continue CDMA execution starting with
 a next job
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180807130713.1016-1-digetx@gmail.com>
 <20180807130713.1016-4-digetx@gmail.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <b508bf7e-e329-b903-e851-d679bac93027@kapsi.fi>
Date:   Tue, 9 Oct 2018 14:10:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20180807130713.1016-4-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 39.110.237.146
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Mikko Perttnuen <mperttunen@nvidia.com>

On 07/08/2018 22.07, Dmitry Osipenko wrote:
> Currently gathers of a hung job are getting NOP'ed and a restarted CDMA
> executes the NOP'ed gathers. There shouldn't be a reason to not restart
> CDMA execution starting with a next job, avoiding the unnecessary churning
> with gathers NOP'ing.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>   drivers/gpu/host1x/cdma.c       | 23 +++++++++++------------
>   drivers/gpu/host1x/hw/cdma_hw.c | 13 -------------
>   2 files changed, 11 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
> index 6aa6fa1498e8..9e4f01c7f663 100644
> --- a/drivers/gpu/host1x/cdma.c
> +++ b/drivers/gpu/host1x/cdma.c
> @@ -323,7 +323,7 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
>   {
>   	struct host1x *host1x = cdma_to_host1x(cdma);
>   	u32 restart_addr, syncpt_incrs, syncpt_val;
> -	struct host1x_job *job;
> +	struct host1x_job *job, *next_job = NULL;
>   
>   	syncpt_val = host1x_syncpt_load(cdma->timeout.syncpt);
>   
> @@ -341,8 +341,13 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
>   		__func__);
>   
>   	list_for_each_entry(job, &cdma->sync_queue, list) {
> -		if (syncpt_val < job->syncpt_end)
> +		if (syncpt_val < job->syncpt_end) {
> +
> +			if (!list_is_last(&job->list, &cdma->sync_queue))
> +				next_job = list_next_entry(job, list);
> +
>   			goto syncpt_incr;
> +		}
>   
>   		host1x_job_dump(dev, job);
>   	}
> @@ -355,17 +360,11 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
>   	/*
>   	 * Increment with CPU the remaining syncpts of a partially executed job.
>   	 *
> -	 * Syncpt increments must be done inline with the pushbuffer from a
> -	 * GATHER buffer to maintain the order (slots are modified to be a
> -	 * GATHER of syncpt incrs).
> -	 *
> -	 * Note: save in restart_addr the location where the timed out buffer
> -	 * started in the PB, so we can start the refetch from there (with the
> -	 * modified NOP-ed PB slots). This lets things appear to have completed
> -	 * properly for this buffer and resources are freed.
> +	 * CDMA will continue execution starting with the next job or will get
> +	 * into idle state.
>   	 */
> -	if (job)
> -		restart_addr = job->first_get;
> +	if (next_job)
> +		restart_addr = next_job->first_get;
>   	else
>   		restart_addr = cdma->last_pos;
>   
> diff --git a/drivers/gpu/host1x/hw/cdma_hw.c b/drivers/gpu/host1x/hw/cdma_hw.c
> index ce320534cbed..bc203532ae6d 100644
> --- a/drivers/gpu/host1x/hw/cdma_hw.c
> +++ b/drivers/gpu/host1x/hw/cdma_hw.c
> @@ -40,7 +40,6 @@ static void cdma_timeout_cpu_incr(struct host1x_cdma *cdma, u32 getptr,
>   				u32 syncpt_incrs, u32 syncval, u32 nr_slots)
>   {
>   	struct host1x *host1x = cdma_to_host1x(cdma);
> -	struct push_buffer *pb = &cdma->push_buffer;
>   	unsigned int i;
>   
>   	for (i = 0; i < syncpt_incrs; i++)
> @@ -48,18 +47,6 @@ static void cdma_timeout_cpu_incr(struct host1x_cdma *cdma, u32 getptr,
>   
>   	/* after CPU incr, ensure shadow is up to date */
>   	host1x_syncpt_load(cdma->timeout.syncpt);
> -
> -	/* NOP all the PB slots */
> -	while (nr_slots--) {
> -		u32 *p = (u32 *)(pb->mapped + getptr);
> -		*(p++) = HOST1X_OPCODE_NOP;
> -		*(p++) = HOST1X_OPCODE_NOP;
> -		dev_dbg(host1x->dev, "%s: NOP at %pad+%#x\n", __func__,
> -			&pb->dma, getptr);
> -		getptr = (getptr + 8) & (pb->size - 1);
> -	}
> -
> -	wmb();
>   }
>   
>   /*
> 
