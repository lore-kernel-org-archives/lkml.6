Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0729EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EE420880
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEtvSVW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EE420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeH1EUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:20:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38444 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeH1EUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:20:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id e2-v6so353992pgv.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 17:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LG+xaxAVZ6BXc4ahO42ESt2GdbDrWYdyMj84C775p0Q=;
        b=aEtvSVW9FKlbOvpqdomWIhW3HRpHbc/1opGCDNkP2qVX76uOl/XpuBDdNJYkIKTy0Z
         sud5Xnjaykferigg1hKJOVywREPvB3DfiJ1ToITh0Vt5pvJbfnlNxSaY1jMOSlaqhBM4
         JUxsK7nwgoyAesWlnXcldQB6AGy3GlD7zktJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LG+xaxAVZ6BXc4ahO42ESt2GdbDrWYdyMj84C775p0Q=;
        b=LdwOnrH7F4cPiPu7Y/39Yw0BdER7qPlvosOSERxgR4TUKf2vC5JXZTmUrmhsShcMWb
         W7BmdzuESnZO2p1IrT7Pk6+qUR+4GL1vyaJdRAj0SF09rV29vVWj1VsZzDCf1stGOi/q
         araxrxrIdhP3xCwPlI3fYDhGfoQ7wXd2gTei60J7ayOGsuZbIBz+St5Nv3svj21j190G
         fYBBIde8MbW7NY/ts6ZjdKCl6NXuFM27oBMz+D1V47aw7i2pLqvIsIH6jjbSnnY/7IYF
         qg81Tz1YjPmO7tryYOgD4UB4ZQ/MuUbJ2cw+JbMBYXgD1OZE31nDJswXYAJg56zaAAXw
         eiqw==
X-Gm-Message-State: APzg51BaSLzFhy3/JtrlNdIQLMcLNLrmmOm+du9xuk0Fdmmt7I5TfwDK
        OQgMex0sayU8imjIQHsrt0HMsA==
X-Google-Smtp-Source: ANB0VdaWZFN33bqqjTqq4HLlyIcun/46IijwpcnpJMbHnMYFYWDhLt/bktlWS83GNP3DO9Hg36WTbA==
X-Received: by 2002:a63:bd01:: with SMTP id a1-v6mr14225192pgf.12.1535416294389;
        Mon, 27 Aug 2018 17:31:34 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u1-v6sm543858pfl.187.2018.08.27.17.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 17:31:33 -0700 (PDT)
Date:   Mon, 27 Aug 2018 17:31:31 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     marc.zyngier@arm.com, sboyd@kernel.org, evgreen@chromium.org,
        linus.walleij@linaro.org, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        andy.gross@linaro.org, dianders@chromium.org
Subject: Re: [PATCH v2 4/5] drivers: pinctrl: qcom: sdm845: support GPIO
 wakeup from suspend
Message-ID: <20180828003131.GD2523@minitux>
References: <20180824200157.9993-1-ilina@codeaurora.org>
 <20180824200157.9993-5-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824200157.9993-5-ilina@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24 Aug 13:01 PDT 2018, Lina Iyer wrote:

> Enable TLMM IRQs to be sensed by PDC when we enter suspend. It is
> possible that the TLMM may be powered off and not detect GPIOs that are
> configured as wake up interrupts. By hooking into suspend callbacks, we
> allow PDC IRQs to take over and wake up the system if wakeup interrupts
> are triggered.
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-sdm845.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> index 2ab7a8885757..cc333b8afb99 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> @@ -1297,10 +1297,16 @@ static const struct of_device_id sdm845_pinctrl_of_match[] = {
>  	{ },
>  };
>  
> +static const struct dev_pm_ops msm_pinctrl_dev_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(msm_pinctrl_suspend_late,
> +				     msm_pinctrl_resume_late)
> +};
> +

I expect these four lines to be duplicated in every platform file, so I
think it would be better to just move it to pinctrl-msm.c and extern
declare it in pinctrl-msm.h.

>  static struct platform_driver sdm845_pinctrl_driver = {
>  	.driver = {
>  		.name = "sdm845-pinctrl",
>  		.of_match_table = sdm845_pinctrl_of_match,
> +		.pm = &msm_pinctrl_dev_pm_ops,
>  	},
>  	.probe = sdm845_pinctrl_probe,
>  	.remove = msm_pinctrl_remove,

Regards,
Bjorn
