Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE9BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E402086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GqFVUc05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E402086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbeIJX1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:27:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40119 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbeIJX1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:27:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id l63-v6so10890718pga.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 11:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TpuhIeaUhNQbKwVc9NwPVFup3soxtxLfabpfaK78xf4=;
        b=GqFVUc05u7MnnZ2vGCr9whHs8yb3q2k3q6kiGIizcz+8RLP7wdRY9eEWl1+AdsXxhw
         Xlacqd3lOLJrK437ExFs1tOmCK1w3soJBOR7O/BItVemtSqYSq+d2DzAfDixaeIK16j0
         F0YbTJdR3LEy+gX9d68ULL3KK46wVOuSKvnsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TpuhIeaUhNQbKwVc9NwPVFup3soxtxLfabpfaK78xf4=;
        b=H1qFm11+gjXB/F5jsV6rkGSt46d7on7GLz/0RW/xViwGQYkhC9GTgOz4FE697r+sPF
         Cg9GRa5gihL3tae5Lv22mSEIo8nRYcmDltwMFZzINzJ9QcgKOalJwCInVCb9+aozgUBC
         IJx9+MbfwXW8XNMgJ4SqxYHhBbqx3rwgaUGe0fwkiPbEj7v9Kwxc4xoOnig3pQ7NKBPB
         hfHeveDJ0D6j6mxXT09hjZ0SNazZMrkxSpwsnR8CSfh7CEzZFOUbgVTRJgnBRoWLDZnD
         gh8vVdIFPkids/Y6/3cniWRU+w4RRIUN7XfdkL/oy/p322fwv7UcXxjHvy5WwTqikpDL
         GZbw==
X-Gm-Message-State: APzg51BNrAocTMe3HCDQfSjnMrBMspbQfK46X7fYXpeDVlr6T6lvIPT0
        u6eUjUGNaQbjWEBok+Yf60JO/FYXEUY=
X-Google-Smtp-Source: ANB0VdZfkIm5k7ZVDcmPgw+vdqWhz7kBG2AHF7BYrHnz0yLhVwFPIzsudkaaAZ4LOS2lyeZ5fkyHPA==
X-Received: by 2002:a62:c4da:: with SMTP id h87-v6mr25280355pfk.39.1536604309925;
        Mon, 10 Sep 2018 11:31:49 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 9-v6sm28208698pfc.20.2018.09.10.11.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 11:31:49 -0700 (PDT)
Date:   Mon, 10 Sep 2018 11:31:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v3 2/2] remoteproc: qcom: Introduce Non-PAS ADSP PIL
 driver
Message-ID: <20180910183147.GE2523@minitux>
References: <1535975560-8200-1-git-send-email-rohitkr@codeaurora.org>
 <1535975560-8200-3-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535975560-8200-3-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03 Sep 04:52 PDT 2018, Rohit kumar wrote:

> This adds Non PAS ADSP PIL driver for Qualcomm
> Technologies Inc SoCs.
> Added initial support for SDM845 with ADSP bootup and
> shutdown operation handled from Application Processor
> SubSystem(APSS).
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>

Thanks for the changes Rohit, this looks good.

Once we hear from DT maintainers that patch 1 can be applied I will
update the name of the file and driver as I apply it to match the naming
scheme I'm aiming for - no need for you to resend because of this.

> ---
>  drivers/remoteproc/Kconfig         |  14 ++
>  drivers/remoteproc/Makefile        |   1 +
>  drivers/remoteproc/qcom_adsp_pil.c | 500 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 515 insertions(+)
>  create mode 100644 drivers/remoteproc/qcom_adsp_pil.c
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index c98c0b2..445de2d 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -139,6 +139,20 @@ config QCOM_Q6V5_WCSS
>  	  Say y here to support the Qualcomm Peripheral Image Loader for the
>  	  Hexagon V5 based WCSS remote processors.
>  
> +config QCOM_ADSP_PIL

I will make this QCOM_Q6V5_ADSP

[..]
> diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_adsp_pil.c

Make this qcom_q6v5_adsp.c

[..]
> +static struct platform_driver adsp_pil_driver = {
> +	.probe = adsp_probe,
> +	.remove = adsp_remove,
> +	.driver = {
> +		.name = "qcom_adsp_pil",

and this qcom_q6v5_adsp".

> +		.of_match_table = adsp_of_match,
> +	},
> +};

Please let me know if you have any objections to this.

Regards,
Bjorn
