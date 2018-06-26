Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B922C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED8726ABD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED8726ABD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965076AbeFZMvs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:51:48 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:50380 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964940AbeFZMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:51:46 -0400
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="13463925"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Jun 2018 05:51:46 -0700
Received: from [10.10.192.125] (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.352.0; Tue, 26 Jun 2018
 05:51:45 -0700
Subject: Re: [PATCH net] net: macb: initialize bp->queues[0].bp for at91rm9200
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     Rafal Ozieblo <rafalo@cadence.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180626084401.16780-1-alexandre.belloni@bootlin.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <5551f74c-9b06-dae1-901b-c9d296ce82ae@microchip.com>
Date:   Tue, 26 Jun 2018 05:51:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626084401.16780-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2018 at 01:44, Alexandre Belloni wrote:
> The macb driver currently crashes on at91rm9200 with the following trace:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000014
> [...]
> [<c031da44>] (macb_rx_desc) from [<c031f2bc>] (at91ether_open+0x2e8/0x3f8)
> [<c031f2bc>] (at91ether_open) from [<c041e8d8>] (__dev_open+0x120/0x13c)
> [<c041e8d8>] (__dev_open) from [<c041ec08>] (__dev_change_flags+0x17c/0x1a8)
> [<c041ec08>] (__dev_change_flags) from [<c041ec4c>] (dev_change_flags+0x18/0x4c)
> [<c041ec4c>] (dev_change_flags) from [<c07a5f4c>] (ip_auto_config+0x220/0x10b0)
> [<c07a5f4c>] (ip_auto_config) from [<c000a4fc>] (do_one_initcall+0x78/0x18c)
> [<c000a4fc>] (do_one_initcall) from [<c0783e50>] (kernel_init_freeable+0x184/0x1c4)
> [<c0783e50>] (kernel_init_freeable) from [<c0574d70>] (kernel_init+0x8/0xe8)
> [<c0574d70>] (kernel_init) from [<c00090e0>] (ret_from_fork+0x14/0x34)
> 
> Solve that by initializing bp->queues[0].bp in at91ether_init (as is done
> in macb_init).
> 
> Fixes: ae1f2a56d273 ("net: macb: Added support for many RX queues")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/net/ethernet/cadence/macb_main.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 3e93df5d4e3b..96cc03a6d942 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3726,6 +3726,8 @@ static int at91ether_init(struct platform_device *pdev)
>   	int err;
>   	u32 reg;
>   
> +	bp->queues[0].bp = bp;
> +
>   	dev->netdev_ops = &at91ether_netdev_ops;
>   	dev->ethtool_ops = &macb_ethtool_ops;
>   
> 


-- 
Nicolas Ferre
