Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CDBC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1340F2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1340F2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeIYNGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:06:45 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:20576 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeIYNGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:06:45 -0400
X-IronPort-AV: E=Sophos;i="5.54,301,1534834800"; 
   d="scan'208";a="20545086"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Sep 2018 00:00:38 -0700
Received: from [10.159.245.112] (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.352.0; Tue, 25 Sep 2018
 00:00:37 -0700
Subject: Re: [PATCH v2] net: macb: Clean 64b dma addresses if they are not
 detected
To:     Michal Simek <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
CC:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>
References: <68051905ba59d7cfd74c63ef5bf0830dc2b9f6fe.1537857166.git.michal.simek@xilinx.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <910b3083-fc17-9d6c-b2d1-69d41d3def5b@microchip.com>
Date:   Tue, 25 Sep 2018 09:00:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <68051905ba59d7cfd74c63ef5bf0830dc2b9f6fe.1537857166.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2018 at 08:32, Michal Simek wrote:
> Clear ADDR64 dma bit in DMACFG register in case that HW_DMA_CAP_64B is
> not detected on 64bit system.
> The issue was observed when bootloader(u-boot) does not check macb
> feature at DCFG6 register (DAW64_OFFSET) and enabling 64bit dma support
> by default. Then macb driver is reading DMACFG register back and only
> adding 64bit dma configuration but not cleaning it out.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Michal. Best regards,
   Nicolas

> ---
> 
> Changes in v2:
> - Clean reg at the first place - Edgar
> - Update commit message
> 
>   drivers/net/ethernet/cadence/macb_main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 16e4ef7d7185..ed8a5c53467e 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2160,6 +2160,7 @@ static void macb_configure_dma(struct macb *bp)
>   		else
>   			dmacfg &= ~GEM_BIT(TXCOEN);
>   
> +		dmacfg &= ~GEM_BIT(ADDR64);
>   #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>   		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
>   			dmacfg |= GEM_BIT(ADDR64);
> 


-- 
Nicolas Ferre
