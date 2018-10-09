Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681B5C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B51120858
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="f5qoLHOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B51120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbeJIMPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:15:37 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:48877 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbeJIMPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RXP7JBLWAIo4UGl4nwoQxR610Fy4Oip1AtKwO0cgQG8=; b=f5qoLHORjGNgAt5wHFdeJ3l9FR
        SjN0J4t33Luenl9Ng4eLnl04dpDw053xu8Jg2yAZuW4LO8OP+jZhsfrtlek8A1wJ5SbP2LJ/PIs9W
        QcUonG7mXJu9xLM5r/rzuZgum8YWnLuNa+XnzJ6wmNoRaAQvN+aqHIpBaOUACN+qReT0tnJlnqU9W
        SGODzyrA0pSx18W7uKFOgxCUpLeMmuckWa6k5HqzUJItkm5GvqaEu4VYdNYnjzXXISmnjJqG8Sztu
        JMqnStZgFiCHaHkcvkGNjDdUOAnNAzhVLZPtL6+5fq3Wwqlndl1BgHz1hrgtTY8ovNIVGBes0EyCN
        H8wX3xJQ==;
Received: from [39.110.237.146] (helo=[10.19.58.25])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1g9k8G-0000Xy-Nv; Tue, 09 Oct 2018 08:00:33 +0300
Subject: Re: [PATCH v2 2/3] gpu: host1x: Don't complete a completed job
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180807130713.1016-1-digetx@gmail.com>
 <20180807130713.1016-3-digetx@gmail.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <4946d88d-f36c-b17e-59f6-5b7d626271a3@kapsi.fi>
Date:   Tue, 9 Oct 2018 14:00:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20180807130713.1016-3-digetx@gmail.com>
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

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

On 07/08/2018 22.07, Dmitry Osipenko wrote:
> There is a chance that the last job has been completed at the time of
> CDMA timeout handler invocation. In this case there is no need to complete
> the completed job.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>   drivers/gpu/host1x/cdma.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
> index 75f339f5df6f..6aa6fa1498e8 100644
> --- a/drivers/gpu/host1x/cdma.c
> +++ b/drivers/gpu/host1x/cdma.c
> @@ -323,7 +323,7 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
>   {
>   	struct host1x *host1x = cdma_to_host1x(cdma);
>   	u32 restart_addr, syncpt_incrs, syncpt_val;
> -	struct host1x_job *job = NULL;
> +	struct host1x_job *job;
>   
>   	syncpt_val = host1x_syncpt_load(cdma->timeout.syncpt);
>   
> @@ -342,11 +342,16 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
>   
>   	list_for_each_entry(job, &cdma->sync_queue, list) {
>   		if (syncpt_val < job->syncpt_end)
> -			break;
> +			goto syncpt_incr;
>   
>   		host1x_job_dump(dev, job);
>   	}
>   
> +	/* all jobs have been completed */
> +	job = NULL;
> +
> +syncpt_incr:
> +
>   	/*
>   	 * Increment with CPU the remaining syncpts of a partially executed job.
>   	 *
> @@ -359,16 +364,16 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
>   	 * modified NOP-ed PB slots). This lets things appear to have completed
>   	 * properly for this buffer and resources are freed.
>   	 */
> -
> -	dev_dbg(dev, "%s: perform CPU incr on pending buffers\n", __func__);
> -
> -	if (!list_empty(&cdma->sync_queue))
> +	if (job)
>   		restart_addr = job->first_get;
>   	else
>   		restart_addr = cdma->last_pos;
>   
>   	/* do CPU increments for the remaining syncpts */
>   	if (job) {
> +		dev_dbg(dev, "%s: perform CPU incr on pending buffers\n",
> +			__func__);
> +
>   		/* won't need a timeout when replayed */
>   		job->timeout = 0;
>   
> @@ -381,9 +386,10 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
>   		host1x_hw_cdma_timeout_cpu_incr(host1x, cdma, job->first_get,
>   						syncpt_incrs, job->syncpt_end,
>   						job->num_slots);
> -	}
>   
> -	dev_dbg(dev, "%s: finished sync_queue modification\n", __func__);
> +		dev_dbg(dev, "%s: finished sync_queue modification\n",
> +			__func__);
> +	}
>   
>   	/* roll back DMAGET and start up channel again */
>   	host1x_hw_cdma_resume(host1x, cdma, restart_addr);
> 
