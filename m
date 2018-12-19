Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35C5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF68121873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sqpQLKJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeLSDMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 22:12:50 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45484 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeLSDMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 22:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5peKips6igA2cfm29XGmOjqLZ3etZ1w6zwOuOvsb2NU=; b=sqpQLKJ2SfYIAdeKqTlaxGhmC1
        KT8NP27uIudDC1Ffb2WdjJcfDsqkkoo/2CDdy19k4tAIADG36fRGfdfrtjU2BXO8nXqbtn1KJDuqZ
        BFLgQcqSOUpaN6QEYeyQgk3pSxEDkhCfQ/4jlmhlpbmWOSjld6QcBP7yqOz3Nki5twe5S4ihqH7PG
        quwFScF1YzjPwje4XBnESf33nquSgQxqX3V/57KqXaAq0dM7nUuMdfrgDv9OENTnvg+lkh5pzdh7o
        MkI4ZSbo/B6VvEpXtvfG9F2SKqXyaw1W4KLG6DsslepiFpoO3VSJR9k2K31GSgEGMSG68N+nZShK5
        N4glaxQQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZSHo-0004s5-LB; Wed, 19 Dec 2018 03:12:40 +0000
Subject: Re: [PATCH v6 1/2] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
To:     Long Cheng <long.cheng@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>
References: <1545186022-3712-1-git-send-email-long.cheng@mediatek.com>
 <1545186022-3712-2-git-send-email-long.cheng@mediatek.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <46c746fc-b400-ec6e-d6b1-899c3d594b19@infradead.org>
Date:   Tue, 18 Dec 2018 19:12:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1545186022-3712-2-git-send-email-long.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
A few small corrections...

On 12/18/18 6:20 PM, Long Cheng wrote:
> diff --git a/drivers/dma/mediatek/Kconfig b/drivers/dma/mediatek/Kconfig
> index 27bac0b..2c082c9 100644
> --- a/drivers/dma/mediatek/Kconfig
> +++ b/drivers/dma/mediatek/Kconfig
> @@ -1,4 +1,15 @@
>  
> +config DMA_MTK_UART
> +	tristate "MediaTek SoCs APDMA support for UART"
> +	depends on OF && SERIAL_8250_MT6577
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Support for the UART DMA engine found on MediaTek MTK SoCs.
> +	  when SERIAL_8250_MT6577 is enabled, and if you want to using DMA,

	  When                                                to use DMA,

> +	  you can enable the config. the DMA engine just only be used

	                             The DMA engine can only be used

> +	  with MediaTek SoCs.
> +


cheers,
-- 
~Randy
