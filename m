Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437E6C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC2222392
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="alFipxpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC2222392
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeHIXfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:35:02 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33830 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeHIXfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:35:02 -0400
Received: by mail-pl0-f67.google.com with SMTP id f6-v6so3070863plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 14:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1fKdxoxxdV/FT/NyjARNS5Qv606dFkoOz+jjRw+rK6E=;
        b=alFipxprlnVEoxiR6koNXVrZQgPxpJUgusmqow95R9T/dQjPy0M2+2Cj2+90EwKZ8U
         dK6/xEob4kxV6yYlN4ahUtmT2LKPUd9E7FQOpXOnjmI5nGT06lSwVYuPc9Bfru+gHdQE
         bG9IbMa4w9i/1wqSy1MgkXl2nIbYwVMSDF/zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1fKdxoxxdV/FT/NyjARNS5Qv606dFkoOz+jjRw+rK6E=;
        b=tOhtfU1umnvqOW5dTsiySvhp+2sozNrbkIFGCD0aJVn9deZwLfcsOP/CUkLTYzWUmb
         B/Uu8BTFpMH/HSYU3Smg1YxkADPbKU8Sk13E9LupGVBDrPh8lAJsX1wBCRKMUNjg8tYv
         1DxliRvoQU+tQ/oIpoXsIGG9dxiDIctDtne411E4l4dml12VLLTC5/TgEiVCazRjdiNt
         ymUMPxgFhM55xZzTrhOqfA3v2yMA7dMYntyM+9WQOAfVhin0vxKh1K1Z5jHIKTkedB6n
         AlO7buzEDEmmSDPOUTtPE0GaDr7abWp9L77SdBA5RgkKHu680kAcyc20obQSY5ZdF5LX
         F7ng==
X-Gm-Message-State: AOUpUlFY0g+U9PiwtIbJX3RjuUEMp0hIqEjWLxpaNeVfOqJJdJThiNAU
        nFhb2Yy76qZxO2hsKPvWl0KPcw==
X-Google-Smtp-Source: AA+uWPz80E+OrVMzYcQqzR1xqb4IgJui05FPcTGnhRC5kXSf/GyIqVfyLdSktr/C97tEqUY6XT1sJg==
X-Received: by 2002:a17:902:7883:: with SMTP id q3-v6mr3388030pll.264.1533848905320;
        Thu, 09 Aug 2018 14:08:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id s14-v6sm23718935pfj.105.2018.08.09.14.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 14:08:24 -0700 (PDT)
Date:   Thu, 9 Aug 2018 14:08:24 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 10/10] MAINTAINERS: Add entry for Qualcomm TSENS
 thermal drivers
Message-ID: <20180809210824.GR160295@google.com>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <106a459af3882745e78cb9b774dcfda08a96a6dd.1533815718.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <106a459af3882745e78cb9b774dcfda08a96a6dd.1533815718.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:02:42PM +0530, Amit Kucheria wrote:
> Create an entry for the TSENS drivers and mark them as maintained
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 68b4ff8ed205..ca6183d6d545 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11862,6 +11862,13 @@ L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/iommu/qcom_iommu.c
>  
> +QUALCOMM TSENS THERMAL DRIVER
> +M:	Amit Kucheria <amit.kucheria@linaro.org>
> +L:	linux-pm@vger.kernel.org
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/thermal/qcom/
> +
>  QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
>  M:	Stanimir Varbanov <stanimir.varbanov@linaro.org>
>  L:	linux-media@vger.kernel.org

FWIW:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
