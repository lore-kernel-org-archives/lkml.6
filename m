Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB43FC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9424320856
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iK277fTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfACCDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 21:03:53 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37424 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfACCDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 21:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pqQWrvO6W4SvJzCp4HQ3+nkhlD0A1cnT15/FyplshiU=; b=iK277fTrtaN5TFe5rTft0cPfFi
        L0QyMuNnx3mAvQHDUdzhBFwAiwzLue/g3AwJY3moB9inQv8+/GVCjHkr7GFMCPa4tGGRfr++VwdMl
        YtvqooM40o7p2ppbP8fYeKmK5u3Z9tCERIin/jLKRbcaUaS93qfEpnwgIdpcTtLap37kBPBBB9WJi
        mbGUVtzUUjPpykO7cPpFGsbxpDebL/OmFvVkhYxEKwKbDY9Mb988ELTXSQSMFBuRY/4PUJjaVQ24c
        cxYVFTcez0bTtmqYaIyUbf+iaLSRQqjT7el5jFh3hG2GqMX81mcGiJR8xlxCnmkGMFMvby0jeruZd
        nRMRYNYA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gesMI-0005Ay-Nq; Thu, 03 Jan 2019 02:03:43 +0000
Subject: Re: [PATCH v9 1/2] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Long Cheng <long.cheng@mediatek.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>
References: <1546395178-8880-1-git-send-email-long.cheng@mediatek.com>
 <1546395178-8880-2-git-send-email-long.cheng@mediatek.com>
 <CANMq1KB=yuEJxUdi8M9deDhAv24WZ-4h+26cFq7AzBi8uyd88Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d60c25c2-efe4-9294-dc7e-98f0333bff76@infradead.org>
Date:   Wed, 2 Jan 2019 18:03:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CANMq1KB=yuEJxUdi8M9deDhAv24WZ-4h+26cFq7AzBi8uyd88Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While you are making changes, here are a few more:


On 1/2/19 5:39 PM, Nicolas Boichat wrote:
> diff --git a/drivers/dma/mediatek/Kconfig b/drivers/dma/mediatek/Kconfig
> index 27bac0b..1a523c87 100644
> --- a/drivers/dma/mediatek/Kconfig
> +++ b/drivers/dma/mediatek/Kconfig
> @@ -1,4 +1,15 @@
> 
> +config DMA_MTK_UART
> +       tristate "MediaTek SoCs APDMA support for UART"
> +       depends on OF && SERIAL_8250_MT6577
> +       select DMA_ENGINE
> +       select DMA_VIRTUAL_CHANNELS
> +       help
> +         Support for the UART DMA engine found on MediaTek MTK SoCs.
> +         when SERIAL_8250_MT6577 is enabled, and if you want to use DMA,

	    When

> +         you can enable the config. the DMA engine can only be used

	                               The

> +         with MediaTek SoCs.
> +

Also, use tabs to indent instead of spaces.
The lines (tristate, depends, select, and help) should be indented with one tab.
The help text lines should be indented with one tab + 2 spaces.

>  config MTK_HSDMA
>         tristate "MediaTek High-Speed DMA controller support"
>         depends on ARCH_MEDIATEK || COMPILE_TEST


thanks,
-- 
~Randy
