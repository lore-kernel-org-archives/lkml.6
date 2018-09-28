Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BCDC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 03:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC82B2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 03:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rbie0ww9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC82B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeI1Jb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 05:31:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32983 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1Jb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 05:31:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so3294433pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 20:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x5DIO/nvJ2SKgrClBKp2o3+r3WybOx5GKYUkQ2GGUfo=;
        b=Rbie0ww951CD9pz62jMI67lRz47uZd92rynnsUWU08Zrd77B+9K20M0Gauu29hJRnV
         lHIf2PoKZV/pgAwWjgigENfC2rAg1eSd9CRmt1PIcPOJ+mFm3aYRQsL/yegDjigDk1O0
         wHmQt66xysD/0AkDNwVIbWPG1/+evVi3MuWoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x5DIO/nvJ2SKgrClBKp2o3+r3WybOx5GKYUkQ2GGUfo=;
        b=BHVrgmq0KjDbcrfgmH/W2x1t0ssTQcxQ+RbSOFCrIAamC3NOwuIbiPV1FghT6UWtJv
         tlW+QnRa6aOvy7m083WCK+Bco7kgayidiyY4hmeZt7ls37qArvyNEDH007Ffuky+yZMp
         DmG1c3EKDwgO2ya/GQ54k+Yr1fgaYfSfDpgiK8skhHilc5gMTdiOAa/tovd/hnkT5kwP
         0GV01OD5HxZ/2DjIeMam/dzhUAMxBvj7kTuzb5bPAZNVDv+hiXC2T+iziEAOm6m4w3Bt
         vpeciFicii/i2j4iWso5oFlEVAq4jcYum2oE40ezF2vRtt0btT7gTUacfRmX93H4poTX
         Hagw==
X-Gm-Message-State: ABuFfohQt1Dj2tFNXPpuShVo94l4+dfU2pamkZa8zRh/MJchTRWAgpyi
        PA0ipskc2blMG/GJog99kcTXy5hO+kMUUw==
X-Google-Smtp-Source: ACcGV62lvOMV0WyEvGBHcPbzmPznvy6082sAd36J+0NGJmhB2CDWa+Rw9sArVMBGB57aS+2UGIzzlw==
X-Received: by 2002:a63:a047:: with SMTP id u7-v6mr13171020pgn.145.1538104195460;
        Thu, 27 Sep 2018 20:09:55 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v26-v6sm4975374pfe.57.2018.09.27.20.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 20:09:54 -0700 (PDT)
Date:   Thu, 27 Sep 2018 20:12:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpmsg: fix memory leak on channel
Message-ID: <20180928031226.GB29702@builder>
References: <20180927213627.12752-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927213627.12752-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27 Sep 14:36 PDT 2018, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently a failed allocation of channel->name leads to an
> immediate return without freeing channel. Fix this by setting
> ret to -ENOMEM and jumping to an exit path that kfree's channel.
> 
> Detected by CoverityScan, CID#1473692 ("Resource Leak")
> 
> Fixes: 53e2822e56c7 ("rpmsg: Introduce Qualcomm SMD backend")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Added Cc: stable and applied.

Thanks,
Bjorn

> ---
>  drivers/rpmsg/qcom_smd.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
> index 0dae7c9f4a8f..4abbeea782fa 100644
> --- a/drivers/rpmsg/qcom_smd.c
> +++ b/drivers/rpmsg/qcom_smd.c
> @@ -1122,8 +1122,10 @@ static struct qcom_smd_channel *qcom_smd_create_channel(struct qcom_smd_edge *ed
>  
>  	channel->edge = edge;
>  	channel->name = kstrdup(name, GFP_KERNEL);
> -	if (!channel->name)
> -		return ERR_PTR(-ENOMEM);
> +	if (!channel->name) {
> +		ret = -ENOMEM;
> +		goto free_channel;
> +	}
>  
>  	spin_lock_init(&channel->tx_lock);
>  	spin_lock_init(&channel->recv_lock);
> @@ -1173,6 +1175,7 @@ static struct qcom_smd_channel *qcom_smd_create_channel(struct qcom_smd_edge *ed
>  
>  free_name_and_channel:
>  	kfree(channel->name);
> +free_channel:
>  	kfree(channel);
>  
>  	return ERR_PTR(ret);
> -- 
> 2.17.1
> 
