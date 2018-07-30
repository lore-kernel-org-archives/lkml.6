Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED70213F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBA320893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PmlEwMvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBA320893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbeG3P2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:28:51 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36000 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeG3P2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:28:50 -0400
Received: by mail-yb0-f196.google.com with SMTP id s1-v6so4762479ybk.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 06:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SML2G7RTOTZqKH0dkx+Iv6c16HuKgzwcwcZ1rdvBB8o=;
        b=PmlEwMvzQQkv8afdOEXOrhPoFB3Os9xZcFtly0s7fhziRyBTnPtsx7nBLhJWg3UNP5
         FZI+34dUtfiCAS2M3FLX+4BsmRiI/FXLlNAUaaZ3k7booCbBH6ftw41DK711FiWixnjF
         1Nk6pC7rUEgPV/hThOQD2lYdHZn3cXnB27Cyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SML2G7RTOTZqKH0dkx+Iv6c16HuKgzwcwcZ1rdvBB8o=;
        b=gO9eorGWnjnZps0cp3hVxcBRXLYlNDiwjs4nIM67eQilSQM7RapQ4LZlmSXBwHMJI4
         p7ZI+ci6lFH2Ez76b1USEVhqFAI3hoZu7q0MShkS4qLAl6hm6yJiWybGHZe3seGzgcOw
         27rVOD3ItFmrh3rSkSFpkyWWa7gfvPyg0ErR2f5brcH+nBNzJ1EM5XayYpHQdhEklje0
         UJSx3hiAI+nsoWGhlIFjVHwo+TYMCm21LpaZHKRkTVPh0YOuHcf96JdjBHtbyR+Yq8C1
         T3I5zG3zoS9HvB0ssg8agujrdVUvSs6q92BmDiu4q1fFYdrOf494wKK5GdrMd3eH76r6
         Gh+g==
X-Gm-Message-State: AOUpUlE6+wZeMyjXDd65UtFaDzqkOhmKMwwzUzXybj/groYNmLp9lfJE
        dU7uP02kAHeXmhBllaGOw4aRlw==
X-Google-Smtp-Source: AAOMgpf1Gibf18Uv9G+kgLw0VkXwoVOERrDOrrkTG1vVduSKN/+w9wVUJtzysKER3zbadJSs+oPnlQ==
X-Received: by 2002:a25:6e0b:: with SMTP id j11-v6mr9240247ybc.388.1532958824141;
        Mon, 30 Jul 2018 06:53:44 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id o62-v6sm4043313ywf.109.2018.07.30.06.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 06:53:43 -0700 (PDT)
Date:   Mon, 30 Jul 2018 09:53:43 -0400
From:   Sean Paul <seanpaul@chromium.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][drm-next] drm/msm/disp/dpu: fix two spelling mistakes
Message-ID: <20180730135343.GC20303@art_vandelay>
References: <20180730134446.8567-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730134446.8567-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 02:44:46PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in error messages
> "diable" -> "disable"
> "cliend" -> "client"
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c      | 2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 0bd3eda93e22..0922d3536412 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -421,7 +421,7 @@ int dpu_encoder_helper_unregister_irq(struct dpu_encoder_phys *phys_enc,
>  
>  	ret = dpu_core_irq_disable(phys_enc->dpu_kms, &irq->irq_idx, 1);
>  	if (ret) {
> -		DRM_ERROR("diable failed id=%u, intr=%d, hw=%d, irq=%d ret=%d",
> +		DRM_ERROR("disable failed id=%u, intr=%d, hw=%d, irq=%d ret=%d",
>  			  DRMID(phys_enc->parent), intr_idx, irq->hw_idx,
>  			  irq->irq_idx, ret);
>  	}
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c
> index a68f1249388c..a75eebca2f37 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c
> @@ -121,7 +121,7 @@ void dpu_power_resource_deinit(struct platform_device *pdev,
>  	mutex_lock(&phandle->phandle_lock);
>  	list_for_each_entry_safe(curr_client, next_client,
>  			&phandle->power_client_clist, list) {
> -		pr_err("cliend:%s-%d still registered with refcount:%d\n",
> +		pr_err("client:%s-%d still registered with refcount:%d\n",
>  				curr_client->name, curr_client->id,
>  				curr_client->refcount);
>  		curr_client->active = false;
> -- 
> 2.17.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sean Paul, Software Engineer, Google / Chromium OS
