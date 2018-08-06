Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D878C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6E3219E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="Fzuq/vOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6E3219E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbeHFMIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:08:46 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:32993 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbeHFMIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EQ/nC9y3KWB5NjEC872Q8V9Ye6oiyKkHJZMNioiUY8A=; b=Fzuq/vOb+tQAa+YrSfo3lubr2H
        HA2mH/QmiK6m+sB0Yv0agKi8by+30vm7/bD5yESz6XqVAY8ldZxTU4mcCIYdM/PUjnSTekn+4WW4b
        tQCQwMAvnWS4yxi/9LSgi8fItg/i0FpEdv8/D/3xcCb60PoygEupmAG0tOQJlQi5MD4P66lc2rWEa
        SiIYAvYHeyOl8UYeXQPVJjR+dhoProI9bUWRS/Eker/57pxrY5iMWj37iSSvh5eZTWbxfkuOSym66
        UIdoztjGoKnNWR5l/fp2AMFy4JUCH60MUa7X2Ju5iE1hkQSD8JFntP/IQmag16mHcz96xaFz7C7Yv
        3hY5SsCg==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fmcJM-000216-Qu; Mon, 06 Aug 2018 13:00:24 +0300
Subject: Re: [PATCH v1] gpu: host1x: Cancel only job that actually got stuck
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180805170131.29263-1-digetx@gmail.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <3eb8099b-8dcb-af37-a67d-463fc7c07c33@kapsi.fi>
Date:   Mon, 6 Aug 2018 13:00:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180805170131.29263-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

On 05.08.2018 20:01, Dmitry Osipenko wrote:
> Host1x doesn't have information about jobs inter-dependency, that is
> something that will become available once host1x will get a proper
> jobs scheduler implementation. Currently a hang job causes other unrelated
> jobs to be canceled, that is a relic from downstream driver which is
> irrelevant to upstream. Let's cancel only the hanging job and not to touch
> other jobs in queue.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>   drivers/gpu/host1x/cdma.c | 30 ++++++------------------------
>   1 file changed, 6 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
> index 91df51e631b2..4d94af4a315f 100644
> --- a/drivers/gpu/host1x/cdma.c
> +++ b/drivers/gpu/host1x/cdma.c
> @@ -348,13 +348,11 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
>   	}
>   
>   	/*
> -	 * Walk the sync_queue, first incrementing with the CPU syncpts that
> -	 * are partially executed (the first buffer) or fully skipped while
> -	 * still in the current context (slots are also NOP-ed).
> +	 * Increment with CPU the remaining syncpts of a partially executed job.
>   	 *
> -	 * At the point contexts are interleaved, syncpt increments must be
> -	 * done inline with the pushbuffer from a GATHER buffer to maintain
> -	 * the order (slots are modified to be a GATHER of syncpt incrs).
> +	 * Syncpt increments must be done inline with the pushbuffer from a
> +	 * GATHER buffer to maintain the order (slots are modified to be a
> +	 * GATHER of syncpt incrs).
>   	 *
>   	 * Note: save in restart_addr the location where the timed out buffer
>   	 * started in the PB, so we can start the refetch from there (with the
> @@ -370,12 +368,8 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
>   	else
>   		restart_addr = cdma->last_pos;
>   
> -	/* do CPU increments as long as this context continues */
> -	list_for_each_entry_from(job, &cdma->sync_queue, list) {
> -		/* different context, gets us out of this loop */
> -		if (job->client != cdma->timeout.client)
> -			break;
> -
> +	/* do CPU increments for the remaining syncpts */
> +	if (job) {
>   		/* won't need a timeout when replayed */
>   		job->timeout = 0;
>   
> @@ -388,20 +382,8 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
>   		host1x_hw_cdma_timeout_cpu_incr(host1x, cdma, job->first_get,
>   						syncpt_incrs, job->syncpt_end,
>   						job->num_slots);
> -
> -		syncpt_val += syncpt_incrs;
>   	}
>   
> -	/*
> -	 * The following sumbits from the same client may be dependent on the
> -	 * failed submit and therefore they may fail. Force a small timeout
> -	 * to make the queue cleanup faster.
> -	 */
> -
> -	list_for_each_entry_from(job, &cdma->sync_queue, list)
> -		if (job->client == cdma->timeout.client)
> -			job->timeout = min_t(unsigned int, job->timeout, 500);
> -
>   	dev_dbg(dev, "%s: finished sync_queue modification\n", __func__);
>   
>   	/* roll back DMAGET and start up channel again */
> 
