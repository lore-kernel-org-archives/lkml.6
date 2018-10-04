Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C4FC00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBA6213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPPsGfXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBA6213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeJDGyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 02:54:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33949 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeJDGyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 02:54:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so2458013pfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 17:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S4vGGkCwhf8/MaME1La4b4mfOsAlD6XQqFqX9USLO7Y=;
        b=aPPsGfXSXEZIH24bOO6hbuk0K3VQOp/5GjOkta8Yuv13dmlSnRfzeBuBI8A6P4pJ35
         iuw+RPlIKqEZEgr4r3Wc8x3QJfRmyfqIKjofAN0QdglM82aQCAz2zeEYnx4k4PqUV8CF
         0YLrtOWth87bHCwTcD4P+UfIYeYwBd+MERIYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S4vGGkCwhf8/MaME1La4b4mfOsAlD6XQqFqX9USLO7Y=;
        b=kZarv2jTmkYsM534OMgLEtsTEExZ9/7qIqOsvioOyhULAjZ/eK/F9lpi9MFAsF7yDq
         1veWxPozWyzgK9t4Db37jbEAnon32Q2NIkD2/WEFFN+nacOr1QUgwbLHVsd/wdwmXvl6
         vK3XkH+VCzBr64DTdTClkyNuW8qI0yfD0fduU7nbBahcBoHUVKp4JjV5Gv3PE8+2gl//
         SGMH959F1Pth+FLtfvvBDauJRfcg+AnXlcqFUkO1Krk2cxr9jRRLiumUGdPVFuR+8qUX
         WR7ilwG86GcQsbXMkjAdg4jqocaroqFzK4Fsz3Bm3mnbfj34tkyjQ+aXJyg6BtaNkcIS
         7PnA==
X-Gm-Message-State: ABuFfoj4LXEVCP/6IPK1qzib3xsB+MKQn5qWJ/bHGQQYBD10fuZzA3zo
        nD1sY1yqqmCDxe8LoyxdRGGltOJ0Vot9Dw==
X-Google-Smtp-Source: ACcGV60N39FUfx/qPEdCD5QbTHPUZdzZcGkpRQKvmWcQmb1HBwQChsqes0pH3OACNDcdjCXfSzLhyw==
X-Received: by 2002:a62:fcd8:: with SMTP id e207-v6mr3950567pfh.132.1538611407306;
        Wed, 03 Oct 2018 17:03:27 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q24-v6sm4602733pfi.165.2018.10.03.17.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 17:03:26 -0700 (PDT)
Date:   Wed, 3 Oct 2018 17:03:24 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>
Cc:     ohad@wizery.com, clew@codeaurora.org, sricharan@codeaurora.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpmsg: glink: smem: Support rx peak for size less than 4
 bytes
Message-ID: <20181004000324.GT2523@minitux>
References: <1538566700-29469-1-git-send-email-aneela@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538566700-29469-1-git-send-email-aneela@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03 Oct 04:38 PDT 2018, Arun Kumar Neelakantam wrote:

> The current rx peak function fails to read the data if size is
> less than 4bytes.
> 
> Use memcpy_fromio to support data reads of size less than 4 bytes.
> 
> Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>

Applied, with a fixes tag and Cc stable.

Thanks,
Bjorn

> ---
>  drivers/rpmsg/qcom_glink_smem.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
> index 2b5cf27..7b65443 100644
> --- a/drivers/rpmsg/qcom_glink_smem.c
> +++ b/drivers/rpmsg/qcom_glink_smem.c
> @@ -89,15 +89,11 @@ static void glink_smem_rx_peak(struct qcom_glink_pipe *np,
>  		tail -= pipe->native.length;
>  
>  	len = min_t(size_t, count, pipe->native.length - tail);
> -	if (len) {
> -		__ioread32_copy(data, pipe->fifo + tail,
> -				len / sizeof(u32));
> -	}
> +	if (len)
> +		memcpy_fromio(data, pipe->fifo + tail, len);
>  
> -	if (len != count) {
> -		__ioread32_copy(data + len, pipe->fifo,
> -				(count - len) / sizeof(u32));
> -	}
> +	if (len != count)
> +		memcpy_fromio(data + len, pipe->fifo, (count - len));
>  }
>  
>  static void glink_smem_rx_advance(struct qcom_glink_pipe *np,
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
