Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B35EC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B49213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vywm7SB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B49213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeJINgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:36:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34584 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeJINgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:36:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id f18-v6so295779plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 23:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nzzWG5/SdBIPBCDcDwPJnGCGHVCSmiEELi0eih6ejck=;
        b=Vywm7SB8Ixz7ZN5PNoIPEjlGRuT+3svh9sJihFMbNjZPG+f/wZEp0V/iOUfGmjYVca
         7NiAYRvzMqF2TPkw9BgFBG0aF44fM7Z6va9iCgFFHWS88+eZxQFY4a1snfGZ1w8GHY8r
         qMYpNg7IRKmxe2/89Ii+g6s4UXtugPiMgZq/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nzzWG5/SdBIPBCDcDwPJnGCGHVCSmiEELi0eih6ejck=;
        b=MUxuCcFqKimO54R2bqCOUjEAC2rXlINxIijxxoRqQEWJXZlloMKK6r28d1A/hVKgVO
         SbIlN71nm59f/1VinXT/KE05lQLBRlwoE5fyg/jkp4FzMEJ4o85CIksksQjuEUn6NRSS
         R1cC/s1g9k847scw1QM4N5Dk7quani5wTNu79Vr6cOINy4xaXiO7ghxkII2OFOk3FBnT
         t720DuihiL1wuJFtUk6fvW6/Iv8XVoMU1YGJx7t1FhalBXWQWRhyozBMJXJQY6Iz/O1L
         7YSO6IOLeUG8O/kxaiKLv2hW7myvrj8FLkQEdw/4I+rbnDpdRjYYI0jUNU8x1ZgX5Wwy
         a6/Q==
X-Gm-Message-State: ABuFfoggXQfrxAlM/8R9K8+fOoLSweh3FyOJy/ATwLgLAbivIFGJXBYO
        +kWoSJRZ5LGdRgMVbhATxiyQ5PoQhlYgrw==
X-Google-Smtp-Source: ACcGV62HCsR9q6rF+ANyC7pEfY3cEmTs9XlwENkSH+iNjDXy8IzZS7isgblzngFcvFxcsDa53pRsvw==
X-Received: by 2002:a17:902:33c2:: with SMTP id b60-v6mr27148905plc.105.1539066089100;
        Mon, 08 Oct 2018 23:21:29 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k185-v6sm7924523pgd.2.2018.10.08.23.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 23:21:28 -0700 (PDT)
Date:   Mon, 8 Oct 2018 23:21:25 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: q6v5-pil: add SCM probe dependency
Message-ID: <20181009062125.GA2518@tuxbook-pro>
References: <20181009020805.143982-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009020805.143982-1-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08 Oct 19:08 PDT 2018, Brian Norris wrote:

> Similar to qcom_q6v5_pas and qcom_wcnss drivers, probe will fail if SCM
> is not up.
> 

Thanks Brian, this dependency was introduced with the memory ownership
support.

I applied it with an updated conditional to make it explicit that it
related to need_mem_protection, updated the commit message to describe
actual relationship to the memory protection mechanism and added a
Fixes: tag.


Don't we also need to add the ability to disable need_mem_protection
when we're running ATF?

Regards,
Bjorn

> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index a839b07a58b1..8836ca1bc0c1 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -1151,6 +1151,9 @@ static int q6v5_probe(struct platform_device *pdev)
>  	if (!desc)
>  		return -EINVAL;
>  
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
>  	rproc = rproc_alloc(&pdev->dev, pdev->name, &q6v5_ops,
>  			    desc->hexagon_mba_image, sizeof(*qproc));
>  	if (!rproc) {
