Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E6EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F68920856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuqVmREK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfAQRIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:08:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44244 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbfAQRIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:08:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so5108032pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=puECamhBYeL6uC1xKJYWEb0GT+YzCKI4Se6bf3iW8OA=;
        b=RuqVmREKCvqOcWquUeyvudqFXygPEg4CpfahXyAUZiNXwiiA5NdSy67goh+7d1wfSq
         t4kbUB0i6lnfD+s3Np97yuYtAufmAFWpBT3B8GY0yGsIK6LELzEA5/wooUBLeASAEu8i
         cqBlLxV404a1vtqtswwULTyRyDvhP2phj2PGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=puECamhBYeL6uC1xKJYWEb0GT+YzCKI4Se6bf3iW8OA=;
        b=JeRAff7n5qpZySXjz2wYOL6NzphQpPgD+CBJ84K9onLkIhON/8htBHJqCRN6QCnkzW
         sMheVZJMb7wwFTsWbnjn18DIblIDl0/k09UkhyS0SiyDaY0LRE57A7dJV5AQvO7xWj1v
         rhLJw/75J970IgQk9CxQI5aemPZiQ2hFqGAfOd22vfhWgRmV9e2OiE5DaV6G/magQkhg
         jeNqRMjrvYRXUMokohzYpvwYKQ6Xp8ddSsMQtXIMxe8EeV7yPMilL7H/guTrmQayPxNI
         VQInnxTFwGXJNpSF3EDRdR9Zf6ZZT6/kEBoFg3oH/2ZtOgApkmLJ+h9Cq72U8tGP6zYB
         1J1g==
X-Gm-Message-State: AJcUukdHP8VS95e4EbNJb4JNlI2WLjKFwBkiIBe5YPxx6czSI1cJ8wnY
        sVyNGmj8Yyvmp+AY4HtRejEp
X-Google-Smtp-Source: ALg8bN75jETmHXS8tagJlYntkucqHyFpUbsM0MGqjXjJeN8+Yj6LOZGFT0PUbnSDxgXY3g6rtMx8hA==
X-Received: by 2002:a62:e0d8:: with SMTP id d85mr15455718pfm.214.1547744918468;
        Thu, 17 Jan 2019 09:08:38 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:7344:aef4:e89a:577b:dc0a:3144])
        by smtp.gmail.com with ESMTPSA id e23sm3615723pfh.68.2019.01.17.09.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 09:08:37 -0800 (PST)
Date:   Thu, 17 Jan 2019 22:38:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/8 v4] Documentation: bindings: dma: Add binding for
 dma-channel-mask
Message-ID: <20190117170829.GJ5283@Mani-XPS-13-9360>
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
 <1547658629-25378-3-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547658629-25378-3-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 09:10:23AM -0800, John Stultz wrote:
> Some dma channels can be reserved for secure mode or other
> hardware on the SoC, so provide a binding for a bitmask
> listing the available channels for the kernel to use.
> 
> This follows the pre-existing bcm,dma-channel-mask binding.
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Tanglei Han <hantanglei@huawei.com>
> Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: dmaengine@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v3: Renamed to hisi-dma-avail-chan
> v4: Reworked to generic dma-channel-mask
> ---
>  Documentation/devicetree/bindings/dma/dma.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
> index 6312fb0..eeb4e4d 100644
> --- a/Documentation/devicetree/bindings/dma/dma.txt
> +++ b/Documentation/devicetree/bindings/dma/dma.txt
> @@ -16,6 +16,9 @@ Optional properties:
>  - dma-channels: 	Number of DMA channels supported by the controller.
>  - dma-requests: 	Number of DMA request signals supported by the
>  			controller.
> +- dma-channel-mask:	Bitmask of available DMA channels in ascending order
> +			that are not reserved by firmware and are available to
> +			the kernel. i.e. first channel corresponds to LSB.

A general assumption is, "dma-channel-mask" refers to the bit fields of
the channels which needs to be masked. But here, it refers to the channels
which are available. Doesn't it contradict?

Thanks,
Mani

>  
>  Example:
>  
> @@ -29,6 +32,7 @@ Example:
>  		#dma-cells = <1>;
>  		dma-channels = <32>;
>  		dma-requests = <127>;
> +		dma-channel-mask = <0xfffe>
>  	};
>  
>  * DMA router
> -- 
> 2.7.4
> 
