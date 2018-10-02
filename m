Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE47C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050AC20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsBpUpDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050AC20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJBKiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:38:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43811 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbeJBKiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:38:50 -0400
Received: by mail-io1-f65.google.com with SMTP id y10-v6so835001ioa.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 20:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S5Qn4eY3fygW7wkPHVbgk8n3XSg5k+LU9kWlJNHV6nY=;
        b=AsBpUpDT9Jx5WBfX5qPzCuinOHU1KL76EqGShECdWB6Bkm37wqYw/umzeBrlpHlNrY
         wpkJTUTTaU4OCfaiAB46fpqw/9z/AbO+E74wsPoLEMf5Jj2+SVg8Wu2NmI1h01GRI2xh
         JKspA0ThEt+k303RB2oUXgDkFCr0k/SuSpwzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S5Qn4eY3fygW7wkPHVbgk8n3XSg5k+LU9kWlJNHV6nY=;
        b=d9Cwz+ezFH/6yI7ptpwhUk5qFXtiWLHgA1MWiIaTwZrEz3LGKjtyN9iLxy47v9RFTi
         qbJK0zMfRLuuleXOijJqFbl7sVJHzfsw9eDIjt2Qw4l89k+t8lWdKUgAAZm3xQrnM5Fa
         yFQasCj4mPlOrOFYCWZqEEHUEV/30LDq1k06zLFgZBzBC3aoRgh1miQPsnT8izdnPe7d
         eerOEjxVNnRQRDUEN/O+N+ZtQaeRIIhc7sZpbr7yuRHsfHAV7sAyq3SHCjN/BoNCjfRj
         4KE4dUe8jAsdT4Xs/m2ldOwDQ1llLVGlywpby11nctr8jhIwFvfcpehw9omaQ/ePeBrN
         87QQ==
X-Gm-Message-State: ABuFfogYfVgJzYpmYg6KabMJgN9RHlRqnSYTmexR0Uw6kpJtSv0SLxF0
        +Ave+pGkEfHrdTYwXJpiVPLpMg==
X-Google-Smtp-Source: ACcGV63Dd09OA5DJd77oRzgLsMTiPQcTs7gUkn55nZcu9XAIpQkrKouvEGWHQi6EzN6Mh5ExD6bYgQ==
X-Received: by 2002:a17:902:7887:: with SMTP id q7-v6mr14737397pll.111.1538452663043;
        Mon, 01 Oct 2018 20:57:43 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g3-v6sm18827417pfi.9.2018.10.01.20.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 20:57:42 -0700 (PDT)
Date:   Mon, 1 Oct 2018 20:57:40 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        elder@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slimbus: ngd: QCOM_QMI_HELPERS has to be selected
Message-ID: <20181002035740.GD5008@tuxbook-pro>
References: <20181001101116.27281-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001101116.27281-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Oct 03:11 PDT 2018, Niklas Cassel wrote:

> QCOM_QMI_HELPERS is a hidden kconfig, so the proper usage is
> to select it, not depend upon it.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/slimbus/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
> index 9d73ad806698..9cca2c3559f2 100644
> --- a/drivers/slimbus/Kconfig
> +++ b/drivers/slimbus/Kconfig
> @@ -22,8 +22,8 @@ config SLIM_QCOM_CTRL
>  
>  config SLIM_QCOM_NGD_CTRL
>  	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
> -	depends on QCOM_QMI_HELPERS
>  	depends on HAS_IOMEM && DMA_ENGINE
> +	select QCOM_QMI_HELPERS
>  	help
>  	  Select driver if Qualcomm's SLIMbus Satellite Non-Generic Device
>  	  Component is programmed using Linux kernel.
> -- 
> 2.17.1
> 
