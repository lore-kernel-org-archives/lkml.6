Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C125C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1385B20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JwwLVwmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1385B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJDVUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:20:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38833 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeJDVUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:20:08 -0400
Received: by mail-io1-f67.google.com with SMTP id e2-v6so6357978ioh.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e3oUToljdNg4jFKh8IeKwQuDeOdbxIh2CueesadUMDs=;
        b=JwwLVwmvBf0ZEUEuA04qfPqOoFblUAKpUctfuh//YCiVGIwhzMphoBMK7Jd/YtiZM6
         pPoEGISaUr5Ov9heXAZmt4oNpl2xVb4iv5aX5Iv9aEqhsFE6tFKniESei/67o5vRn8yf
         ukv2G1wA46mv7aQd7PJhAVhsjSwGnc8R7lN5yjCUtVaZRxWvVBiMoPpkBwU4T0ummtii
         XFHdxnzsWQ966xJz8hYszDbnrQDdLXiETsSnHLTxtdNyBf26UqPUUEilWhOIoECbYMCG
         Nwv+KpYC3VdWHjlEl1H5f7gydZ/FmUqu9q/cspelYPltUdaIvWPwnN6GWb+GYkn5JlFV
         NOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e3oUToljdNg4jFKh8IeKwQuDeOdbxIh2CueesadUMDs=;
        b=LAGMivVuna41eXbtx2y3LD5ZIPko7OlSslQxjuKfS2LGVA5aP7SCm1kO0TsBO9/Zt6
         a/jnTrcROiMHuXNTLAGRx1dBM3VrotwVPR2t2hpphzNsPU04QgkPoNjaEIhLLEJ4scXo
         xcbSaMtwWhVKGJQ3k4mgMeo8H5X0tLrCSep3r0qJ76Csj2yr/cfDGs6NvZUfym0NGexm
         faVYXyiw/L7E+gUocFmVXbMrY8b4or1oCkFXcxBoY74pFUmXNwj0xqdmCE3FkSaJsu2B
         iS3SaI2CToT71zm4wUm2VTt15yL3BnO3lP9nhZoAkVt1aRu8jcdQKmYFopDs6dMs51+t
         vnCA==
X-Gm-Message-State: ABuFfogbNWy1SeyitgEN3JOOsewpgyO0WYI65pWpjed88nXEPmSh8lKr
        XLA0JrQUoLkptxv9yGKH56FK3g==
X-Google-Smtp-Source: ACcGV60zgYrhUhNKJtoHiVfwaMvVngvlVkHeFyUkTuBfPtFtrUf3IwYI6DQNgyK/EyPeLhUStcjCng==
X-Received: by 2002:a6b:370b:: with SMTP id e11-v6mr4723566ioa.67.1538663195137;
        Thu, 04 Oct 2018 07:26:35 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w193-v6sm2083276ita.11.2018.10.04.07.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 07:26:33 -0700 (PDT)
Subject: Re: [PATCH] ata: ep93xx: Use proper enums for directions
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20181004023754.15477-1-natechancellor@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <139aaf99-1189-a3cb-b801-fdf16a6ec9ac@kernel.dk>
Date:   Thu, 4 Oct 2018 08:26:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181004023754.15477-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/18 8:37 PM, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another.
> 
> drivers/ata/pata_ep93xx.c:662:36: warning: implicit conversion from
> enumeration type 'enum dma_data_direction' to different enumeration type
> 'enum dma_transfer_direction' [-Wenum-conversion]
>         drv_data->dma_rx_data.direction = DMA_FROM_DEVICE;
>                                         ~ ^~~~~~~~~~~~~~~
> drivers/ata/pata_ep93xx.c:670:36: warning: implicit conversion from
> enumeration type 'enum dma_data_direction' to different enumeration type
> 'enum dma_transfer_direction' [-Wenum-conversion]
>         drv_data->dma_tx_data.direction = DMA_TO_DEVICE;
>                                         ~ ^~~~~~~~~~~~~
> drivers/ata/pata_ep93xx.c:681:19: warning: implicit conversion from
> enumeration type 'enum dma_data_direction' to different enumeration type
> 'enum dma_transfer_direction' [-Wenum-conversion]
>         conf.direction = DMA_FROM_DEVICE;
>                        ~ ^~~~~~~~~~~~~~~
> drivers/ata/pata_ep93xx.c:692:19: warning: implicit conversion from
> enumeration type 'enum dma_data_direction' to different enumeration type
> 'enum dma_transfer_direction' [-Wenum-conversion]
>         conf.direction = DMA_TO_DEVICE;
>                        ~ ^~~~~~~~~~~~~
> 
> Use the equivalent valued enums from the expected type so that Clang no
> longer warns about a conversion.
> 
> DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1
> DMA_FROM_DEVICE = DMA_DEV_TO_MEM = 2

Applied, thanks.

-- 
Jens Axboe

