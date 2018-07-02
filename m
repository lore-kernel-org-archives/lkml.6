Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72602C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE2925230
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGeuGw2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE2925230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeGBGd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 02:33:57 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38164 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753465AbeGBGdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 02:33:55 -0400
Received: by mail-pf0-f193.google.com with SMTP id j17-v6so7008570pfn.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 23:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=alTePAsm5rvwZ6RMQFYt1QbTavgWLkXAOYlcUJeLxEc=;
        b=AGeuGw2+a51h0kKOBJNaSgoO3RnA7ev4T0x6Id+KPzenmWXM5X46ZCkfhXGLYT3Qac
         w43p/+ME/6R1yUdb7LwqMCya5Rejb5/5RMMHNvT4FMqh/3FrFeaXGo87T9XYEmMx8Ahh
         J6Clxxtk8clr0nBrvPqJmdF1QgTdXYBMR8kfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=alTePAsm5rvwZ6RMQFYt1QbTavgWLkXAOYlcUJeLxEc=;
        b=evcxF6v77D4UVygvm1w1UtPhBpznHCEpTgIaL/Bnshu6jKh35AFmBUaxNRpKc3kXAI
         T0hDT1aMvFqDZCc3vRiXTmR2y38d4ZNGug5ZYUjsXhS9eE/YRoHeFDaGuXiHlk2DJdvv
         gCWQIm7Lakfhi1K3kHk/hGx7f/Di+3eDo6Krf/Ey7qsom1OYKpodQL369DubZyYYQgHI
         gyhTOpahwZzfIqrm1IL0u70MbEb3/6OXg9inJ48jI61tvsy2N6z6pgM+Ifh2SL9q/A6h
         Zx/2d98tM+gmHZd4RA3s3wz5g+d81GwadMbWi+yN8cXixCJUP3AJ/odWU4yTa0K/LtG/
         Ffpw==
X-Gm-Message-State: APt69E0Wh5u+ngfeTXyasKRhfkWYitcn/aKULLfNzUYzjzKVyR60Bkzz
        UPmaV8FPTLFto+gV8e5svuSt6Q==
X-Google-Smtp-Source: AAOMgpcQKSbpaxoltpo2bKfNWMFfLxhJYxZoYF8Y7cslHgxJ6tpBGcxnYMVD7krHJWNsGORnwOBPog==
X-Received: by 2002:a62:b90f:: with SMTP id z15-v6mr24385435pfe.254.1530513235197;
        Sun, 01 Jul 2018 23:33:55 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k186-v6sm38297784pgk.94.2018.07.01.23.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 23:33:54 -0700 (PDT)
Date:   Sun, 1 Jul 2018 23:33:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpmsg: smd: Add missing include of sizes.h
Message-ID: <20180702063351.GA21402@builder>
References: <20180629170101.16255-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180629170101.16255-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29 Jun 10:01 PDT 2018, Niklas Cassel wrote:

> Add missing include of sizes.h.
> 
> drivers/rpmsg/qcom_smd.c: In function ‘qcom_smd_channel_open’:
> drivers/rpmsg/qcom_smd.c:809:36: error: ‘SZ_4K’ undeclared (first use in this function)
>   bb_size = min(channel->fifo_size, SZ_4K);
>                                     ^~~~~
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Applied

Thanks,
Bjorn

> ---
>  drivers/rpmsg/qcom_smd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
> index 6437bbeebc91..8695cb041c31 100644
> --- a/drivers/rpmsg/qcom_smd.c
> +++ b/drivers/rpmsg/qcom_smd.c
> @@ -14,6 +14,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/sched.h>
> +#include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/smem.h>
>  #include <linux/wait.h>
> -- 
> 2.17.1
> 
