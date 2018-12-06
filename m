Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77F6C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FE220700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="V/zng8ND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FE220700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbeLFQLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:11:12 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45593 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeLFQLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:11:11 -0500
Received: by mail-yb1-f195.google.com with SMTP id f6-v6so780045ybg.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZVjFzdeUXTgNLHquDUo2XfcnHZOoJYMKCPXqPHJz1VI=;
        b=V/zng8NDTWO6WD+6iHM/Axl91eOWwwSI4dEmF4BltI8NuPxlKavDf1MKd9NaXsCtti
         VOGTeAJMS1SsLNpsHNNAuZhiSo9hM4/bV0P3ln2Mn+84yN11ExNpvWPEnJZwXyUsgOD5
         w+4WKrcyl5Vjn8NAJ5ytlhUAXLhjcA+ict9qmQjcYxe87Y8KiaNC4Sbc32ojXQeSQ8Sg
         4bNLcFg9hGSBmGPYdsyB3o1suEuaPw1cLcY/fYVww8SV+8mAR/5C4UbIAZ+UIghTS2th
         NYCzm/y9Eft+byzzZuFobkwKvx6NJeYVBNdqjFieD6wAJEfhiT0gfBr50rX9E9is9lfu
         vYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZVjFzdeUXTgNLHquDUo2XfcnHZOoJYMKCPXqPHJz1VI=;
        b=AAV8Twr9qpHheBHLJ7ES73hbvksZyzGToSNmiWtMv4qGXwDs0A1OHORsrcPc8FDmDs
         P6FsPOjsj5e+ldYgsH4duJ6VI7pj2O0tASctbOJL9WtkcTXAgQu0VnDL0kDP6wM+K2tQ
         DF+nLdzlW5jHhp3Q74szA2DUdMM6CwlHrSWw3tk7/JARmtCeghi76atICsUJKgKCPzSv
         ZKEXhtAgQdi8+JVGkBWFdddk24lT4qUR3yekf7ymXY77l24wrE7/lYcX21d8f0ZC0NNw
         +HipaHwLSfv97n1qLOFO+rSlj+ODKLVBvqyUaoCaLChUUW667PvrXHdtCG3MwLxTkx5t
         F1qw==
X-Gm-Message-State: AA+aEWbJwdpbpbUxgnwPs9304+FNMU+Xr6QG2Fi5JX8nEBNQaiWSfWoJ
        Cvb4Cg3dLN8m5iKnevnwue5FCw==
X-Google-Smtp-Source: AFSGD/UV6OpVfPHxzGnzN6KuYpCNk9FVX/jgAax/OQZ611dlTV5O4cypCT77XN6+hN9udU8ZI90kOA==
X-Received: by 2002:a25:cd04:: with SMTP id d4-v6mr27377060ybf.189.1544112670926;
        Thu, 06 Dec 2018 08:11:10 -0800 (PST)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id x9sm530671ywc.8.2018.12.06.08.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 08:11:09 -0800 (PST)
Date:   Thu, 6 Dec 2018 11:11:09 -0500
From:   Sean Paul <sean@poorly.run>
To:     Jayant Shekhar <jshekhar@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org, nganji@codeaurora.org
Subject: Re: [DPU =?iso-8859-1?Q?PATCH=A0?= =?iso-8859-1?Q?=5D?= drm/msm/dpu:
 Fix clock issue after bind failure
Message-ID: <20181206161109.GZ154160@art_vandelay>
References: <1544026907-24267-1-git-send-email-jshekhar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544026907-24267-1-git-send-email-jshekhar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 09:51:47PM +0530, Jayant Shekhar wrote:
> In case of msm drm bind failure, pm runtime put sync
> is called from dsi driver which issues an asynchronous
> put on mdss device. Subsequently when dpu_mdss_destroy
> is triggered the change will make sure to put the mdss
> device in suspend and clearing pending work if not
> scheduled.
> 
> Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>

Thanks for sending this, pushed to dpu-staging/for-next

Sean

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> index 2d66025..030229a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> @@ -191,6 +191,7 @@ static void dpu_mdss_destroy(struct drm_device *dev)
>  	struct dss_module_power *mp = &dpu_mdss->mp;
>  	int i;
>  
> +	pm_runtime_suspend(dev->dev);
>  	pm_runtime_disable(dev->dev);
>  	_dpu_mdss_irq_domain_fini(dpu_mdss);
>  	free_irq(platform_get_irq(pdev, 0), dpu_mdss);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
