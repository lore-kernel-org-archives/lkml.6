Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B985C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE5A20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CF2qB4+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388650AbeLQSQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:16:39 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37590 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeLQSQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:16:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so4993088pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UEae6SeL9V7jRXcpTeUQ0gkjdR2BbKXQwwXbdAYpaZo=;
        b=CF2qB4+sCzfoSEvJAOKuyawtBgiMNcXdvTdt4qOZNwzSqpt3/c8793ganPsUCOM0H9
         Pw37EulVZbHwwssRGMPy+bOuiS7esCvnt/7BoOfmTsocoBp9fq/vQYDSfxM1B+Zpwmn8
         mWo5rKNThdksIdqmIKl5t4AgUllUpA8k0zWdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UEae6SeL9V7jRXcpTeUQ0gkjdR2BbKXQwwXbdAYpaZo=;
        b=bXge/Sy3/rey+FnE4t+5gSf2FSlqlpbBEr8VqeEmDh61ZBoy3vZccyxOC/HR5ZusUT
         HPEUrs9rV/X9xsn+CD3BPXZfwlOsXiw0ySRBQSkEY8V0Vevyjyp8k5Dq8jOJ1liDfABe
         KvR1TcYfeVkTc5URVFpTEmGoi7drclTGDfgK1LkmE223xlqbJrBDc+HWm+k3vMjq5kc9
         XFzEmiPp+bAIoZKW2H4Vo3MQX2goq/J68yglqyiXVdZHHWitSmDMdxcXeZLXT6HFjoBN
         8OECgUlMyaSMo3Nmd7Y1LaFc8x1q+obYwen+AKyVP/AttbM6OtXlsqI6wCTynXWMxJ0n
         yR3g==
X-Gm-Message-State: AA+aEWa1le780jDMp+Tyg2nt+tO2Mm/A6J+6NziDO3DzqxwD5fpRyMg9
        ebFV+mku8nJ6R3OU/SEPM7m3pg==
X-Google-Smtp-Source: AFSGD/WpY6yPewO+K4kAA2Dzw0KfOK+JLE9MCA/0AxFZN/ZwcebzUckXb270Ft4KcYY3SEEVkleHwA==
X-Received: by 2002:a62:f247:: with SMTP id y7mr13726811pfl.25.1545070597068;
        Mon, 17 Dec 2018 10:16:37 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w10sm15388584pgi.81.2018.12.17.10.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 10:16:35 -0800 (PST)
Date:   Mon, 17 Dec 2018 10:16:33 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v2 16/19] mailbox: qcom-apcs: Use device-managed
 registration API
Message-ID: <20181217181633.GD12886@minitux>
References: <20181217150217.32435-1-thierry.reding@gmail.com>
 <20181217150217.32435-17-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217150217.32435-17-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Dec 07:02 PST 2018, Thierry Reding wrote:

> From: Thierry Reding <treding@nvidia.com>
> 
> Get rid of some boilerplate driver removal code by using the newly added
> device-managed registration API.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Cc: Georgi Djakov <georgi.djakov@linaro.org>
> Cc: Sibi Sankar <sibis@codeaurora.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index aed23ac9550d..3cf2937be149 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -91,7 +91,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
>  	apcs->mbox.chans = apcs->mbox_chans;
>  	apcs->mbox.num_chans = ARRAY_SIZE(apcs->mbox_chans);
>  
> -	ret = mbox_controller_register(&apcs->mbox);
> +	ret = devm_mbox_controller_register(&pdev->dev, &apcs->mbox);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register APCS IPC controller\n");
>  		return ret;
> @@ -115,7 +115,6 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
>  	struct qcom_apcs_ipc *apcs = platform_get_drvdata(pdev);
>  	struct platform_device *clk = apcs->clk;
>  
> -	mbox_controller_unregister(&apcs->mbox);
>  	platform_device_unregister(clk);
>  
>  	return 0;
> -- 
> 2.19.1
> 
